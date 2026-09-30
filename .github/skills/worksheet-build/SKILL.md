---
name: worksheet-build
description: >-
  Shared conventions for building the Agentic SDLC Handbook facilitated
  worksheet kit from its build specs. Use whenever creating, editing, reviewing
  or rendering a worksheet under worksheets/ from a spec in docs/worksheets/.
  Carries the Quarto worksheet template, the input-type to markup mapping, page
  geometry for every physical format, the render and layout-gate scripts, and
  the house rule for how a pre-filled prior is distinguished from a blank cell.
---

# Building a worksheet

A worksheet is a **printed artifact a room fills in with a pen**. It is not a
document, not a web page, and not a form to type into. Every decision below
follows from that.

You are turning `docs/worksheets/<ws_id>.md` (the build spec) into
`worksheets/<ws_id>.qmd` (the sheet). The spec is authoritative. Where the spec
and this skill disagree about content, the spec wins. Where they disagree about
*markup*, this skill wins.

---

## The one-minute version

```bash
cp worksheets/_templates/worksheet-template.qmd worksheets/<ws_id>.qmd
# ... fill it in from docs/worksheets/<ws_id>.md ...
.github/skills/worksheet-build/scripts/render-worksheet.sh <ws_id>
```

The render script renders, runs the layout gate, and writes one PNG per sheet
to `worksheets/_review/<ws_id>/`. Exit 0 means the gate passed. **Look at the
PNG.** A gate pass is a floor, not a finish.

---

## The three house rules

These live in `worksheets/styles/worksheet.css`. Do not restate them in a
worksheet's own CSS, and do not work around them.

### 1. A printed prior never looks like a blank

A value **the book supplies** renders in `.prior`: grey tint, serif italic,
dark left rule, with a `.prior-src` line naming its chapter and line.
A cell **the organisation fills** renders in `.fill`: white, hairline rule,
real physical height.

Hold the printed page at arm's length. If you cannot tell which is which
without reading a word, the sheet is wrong. The gate checks this mechanically
by comparing computed background colours, but the gate only catches the
degenerate case — you still have to look.

### 2. A hedged figure and its hedge are one unit

Where spec §10 lists a hedged figure reachable from the worksheet's source
range, it prints inside `.prior--hedged`, which carries:

- `.hedge-figure` — the figure, exactly as the book states it
- `.hedge-text` — **the book's own hedge, verbatim**. Copy it from spec §10.
  Never rewrite it, never summarise it, never move it to a footnote.
- `.hedge-src` — the file and line

The organisation's own number goes in a **separate adjacent field** under an
`.ours-label`, never in place of the prior.

A hedged figure must never appear:
- in a column header with blank cells under it
- as a target, threshold, benchmark or acceptance criterion
- anywhere its hedge could be removed by a scissors cut, a fold, or a crop

> A printed sheet launders a hedged anecdote faster than prose does, because a
> blank cell next to a printed number reads as a target by layout alone.

**Never invent a number, threshold, price, or percentage that is not in the
book.** If the spec calls for a rubric the book does not supply, the rubric is
**qualitative with anchored descriptors** — the ch06 assessment worksheet's
"1 = almost all tribal; 5 = comprehensive docs" is the model. Never a numeric
cut-off you made up.

### 3. Every field is physically writable

| Need | Minimum height |
|---|---|
| any writable field | 8mm |
| a `.sm` variant | 6mm |
| a signature | 16mm |
| a multi-line answer | 18mm (`.f-box`), 30mm (`.lg`), 46mm (`.xl`) |

The gate fails anything shorter. A field you cannot write in is not a field.

---

## Markup: raw HTML, never fenced divs

