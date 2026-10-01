#!/usr/bin/env bash
#
# resolve-build-request.test.sh — prove the build stage is told the right
# worksheet for every trigger, refuses rather than guesses, and is wired into
# the compiled workflow ahead of the agent.
#
#   bash .github/skills/worksheet-build/scripts/resolve-build-request.test.sh
#
# Exit 0 = every case passed. Exit 1 = at least one failed. Uses fixtures only,
# never the live worksheets/_build-request.txt, so a build request does not
# turn this red.

set -uo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RESOLVER="$HERE/resolve-build-request.sh"
ROOT="$(git -C "$HERE" rev-parse --show-toplevel)"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

PASS=0
FAIL=0
ok()  { PASS=$((PASS + 1)); echo "  [ok]   $1"; }
bad() { FAIL=$((FAIL + 1)); echo "  [FAIL] $1"; if [ -n "${2:-}" ]; then sed 's/^/           /' "$2"; fi; }

# run_case <name> <want ws_id | REFUSE> [expected source substring] -- VAR=value...
run_case() {
  local name="$1" want="$2" src="" ev="" a
  shift 2
  if [ "$1" != "--" ]; then src="$1"; shift; fi
  shift
  for a in "$@"; do case "$a" in EVENT_NAME=*) ev="${a#EVENT_NAME=}" ;; esac; done

  local out="$WORK/out-$((PASS + FAIL))" got rc json
  env -u EVENT_NAME -u INPUT_WS_ID -u ISSUE_TITLE -u ISSUE_BODY -u BUILD_REQUEST_FILE -u GITHUB_STEP_SUMMARY \
    "$@" bash "$RESOLVER" "$out" >"$WORK/log" 2>&1
  rc=$?
  got="$(cat "$out/ws_id" 2>/dev/null || true)"

  if [ "$want" = "REFUSE" ]; then
    if [ "$rc" -ne 0 ] && [ -z "$got" ] && grep -q '^::error title=No worksheet to build::' "$WORK/log"; then
      ok "$name"
    else
      bad "$name — expected a reported refusal, got exit $rc ws_id='$got'" "$WORK/log"
    fi
    return
  fi

  json="$(cat "$out/request.json" 2>/dev/null || true)"
  if [ "$rc" -eq 0 ] && [ "$got" = "$want" ] \
     && [[ "$json" == *"\"ws_id\":\"$want\""* ]] \
     && [[ "$json" == *"\"trigger\":\"$ev\""* ]] \
     && { [ -z "$src" ] || [[ "$json" == *"$src"* ]]; }; then
    ok "$name"
  else
    bad "$name — expected $want${src:+ from \"$src\"}, got exit $rc ws_id='$got' $json" "$WORK/log"
  fi
}

fixture() { local f="$WORK/$1"; shift; printf '%s\n' "$@" > "$f"; printf '%s' "$f"; }

STALE="$(fixture stale.txt 'ws_id:     WS-06-team-readiness-scorecard' 'requested: 2026-09-30T18:51Z')"
ISSUE3_BODY='Build the facilitated worksheet `WS-16-seam-placement-canvas` from its build spec.

**Spec:** [`docs/worksheets/WS-16-seam-placement-canvas.md`](../blob/main/docs/worksheets/WS-16-seam-placement-canvas.md)
**ws_id:** `WS-16-seam-placement-canvas`'

echo
echo "RESOLVE-BUILD-REQUEST TEST"
echo "========================================================================"

echo "workflow_dispatch"
run_case "the ws_id input is used" WS-16-seam-placement-canvas "workflow_dispatch input" -- \
  EVENT_NAME=workflow_dispatch INPUT_WS_ID=WS-16-seam-placement-canvas
run_case "the input wins over a request file naming another worksheet" WS-16-seam-placement-canvas -- \
  EVENT_NAME=workflow_dispatch INPUT_WS_ID=WS-16-seam-placement-canvas BUILD_REQUEST_FILE="$STALE"
run_case "surrounding whitespace is ignored" WS-07-cost-vs-value-gate -- \
  EVENT_NAME=workflow_dispatch INPUT_WS_ID='  WS-07-cost-vs-value-gate  '
run_case "a trailing carriage return is ignored" WS-07-cost-vs-value-gate -- \
  EVENT_NAME=workflow_dispatch INPUT_WS_ID=$'WS-07-cost-vs-value-gate\r'
