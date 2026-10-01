#!/usr/bin/env bash
#
# capture-for-review.sh — put a worksheet render in front of an agent's EYES.
#
#   capture-for-review.sh <stage-label> <out-dir>
#
# Finds the open worksheet pull request waiting at <stage-label>, checks out its
# head, renders the worksheet, runs the layout gate, and leaves four images in
# <out-dir> — full-page.png and sheet-01..03.png, one per --attachment slot —
# plus <out-dir>/capture.json. Every one is checked before the agent launches:
# a single unusable image makes the model drop all of them.
#
# WHY THIS EXISTS
#
# The Copilot CLI's mid-session file read loads a PNG and reports its MIME type
# and dimensions, but does not send the image bytes to the model. Measured on a
# real run: six 2000x1414 screenshots would cost ~22,600 image tokens, and the
# whole run's input was 8,857. The agent could not see them, and correctly
# refused to review what it could not see.
#
# `copilot --attachment <path>` DOES send the image. That flag is applied at
# launch, so the image must exist BEFORE the agent starts — which is what this
# script guarantees. Verified locally: a fresh Copilot CLI given only the
# attachment correctly read the column headers, named the prior column's tint
# and serif italic against the blank column's hairlines, and read "† PRIOR —
# NOT A TARGET" and "THE SEAM" off the page.
#
# full-page.png shows every sheet at once AND any content spilling past a paper
# edge, which is the defect that matters most. sheet-01..03.png add detail.
# Because --attachment is fixed at launch, a worksheet with fewer than three
# sheets fills the spare slots with a card saying so.
#
# This script ALWAYS leaves four usable PNGs. If anything fails it writes a
# rendered failure card instead, so the agent sees why rather than hitting a
# missing-file launch error, and any slot that is still unusable is replaced
# with a plain image and listed in capture.json under replaced_slots.

set -uo pipefail

STAGE_LABEL="${1:?usage: capture-for-review.sh <stage-label> <out-dir>}"
OUT_DIR="${2:?usage: capture-for-review.sh <stage-label> <out-dir>}"

ROOT="$(git rev-parse --show-toplevel)"
cd "$ROOT"

mkdir -p "$OUT_DIR"
SHOT="$OUT_DIR/full-page.png"
FACTS="$OUT_DIR/capture.json"

# The checkout below swaps the working tree for the pull request's, and that
# tree can predate any helper this script needs: a pull request built before a
# fix would silently lose it. So run the helpers from copies taken NOW, from
# the tree that started this capture. node_modules is untracked, so it survives
# the checkout, and PLAYWRIGHT_FROM tells note-card.mjs to resolve from it.
SKILL_DIR="$ROOT/.github/skills/worksheet-build"
TOOLS="$(mktemp -d)"
cp "$SKILL_DIR/scripts/note-card.mjs" "$SKILL_DIR/scripts/ensure-attachment.mjs" "$TOOLS/"
export PLAYWRIGHT_FROM="$SKILL_DIR"

# ---------------------------------------------------------------------------
# A readable card, used both for hard failures and for unused sheet slots.
#
# This used to be an inline `node -e` run from the repository root, where
# `playwright` does not resolve; the error went to /dev/null and every card
# became a corrupt 1x1 PNG, which made the model drop every attachment — the
# good sheets included. Errors now go to card.log, and ensure_slots below
# guarantees no slot is ever unusable.
# ---------------------------------------------------------------------------
note_card() {
  local msg="$1" out="$2" bg="${3:-#334155}"
  if ! node "$TOOLS/note-card.mjs" "$out" "$bg" "$msg" 2>>"$OUT_DIR/card.log"; then
    echo "capture: could not render a card for $(basename "$out"); see card.log" >&2
  fi
}

# Every attachment slot must hold an image the model accepts. One unusable
# image (missing, corrupt, or 1x1) gets the WHOLE request's images dropped.
# Prints the names of any slots it had to replace.
ensure_slots() {
  node "$TOOLS/ensure-attachment.mjs" \
    "$SHOT" "$OUT_DIR/sheet-01.png" "$OUT_DIR/sheet-02.png" "$OUT_DIR/sheet-03.png"
}

# capture.json: what the agent reads first. Args: ok reason pr ws_id gate replaced
write_facts() {
  python3 - "$FACTS" "$OUT_DIR/judge-verdict.md" "$@" <<'PY'
import json, os, sys
out, verdict, ok, reason, pr, ws_id, gate, replaced = sys.argv[1:9]
facts = {"ok": ok == "true", "replaced_slots": replaced.split(),
         "previous_judge_verdict": os.path.exists(verdict) and os.path.getsize(verdict) > 0,
         "judge_verdict_unreadable": os.path.exists(verdict.replace(".md", ".unreadable"))}
if facts["ok"]:
    facts.update(pull_request=int(pr), ws_id=ws_id, gate_exit=int(gate), gate_passed=int(gate) == 0)
else:
    facts["reason"] = reason
json.dump(facts, open(out, "w"), indent=2)
PY
}

