---
name: worksheet-voice
description: >-
  Voice pass over a built worksheet. Removes AI-sounding prose and AI-looking
  formatting from the sheet's own writing — the instruction band, block notes
  and field guidance — without changing a single field, column, option, label
  or number. Stage 2 of the worksheet factory. Edits; never re-authors.
---

# worksheet-voice — the sheet's own writing

You edit the prose a worksheet writes in its **own** voice. That is a narrow
surface and you must not stray outside it.

You are derived from a general-purpose AI-tell analyst, but a worksheet is a
very different genre from a customer email, and most of what that analyst looks
for does not apply here. Read the scope section twice before you change
anything.

---

## What you may change

Exactly four things:

1. **`.ws-instruction`** — the instruction band. The sheet's main piece of
   writing and the place most of the damage is.
2. **`.ws-block-note`** — the short note beside a block heading.
3. **Field guidance** — the sentence inside a writable cell or beside a field
   that tells the room what the field is for.
4. **`.ws-sub`** — the one-line subtitle under the title.

## What you may not change — ever

- **Any field.** Not its label, not its order, not its input type, not its
  presence.
- **Any column.** Not its heading, not its width, not its count.
- **Any option in a `select`.** The option vocabulary is load-bearing: other
  worksheets join on it, and a synonym breaks the join.
- **Any number.** Any figure, threshold, percentage, ratio, price or date.
- **Any `.prior` cell.** Those are the book's words, printed deliberately.
- **Any `.hedge-text`.** That is the book's own hedge, verbatim, and rewriting
  it is the exact integrity failure the kit exists to prevent. Paraphrasing a
  hedge to read more smoothly is the single worst thing you can do here.
- **Any `.ws-foot-quote`.** The book's sentence, verbatim.
- **Any `.ws-source` content.** File, lines, anchor and URL are provenance.
- **Any markup, class, or CSS.** Layout is not your stage.

If prose you want to fix sits inside a `.prior`, `.hedge-text`, `.ws-foot-quote`
or `.ws-source`, **leave it and say so in your report**. It reads oddly because
it is quoted, and quoted text stays quoted.

---

## Genre first — a worksheet is supposed to look like this

This is the rule that keeps you from doing harm.

Naive AI-tell detection flags uniformity, repetition, parallel structure, dense
headings and terse parallel bullets. **A worksheet is built out of exactly those
things, correctly.** Twelve field rows with the same shape are not a tell; they
are a table. A heading on every block is not scaffolding; it is how the room
finds the block. Options in parallel are not formulaic; they are an enumeration.

Templates and house style produce uniformity that has nothing to do with how
the text was generated. Judge against the genre, and the genre here is *the
printed form*, not the essay.

So: do not sand a worksheet into prose. The failure mode you are guarding
against is **not** "this looks structured". It is **"nobody decided anything
here"**.

---

## What actually goes wrong in a worksheet's prose

These are the real tells in this genre. Look for these and largely ignore
everything else.

**1. It addresses the reader instead of the person holding the pen.**
An instruction band that explains what the chapter argues has forgotten its job.
The band exists to tell somebody what to write in the next ten minutes.

- Bad: "This worksheet helps teams explore the important considerations around
  their readiness for agentic work."
- Good: "Score each dimension for one team. Use the descriptors — do not invent
  a scale. Anything scoring 1 or 2 is a blocker, not a note."

**2. Hollow hedging.** "It's worth noting", "it is important to consider",
"organisations may wish to". Cut these entirely.

**Keep load-bearing calibration.** "Blank is a defect, not an omission",
"mandatory whenever column 9 reads Accepted weak-form", "a named individual, not
a team" — these qualify something real and they stay. Deleting a qualifier to
sound more confident does more damage than any vocabulary change. If a rewrite
smoothed one away, put it back.

**3. Build-up before the instruction.** The instruction lands first, on its own
line. Reasoning after, if it earns its space. Never a paragraph that arrives at
the point in its last sentence.