run_case "an empty input is refused" REFUSE -- \
  EVENT_NAME=workflow_dispatch INPUT_WS_ID=
run_case "a ws_id with no build spec is refused" REFUSE -- \
  EVENT_NAME=workflow_dispatch INPUT_WS_ID=WS-99-no-such-worksheet
run_case "a lower-case ws_id is refused" REFUSE -- \
  EVENT_NAME=workflow_dispatch INPUT_WS_ID=ws-16-seam-placement-canvas
run_case "shell metacharacters are refused" REFUSE -- \
  EVENT_NAME=workflow_dispatch INPUT_WS_ID='WS-16-seam-placement-canvas; touch /tmp/ws-pwned'
run_case "a path is refused" REFUSE -- \
  EVENT_NAME=workflow_dispatch INPUT_WS_ID='../../docs/worksheets/WS-16-seam-placement-canvas'
run_case "two ws_ids in one input are refused" REFUSE -- \
  EVENT_NAME=workflow_dispatch INPUT_WS_ID='WS-16-seam-placement-canvas WS-07-cost-vs-value-gate'
run_case "a valid ws_id with a second line smuggled after it is refused" REFUSE -- \
  EVENT_NAME=workflow_dispatch INPUT_WS_ID=$'WS-16-seam-placement-canvas\ntouch /tmp/ws-pwned'

echo "issues"
run_case "the body's ws_id line is used (issue #3, verbatim)" WS-16-seam-placement-canvas "ws_id line" -- \
  EVENT_NAME=issues ISSUE_TITLE='Build worksheet: Draw the Seam: Deterministic / Probabilistic Canvas' ISSUE_BODY="$ISSUE3_BODY"
run_case "a body with CRLF line endings still declares" WS-07-cost-vs-value-gate "ws_id line" -- \
  EVENT_NAME=issues ISSUE_TITLE='Build worksheet' ISSUE_BODY=$'Intro.\r\n**ws_id:** `WS-07-cost-vs-value-gate`\r\n'
run_case "the declaration wins over ids mentioned in prose" WS-07-cost-vs-value-gate "ws_id line" -- \
  EVENT_NAME=issues ISSUE_TITLE='Build worksheet' ISSUE_BODY=$'Absorbs WS-07-three-variables-audit.\n**ws_id:** `WS-07-cost-vs-value-gate`'
run_case "the same ws_id declared twice resolves" WS-07-cost-vs-value-gate -- \
  EVENT_NAME=issues ISSUE_TITLE='Build worksheet' ISSUE_BODY=$'**ws_id:** `WS-07-cost-vs-value-gate`\nws_id: WS-07-cost-vs-value-gate'
run_case "a title that agrees with the body resolves" WS-16-seam-placement-canvas "ws_id line" -- \
  EVENT_NAME=issues ISSUE_TITLE='[worksheet] WS-16-seam-placement-canvas' ISSUE_BODY="$ISSUE3_BODY"
run_case "with no declaration, the title is used" WS-06-team-readiness-scorecard "issue title" -- \
  EVENT_NAME=issues ISSUE_TITLE='[worksheet] WS-06-team-readiness-scorecard' ISSUE_BODY='No identifier here.'
run_case "a ws_id that is not numbered resolves" WS-CS-APM-plan-gate -- \
  EVENT_NAME=issues ISSUE_TITLE='Build worksheet' ISSUE_BODY='**ws_id:** `WS-CS-APM-plan-gate`'
run_case "a visible declaration survives a trailing HTML comment" WS-07-cost-vs-value-gate -- \
  EVENT_NAME=issues ISSUE_TITLE='Build worksheet' ISSUE_BODY='**ws_id:** `WS-07-cost-vs-value-gate` <!-- reviewed -->'
run_case "an id in prose is not a declaration: the title is used" WS-16-seam-placement-canvas "issue title" -- \
  EVENT_NAME=issues ISSUE_TITLE='Build WS-16-seam-placement-canvas' \
  ISSUE_BODY='Same shape as the pilot (ws_id: WS-06-team-readiness-scorecard), but five sheets.'
