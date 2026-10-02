#!/usr/bin/env bash
#
# queue.test.sh — prove the queue starts the next worksheet by itself, one at a
# time, and never double-starts, strands or retries one forever.
#
#   bash .github/skills/worksheet-build/scripts/queue.test.sh
#
# Drives promote-queue.sh against a stateful stand-in gh: relabelling changes
# an issue's labels, closing removes it, and a dispatch leaves a build running,
# so consecutive runs see what the previous one did. Exit 0 = all passed.

set -uo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

PASS=0
FAIL=0
ok()  { PASS=$((PASS + 1)); echo "  [ok]   $1"; }
bad() { FAIL=$((FAIL + 1)); echo "  [FAIL] $1"; if [ -n "${2:-}" ]; then sed 's/^/           /' "$2"; fi; }

export FAKE="$WORK/fake"
mkdir -p "$WORK/bin"
cat > "$WORK/bin/gh" <<'GH'
#!/usr/bin/env bash
F="$FAKE"
has_label() { grep -qxF -- "$2" "$F/issue-$1-labels" 2>/dev/null; }
arg_after() { local want="$1" prev=""; shift; for a in "$@"; do [ "$prev" = "$want" ] && echo "$a"; prev="$a"; done; }
case "$1 $2" in
  "pr list")
    if printf '%s\n' "$@" | grep -qx files; then cat "$F/pr-files"; else grep -c . "$F/open-prs"; fi ;;
  "pr view") cat "$F/pr-$3-files" 2>/dev/null ;;
  "run list") cat "$F/running" ;;
  "issue list")
    label="$(arg_after --label "$@")"
    while read -r n; do [ -n "$n" ] && has_label "$n" "$label" && echo "$n"; done < "$F/issues" ;;
  "issue view")
    field=""; for a in "$@"; do case "$a" in labels|title|body) field="$a" ;; esac; done
    cat "$F/issue-$3-$field" ;;
  "issue edit")
    echo "$*" >> "$F/calls"
    for l in $(arg_after --remove-label "$@"); do grep -vxF -- "$l" "$F/issue-$3-labels" > "$F/t" || true; mv "$F/t" "$F/issue-$3-labels"; done
    for l in $(arg_after --add-label "$@"); do echo "$l" >> "$F/issue-$3-labels"; done ;;
  "issue close")
    echo "$*" >> "$F/calls"
    grep -vxF -- "$3" "$F/issues" > "$F/t" || true; mv "$F/t" "$F/issues" ;;
  "issue comment") echo "$*" >> "$F/calls" ;;
  "workflow run")
    echo "$*" >> "$F/calls"
    [ -z "${FAKE_FAIL_DISPATCH:-}" ] || { echo "HTTP 403: Resource not accessible by integration" >&2; exit 1; }
    echo $(( $(cat "$F/running") + 1 )) > "$F/running" ;;
  *) echo "stand-in gh: unexpected call: $*" >&2; exit 1 ;;
esac
# Like gh: a read that matches nothing still succeeds.
exit 0
GH
chmod +x "$WORK/bin/gh"

reset() {
  rm -rf "$FAKE"; mkdir -p "$FAKE"
  : > "$FAKE/calls"; : > "$FAKE/issues"; : > "$FAKE/open-prs"; : > "$FAKE/pr-files"; echo 0 > "$FAKE/running"
}
# issue <n> <labels, one per line> <title> <body>
issue() {
  echo "$1" >> "$FAKE/issues"
  printf '%s\n' "$2" > "$FAKE/issue-$1-labels"; printf '%s\n' "$3" > "$FAKE/issue-$1-title"; printf '%s\n' "$4" > "$FAKE/issue-$1-body"
}
decl() { printf '**ws_id:** `%s`' "$1"; }
open_pr() { echo "$1" >> "$FAKE/open-prs"; echo "worksheets/$2.qmd" | tee -a "$FAKE/pr-files" > "$FAKE/pr-$1-files"; }
closed_pr() { echo "worksheets/$2.qmd" > "$FAKE/pr-$1-files"; }
run() { env PATH="$WORK/bin:$PATH" REPO=o/r MAX_IN_FLIGHT="${CAP:-1}" DEFAULT_BRANCH=main "$@" \
          bash "$HERE/promote-queue.sh" > "$WORK/run.log" 2>&1; }
labels_of() { tr '\n' ' ' < "$FAKE/issue-$1-labels"; }
line_of() { grep -nF -- "$1" "$FAKE/calls" | head -n 1 | cut -d: -f1; }
dispatches() { grep -c '^workflow run' "$FAKE/calls"; }

WS07=WS-07-cost-vs-value-gate
WS16=WS-16-seam-placement-canvas
WS06=WS-06-team-readiness-scorecard   # already on main

echo
echo "QUEUE TEST"
echo "========================================================================"

echo "one at a time"
reset
issue 20 worksheet-queued 'Build worksheet: Cost-vs-Value Gate' "$(decl $WS07)"
issue 21 worksheet-queued 'Build worksheet: Draw the Seam' "$(decl $WS16)"
run; rc=$?
relabel="$(line_of "issue edit 20 --repo o/r --remove-label worksheet-queued --add-label stage:build")"
dispatch="$(line_of "workflow run aw-worksheet-build.lock.yml --repo o/r --ref main -f ws_id=$WS07")"
if [ "$rc" -eq 0 ] && [ -n "$relabel" ] && [ -n "$dispatch" ] && [ "$relabel" -lt "$dispatch" ]; then
  ok "the oldest queued issue is relabelled, then its build is dispatched"
else
  bad "the oldest issue was not relabelled-then-dispatched (exit $rc)" "$FAKE/calls"