The worksheet body is **raw HTML inside one ` ```{=html} ` block**.

Do **not** use Pandoc fenced divs (`::: {.class}`). A closing `:::` that follows
a block-level HTML tag is absorbed into that tag, and the page silently
mis-nests — Quarto reports "Div unclosed, closing implicitly" and emits a
structurally wrong document. A worksheet is structured layout, not prose; raw
HTML is unambiguous and is the contract here.

---

## Page geometry

Declare the format **once**, in the worksheet's own frontmatter. Use the
`html:root` selector — Quarto injects `include-in-header` *before* the project
stylesheet, so a plain `:root` override has equal specificity, loses on source
order, and the sheet silently renders at the default size.

Copy exactly one of these pairs:

| Format | Frontmatter block |
|---|---|
| A4 portrait | `html:root { --sheet-w: 210mm; --sheet-h: 297mm; --sheet-margin: 12mm; }`<br>`@page { size: A4 portrait; margin: 12mm; }` |
| A4 landscape | `html:root { --sheet-w: 297mm; --sheet-h: 210mm; --sheet-margin: 12mm; }`<br>`@page { size: A4 landscape; margin: 12mm; }` |
| A3 portrait | `html:root { --sheet-w: 297mm; --sheet-h: 420mm; --sheet-margin: 12mm; }`<br>`@page { size: A3 portrait; margin: 12mm; }` |
| **A3 landscape** (most common) | `html:root { --sheet-w: 420mm; --sheet-h: 297mm; --sheet-margin: 12mm; }`<br>`@page { size: A3 landscape; margin: 12mm; }` |
| A2 landscape | `html:root { --sheet-w: 594mm; --sheet-h: 420mm; --sheet-margin: 16mm; }`<br>`@page { size: A2 landscape; margin: 16mm; }` |
| A1 landscape | `html:root { --sheet-w: 841mm; --sheet-h: 594mm; --sheet-margin: 20mm; }`<br>`@page { size: A1 landscape; margin: 20mm; }` |
| A0 landscape | `html:root { --sheet-w: 1189mm; --sheet-h: 841mm; --sheet-margin: 24mm; }`<br>`@page { size: A0 landscape; margin: 24mm; }` |
| A5 card | `html:root { --sheet-w: 148mm; --sheet-h: 210mm; --sheet-margin: 8mm; }`<br>`@page { size: A5 portrait; margin: 8mm; }` |

**Take the format from spec §8 "Room format".** It says what the sheet
physically is. Read it literally:

| Spec §8 says | Build |
|---|---|
| "A3 landscape", "one A3 sheet" | one A3 landscape `.sheet` |
| "a one-page A4 card", "single-sided A4" | one A4 portrait `.sheet` |
| "two-sided card" | **two** `.sheet` divs, A5 |
| "one page per block, taped in a row" | one `.sheet` per block |
| "A0 or A1 landscape" | A1 landscape unless the spec insists on A0 |
| "projected and filled live", "a live spreadsheet" | A4 portrait — it still gets printed and signed |
| "flip-chart sheets on the wall" | A1 landscape, one `.sheet` per chart |

One `.sheet` = one physical page. If the content does not fit, **split it into
another `.sheet`** — never shrink the type below 7pt and never let it spill.

---

## Tables

```html
<table class="ws">
  <colgroup>
    <!-- PERCENTAGES ONLY, SUMMING TO 100 -->
    <col style="width:6%"><col style="width:22%"><col style="width:36%"><col style="width:36%">
  </colgroup>
  <thead>
    <tr><th></th><th>Field</th><th>What the book says</th><th>Your answer</th></tr>
  </thead>
  <tbody>
    <tr>
      <td class="ws-num"><span class="fno">1</span></td>
      <td><b>Field name</b></td>
      <td class="prior">Value from the book<span class="prior-src">ch07 L98</span></td>
      <td class="fill"><span class="f-text"></span></td>
    </tr>
  </tbody>
</table>
```

**Column widths must be percentages that sum to 100.** Quarto's table filter
re-parses raw HTML tables, **drops any `mm` or `px` col width**, sums the
percentages it kept, and writes the result onto the table as an inline
`style="width:58%"`. Mixed units silently produce a half-width sheet. The gate
fails a table that does not fill its block.

`<td class="ws-num">` + `<span class="fno">N</span>` gives the fill-order badge.
Numbers run in ascending document order — that is what makes the fill order
obvious without a legend.

---

## Input type → markup

Spec §5's "Input type" column maps to exactly these primitives. The left column
is the spec's own vocabulary, verbatim.

| Spec §5 input type | Markup |
|---|---|
| `free text` | `<span class="f-text"></span>` |
| `free text` (count / integer / duration / path) | `<span class="f-text sm"></span>` |
| `free text` (list) | two or three stacked `<span class="f-text"></span>` |
| a long free-text answer | `<span class="f-box"></span>` (`.sm` `.lg` `.xl` variants) |
| `free text` (read-only) / (pre-printed) / `locked` / `printed` | `<td class="locked">…</td>` — no writing surface |
| `owner (named person)` | `<span class="f-owner"></span>` |
| `checkbox` | `<span class="f-checkline"><span class="f-check"></span>label</span>` |
| `checkbox` set | one `.f-checkline` per option |
| `select` (any option list) | `<div class="f-select"><span class="opt">A</span>…</div>` |
| `H/M/L` | `<div class="f-hml"><span class="pt">H</span><span class="pt">M</span><span class="pt">L</span></div>` |
| `1-5 scale` | `<div class="f-scale"><span class="pt">1</span>…<span class="pt">5</span></div>` |
| `0-3` | `.f-scale` with points 0–3 |
| `currency` | `<span class="f-currency" data-symbol="&pound;"></span>` |
| `date` | `<div class="f-date"><span class="seg d"></span>/<span class="seg m"></span>/<span class="seg y"></span></div>` |
| `signature` | `<span class="f-sign"></span>` in a `<td class="fill tall">` |
| `computed` | `<span class="f-computed" data-formula="field 9 &times; field 10"></span>` |
| combinations (`X` + `Y`) | both primitives stacked in the same `.fill` cell |

**Print every option of a `select`.** A select whose options are not on the
page is a free-text field wearing a costume, and the room will not use the
vocabulary the spec requires.

**`computed` always carries its formula** in `data-formula`. A derived cell with
no visible derivation gets filled in by hand with a number nobody can check.

---

## Canvas primitives

For large-format `type: canvas` sheets:

```html
<div class="canvas">
  <div class="canvas__half"><h3>LEFT SIDE HEADING</h3><div class="zone"></div></div>
  <div class="canvas__seam"><span class="seam-label">the seam</span></div>
  <div class="canvas__half"><h3>RIGHT SIDE HEADING</h3><div class="zone"></div></div>