run_case "a declaration hidden in an HTML comment does not count" REFUSE -- \
  EVENT_NAME=issues ISSUE_TITLE='Build worksheet' ISSUE_BODY=$'Please build the canvas next.\n<!--\n**ws_id:** `WS-07-cost-vs-value-gate`\n-->'
run_case "a declaration in a fenced code block does not count" REFUSE -- \
  EVENT_NAME=issues ISSUE_TITLE='Build worksheet' ISSUE_BODY=$'Example:\n```\n**ws_id:** `WS-07-cost-vs-value-gate`\n```'
run_case "a title and body that disagree are refused" REFUSE -- \
  EVENT_NAME=issues ISSUE_TITLE='Build WS-16-seam-placement-canvas' ISSUE_BODY='**ws_id:** `WS-07-cost-vs-value-gate`'
run_case "two different declarations are refused" REFUSE -- \
  EVENT_NAME=issues ISSUE_TITLE='Build worksheet' ISSUE_BODY=$'ws_id: WS-07-cost-vs-value-gate\nws_id: WS-16-seam-placement-canvas'
run_case "an id mentioned only in prose is refused, not guessed" REFUSE -- \
  EVENT_NAME=issues ISSUE_TITLE='Build worksheet' ISSUE_BODY='This covers WS-07-cost-vs-value-gate.'
run_case "a ws_id must be a whole token" REFUSE -- \
  EVENT_NAME=issues ISSUE_TITLE='Build WS-16-seam-placement-canvas_draft' ISSUE_BODY=''
run_case "an issue that names no worksheet is refused" REFUSE -- \
  EVENT_NAME=issues ISSUE_TITLE='Build worksheet: Draw the Seam' ISSUE_BODY='No identifier anywhere.'

echo "push"
REQ="$(fixture request.txt '#   ws_id:     WS-06-team-readiness-scorecard' 'ws_id:     WS-07-cost-vs-value-gate' 'requested: 2026-10-01T00:00Z')"
run_case "the request file's ws_id line is used, not its commented example" WS-07-cost-vs-value-gate -- \
  EVENT_NAME=push BUILD_REQUEST_FILE="$REQ"
run_case "a request file with CRLF line endings resolves" WS-07-cost-vs-value-gate -- \
  EVENT_NAME=push BUILD_REQUEST_FILE="$(fixture crlf.txt $'ws_id: WS-07-cost-vs-value-gate\r' $'requested: x\r')"
run_case "a ws_id must be a whole token" REFUSE -- \
  EVENT_NAME=push BUILD_REQUEST_FILE="$(fixture suffix.txt 'ws_id: WS-07-cost-vs-value-gate-V2')"
run_case "a bare id with no ws_id: line is refused" REFUSE -- \
  EVENT_NAME=push BUILD_REQUEST_FILE="$(fixture bare.txt 'WS-07-cost-vs-value-gate')"
run_case "a missing request file is refused" REFUSE -- \
  EVENT_NAME=push BUILD_REQUEST_FILE="$WORK/does-not-exist.txt"
COMMITTED="$ROOT/worksheets/_build-request.txt"
if [ -f "$COMMITTED" ]; then
  # Whatever it names today, it must be well formed. Expected value read
  # independently, so editing the request never turns this red.
  expect="$(tr -d '\r' < "$COMMITTED" | sed -n 's/^ws_id:[[:space:]]*\([^[:space:]]*\).*/\1/p' | head -1)"
  run_case "the committed request file is well formed" "${expect:-<none>}" -- \
    EVENT_NAME=push BUILD_REQUEST_FILE="$COMMITTED"
fi

echo "anything else"
run_case "an unsupported trigger is refused" REFUSE -- \
  EVENT_NAME=schedule INPUT_WS_ID=WS-16-seam-placement-canvas
run_case "a missing trigger is refused" REFUSE -- \
  INPUT_WS_ID=WS-16-seam-placement-canvas

echo "step summary"
: > "$WORK/summary"
env -u ISSUE_TITLE -u ISSUE_BODY -u BUILD_REQUEST_FILE GITHUB_STEP_SUMMARY="$WORK/summary" \
  EVENT_NAME=workflow_dispatch INPUT_WS_ID=WS-16-seam-placement-canvas bash "$RESOLVER" "$WORK/sum-ok" >/dev/null 2>&1
