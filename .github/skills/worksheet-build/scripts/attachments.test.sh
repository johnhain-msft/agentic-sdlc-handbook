#!/usr/bin/env bash
#
# attachments.test.sh — prove that every image attached to a review or judge
# run is one the model will accept.
#
#   bash .github/skills/worksheet-build/scripts/attachments.test.sh
#
# Exit 0 = every case passed. Exit 1 = at least one failed.
#
# One unusable image in a Copilot request makes the model reject the request,
# and the CLI then drops EVERY image and carries on blind. The WS-16 review saw
# nothing for exactly that reason: the third attachment slot of a two-sheet
# worksheet held a 1x1 fallback PNG, because the card renderer could not load
# playwright from the repository root.

set -uo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(git -C "$HERE" rev-parse --show-toplevel)"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

PASS=0
FAIL=0
ok()  { PASS=$((PASS + 1)); echo "  [ok]   $1"; }
bad() { FAIL=$((FAIL + 1)); echo "  [FAIL] $1"; }

# "<w>x<h>" for a file that starts like a PNG, "not-a-png", or "missing".
dims() {
  node -e '
    const fs = require("fs");
    try {
      const b = fs.readFileSync(process.argv[1]);
      console.log(b.length >= 24 && b.toString("latin1", 12, 16) === "IHDR"
        ? `${b.readUInt32BE(16)}x${b.readUInt32BE(20)}` : "not-a-png");
    } catch { console.log("missing"); }' "$1"
}
big_enough() { local d; d="$(dims "$1")"; [[ "$d" =~ ^([0-9]+)x([0-9]+)$ ]] && [ "${BASH_REMATCH[1]}" -ge "$2" ] && [ "${BASH_REMATCH[2]}" -ge "$3" ]; }
digest() { node -e 'console.log(require("crypto").createHash("sha256").update(require("fs").readFileSync(process.argv[1])).digest("hex"))' "$1"; }

ENSURE="$HERE/ensure-attachment.mjs"
CARD="$HERE/note-card.mjs"

echo
echo "ATTACHMENTS TEST"
echo "========================================================================"

echo "note-card.mjs"
# Run from the repository root, exactly as capture-for-review.sh does.
if (cd "$ROOT" && node "$CARD" "$WORK/card.png" '#b3261e' \
      'This worksheet has fewer than 3 sheets. Nothing to show in this slot.') >"$WORK/card.log" 2>&1 \
   && big_enough "$WORK/card.png" 1000 300; then
  ok "renders a real card from the repository root ($(dims "$WORK/card.png"))"
else
  bad "did not render a real card from the repository root: $(dims "$WORK/card.png") $(head -c 300 "$WORK/card.log")"
fi
if (cd "$ROOT" && node "$CARD" "$WORK/long.png" '#334155' \
      "$(printf 'A long failure reason %.0s' {1..60})") >/dev/null 2>&1 \
   && big_enough "$WORK/long.png" 1000 300; then
  ok "a long message still renders"
else
  bad "a long message did not render: $(dims "$WORK/long.png")"
fi

