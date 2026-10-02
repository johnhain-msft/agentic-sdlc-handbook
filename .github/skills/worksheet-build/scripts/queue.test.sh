#!/usr/bin/env bash
#
# queue.test.sh — prove the queue starts the next worksheet by itself, one at a
# time, and never double-starts, strands or retries one forever.
#
#   bash .github/skills/worksheet-build/scripts/queue.test.sh
#
# Drives promote-queue.sh against a stateful stand-in gh: relabelling changes
# an issue's labels and its updatedAt, closing removes it, and a dispatch puts
# a running build on top of a run list kept newest first, so consecutive runs
# see what the previous one did. Like gh, "run list" honours --status and
# --limit, so newer runs can push an older one out of an unfiltered listing.
# Exit 0 = all passed.

set -uo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

PASS=0
FAIL=0
ok()  { PASS=$((PASS + 1)); echo "  [ok]   $1"; }
bad() { FAIL=$((FAIL + 1)); echo "  [FAIL] $1"; if [ -n "${2:-}" ]; then sed 's/^/           /' "$2"; fi; }

export FAKE="$WORK/fake"
MAIN="$WORK/main"   # worksheets/ as it is on main
mkdir -p "$WORK/bin"
cat > "$WORK/bin/gh" <<'GH'
#!/usr/bin/env bash
F="$FAKE"
has_label() { grep -qxF -- "$2" "$F/issue-$1-labels" 2>/dev/null; }
arg_after() { local want="$1" prev=""; shift; for a in "$@"; do [ "$prev" = "$want" ] && echo "$a"; prev="$a"; done; }
stamp() { date -u +%Y-%m-%dT%H:%M:%SZ > "$F/issue-$1-updatedAt"; }
case "$1 $2" in
  "pr list")
    # What the script's --jq makes of it: "<number> <worksheet file>" per open worksheet pull request.
    [ "$(arg_after --json "$@")" = number,files ] || { echo "stand-in gh: unexpected pr list: $*" >&2; exit 1; }
    cat "$F/open-prs" ;;
  "run list")
    # $F/runs: one "<event> <status>" line per run of the build, newest first.
    [ "$(arg_after --workflow "$@")" = aw-worksheet-build.lock.yml ] || { echo "stand-in gh: run list of another workflow: $*" >&2; exit 1; }
    lim="$(arg_after --limit "$@")"; st="$(arg_after --status "$@")"
    if [ -n "$st" ]; then
      awk -v s="$st" '$2 == s' "$F/runs" | head -n "${lim:-20}" | wc -l
    else
      head -n "${lim:-20}" "$F/runs" | awk '$2 != "completed"' | wc -l
    fi ;;
  "issue list")
    label="$(arg_after --label "$@")"
    while read -r n; do [ -n "$n" ] && has_label "$n" "$label" && echo "$n"; done < "$F/issues" ;;
  "issue view")
    field=""; for a in "$@"; do case "$a" in labels|title|body|updatedAt) field="$a" ;; esac; done
    [ "${FAKE_FAIL_FIELD:-}" != "$field" ] || { echo "HTTP 502: Bad Gateway" >&2; exit 1; }
    cat "$F/issue-$3-$field" ;;
  "issue edit")
    echo "$*" >> "$F/calls"
    for l in $(arg_after --remove-label "$@"); do grep -vxF -- "$l" "$F/issue-$3-labels" > "$F/t" || true; mv "$F/t" "$F/issue-$3-labels"; done
    for l in $(arg_after --add-label "$@"); do echo "$l" >> "$F/issue-$3-labels"; done
    stamp "$3" ;;
  "issue close")
    echo "$*" >> "$F/calls"
    grep -vxF -- "$3" "$F/issues" > "$F/t" || true; mv "$F/t" "$F/issues" ;;
  "issue comment") echo "$*" >> "$F/calls"; stamp "$3" ;;
  "workflow run")
    echo "$*" >> "$F/calls"
    [ -z "${FAKE_FAIL_DISPATCH:-}" ] || { echo "HTTP 403: Resource not accessible by integration" >&2; exit 1; }
    # GitHub lists a dispatched run a moment after it accepts the dispatch.
    [ -n "${FAKE_NOT_LISTED_YET:-}" ] || { { echo "workflow_dispatch in_progress"; cat "$F/runs"; } > "$F/t"; mv "$F/t" "$F/runs"; } ;;
  *) echo "stand-in gh: unexpected call: $*" >&2; exit 1 ;;
esac
# Like gh: a read that matches nothing still succeeds.
exit 0
GH
chmod +x "$WORK/bin/gh"

OLD=2026-01-01T00:00:00Z   # far enough back to be past the grace period

WS07=WS-07-cost-vs-value-gate
WS16=WS-16-seam-placement-canvas
WS02=WS-02-shadow-ai-usage-inventory
WS06=WS-06-team-readiness-scorecard   # on main in every case