fi
if [ "$(dispatches)" -eq 1 ] && ! grep -q "ws_id=$WS16" "$FAKE/calls"; then
  ok "only one worksheet is started"
else
  bad "more than one worksheet was started under a cap of one" "$FAKE/calls"
fi
run
if [ "$(dispatches)" -eq 1 ] && grep -q 'At capacity' "$WORK/run.log"; then
  ok "a build still running holds the slot before its pull request exists"
else
  bad "a second run started another build while the first was still running" "$FAKE/calls"
fi
reset
open_pr 13 "$WS16"
issue 20 worksheet-queued 'Build worksheet' "$(decl $WS07)"
run
if [ "$(dispatches)" -eq 0 ] && grep -q 'At capacity' "$WORK/run.log"; then
  ok "an open worksheet pull request holds the slot"
else
  bad "a build started while a worksheet pull request was open" "$FAKE/calls"
fi

echo "merging starts the next one"
reset
issue 3 'stage:build' 'Build worksheet: Draw the Seam' "$(decl $WS16)"
issue 20 worksheet-queued 'Build worksheet: Cost-vs-Value Gate' "$(decl $WS07)"
closed_pr 13 "$WS16"
run CLOSED_PR=13 CLOSED_PR_MERGED=true
if grep -q 'issue close 3 --repo o/r --comment Built and merged in #13.' "$FAKE/calls" \
   && grep -q "ws_id=$WS07" "$FAKE/calls"; then
  ok "merging a worksheet closes its issue and starts the next build"
else
  bad "a merge did not close the issue and start the next worksheet" "$FAKE/calls"
fi
reset
issue 3 'stage:build' 'Build worksheet: Draw the Seam' "$(decl $WS16)"
closed_pr 13 "$WS16"
run CLOSED_PR=13 CLOSED_PR_MERGED=false
if grep -q 'issue edit 3 --repo o/r --add-label needs-human' "$FAKE/calls" && ! grep -q 'issue close 3' "$FAKE/calls"; then
  ok "a pull request closed without merging flags its issue needs-human"
else
  bad "an unmerged close was treated as built, or not flagged" "$FAKE/calls"
fi

echo "never twice, never stranded"
reset
issue 20 worksheet-queued 'Build worksheet' "$(decl $WS07)"
FAKE_FAIL_DISPATCH=1 run; rc=$?
if [ "$rc" -ne 0 ] && [[ "$(labels_of 20)" == *worksheet-queued* ]] && [[ "$(labels_of 20)" != *stage:build* ]]; then
  ok "a failed dispatch fails the run and puts the issue back in the queue"
else
  bad "after a failed dispatch the issue was left at stage:build, or the run passed (exit $rc, labels: $(labels_of 20))" "$FAKE/calls"
fi
reset
issue 20 worksheet-queued 'Build worksheet' "$(decl $WS06)"
issue 21 worksheet-queued 'Build worksheet' "$(decl $WS07)"
run
if grep -q 'issue close 20' "$FAKE/calls" && ! grep -q "ws_id=$WS06" "$FAKE/calls" && grep -q "ws_id=$WS07" "$FAKE/calls"; then
  ok "a worksheet already on main is closed, not rebuilt, and does not use the slot"
else
  bad "a worksheet already on main was rebuilt, or blocked the next one" "$FAKE/calls"
fi
reset
open_pr 13 "$WS16"
issue 20 worksheet-queued 'Build worksheet' "$(decl $WS16)"
issue 21 worksheet-queued 'Build worksheet' "$(decl $WS07)"
CAP=2 run
if ! grep -q "ws_id=$WS16" "$FAKE/calls" && [[ "$(labels_of 20)" == *worksheet-queued* ]] && grep -q "ws_id=$WS07" "$FAKE/calls"; then
  ok "a worksheet already in an open pull request is left queued, not started again"
else
  bad "a worksheet with an open pull request was started again" "$FAKE/calls"
fi
reset
issue 20 worksheet-queued 'Build worksheet' "$(decl $WS07)"
issue 21 worksheet-queued 'Build worksheet again' "$(decl $WS07)"
CAP=3 run
if [ "$(dispatches)" -eq 1 ] && [[ "$(labels_of 21)" == *worksheet-queued* ]]; then
  ok "two issues naming one worksheet start it once"
else
  bad "one worksheet was started twice" "$FAKE/calls"
fi
reset
issue 20 worksheet-queued 'Build worksheet: Draw the Seam' 'No identifier in this one.'
issue 21 worksheet-queued 'Build worksheet' "$(decl $WS07)"
run
if grep -q 'issue edit 20 --repo o/r --remove-label worksheet-queued --add-label needs-human' "$FAKE/calls" \
   && grep -q 'issue comment 20 .*Taken out of the worksheet queue' "$FAKE/calls" && grep -q "ws_id=$WS07" "$FAKE/calls"; then
  ok "an issue that names no worksheet leaves the queue as needs-human, and does not use the slot"
else
  bad "an unresolvable issue was not taken out of the queue properly" "$FAKE/calls"
fi
reset
issue 20 $'worksheet-queued\nstage:voice' 'Build worksheet' "$(decl $WS07)"
run
if [ ! -s "$FAKE/calls" ]; then
  ok "an issue already at a stage is left alone"
else
  bad "an issue already moving was touched" "$FAKE/calls"
fi
reset
run
if [ ! -s "$FAKE/calls" ] && grep -q 'Queue is empty' "$WORK/run.log"; then
  ok "an empty queue does nothing"
else
  bad "the queue acted with nothing queued" "$FAKE/calls"
fi

echo "========================================================================"
if [ "$FAIL" -gt 0 ]; then
  echo "FAIL — $FAIL of $((PASS + FAIL)) cases failed."
  exit 1
fi
echo "PASS — all $PASS cases passed."