echo "ensure-attachment.mjs"
# The exact 1x1 PNG that blinded the WS-16 review.
printf '\211PNG\r\n\032\n\0\0\0\rIHDR\0\0\0\1\0\0\0\1\10\6\0\0\0\37\25\304\211\0\0\0\nIDATx\234c\370\17\0\1\1\1\0\30\335\215\260\0\0\0\0IEND\256B`\202' > "$WORK/one.png"
replaced() {
  local name="$1" file="$2"
  node "$ENSURE" "$file" >/dev/null 2>"$WORK/warn.log"
  if big_enough "$file" 1000 300 && grep -q '^::warning title=Attachment replaced::' "$WORK/warn.log"; then
    ok "$name is replaced, with a warning ($(dims "$file"))"
  else
    bad "$name was not replaced: $(dims "$file") $(cat "$WORK/warn.log")"
  fi
}
replaced "the 1x1 fallback PNG" "$WORK/one.png"
replaced "a missing file" "$WORK/missing/none.png"
printf 'not an image at all' > "$WORK/junk.png"
replaced "a file that is not a PNG" "$WORK/junk.png"
if [ -f "$WORK/card.png" ]; then
  head -c 600 "$WORK/card.png" > "$WORK/truncated.png"
  replaced "a truncated PNG" "$WORK/truncated.png"
  cp "$WORK/card.png" "$WORK/corrupt.png"
  node -e 'const fs=require("fs"),p=process.argv[1],b=fs.readFileSync(p);b[b.length-200]^=0xff;fs.writeFileSync(p,b)' "$WORK/corrupt.png"
  replaced "a PNG with a corrupted chunk" "$WORK/corrupt.png"

  cp "$WORK/card.png" "$WORK/good.png"
  before="$(digest "$WORK/good.png")"
  node "$ENSURE" "$WORK/good.png" 2>"$WORK/warn.log"
  if [ "$before" = "$(digest "$WORK/good.png")" ] && [ ! -s "$WORK/warn.log" ]; then
    ok "a good image is left byte for byte, with no warning"
  else
    bad "a good image was changed or warned about: $(cat "$WORK/warn.log")"
  fi
else
  bad "the truncated, corrupted and good-image cases need a rendered card, and there is none"
fi
node "$ENSURE" "$WORK/a.png" "$WORK/b.png" 2>/dev/null
if big_enough "$WORK/a.png" 1000 300 && big_enough "$WORK/b.png" 1000 300; then
  ok "several slots are checked in one call"
else
  bad "several slots were not all checked: $(dims "$WORK/a.png") $(dims "$WORK/b.png")"
fi
# Valid checksums, but pixel data too short for the size the header claims:
# the second flaw of the CI file, at a size the minimum would otherwise allow.
node -e '
  const zlib = require("zlib"), fs = require("fs");
  const T = Array.from({length:256},(_,n)=>{let c=n;for(let k=0;k<8;k++)c=c&1?0xedb88320^(c>>>1):c>>>1;return c>>>0});
  const crc = (b)=>{let c=0xffffffff;for(const x of b)c=T[(c^x)&0xff]^(c>>>8);return (c^0xffffffff)>>>0};
  const chunk = (t,d)=>{const h=Buffer.alloc(8);h.writeUInt32BE(d.length);h.write(t,4,"latin1");const c=Buffer.alloc(4);c.writeUInt32BE(crc(Buffer.concat([h.subarray(4),d])));return Buffer.concat([h,d,c])};
  const ihdr = Buffer.alloc(13); ihdr.writeUInt32BE(300,0); ihdr.writeUInt32BE(200,4); ihdr[8]=8; ihdr[9]=2;
  fs.writeFileSync(process.argv[1], Buffer.concat([Buffer.from([137,80,78,71,13,10,26,10]), chunk("IHDR",ihdr),
    chunk("IDAT", zlib.deflateSync(Buffer.alloc(1000))), chunk("IEND", Buffer.alloc(0))]));' "$WORK/short.png"
replaced "a PNG whose pixel data is too short for its size" "$WORK/short.png"
printf '\211PNG\r\n\032\n\0\0\0\rIHDR\0\0\0\1\0\0\0\1\10\6\0\0\0\37\25\304\211\0\0\0\nIDATx\234c\370\17\0\1\1\1\0\30\335\215\260\0\0\0\0IEND\256B`\202' > "$WORK/check.png"
before="$(digest "$WORK/check.png")"
if ! node "$ENSURE" --check "$WORK/check.png" 2>/dev/null && [ "$before" = "$(digest "$WORK/check.png")" ]; then
  ok "--check reports a bad file without touching it"
else
  bad "--check passed a bad file, or changed it"
fi
mkdir -p "$WORK/a-directory.png"
if node "$ENSURE" "$WORK/a-directory.png" "$WORK/after.png" >/dev/null 2>&1 && big_enough "$WORK/after.png" 1000 300; then
  ok "a slot that cannot be replaced does not stop the rest, and exit is still 0"