reset() {
  rm -rf "$FAKE" "$MAIN"; mkdir -p "$FAKE" "$MAIN"
  : > "$FAKE/calls"; : > "$FAKE/issues"; : > "$FAKE/open-prs"; : > "$FAKE/runs"
  on_main "$WS06"
}
# issue <n> <labels, one per line> <title> <body>
issue() {
  echo "$1" >> "$FAKE/issues"
  printf '%s\n' "$2" > "$FAKE/issue-$1-labels"; printf '%s\n' "$3" > "$FAKE/issue-$1-title"; printf '%s\n' "$4" > "$FAKE/issue-$1-body"
  echo "$OLD" > "$FAKE/issue-$1-updatedAt"
}
decl() { printf '**ws_id:** `%s`' "$1"; }
open_pr() { echo "$1 worksheets/$2.qmd" >> "$FAKE/open-prs"; }
on_main() { : > "$MAIN/$1.qmd"; }
# Newer runs go on top: a build someone dispatched by hand, or label events the build's if: skipped.
build_started() { { echo "workflow_dispatch in_progress"; cat "$FAKE/runs"; } > "$FAKE/t"; mv "$FAKE/t" "$FAKE/runs"; }
label_events() { local i; for i in $(seq 1 "$1"); do { echo "issues completed"; cat "$FAKE/runs"; } > "$FAKE/t"; mv "$FAKE/t" "$FAKE/runs"; done; }
builds_end() { sed -i 's/ in_progress$/ completed/' "$FAKE/runs"; }
time_passes() { local f; for f in "$FAKE"/issue-*-updatedAt; do echo "$OLD" > "$f"; done; }
run() { env PATH="$WORK/bin:$PATH" REPO=o/r MAX_IN_FLIGHT="${CAP:-1}" DEFAULT_BRANCH=main WORKSHEETS_DIR="$MAIN" "$@" \
          bash "$HERE/promote-queue.sh" > "$WORK/run.log" 2>&1; }
labels_of() { tr '\n' ' ' < "$FAKE/issue-$1-labels"; }
line_of() { grep -nF -- "$1" "$FAKE/calls" | head -n 1 | cut -d: -f1; }
dispatches() { grep -c '^workflow run' "$FAKE/calls"; }
calls_like() { grep -cF -- "$1" "$FAKE/calls"; }

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
  bad "the oldest issue was not relabelled-then-dispatched (exit $rc)" "$WORK/run.log"
fi
if [ "$(dispatches)" -eq 1 ] && ! grep -q "ws_id=$WS16" "$FAKE/calls"; then
  ok "only one worksheet is started"
else
  bad "more than one worksheet was started under a cap of one" "$FAKE/calls"
fi
run
if [ "$(dispatches)" -eq 1 ] && grep -q 'At capacity' "$WORK/run.log"; then
  ok "the started worksheet holds the slot before its pull request exists"
else
  bad "a second run started another build while the first was still running" "$WORK/run.log"
fi
label_events 20
run
if [ "$(dispatches)" -eq 1 ] && grep -q 'At capacity' "$WORK/run.log"; then
  ok "twenty newer runs of the build do not free the slot"
else
  bad "after twenty label events a second build started" "$WORK/run.log"
fi
reset
build_started   # dispatched by hand: no issue, and no pull request yet
label_events 20
issue 20 worksheet-queued 'Build worksheet' "$(decl $WS07)"
run
if [ "$(dispatches)" -eq 0 ] && grep -q 'At capacity' "$WORK/run.log"; then
  ok "a running build no issue knows about holds the slot, behind twenty newer runs"
else
  bad "a build started while another was running out of sight" "$WORK/run.log"
fi
reset
open_pr 13 "$WS16"
issue 20 worksheet-queued 'Build worksheet' "$(decl $WS07)"
run
if [ "$(dispatches)" -eq 0 ] && grep -q 'At capacity' "$WORK/run.log"; then
  ok "an open worksheet pull request holds the slot"
else
  bad "a build started while a worksheet pull request was open" "$WORK/run.log"
fi

echo "merging starts the next one, whatever event started the run"
reset
issue 3 'stage:build' 'Build worksheet: Draw the Seam' "$(decl $WS16)"
issue 20 worksheet-queued 'Build worksheet: Cost-vs-Value Gate' "$(decl $WS07)"
on_main "$WS16"   # its pull request merged
run
if grep -qF "issue close 3 --repo o/r --comment worksheets/$WS16.qmd is on main: built and merged." "$FAKE/calls" \
   && grep -q "ws_id=$WS07" "$FAKE/calls"; then
  ok "once its worksheet is on main, the issue is closed and the next build starts"
else
  bad "a merged worksheet did not close its issue and start the next one" "$WORK/run.log"
fi
reset
issue 3 'stage:build' 'Build worksheet: Draw the Seam' "$(decl $WS16)"
issue 4 'stage:build' 'Build worksheet: Shadow AI' "$(decl $WS02)"
open_pr 14 "$WS02"
issue 20 worksheet-queued 'Build worksheet' "$(decl $WS07)"
on_main "$WS16"
run
if grep -q 'issue close 3 ' "$FAKE/calls" && ! grep -q ' 4 --repo' "$FAKE/calls" \
   && [ "$(dispatches)" -eq 0 ] && grep -q 'At capacity' "$WORK/run.log"; then
  ok "only the issue whose worksheet is on main is closed; the other keeps the slot"