# ---------------------------------------------------------------------------
# A failure card the agent can actually read, rather than a missing file.
# ---------------------------------------------------------------------------
fail_card() {
  local reason="$1"
  echo "capture: $reason" >&2
  note_card "NO RENDER TO REVIEW — ${reason}  ...  Report VOID. Do not describe a worksheet you have not seen." "$SHOT" "#b3261e"
  # Every attachment slot must resolve or copilot fails to launch.
  for n in 1 2 3; do
    note_card "No render — see the main capture card." "$OUT_DIR/sheet-0$n.png" "#b3261e"
  done
  ensure_slots_out="$(ensure_slots)"
  write_facts false "$reason" 0 "" 0 "$ensure_slots_out"
  exit 0   # never fail the job here — the agent reports VOID from the card
}

# ---------------------------------------------------------------------------
# Oldest first, the policy every stage states: with several pull requests at
# one stage, each dispatch takes the lowest-numbered and the rest wait theirs.
PR="$(gh pr list --state open --label worksheet --label "$STAGE_LABEL" \
        --json number --jq 'sort_by(.number) | .[0].number // empty' 2>/dev/null)" || PR=""

[ -n "$PR" ] || fail_card "No open worksheet pull request is waiting at ${STAGE_LABEL}."

echo "capture: pull request #$PR"

# If the judge sent this pull request back, its findings are in a comment. Put
# them where the agent reads first. Done before the checkout, from this tree.
# Unreadable is recorded, never passed off as "the judge has not ruled".
bash "$SKILL_DIR/scripts/fetch-judge-verdict.sh" "$PR" "$OUT_DIR/judge-verdict.md" \
  || : > "$OUT_DIR/judge-verdict.unreadable"

# Credentials are stripped after checkout, so the PR head must already be
# fetched (checkout: fetch: ["refs/pulls/open/*"]).
git checkout -B "pr-$PR" "refs/remotes/origin/pull/$PR/head" 2>/dev/null \
  || fail_card "PR #${PR}'s head branch is not in the workspace. Is checkout.fetch configured?"

WS_ID="$(gh pr view "$PR" --json files --jq '.files[].path' 2>/dev/null \
          | grep -E '^worksheets/.+\.qmd$' | head -n1 \
          | xargs -r basename | sed 's/\.qmd$//')"

# Deliberately ask GitHub rather than diffing locally. The pull request head is
# fetched shallow (--depth=1), so it shares no history with origin/main and a
# three-dot `git diff origin/main...HEAD` finds nothing — which looked exactly
# like "this PR changes no worksheet".
[ -n "$WS_ID" ] || fail_card "PR #${PR} changes no worksheets/*.qmd file."

echo "capture: worksheet $WS_ID"

bash .github/skills/worksheet-build/scripts/render-worksheet.sh "$WS_ID" > "$OUT_DIR/gate.log" 2>&1
GATE=$?

SRC="worksheets/_review/$WS_ID/full-page.png"
[ -f "$SRC" ] || fail_card "Render produced no screenshot for ${WS_ID}. Gate exit ${GATE}. $(tail -n 3 "$OUT_DIR/gate.log" | tr '\n' ' ')"

cp "$SRC" "$SHOT"
cp -f "worksheets/_review/$WS_ID/layout-report.json" "$OUT_DIR/layout-report.json" 2>/dev/null || true

# The full page shows every sheet at once, which is right for spotting overflow
# and overall shape — but on a 5-sheet A3 worksheet the detail is too small to
# judge house rule 1. Attach the first three sheets at full resolution as well.
# The slot count is FIXED because --attachment is fixed at launch; unused slots
# get a card saying so, which is clearer to the agent than a missing file.
for n in 1 2 3; do
  slot="$OUT_DIR/sheet-0$n.png"
  src="worksheets/_review/$WS_ID/sheet-0$n.png"
  if [ -f "$src" ]; then
    cp "$src" "$slot"
  else
    note_card "This worksheet has fewer than $n sheets. Nothing to show in this slot." "$slot"
  fi
done
REPLACED="$(ensure_slots)"
write_facts true "" "$PR" "$WS_ID" "$GATE" "$REPLACED"

echo "capture: $SHOT ready (gate exit $GATE)${REPLACED:+; replaced slots: $(echo $REPLACED)}"
cat "$OUT_DIR/gate.log" | tail -n 25
