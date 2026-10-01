#!/usr/bin/env bash
#
# resolve-build-request.sh — decide which worksheet a build run is for, BEFORE
# the agent starts.
#
#   resolve-build-request.sh <out-dir>
#
# Reads the trigger from EVENT_NAME and the request from that trigger only:
#
#   workflow_dispatch   INPUT_WS_ID, which must be one ws_id and nothing else
#   issues              a declaration line in ISSUE_BODY ("ws_id: <id>", written
#                       "**ws_id:** `<id>`" in the build issues), else
#                       ISSUE_TITLE. Only text a reader can see counts: HTML
#                       comments and fenced code blocks are ignored. A title
#                       that names a different worksheet from the body is
#                       refused, and an id mentioned only in prose is not used.
#   push                the "ws_id: <id>" line of BUILD_REQUEST_FILE
#                       (default worksheets/_build-request.txt)
#
# A ws_id counts only as a whole token: "WS-07-cost-vs-value-gate-V2" is not
# WS-07-cost-vs-value-gate.
#
# Writes <out-dir>/ws_id and <out-dir>/request.json. Exits 1, before any model
# call is spent, unless it finds exactly one well-formed ws_id with a build
# spec. It never guesses: an ambiguous or conflicting request fails.
#
# The agent used to work the ws_id out for itself. It could not see the
# dispatch input, so it read the push-path request file instead, which still
# named a worksheet that had already shipped, and it spent a run on a no-op.

set -euo pipefail
# Byte semantics, identical on every runner: [A-Z] means A to Z and nothing else.
export LC_ALL=C

OUT="${1:?usage: resolve-build-request.sh <out-dir>}"
ROOT="$(git -C "$(dirname "${BASH_SOURCE[0]}")" rev-parse --show-toplevel)"
cd "$ROOT"

# "WS", one or more upper-case or numeric segments (-07, -APXA, -CS-APM), then
# one or more lower-case slug segments. Derived from all 72 build specs, which
# the test checks.
ID='WS(-[A-Z0-9]+)+(-[a-z0-9]+)+'

# A line that declares the ws_id and says nothing else.
DECL="^[[:space:]]*(\*\*)?ws_id:(\*\*)?[[:space:]]*\`?${ID}\`?[[:space:]]*\$"

refuse() {
  echo "::error title=No worksheet to build::$1"
  if [ -n "${GITHUB_STEP_SUMMARY:-}" ]; then
    printf '**Build refused:** %s\n' "$1" >> "$GITHUB_STEP_SUMMARY"
  fi
  exit 1
}

# Unique whole-token ws_ids in stdin, one per line.
ids() { { grep -oE '[A-Za-z0-9_-]+' || true; } | { grep -xE "$ID" || true; } | sort -u; }

# Only the text a reader of the rendered issue sees: drop fenced code blocks
# and HTML comments, including comments that span lines. [ \t] rather than a
# POSIX class, because Ubuntu's default awk is mawk.
visible() {
  awk '
    !c && /^[ \t]*(```|~~~)/ { f = !f; next }
    f { next }
    {
      line = $0; out = ""
      while (length(line)) {
        if (c) { i = index(line, "-->"); if (!i) { line = ""; break }; line = substr(line, i + 3); c = 0 }
        else   { i = index(line, "<!--"); if (!i) { out = out line; break }; out = out substr(line, 1, i - 1); line = substr(line, i + 4); c = 1 }
      }
      print out
    }'
}

count() { if [ -z "$1" ]; then echo 0; else printf '%s\n' "$1" | wc -l | tr -d ' '; fi; }
oneline() { printf '%s' "$1" | tr '\n' ' ' | sed 's/ $//'; }

case "${EVENT_NAME:-}" in
  workflow_dispatch)
    source="the workflow_dispatch input ws_id"
    input="$(printf '%s' "${INPUT_WS_ID:-}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
    # The whole input must be one identifier and nothing else, so a value with
    # anything appended (a second line, a shell fragment) is refused outright.
    found="$(printf '%s\n' "$input" | grep -xE "$ID" || true)"
    [ "$found" = "$input" ] || found=""
    ;;
  issues)
    body="$(printf '%s\n' "${ISSUE_BODY:-}" | tr -d '\r' | visible)"
    declared="$( { printf '%s\n' "$body" | grep -E "$DECL" || true; } | ids)"
    titled="$(printf '%s\n' "${ISSUE_TITLE:-}" | ids)"
    if [ -n "$declared" ]; then
      source="the issue body's ws_id line"
      found="$declared"
      if [ -n "$titled" ] && [ "$titled" != "$declared" ]; then
        refuse "the issue title names $(oneline "$titled") but its body declares $(oneline "$declared")."
      fi
    else
      source="the issue title"
      found="$titled"
    fi
    ;;
  push)
    file="${BUILD_REQUEST_FILE:-worksheets/_build-request.txt}"
    source="$file"
    [ -f "$file" ] || refuse "push trigger, but there is no request file at $file."
    found="$( { tr -d '\r' < "$file" | grep -E "$DECL" || true; } | ids)"
    ;;
  *)
    refuse "unsupported trigger '${EVENT_NAME:-}'. Expected workflow_dispatch, issues or push."
    ;;
esac

n="$(count "$found")"
[ "$n" -eq 1 ] || refuse "expected exactly one ws_id from $source, found $n${found:+: $(oneline "$found")}."

ws_id="$found"
[ -f "docs/worksheets/${ws_id}.md" ] || refuse "$ws_id came from $source, but there is no build spec at docs/worksheets/${ws_id}.md."

mkdir -p "$OUT"
printf '%s\n' "$ws_id" > "$OUT/ws_id"
printf '{"ws_id":"%s","trigger":"%s","source":"%s"}\n' "$ws_id" "$EVENT_NAME" "$source" > "$OUT/request.json"

echo "Resolved ws_id=$ws_id from $source."
if [ -n "${GITHUB_STEP_SUMMARY:-}" ]; then
  printf '**Building:** `%s` (from %s)\n' "$ws_id" "$source" >> "$GITHUB_STEP_SUMMARY"
fi