else
  bad "a merge closed or touched the wrong issue" "$FAKE/calls"
fi
reset
issue 3 'stage:build' 'Build worksheet: Draw the Seam' "$(decl $WS16)"
issue 20 worksheet-queued 'Build worksheet' "$(decl $WS07)"
run   # its pull request was closed without merging: no pull request, no build, not on main
if grep -q 'issue edit 3 --repo o/r --add-label needs-human' "$FAKE/calls" && grep -q 'issue comment 3 ' "$FAKE/calls" \
   && ! grep -q 'issue close 3' "$FAKE/calls" && [ "$(dispatches)" -eq 0 ]; then
  ok "a pull request closed without merging flags its issue needs-human, and the line waits"
else
  bad "an unmerged close was treated as built, went unflagged, or let the next one start" "$WORK/run.log"
fi

echo "never stranded, never silent"
reset
issue 20 worksheet-queued 'Build worksheet' "$(decl $WS07)"
issue 21 worksheet-queued 'Build worksheet' "$(decl $WS16)"
FAKE_NOT_LISTED_YET=1 run   # GitHub accepted the dispatch but has not listed the run yet
run
if ! grep -q 'add-label needs-human' "$FAKE/calls" && [ "$(dispatches)" -eq 1 ] && grep -q 'At capacity' "$WORK/run.log"; then
  ok "a build GitHub has not listed yet is not flagged, and its issue holds the slot"
else
  bad "a just-started worksheet was flagged, or the next one started" "$WORK/run.log"
fi
reset
issue 20 worksheet-queued 'Build worksheet' "$(decl $WS07)"
issue 21 worksheet-queued 'Build worksheet' "$(decl $WS16)"
run; builds_end; time_passes   # the build ended without opening a pull request
run
if grep -q 'issue edit 20 --repo o/r --add-label needs-human' "$FAKE/calls" && grep -q 'issue comment 20 ' "$FAKE/calls" \
   && [ "$(dispatches)" -eq 1 ] && ! grep -q "ws_id=$WS16" "$FAKE/calls"; then
  ok "a build that ended without a pull request is flagged needs-human, and holds the slot"
else
  bad "a stranded worksheet went unflagged, or the next one started behind it" "$WORK/run.log"
fi
time_passes
run
if [ "$(calls_like 'issue comment 20 ')" -eq 1 ] && [ "$(calls_like 'issue edit 20 --repo o/r --add-label needs-human')" -eq 1 ]; then
  ok "it is flagged once, not again on every run"
else
  bad "a flagged worksheet was flagged again" "$FAKE/calls"
fi
reset
issue 20 $'worksheet-queued\nneeds-human' 'Build worksheet' "$(decl $WS07)"   # requeued with its old flag still on
issue 21 worksheet-queued 'Build worksheet' "$(decl $WS16)"
run; builds_end; time_passes   # and its new build also ended without a pull request
run
if grep -q 'issue edit 20 --repo o/r --remove-label worksheet-queued --add-label stage:build --remove-label needs-human' "$FAKE/calls" \
   && grep -q 'issue comment 20 ' "$FAKE/calls" && ! grep -q "ws_id=$WS16" "$FAKE/calls"; then
  ok "a requeued issue loses an old needs-human when it starts, so a second failure is flagged too"
else
  bad "a requeued issue's second failure went unflagged" "$WORK/run.log"
fi
reset
issue 5 'stage:build' 'Something else entirely' 'No identifier in this one.'
issue 20 worksheet-queued 'Build worksheet' "$(decl $WS07)"
run
if grep -q 'issue edit 5 --repo o/r --add-label needs-human' "$FAKE/calls" && [ "$(dispatches)" -eq 0 ]; then
  ok "a stage:build issue that names no worksheet is flagged, and holds the slot"
else
  bad "a stage:build issue naming no worksheet was ignored" "$WORK/run.log"
fi
reset
issue 3 $'stage:build\nneeds-human' 'Build worksheet' "$(decl $WS07)"
issue 20 worksheet-queued 'Build worksheet again' "$(decl $WS07)"
CAP=2 run
if [ "$(dispatches)" -eq 0 ] && [[ "$(labels_of 20)" == *worksheet-queued* ]] && [ ! -s "$FAKE/calls" ]; then
  ok "a worksheet whose issue is flagged is not started again from a second issue"
else
  bad "a flagged worksheet was started again, or flagged again" "$FAKE/calls"
fi

echo "never twice, never forever"
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
issue 20 worksheet-queued 'Build worksheet' "$(decl $WS07)"
FAKE_FAIL_FIELD=body run; rc=$?
if [ "$rc" -ne 0 ] && [ ! -s "$FAKE/calls" ]; then
  ok "a gh read that fails stops the run, rather than being taken as an empty answer"
else
  bad "a failed gh read was taken as an answer (exit $rc)" "$FAKE/calls"
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