env -u ISSUE_TITLE -u ISSUE_BODY -u BUILD_REQUEST_FILE GITHUB_STEP_SUMMARY="$WORK/summary" \
  EVENT_NAME=workflow_dispatch INPUT_WS_ID=WS-99-no-such-worksheet bash "$RESOLVER" "$WORK/sum-no" >/dev/null 2>&1
if grep -q '^\*\*Building:\*\* `WS-16-seam-placement-canvas`' "$WORK/summary" \
   && grep -q '^\*\*Build refused:\*\* WS-99-no-such-worksheet' "$WORK/summary"; then
  ok "builds and refusals are both written to the step summary"
else
  bad "the step summary is missing a build or refusal line" "$WORK/summary"
fi

echo "every real spec"
# The identifier pattern must accept every build spec that exists, or the
# resolver would refuse a legitimate worksheet. Only failures are printed.
for spec in "$ROOT"/docs/worksheets/WS-*.md; do
  id="$(basename "$spec" .md)"
  run_case "accepts $id" "$id" -- EVENT_NAME=workflow_dispatch INPUT_WS_ID="$id" >>"$WORK/specs.log"
done
grep -A4 '\[FAIL\]' "$WORK/specs.log" || true
echo "  checked $(ls "$ROOT"/docs/worksheets/WS-*.md | wc -l | tr -d ' ') specs"

echo "wiring"
# A resolver that is never called proves nothing. Check the COMPILED workflow,
# which is what actually runs.
LOCK="$ROOT/.github/workflows/aw-worksheet-build.lock.yml"
MD="$ROOT/.github/workflows/aw-worksheet-build.md"
step="$(grep -n 'name: Resolve which worksheet this run builds' "$LOCK" | head -1 | cut -d: -f1)"
agent="$(grep -n 'name: Execute GitHub Copilot CLI' "$LOCK" | head -1 | cut -d: -f1)"
if [ -n "$step" ] && [ -n "$agent" ] && [ "$step" -lt "$agent" ] \
   && ! sed -n "${step},${agent}p" "$LOCK" | tr -d '\r' | grep -qE '^  [A-Za-z0-9_-]+:[[:space:]]*$'; then
  ok "the resolve step runs in the agent's job, before the agent"
else
  bad "the resolve step is missing, after the agent, or in another job (step L${step:-?}, agent L${agent:-?})"
fi
if [ -n "$step" ]; then
  start="$(tr -d '\r' < "$LOCK" | awk -v n="$step" 'NR <= n && /^      - / { s = NR } END { print s }')"
  end="$(tr -d '\r' < "$LOCK" | awk -v n="$step" 'NR > n && /^      - / { print NR; exit }')"
  block="$(tr -d '\r' < "$LOCK" | sed -n "${start},$(( ${end:-$step} - 1 ))p")"
  missing=""
  for v in 'EVENT_NAME: ${{ github.event_name }}' 'INPUT_WS_ID: ${{ github.event.inputs.ws_id }}' \
           'ISSUE_TITLE: ${{ github.event.issue.title }}' 'ISSUE_BODY: ${{ github.event.issue.body }}'; do
    [[ "$block" == *"$v"* ]] || missing="$missing [$v]"
  done
  [ -z "$missing" ] && ok "it receives all four event values through env" || bad "the step's env is missing:$missing"
  if printf '%s\n' "$block" | grep -qE 'continue-on-error|^        if:'; then
    bad "the resolve step can be skipped or can fail without stopping the agent"
  else
    ok "it cannot be skipped, and its failure stops the job"
  fi
  dir="$(printf '%s\n' "$block" | grep -oE '/tmp/gh-aw/agent/[A-Za-z0-9_-]+' | head -1)"
  if [ -n "$dir" ] && grep -qF "cat $dir/ws_id" "$MD"; then
    ok "the prompt reads the directory the step writes ($dir)"
  else
    bad "the prompt does not read the step's output directory '${dir:-?}'"
  fi
fi

[ -e /tmp/ws-pwned ] && { bad "an input was executed: /tmp/ws-pwned exists"; rm -f /tmp/ws-pwned; }

echo "========================================================================"
if [ "$FAIL" -gt 0 ]; then
  echo "FAIL — $FAIL of $((PASS + FAIL)) cases failed."
  exit 1
fi
echo "PASS — all $PASS cases passed."
