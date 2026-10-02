#!/usr/bin/env bash
#
# promote-queue.sh — start the next queued worksheet, and tidy up after a merge.
#
#   REPO=owner/name [MAX_IN_FLIGHT=1] [DEFAULT_BRANCH=main] \
#   [CLOSED_PR=<n> CLOSED_PR_MERGED=true|false] promote-queue.sh
#
# The queue used to relabel an issue stage:build and stop there. A label
# applied with GITHUB_TOKEN never creates a workflow run, so no promotion it
# made ever started a build. workflow_dispatch is the documented exception, so
# this dispatches the build directly, with the ws_id resolved from the issue by
# the same resolver the build itself uses.
#
# One worksheet at a time (MAX_IN_FLIGHT=1). Dispatched runs of a stage share
# one concurrency group and cancel each other, so two pull requests moving
# through the stages at once would strand one of them. A build that is still
# running counts as in flight, so a just-dispatched build holds the slot before
# its pull request exists. So does every open worksheet pull request, including
# one waiting for a person: merging it is what frees the slot.
#
# The issue is relabelled BEFORE the build is dispatched, and put back if the
# dispatch fails, so an issue is never dispatched twice and never left at
# stage:build with nothing running. An issue for a worksheet already on main is
# closed; one already in an open pull request is left queued; one that names no
# single buildable worksheet leaves the queue as needs-human, with a comment.
#
# When a worksheet pull request closes (CLOSED_PR), the issue it was built from
# is closed if it merged, or flagged needs-human if it did not.

set -euo pipefail

: "${REPO:?set REPO to owner/name}"
MAX_IN_FLIGHT="${MAX_IN_FLIGHT:-1}"
DEFAULT_BRANCH="${DEFAULT_BRANCH:-main}"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(git -C "$HERE" rev-parse --show-toplevel)"

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

# ---- after a worksheet pull request closes ---------------------------------
if [ -n "${CLOSED_PR:-}" ]; then
  closed_ws="$(gh pr view "$CLOSED_PR" --repo "$REPO" --json files --jq '.files[].path' | ws_of_files | head -n 1)"
  if [ -n "$closed_ws" ]; then
    for n in $(gh issue list --repo "$REPO" --state open --label 'stage:build' --json number --jq '.[].number'); do
      [ "$(issue_ws_id "$n")" = "$closed_ws" ] || continue
      if [ "${CLOSED_PR_MERGED:-false}" = "true" ]; then
        echo "issue #$n: $closed_ws merged in #$CLOSED_PR — closing it"
        gh issue close "$n" --repo "$REPO" --comment "Built and merged in #$CLOSED_PR."
      else
        echo "issue #$n: #$CLOSED_PR closed without merging — flagging it"
        gh issue edit "$n" --repo "$REPO" --add-label needs-human
        gh issue comment "$n" --repo "$REPO" --body "Its pull request #$CLOSED_PR was closed without merging. To build it again, remove stage:build and needs-human and label it worksheet-queued."
      fi
    done
  fi
fi

# ---- what is in flight ------------------------------------------------------
open_prs="$(gh pr list --repo "$REPO" --state open --label worksheet --json number --jq 'length')"
running="$(gh run list --repo "$REPO" --workflow aw-worksheet-build.lock.yml --limit 20 \
             --json status --jq '[.[] | select(.status != "completed")] | length')"
in_flight=$(( open_prs + running ))
echo "in flight: $open_prs open worksheet pull request(s) + $running running build(s) (cap $MAX_IN_FLIGHT)"

slots=$(( MAX_IN_FLIGHT - in_flight ))
if [ "$slots" -le 0 ]; then
  echo "At capacity. Nothing promoted."
  exit 0
fi

# Oldest first: issues are created in the order the queue should run.
mapfile -t queued < <(
  gh issue list --repo "$REPO" --state open --label worksheet-queued --limit 200 \
    --json number,createdAt --jq 'sort_by(.createdAt)[].number'
)
if [ "${#queued[@]}" -eq 0 ]; then
  echo "Queue is empty. Nothing to promote."
  exit 0
fi

in_prs="$(gh pr list --repo "$REPO" --state open --label worksheet --json files --jq '.[].files[].path' | ws_of_files)"
declare -A started=()
promoted=0

for n in "${queued[@]}"; do
  [ "$promoted" -ge "$slots" ] && break

  # Never restart a worksheet that is already moving.
  labels="$(gh issue view "$n" --repo "$REPO" --json labels --jq '.labels[].name')"
  if printf '%s\n' "$labels" | grep -qE '^stage:'; then
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

  if [ -f "$ROOT/worksheets/$ws_id.qmd" ]; then
    echo "issue #$n: $ws_id is already on $DEFAULT_BRANCH — closing it"
    gh issue close "$n" --repo "$REPO" --comment "worksheets/$ws_id.qmd is already on $DEFAULT_BRANCH, so there is nothing to build."
    continue
  fi
  if printf '%s\n' "$in_prs" | grep -qxF -- "$ws_id"; then
    echo "issue #$n: $ws_id already has an open pull request — leaving it queued"
    continue
  fi
  if [ -n "${started[$ws_id]:-}" ]; then
    echo "issue #$n: $ws_id was started from issue #${started[$ws_id]} in this run — leaving it queued"
    continue
  fi

  echo "issue #$n: starting the build of $ws_id"
  gh issue edit "$n" --repo "$REPO" --remove-label worksheet-queued --add-label 'stage:build'
  if ! gh workflow run aw-worksheet-build.lock.yml --repo "$REPO" --ref "$DEFAULT_BRANCH" -f "ws_id=$ws_id"; then
    gh issue edit "$n" --repo "$REPO" --remove-label 'stage:build' --add-label worksheet-queued || true
    echo "::error title=Build not started::could not dispatch the build of $ws_id for issue #$n; it is back in the queue" >&2
    exit 1
  fi
  started[$ws_id]="$n"
  promoted=$(( promoted + 1 ))
done

echo "promoted $promoted worksheet(s); $(( slots - promoted )) slot(s) left idle"