else
  bad "one unreplaceable slot stopped the others or failed the call"
fi
if node "$ENSURE" "$WORK/one-more.png" 2>/dev/null; then
  ok "a replaced slot is reported, never fatal"
else
  bad "ensure-attachment.mjs exited non-zero"
fi

echo "capture-for-review.sh, end to end"
# Run the REAL capture against a pull request head that predates the helpers,
# exactly as the review of a pull request built before this fix would: main's
# capture script starts, checks out the pull request's tree, then needs them.
if ! command -v quarto >/dev/null || ! command -v python3 >/dev/null; then
  bad "the end-to-end capture needs quarto and python3 on PATH"
else
  R="$WORK/scratch"
  git clone -q --shared --no-checkout "$ROOT" "$R"
  git -C "$R" checkout -q --detach "$(git -C "$ROOT" rev-parse HEAD)"
  # The clone holds committed files only. Commit this working tree's scripts
  # on top, as "main with the fix", and link the untracked node_modules in.
  cp "$HERE"/*.sh "$HERE"/*.mjs "$R/.github/skills/worksheet-build/scripts/"
  ln -s "$(cd "$HERE/.." && pwd)/node_modules" "$R/.github/skills/worksheet-build/node_modules" 2>/dev/null \
    || cp -r "$HERE/../node_modules" "$R/.github/skills/worksheet-build/"
  git -C "$R" add .github/skills/worksheet-build/scripts
  git -C "$R" -c user.name=test -c user.email=test@example.com commit -q --allow-empty -m 'main, with the fix under test'
  git -C "$R" branch -q -f main-under-test HEAD

  # The pull request: no helpers, and a one-sheet worksheet, so slots two and
  # three both need cards. Built with plumbing, leaving the working tree alone.
  base="$(git -C "$R" rev-parse HEAD)"
  export GIT_INDEX_FILE="$WORK/pr.index"
  git -C "$R" read-tree "$base"
  git -C "$R" rm -q --cached .github/skills/worksheet-build/scripts/note-card.mjs \
                             .github/skills/worksheet-build/scripts/ensure-attachment.mjs
  blob="$(git -C "$R" hash-object -w "$R/worksheets/specimen.qmd")"
  git -C "$R" update-index --add --cacheinfo "100644,$blob,worksheets/WS-07-cost-vs-value-gate.qmd"
  tree="$(git -C "$R" write-tree)"
  unset GIT_INDEX_FILE
  pr="$(git -C "$R" -c user.name=test -c user.email=test@example.com commit-tree "$tree" -p "$base" -m 'a pull request built before the fix')"
  git -C "$R" update-ref refs/remotes/origin/pull/99/head "$pr"

  # A stand-in for gh: pull request 99 is waiting, and changes what we say.
  mkdir -p "$WORK/bin"
  cat > "$WORK/bin/gh" <<'GH'
#!/usr/bin/env bash
case " $* " in
  *" pr list "*) echo 99 ;;
  *" pr view "*) [ -n "${FAKE_PR_FILES:-}" ] && printf '%s\n' "$FAKE_PR_FILES" ;;
  # Like the API: only the exact comments path answers, with a judge verdict
  # posted the way the judge workflow posts it; anything else is a 404.
  *" api repos/o/r/issues/99/comments?per_page=100 "*)
    if [ -n "${FAKE_VERDICT:-}" ]; then
      python3 -c 'import json, os; print(json.dumps([{"user": {"login": "github-actions[bot]"}, "body": os.environ["FAKE_VERDICT"] + "\n\n<!-- gh-aw-workflow-call-id: o/r/aw-worksheet-judge -->"}]))'
    else
      echo '[]'
    fi ;;
  *" api "*) echo "gh: Not Found (HTTP 404)" >&2; exit 1 ;;
  *) echo "stand-in gh: unexpected call: $*" >&2; exit 1 ;;
esac
GH
  chmod +x "$WORK/bin/gh"

  # capture <name> <files the pull request changes> [judge verdict] -> leaves $OUT
  capture() {
    git -C "$R" checkout -q -f main-under-test
    git -C "$R" clean -qfdx -e node_modules
    OUT="$WORK/out-$1"
    (cd "$R" && PATH="$WORK/bin:$PATH" GITHUB_REPOSITORY=o/r FAKE_PR_FILES="$2" FAKE_VERDICT="${3:-}" \
       bash .github/skills/worksheet-build/scripts/capture-for-review.sh stage:review "$OUT") \
       >"$WORK/capture-$1.log" 2>&1
  }
  # Read-only: a test must never repair the evidence it is judging.
  usable() { big_enough "$1" "$2" "$3" && node "$ENSURE" --check "$1" 2>/dev/null; }
  facts() { python3 -c 'import json,sys; f=json.load(open(sys.argv[1])); print(f.get("ok"), f.get("ws_id", "-"), ",".join(f.get("replaced_slots", [])) or "none", f.get("previous_judge_verdict"), f.get("judge_verdict_unreadable"))' "$OUT/capture.json" 2>/dev/null; }

  VERDICT=$'**WORKSHEET JUDGE: WS-07-cost-vs-value-gate**\nVERDICT: FAIL\n[S1 blocking] footer says sheet 1 of 2\nRETURN TO: review'
  capture ok "worksheets/WS-07-cost-vs-value-gate.qmd" "$VERDICT"
  if [ ! -e "$R/.github/skills/worksheet-build/scripts/note-card.mjs" ] && grep -q 'capture: pull request #99' "$WORK/capture-ok.log"; then
    ok "the capture really ran on a pull request tree without the helpers"
  else
    bad "the scenario is not the real one: the pull request tree still has the helpers, or capture never got to it"
  fi
  if usable "$OUT/full-page.png" 1000 1000 && usable "$OUT/sheet-01.png" 1000 1000 \
     && usable "$OUT/sheet-02.png" 1000 300 && usable "$OUT/sheet-03.png" 1000 300 \
     && ! grep -q 'Attachment replaced' "$WORK/capture-ok.log" \
     && [ "$(facts)" = "True WS-07-cost-vs-value-gate none True False" ]; then
    ok "all four slots are usable: the sheet, the full page, and two real cards"
  else
    bad "a slot is unusable or was replaced: full=$(dims "$OUT/full-page.png") 1=$(dims "$OUT/sheet-01.png") 2=$(dims "$OUT/sheet-02.png") 3=$(dims "$OUT/sheet-03.png") facts=[$(facts)]"
    sed 's/^/           /' "$WORK/capture-ok.log" | tail -n 15
  fi
  if grep -q 'RETURN TO: review' "$OUT/judge-verdict.md" 2>/dev/null; then
    ok "the judge's verdict is put where the returned stage reads it"
  else
    bad "judge-verdict.md does not hold the judge's verdict"
  fi

  capture fail ""
  if usable "$OUT/full-page.png" 1000 300 && usable "$OUT/sheet-01.png" 1000 300 \
     && usable "$OUT/sheet-02.png" 1000 300 && usable "$OUT/sheet-03.png" 1000 300 \
     && ! grep -q 'Attachment replaced' "$WORK/capture-fail.log" \
     && [ "$(facts)" = "False - none False False" ] && [ ! -s "$OUT/judge-verdict.md" ]; then
    ok "a capture that fails after the checkout still leaves four real cards"
  else
    bad "the failure path left an unusable or replaced slot: full=$(dims "$OUT/full-page.png") 1=$(dims "$OUT/sheet-01.png") 2=$(dims "$OUT/sheet-02.png") 3=$(dims "$OUT/sheet-03.png") facts=[$(facts)]"
    sed 's/^/           /' "$WORK/capture-fail.log" | tail -n 15
  fi
fi

echo "========================================================================"
if [ "$FAIL" -gt 0 ]; then
  echo "FAIL — $FAIL of $((PASS + FAIL)) cases failed."
  exit 1
fi
echo "PASS — all $PASS cases passed."