</div>

<div class="channel"><span class="arrow">&rarr;</span><span>what crosses this way</span></div>
<div class="channel"><span class="arrow">&larr;</span><span>what crosses back</span></div>

<span class="redcircle"></span> <span class="defect-note">a marked defect</span>
```

`.zone` is a gridded placement area for movable stickies. `.canvas__seam` is the
heavy centre line. `.channel` is a pre-drawn crossing arrow lane. Give `.canvas`
an explicit `style="height:NNmm"` so the sheet's vertical budget is deliberate.

---

## Structure of a sheet

```
.screen-only        review banner — never printed
.sheet              one physical page
  .ws-head          title + subtitle, and ws_id / pack / fill order / type / audience
  .ws-source        chapter, heading, file, lines, link to the published anchor
  .ws-instruction   spec §4, rewritten as a direct instruction to the person with the pen
  .ws-block         one per block in spec §5 — h2 + .ws-block-note + table/canvas
  .prior--hedged    where spec §10 applies
  .ws-foot-quote    the book's own sentence, where the spec calls for it
  .ws-foot          ws_id, sheet N of M, filled-by and date rules
```

`.ws-source` is not decoration. A facilitated sheet detached from its chapter
becomes folklore in about one quarter, and the anchor link is how somebody
checks it a year later.

---

## Scripts

```bash
# render + gate + screenshots
.github/skills/worksheet-build/scripts/render-worksheet.sh <ws_id>

# render + gate + leave a localhost server up for Playwright
.github/skills/worksheet-build/scripts/render-worksheet.sh <ws_id> --serve --port 8977

# gate only, against an already-rendered file or a localhost URL
node .github/skills/worksheet-build/scripts/check-layout.mjs \
     worksheets/_output/<ws_id>.html worksheets/_review/<ws_id> \
     --json worksheets/_review/<ws_id>/layout-report.json
```

The gate needs `npm install` once inside
`.github/skills/worksheet-build/`. It prefers Playwright's own Chromium and
falls back to a system Chrome or Edge.

### What the gate fails on

| Rule | Meaning |
|---|---|
| `clipping` | content reaches outside the sheet's printable area — it will clip |
| `placeholder` | an unfilled `<<…>>` reached the render |
| `page-size-mismatch` | `@page` and the rendered sheet disagree — usually a `:root` override that should be `html:root` |
| `no-page-rule` | no `@page` declared, so print falls back to A4 whatever the screen says |
| `table-not-full-width` | a `<col>` used `mm`/`px`, so Quarto shrank the table |
| `unwritable-field` | a field shorter than its floor |
| `no-writable-fields` | it is a handout, not a worksheet |
| `prior-not-distinct` | house rule 1 broken |
| `hedge-stripped` | house rule 2 broken |
| `figure-in-header` *(warn)* | a number in a column header with blanks beneath it |
| `fill-order` *(warn)* | field badges do not ascend in document order |

---

## The reference specimen

`worksheets/specimen.qmd` renders every primitive and both house rules on one
A3 portrait page and passes the gate clean. It is **not** one of the 72. Read it
as the worked example of exactly the markup to emit, and re-render it after any
change to `styles/worksheet.css` to check for regressions.

---

## Never

- Never edit anything under `handbook/`, or the book's root `.qmd` files, or the
  root `_quarto.yml`. The worksheet kit is downstream of the book and never
  changes it.
- Never edit a build spec in `docs/worksheets/`. If a spec looks wrong, say so
  in the PR; do not fix it in passing.
- Never invent a number, threshold, price or percentage that is not in the book.
- Never present a hedged figure as a target.
- Never drop a column, row or field that spec §5 lists. §5 is a contract,
  implemented column for column.
- Never add a field that spec §5 does not list, except the sheet furniture in
  the structure above.
