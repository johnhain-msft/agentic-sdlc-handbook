---
name: worksheet-review
description: >-
  Usability review of a rendered worksheet as a PRINTED artifact. Renders the
  Quarto worksheet, serves it on localhost, drives Playwright, and LOOKS at the
  image. Checks format fit, physical writability, fill order, prior-vs-blank
  legibility and clipping. Stage 3 of the worksheet factory. A review that does
  not attach the rendered image to the pull request is void.
---

# worksheet-review — look at the printed page

You review the **artifact**, not the source.

Everything before you in this pipeline read a spec and wrote markup. You are the
first stage that finds out what the thing actually looks like on paper. That is
your entire value, and you forfeit it the moment you start reviewing the `.qmd`
instead of the render.

---

## The rule that defines this stage

**You must open the rendered worksheet and look at it. A review that does not
attach the rendered image to the pull request is void.**

Not "should". Void. A review of a printed artifact conducted by reading its
source code is not a review of a printed artifact. If you cannot render it, or
cannot see the image, say so plainly and fail the stage — do not substitute a
source reading and present it as a review. The workflow also fails this stage
when no image is attached, so a source-only review cannot pass anyway.

---

## Do this first

```bash
cd .github/skills/worksheet-build && npm install --no-audit --no-fund && cd -
.github/skills/worksheet-build/scripts/render-worksheet.sh <ws_id> --serve --port 8977
```

That renders the worksheet, runs the mechanical layout gate, writes one PNG per
sheet to `worksheets/_review/<ws_id>/`, and leaves a static server on
`http://localhost:8977/<ws_id>.html`.

Then, with Playwright:

1. Navigate to `http://localhost:8977/<ws_id>.html`.
2. Emulate print media.
3. Screenshot each `.sheet` element, and take one full-page screenshot.
4. **Look at every image.** Describe what you see before you judge it.

Read `worksheets/_review/<ws_id>/layout-report.json` for the mechanical facts,
and `.github/skills/worksheet-build/SKILL.md` for the house rules you are
checking against. Read the build spec `docs/worksheets/<ws_id>.md` §8 for the
declared physical format — that is the claim you are testing.

The mechanical gate is the **floor of your review, never the ceiling.** It
measures geometry. It cannot see that a table is unreadable, that the fill order
makes no sense to a human, that two zones are visually identical, or that a
sheet is technically within its margins and still unusable in a room.

---

## What you check

### 1. Does it fit its declared format?

Spec §8 "Room format" says what this physically is — A3 landscape, a two-sided
card, one page signed, a wall canvas. Check the render against that claim.

- The sheet dimensions in the layout report must match the declared format.
- `@page` must agree with the on-screen sheet. The gate checks this; confirm it
  ran.
- "One page" means **one** `.sheet`. If the builder produced three, either the
  format claim is wrong or the sheet is overbuilt. Say which.
- A "two-sided card" is exactly two sheets, and the second must be the back —
  not a continuation that happens to be sheet two.

### 2. Is every field physically writable?

Look at the image, not the CSS.

- Can an adult write a name, a date, a sentence in that space with a pen?
- Are multi-line answers given multiple lines, or one line and an expectation?
- Do signature blocks look like signature blocks at a glance?
- Is anything so narrow that the answer will be abbreviated into uselessness?
- Are option labels in a `select` readable at printed size, or have they wrapped
  into an unreadable stack?

### 3. Is the fill order obvious?

Somebody picks this up cold. Can they tell where to start and what comes next
without being told?

- Do the numbered badges ascend down the page?
- Does the reading order match the fill order, or does it jump columns?
- On a canvas, is it clear which zone is filled first?
- If the sheet has blocks, does a block that depends on an earlier one come
  after it?

### 4. Do pre-filled priors read as distinct from blank cells?

This is house rule 1 and it is the one that matters most.

Look at the image at arm's length — zoom out, do not read the words. You should
be able to tell which cells the book already filled and which ones the room
fills, by tone and texture alone.

Then check the failure that the gate cannot see: **a printed number sitting
next to a blank cell**. Even correctly tinted, a figure in a `.prior` beside an
empty `.fill` can read as a target. Ask of every printed number: *does the
layout invite somebody to copy this into the blank next to it?* If yes, that is
a finding regardless of what the gate says.

Confirm every hedged figure keeps its hedge in the same visual unit, and that
no crop, fold or column break could separate them.

### 5. Does it print without clipping?

The gate catches content leaving the printable area. You catch the rest:

- Text that fits but is too small to read — nothing below 7pt.
- A table whose last column is squeezed to unusable width.
- A row that will break across a page fold.
- A canvas zone so short that a sticky note will not fit in it.
- Anything that fits only because it is empty, and will overflow the moment
  somebody writes in it.

---

## Fixing

You **may** fix layout. That is the difference between you and the judge.

Fix: sheet splits, column widths, field heights, block ordering, a too-small
canvas zone, a wrapped option list, a page-geometry declaration.

Do **not** fix: a field's presence, its label, its input type, its options, any
number, any prior, any hedge, any of the sheet's prose. Those belong to the
builder and the voice stage. If one of them is wrong, **report it and return the
sheet** rather than reaching into another stage's territory.

After any fix, re-render, re-run the gate, and **look at the image again**. A
fix you did not re-look at is a claim, not a fix.

---

## Output

Attach the sheet images to the pull request. Then report:

```
WORKSHEET REVIEW: <ws_id>
Rendered:      yes — <N> sheet(s) at <W>x<H>mm
Served:        http://localhost:8977/<ws_id>.html
Images:        <paths>, attached to the PR
Declared format (spec §8): <what it says>   Actual: <what rendered>   Match: yes/no
Mechanical gate: <verbatim last line of check-layout.mjs>

WHAT I SAW
  <two or three sentences describing the actual page — not what it should
   contain, what it does contain. If you cannot write this, you did not look.>

FINDINGS
  [blocking]   <what a room would fail to do with this sheet>
     where:    <sheet N, block, field>
     evidence: <what in the image shows it>
  [fixed]      <what you changed, and the re-render that confirms it>
  [returned]   <what is wrong but belongs to another stage — name the stage>

CHECKS
  format fit:        pass/fail — <one line>
  writability:       pass/fail — <one line>
  fill order:        pass/fail — <one line>
  prior vs blank:    pass/fail — <one line, including the arm's-length test>
  prints unclipped:  pass/fail — <one line>
```

If you could not render or could not see the image, the report is:

```
WORKSHEET REVIEW: <ws_id>
VOID — could not <render | serve | screenshot | view> the artifact.
<what failed, verbatim>
No usability judgement offered. This stage did not run.
```

That is a legitimate and useful outcome. A fabricated review of an artifact you
never saw is not.

---

## Never

- Never review the `.qmd` in place of the render.
- Never pass a stage without attaching the rendered image.
- Never describe an image you did not open.
- Never change a field, label, option, number, prior, hedge or the sheet's prose.
- Never touch `handbook/`, the root `.qmd` files, or `docs/worksheets/`.
- Never "fix" a clipping defect by shrinking type below 7pt. Split the sheet.
