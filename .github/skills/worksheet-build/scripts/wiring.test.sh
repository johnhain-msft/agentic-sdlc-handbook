#!/usr/bin/env bash
#
# wiring.test.sh — prove the factory's compiled workflows are wired the way the
# fixes say, so a recompile or an edit cannot quietly undo one.
#
#   bash .github/skills/worksheet-build/scripts/wiring.test.sh
#
# Checks the COMPILED .lock.yml files, which are what actually runs, and the
# plain workflows and scripts beside them. Only live lines count: a commented
# out step is not wired. Exit 0 = all wired. Exit 1 = not.

set -uo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(git -C "$HERE" rev-parse --show-toplevel)"
WF="$ROOT/.github/workflows"

PASS=0
FAIL=0
ok()  { PASS=$((PASS + 1)); echo "  [ok]   $1"; }
bad() { FAIL=$((FAIL + 1)); echo "  [FAIL] $1"; }

# The file with comment lines removed, so a disabled step does not count.
live() { tr -d '\r' < "$1" | grep -vE '^[[:space:]]*#'; }
count() { live "$1" | grep -cF -- "$2" || true; }
line_of() { live "$1" | grep -nF -- "$2" | head -n 1 | cut -d: -f1; }
before() { local a b; a="$(line_of "$1" "$2")"; b="$(line_of "$1" "$3")"; [ -n "$a" ] && [ -n "$b" ] && [ "$a" -lt "$b" ]; }

echo
echo "WIRING TEST"
echo "========================================================================"

echo "triggers: a stage runs only when its own label is the one just added"
for s in build voice review judge; do
  lock="$WF/aw-worksheet-$s.lock.yml"
  if [ "$(count "$lock" "github.event.label.name == 'stage:$s'")" -ge 1 ] && [ "$(count "$lock" 'labels.*.name')" -eq 0 ]; then
    ok "$s fires on stage:$s alone, not on any label added to an item carrying it"
  else
    bad "$s still fires on any label, or not on stage:$s"
  fi
done

echo "judge routing"
judge="$WF/aw-worksheet-judge.lock.yml"
if [ "$(count "$judge" 'aw-worksheet-build')" -eq 0 ]; then
  ok "the judge cannot dispatch the build stage, which would open a duplicate pull request"
else
  bad "the judge can still dispatch aw-worksheet-build"
fi
if live "$judge" | grep -oE '"add_labels":\{"allowed":\[[^]]*\]' | grep -q '"stage:build"'; then
  bad "the judge may still label a pull request stage:build"
else
  ok "the judge may not label a pull request stage:build"
fi
if [ "$(count "$judge" "--label stage:judge")" -ge 1 ] && [ "$(count "$judge" "sort_by(.number) | .[0].number // empty")" -ge 1 ]; then
  ok "the judge's image gate checks the same pull request capture judges: the oldest"
else
  bad "the judge's image gate may check a different pull request from the one judged"
fi

echo "returned stages see the judge's real verdict"
voice="$WF/aw-worksheet-voice.lock.yml"
if before "$voice" "name: Fetch the judge's verdict for each pull request waiting at voice" 'name: Execute GitHub Copilot CLI'; then
  ok "voice fetches the judge's verdict before its agent starts"
else
  bad "voice does not fetch the judge's verdict before its agent starts"
fi
capture="$HERE/capture-for-review.sh"
if before "$capture" 'fetch-judge-verdict.sh' 'git checkout -B'; then
  ok "review and judge fetch the verdict, before the checkout"
else
  bad "capture-for-review.sh does not fetch the verdict before it checks out the pull request"
fi
if before "$capture" 'TOOLS="$(mktemp -d)"' 'git checkout -B' && before "$capture" 'ensure-attachment.mjs" "$TOOLS/' 'git checkout -B'; then
  ok "capture copies its helpers out before the checkout can remove them"
else
  bad "capture still runs a helper from the tree the checkout replaces"
fi

echo "every test runs in CI"
iso="$WF/worksheet-isolation.yml"
for t in "$HERE"/*.test.sh; do
  name="$(basename "$t")"
  if [ "$(count "$iso" "scripts/$name")" -ge 1 ]; then
    ok "$name runs on every pull request"
  else
    bad "$name exists but worksheet-isolation.yml never runs it"
  fi
done
if [ "$(count "$iso" 'gate-mutation-test.mjs')" -ge 1 ]; then
  ok "gate-mutation-test.mjs runs on every pull request"
else
  bad "gate-mutation-test.mjs is not run in CI"
fi

echo "========================================================================"
if [ "$FAIL" -gt 0 ]; then
  echo "FAIL — $FAIL of $((PASS + FAIL)) cases failed."
  exit 1
fi
echo "PASS — all $PASS cases passed."
