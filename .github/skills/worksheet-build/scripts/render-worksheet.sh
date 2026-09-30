#!/usr/bin/env bash
#
# render-worksheet.sh — render one worksheet, check its layout, shoot it.
#
#   scripts/render-worksheet.sh <ws_id> [--serve] [--port N]
#
#   <ws_id>     e.g. WS-06-team-readiness-scorecard
#   --serve     leave a static server running on localhost and print the URL,
#               so Playwright (which is scoped to localhost) can drive it
#   --port N    server port, default 8977
#
# Exit 0 = rendered and no fatal layout defect.
# Exit 1 = rendered but the layout gate failed.
# Exit 2 = could not render at all.
#
# Outputs land in worksheets/_output/ (HTML) and worksheets/_review/<ws_id>/
# (PNGs + layout-report.json).

set -euo pipefail

WS_ID="${1:-}"
SERVE=0
PORT=8977

shift || true
while [[ $# -gt 0 ]]; do
  case "$1" in
    --serve) SERVE=1; shift ;;
    --port)  PORT="$2"; shift 2 ;;
    *) echo "unknown argument: $1" >&2; exit 2 ;;
  esac
done

if [[ -z "$WS_ID" ]]; then
  echo "usage: render-worksheet.sh <ws_id> [--serve] [--port N]" >&2
  exit 2
fi

ROOT="$(git rev-parse --show-toplevel)"
cd "$ROOT"

SRC="worksheets/${WS_ID}.qmd"
SPEC="docs/worksheets/${WS_ID}.md"
OUT="worksheets/_output/${WS_ID}.html"
REVIEW="worksheets/_review/${WS_ID}"

[[ -f "$SRC" ]]  || { echo "FATAL: no worksheet at $SRC" >&2; exit 2; }
[[ -f "$SPEC" ]] || { echo "FATAL: no build spec at $SPEC — is the ws_id right?" >&2; exit 2; }

echo "==> rendering $SRC"
( cd worksheets && quarto render "${WS_ID}.qmd" )

[[ -f "$OUT" ]] || { echo "FATAL: quarto produced no $OUT" >&2; exit 2; }

mkdir -p "$REVIEW"

echo "==> checking layout"
set +e
node .github/skills/worksheet-build/scripts/check-layout.mjs \
  "$OUT" "$REVIEW" --json "$REVIEW/layout-report.json"
GATE=$?
set -e

if [[ "$SERVE" == "1" ]]; then
  echo "==> serving worksheets/_output on http://localhost:${PORT}"
  # Background a static server so Playwright can reach it over localhost.
  ( cd worksheets/_output && python3 -m http.server "$PORT" --bind 127.0.0.1 >/dev/null 2>&1 & )
  for _ in $(seq 1 40); do
    if curl -fsS "http://localhost:${PORT}/${WS_ID}.html" -o /dev/null 2>/dev/null; then break; fi
    sleep 0.25
  done
  if curl -fsS "http://localhost:${PORT}/${WS_ID}.html" -o /dev/null 2>/dev/null; then
    echo "    READY: http://localhost:${PORT}/${WS_ID}.html"
  else
    echo "    WARNING: server did not come up on port ${PORT}" >&2
  fi
fi

echo
echo "  worksheet : $OUT"
echo "  review    : $REVIEW"
exit "$GATE"
