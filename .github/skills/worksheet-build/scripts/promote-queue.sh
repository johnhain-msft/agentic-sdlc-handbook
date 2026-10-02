#!/usr/bin/env bash
#
# promote-queue.sh — keep the worksheet queue honest, then start the next one.
#
#   REPO=owner/name [MAX_IN_FLIGHT=1] [DEFAULT_BRANCH=main] [GRACE_MINUTES=15] \
#   promote-queue.sh
#
# The queue used to relabel an issue stage:build and stop there. A label
# applied with GITHUB_TOKEN never creates a workflow run, so no promotion it
# made ever started a build. workflow_dispatch is the documented exception, so
# this dispatches the build directly, with the ws_id resolved from the issue by
# the same resolver the build itself uses.
#
# Every run does the whole job and reads nothing from the event that started
# it. A pending run that GitHub cancels in favour of a newer one therefore
# loses nothing: the newer run does the same work.
#
# 1. Reconcile. An open stage:build issue is a worksheet in flight, from the
#    moment it is promoted until its worksheet is on main. Each one is
#      - closed once worksheets/<ws_id>.qmd is on main: built and merged;
#      - left alone while its pull request is open or any build is running;
#      - otherwise flagged needs-human, once, after GRACE_MINUTES with no
#        update: its build ended without a pull request, or its pull request
#        was closed without merging. The grace covers a build GitHub has
#        accepted but not listed yet.
#    A flagged issue keeps its slot. A worksheet that failed stops the line
#    until a person looks, rather than the queue spending a build on every
#    worksheet behind it.
#
# 2. Count. In flight = the worksheets with an open stage:build issue or an
#    open worksheet pull request, plus every build run not yet completed.
#    Runs are counted by status, so no number of newer runs can push a running
#    build out of view. A running build is counted even when its issue is
#    too: the count can overstate, never understate.
#
# 3. Promote, oldest first, while a slot is free. One worksheet at a time
#    (MAX_IN_FLIGHT=1): dispatched runs of a stage share one concurrency group
#    and cancel each other, so two pull requests in the stages at once would
#    strand one of them. The issue is relabelled BEFORE the build is
#    dispatched, and put back if the dispatch fails, so an issue is never
#    dispatched twice. A worksheet already on main is closed; one already in
#    flight is left queued; an issue that names no single buildable worksheet
#    leaves the queue as needs-human, with a comment.

set -euo pipefail
# A gh call that fails inside $(...) must stop the run, not read as "nothing".
shopt -s inherit_errexit

: "${REPO:?set REPO to owner/name}"
MAX_IN_FLIGHT="${MAX_IN_FLIGHT:-1}"
DEFAULT_BRANCH="${DEFAULT_BRANCH:-main}"
GRACE_MINUTES="${GRACE_MINUTES:-15}"
BUILD=aw-worksheet-build.lock.yml
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(git -C "$HERE" rev-parse --show-toplevel)"
# What is on main. The workflow checks main out; the test points this elsewhere.
WORKSHEETS_DIR="${WORKSHEETS_DIR:-$ROOT/worksheets}"

# The ws_id an issue names, via the build's own resolver; or "REFUSED:<why>".
issue_ws_id() {
  local n="$1" title body out
  title="$(gh issue view "$n" --repo "$REPO" --json title --jq '.title')"
  body="$(gh issue view "$n" --repo "$REPO" --json body --jq '.body')"
  out="$(mktemp -d)"
  if EVENT_NAME=issues ISSUE_TITLE="$title" ISSUE_BODY="$body" GITHUB_STEP_SUMMARY= \
       bash "$HERE/resolve-build-request.sh" "$out" > "$out/resolve.log" 2>&1; then
    cat "$out/ws_id"
  else
    printf 'REFUSED:%s\n' "$(sed -n 's/^::error title=[^:]*:://p' "$out/resolve.log" | head -n 1)"
  fi
}

ws_of_files() { sed -n 's|^worksheets/\([^/]*\)\.qmd$|\1|p'; }
on_main() { [ -f "$WORKSHEETS_DIR/$1.qmd" ]; }
# has_line <line> <newline-separated lines>
has_line() { [[ $'\n'"$2"$'\n' == *$'\n'"$1"$'\n'* ]]; }

# flag <issue> <what happened>: needs-human, and a comment saying what to do.
flag() {
  echo "issue #$1: flagged needs-human — $2"
  gh issue edit "$1" --repo "$REPO" --add-label needs-human
  gh issue comment "$1" --repo "$REPO" --body "$2 It keeps its slot in the worksheet queue until someone deals with it. To build it again, remove stage:build and needs-human and label it worksheet-queued. To drop it, close this issue, and the queue moves on."
}

# ws_id, or a stand-in for an item that names none -> what holds that slot.
declare -A flight=()
# ws_id -> its open worksheet pull request.
declare -A pr_for=()

