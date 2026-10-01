#!/usr/bin/env bash
#
# fetch-judge-verdict.sh — put the judge's latest verdict on a pull request
# where the stage it was returned to will read it.
#
#   fetch-judge-verdict.sh <pull-request-number> <out-file>
#
# When the judge fails a worksheet and returns it to voice or review, its
# findings live in a comment on the pull request. Neither stage looked there,
# so a return trip re-ran a generic pass blind to what had failed.
#
# Only a comment the judge workflow itself posted counts. The repository is
# public, so anyone can write "WORKSHEET JUDGE:" in a comment, and a stage
# reading that as its instructions would be taking orders from a stranger. A
# comment counts only if github-actions[bot] posted it AND the last gh-aw
# footer marker in it names this repository's aw-worksheet-judge workflow. The
# footer is appended after the agent's text, so a report that merely quotes a
# judge marker still ends in its own workflow's marker and is ignored.
#
# Writes the most recent such verdict to <out-file>, or an empty file if the
# judge has not ruled. Exit 0 either way. Exit 2, with a warning and an empty
# file, if the comments could not be read at all: that is not the same as "no
# verdict", and must not be reported as if it were.

set -uo pipefail

PR="${1:?usage: fetch-judge-verdict.sh <pull-request-number> <out-file>}"
OUT="${2:?usage: fetch-judge-verdict.sh <pull-request-number> <out-file>}"

mkdir -p "$(dirname "$OUT")"
: > "$OUT"

repo="${GITHUB_REPOSITORY:-}"
if [ -z "$repo" ]; then
  repo="$(gh repo view --json nameWithOwner --jq '.nameWithOwner' 2>/dev/null)" || repo=""
fi
if [ -z "$repo" ]; then
  echo "::warning title=Judge verdict unreadable::cannot tell which repository #$PR is in" >&2
  exit 2
fi

raw="$(mktemp)"
# per_page=100: one page covers any realistic pull request; each stage posts
# about one comment per pass and the cycle bound stops at three.
if ! gh api "repos/$repo/issues/$PR/comments?per_page=100" > "$raw" 2> "$raw.err"; then
  echo "::warning title=Judge verdict unreadable::could not read the comments on #$PR: $(head -c 300 "$raw.err" | tr '\n' ' ')" >&2
  exit 2
fi

if ! python3 - "$raw" "$repo" > "$OUT" <<'PY'
import json, re, sys

# gh-aw footers carry symbols such as U+2316; without this, Windows writes
# redirected output as cp1252 and a real verdict fails to encode.
sys.stdout.reconfigure(encoding="utf-8")

comments = json.load(open(sys.argv[1], encoding="utf-8"))
judge = f"{sys.argv[2]}/aw-worksheet-judge"
verdict = ""
for c in comments:  # oldest first, as the API returns them
    # Safe outputs post as github-actions[bot] because GH_AW_GITHUB_TOKEN is
    # not set. If that secret is ever added, comments come from its owner, and
    # this check must change with it or every real verdict is dropped.
    if (c.get("user") or {}).get("login") != "github-actions[bot]":
        continue
    body = c.get("body") or ""
    markers = re.findall(r"gh-aw-workflow-call-id:\s*(\S+)", body)
    if markers and markers[-1] == judge and "WORKSHEET JUDGE:" in body:
        verdict = body
sys.stdout.write(verdict)
PY
then
  : > "$OUT"
  echo "::warning title=Judge verdict unreadable::the comments on #$PR could not be parsed" >&2
  exit 2
fi

if [ -s "$OUT" ]; then
  echo "verdict: the judge's latest verdict on #$PR is in $OUT"
else
  echo "verdict: the judge has not ruled on #$PR"
fi
