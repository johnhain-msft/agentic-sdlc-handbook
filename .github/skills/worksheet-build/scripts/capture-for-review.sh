#!/usr/bin/env bash
#
# capture-for-review.sh — put a worksheet render in front of an agent's EYES.
#
#   capture-for-review.sh <stage-label> <out-dir>
#
# Finds the open worksheet pull request waiting at <stage-label>, checks out its
# head, renders the worksheet, runs the layout gate, and leaves exactly one
# file at <out-dir>/full-page.png plus <out-dir>/capture.json.
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
# full-page.png is deliberately the single attachment: it is always exactly one
# file whatever the sheet count, and it shows every sheet AND any content
# spilling past a paper edge, which is the defect that matters most.
#
# This script ALWAYS leaves a readable PNG at that path. If anything fails it
# writes a rendered failure card instead, so the agent sees why rather than
# hitting a missing-file launch error.

set -uo pipefail

STAGE_LABEL="${1:?usage: capture-for-review.sh <stage-label> <out-dir>}"
OUT_DIR="${2:?usage: capture-for-review.sh <stage-label> <out-dir>}"

ROOT="$(git rev-parse --show-toplevel)"
cd "$ROOT"

mkdir -p "$OUT_DIR"
SHOT="$OUT_DIR/full-page.png"
FACTS="$OUT_DIR/capture.json"

# ---------------------------------------------------------------------------
# A readable card, used both for hard failures and for unused sheet slots.
# ---------------------------------------------------------------------------
note_card() {
  local msg="$1" out="$2" bg="${3:-#334155}"
  node -e '
    const { chromium } = require("playwright");
    const [msg, out, bg] = process.argv.slice(1);
    (async () => {
      const b = await chromium.launch();
      const p = await b.newPage({ viewportSize: { width: 1100, height: 320 } });
      await p.setContent(`<body style="margin:0;font:22px/1.5 system-ui;background:${bg};color:#fff;padding:44px">
        <div style="font-size:14px;letter-spacing:.2em;opacity:.8">WORKSHEET CAPTURE</div>
        <div style="font-size:26px;margin-top:16px">${msg.replace(/[<>&]/g, "")}</div>
      </body>`);
      await p.screenshot({ path: out });
      await b.close();
    })();
  ' "$msg" "$out" "$bg" 2>/dev/null || {
    printf '\211PNG\r\n\032\n\0\0\0\rIHDR\0\0\0\1\0\0\0\1\10\6\0\0\0\37\25\304\211\0\0\0\nIDATx\234c\370\17\0\1\1\1\0\30\335\215\260\0\0\0\0IEND\256B`\202' > "$out"
  }
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
  printf '{"ok":false,"reason":%s}\n' "$(printf '%s' "$reason" | python3 -c 'import json,sys;print(json.dumps(sys.stdin.read()))')" > "$FACTS"
  exit 0   # never fail the job here — the agent reports VOID from the card
}

# ---------------------------------------------------------------------------
PR="$(gh pr list --state open --label worksheet --label "$STAGE_LABEL" \
        --json number --jq '.[0].number // empty' 2>/dev/null)" || PR=""

[ -n "$PR" ] || fail_card "No open worksheet pull request is waiting at ${STAGE_LABEL}."

echo "capture: pull request #$PR"

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

python3 - "$PR" "$WS_ID" "$GATE" "$FACTS" <<'PY'
import json, sys
pr, ws_id, gate, out = sys.argv[1:5]
json.dump({"ok": True, "pull_request": int(pr), "ws_id": ws_id,
           "gate_exit": int(gate), "gate_passed": int(gate) == 0},
          open(out, "w"), indent=2)
PY

echo "capture: $SHOT ready (gate exit $GATE)"
cat "$OUT_DIR/gate.log" | tail -n 25