# ---- 1. reconcile -------------------------------------------------------------
pr_rows="$(gh pr list --repo "$REPO" --state open --label worksheet --limit 100 --json number,files \
             --jq '.[] | "\(.number) \([.files[].path | select(test("^worksheets/[^/]+[.]qmd$"))][0] // "")"')"
while read -r num path; do
  [ -n "$num" ] || continue
  ws="$(printf '%s\n' "${path:-}" | ws_of_files)"
  ws="${ws:-pull request #$num}"
  pr_for["$ws"]="$num"
  flight["$ws"]="pull request #$num"
done <<< "$pr_rows"

running=0
for status in queued in_progress waiting requested pending; do
  n_runs="$(gh run list --repo "$REPO" --workflow "$BUILD" --status "$status" --limit 100 \
              --json databaseId --jq 'length')"
  running=$(( running + n_runs ))
done

now="$(date -u +%s)"
building="$(gh issue list --repo "$REPO" --state open --label 'stage:build' --limit 200 \
              --json number --jq '.[].number')"
for n in $building; do
  ws="$(issue_ws_id "$n")"
  labels="$(gh issue view "$n" --repo "$REPO" --json labels --jq '.labels[].name')"
  if [[ "$ws" == REFUSED:* ]]; then
    flight["issue #$n"]="issue #$n"
    has_line needs-human "$labels" \
      || flag "$n" "This issue is at stage:build but does not name exactly one worksheet with a build spec."
    continue
  fi
  if on_main "$ws"; then
    echo "issue #$n: $ws is on $DEFAULT_BRANCH — closing it"
    gh issue close "$n" --repo "$REPO" --comment "worksheets/$ws.qmd is on $DEFAULT_BRANCH: built and merged."
    continue
  fi
  flight["$ws"]="${flight[$ws]:-issue #$n}"
  if [ -n "${pr_for[$ws]:-}" ] || [ "$running" -gt 0 ] || has_line needs-human "$labels"; then
    continue
  fi
  updated="$(gh issue view "$n" --repo "$REPO" --json updatedAt --jq '.updatedAt')"
  updated_s="$(date -u -d "$updated" +%s)"
  if [ $(( now - updated_s )) -lt $(( GRACE_MINUTES * 60 )) ]; then
    echo "issue #$n: no pull request or running build for $ws yet, but it changed under $GRACE_MINUTES minutes ago"
    continue
  fi
  flag "$n" "No pull request is open for $ws and no build is running: its build never opened one, or its pull request was closed without merging."
done

# ---- 2. count -----------------------------------------------------------------
in_flight=$(( ${#flight[@]} + running ))
echo "in flight: ${#flight[@]} worksheet(s) with an open issue or pull request + $running unfinished build run(s) (cap $MAX_IN_FLIGHT)"
for k in "${!flight[@]}"; do echo "  $k (${flight[$k]})"; done

slots=$(( MAX_IN_FLIGHT - in_flight ))
if [ "$slots" -le 0 ]; then
  echo "At capacity. Nothing promoted."
  exit 0
fi

# ---- 3. promote, oldest first: issues are created in the order the queue runs --
queued="$(gh issue list --repo "$REPO" --state open --label worksheet-queued --limit 200 \
            --json number,createdAt --jq 'sort_by(.createdAt)[].number')"
if [ -z "$queued" ]; then
  echo "Queue is empty. Nothing to promote."
  exit 0
fi

promoted=0
for n in $queued; do
  [ "$promoted" -ge "$slots" ] && break

  # Never restart a worksheet that is already moving.
  labels="$(gh issue view "$n" --repo "$REPO" --json labels --jq '.labels[].name')"
  if [[ $'\n'"$labels" == *$'\n'stage:* ]]; then
    echo "issue #$n already has a stage label — skipping"
    continue
  fi

  ws_id="$(issue_ws_id "$n")"
  if [[ "$ws_id" == REFUSED:* ]]; then
    reason="${ws_id#REFUSED:}"
    reason="${reason:-it does not name exactly one worksheet with a build spec}"
    echo "issue #$n: taken out of the queue — $reason"
    gh issue edit "$n" --repo "$REPO" --remove-label worksheet-queued --add-label needs-human
    gh issue comment "$n" --repo "$REPO" --body "Taken out of the worksheet queue: $reason Give the issue one line reading ws_id: followed by the worksheet's id, then queue it again."
    continue
  fi

  if on_main "$ws_id"; then
    echo "issue #$n: $ws_id is already on $DEFAULT_BRANCH — closing it"
    gh issue close "$n" --repo "$REPO" --comment "worksheets/$ws_id.qmd is already on $DEFAULT_BRANCH, so there is nothing to build."
    continue
  fi
  if [ -n "${flight[$ws_id]:-}" ]; then
    echo "issue #$n: $ws_id is already in flight (${flight[$ws_id]}) — leaving it queued"
    continue
  fi

  echo "issue #$n: starting the build of $ws_id"
  relabel=(--remove-label worksheet-queued --add-label 'stage:build')
  # A needs-human left over from an earlier failure would make reconcile skip
  # this issue if its new build fails too, so the line would stop silently.
  if has_line needs-human "$labels"; then relabel+=(--remove-label needs-human); fi
  gh issue edit "$n" --repo "$REPO" "${relabel[@]}"
  if ! gh workflow run "$BUILD" --repo "$REPO" --ref "$DEFAULT_BRANCH" -f "ws_id=$ws_id"; then
    gh issue edit "$n" --repo "$REPO" --remove-label 'stage:build' --add-label worksheet-queued || true
    echo "::error title=Build not started::could not dispatch the build of $ws_id for issue #$n; it is back in the queue" >&2
    exit 1
  fi
  flight["$ws_id"]="issue #$n"
  promoted=$(( promoted + 1 ))
done

echo "promoted $promoted worksheet(s); $(( slots - promoted )) slot(s) left idle"