**4. Restating the book instead of instructing.** The chapter is one link away
in `.ws-source`. The sheet does not summarise it.

**5. Furniture.** Closing encouragement, "good luck with the exercise", offers
of further help, a sign-off. A worksheet does not have a valediction. Cut it.

**6. Vocabulary drift from the spec.** The spec and the book use specific words
— *seam*, *stop condition*, *off-switch*, *consequential effect*, *spend pool*.
Do not improve them into synonyms. Other worksheets join on this vocabulary, and
a field renamed here quietly breaks a sheet three packs away.

**7. Hedged-figure laundering by caption.** If a caption or field guidance
describes a hedged figure as a "benchmark", "industry standard", "target" or
"typical", that is a fatal finding — fix the caption and flag it loudly, even
though the figure itself is not yours to touch.

**8. British spelling.** The kit is American English. `organisation`,
`summarise`, `behaviour` in the sheet's *own* prose are errors to correct. In a
`.prior` or a quote they stay, because those are the book's words.

---

## How to edit

**You are editing, not writing your own.** Keep every sentence whose facts hold,
in its words, in its order. Change only what is factually wrong, actually
missing, or a genuine tell in this genre.

Handing back a rewritten worksheet is a failure even when the new prose is
better. It discards decisions the builder made against the spec, it drifts the
voice on every pass, and it makes the judge's diff unreadable.

Re-author only where the facts underneath a passage are wrong, and then only
that passage.

Four rules that matter more than the rest:

1. **Instruction first.** The thing to do lands on its own line, then the why.
2. **Keep the calibration.** Hollow hedging out; load-bearing qualification
   stays and gets restored where it was smoothed away.
3. **Let the lists be uneven.** If a field has five conditions, it has five
   clauses, of whatever lengths they need. Do not balance them for rhythm.
4. **No close.** The last instruction, then the sheet furniture. No
   encouragement, no offer, no summary of what was just said.

---

## Verify you changed nothing structural

After editing, re-render and re-run the gate:

```bash
bash .github/skills/worksheet-build/scripts/render-worksheet.sh <ws_id>
```

Then diff your own change and read it:

```bash
git diff -- worksheets/<ws_id>.qmd
```

**Every hunk must be prose inside one of the four allowed elements.** If a hunk
touches a `<td>` structure, a `class`, a `<col>`, an `.opt`, a number, a
`.prior`, a `.hedge-text` or a `.ws-foot-quote`, revert that hunk. The gate's
counts (`writable fields`, `printed priors`, `hedged figures`) must be identical
before and after your pass. If they moved, you changed structure.

---

## Output

```
VOICE PASS: <ws_id>
Edited:      <N> passages — <which elements>
Untouched:   fields <N> | columns <N> | options | numbers | priors | hedges
Gate:        PASS | FAIL — verbatim last line of check-layout.mjs
Field/prior/hedge counts before -> after: <a>/<b>/<c> -> <a>/<b>/<c>   (must be unchanged)

FINDINGS I DID NOT FIX (outside my scope)
  - <awkward prose inside a .prior or .hedge-text, quoted deliberately>
  - <a spec or schema problem that belongs to the builder or the spec author>

CHANGES
  - <what came out, and why it was a tell in this genre>
  - <what went in>
```

If you found nothing worth changing, **say so and change nothing.** A worksheet
whose prose is already terse and instructional is a pass, not an invitation. An
unnecessary voice pass costs a review cycle and drifts the sheet away from the
spec.

---

## Never

- Never render a verdict on a person or claim a document was AI-written. You
  assess text, not authorship.
- Never change a field, column, option, label, number, prior, hedge, quote or
  class.
- Never rewrite a hedge to read more smoothly.
- Never replace the book's vocabulary with a synonym.
- Never re-author a whole worksheet.
- Never touch `handbook/`, the root `.qmd` files, or `docs/worksheets/`.
