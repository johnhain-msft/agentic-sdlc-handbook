# Draw the Seam: Deterministic / Probabilistic Canvas

`WS-16-seam-placement-canvas` &middot; **Pack D - Architecture and ownership** &middot; fill order **3** &middot; type `canvas` &middot; audience **architect** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A marked-up architecture canvas with the seam explicitly drawn, plus a red-circle list of every consequential effect currently sitting on the wrong side.

**Cluster.** `CL-SEAM-DESIGN` - Design the Agentic System: Seam, Topology and Bounds

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch16-deterministic-probabilistic-boundary.qmd` |
| Chapter | The Deterministic/Probabilistic Boundary |
| Heading | Two Computers, One Program |
| Stable anchor | `#sec-seam-two-computers` |
| Lines | L18-41 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch16-deterministic-probabilistic-boundary.html#sec-seam-two-computers> |
| Locator quote | "Every agentic system you will ever build is the composition of two computers" |

Resolve at any time with `python docs/resolve.py ws WS-16-seam-placement-canvas`.

## 3. Source extract - the scaffolding, verbatim

```text
   18 | Every agentic system you will ever build is the composition of two computers running in lockstep.
   19 | 
   20 | The first is **the deterministic computer**. It is the machine you already know how to program. It executes the harness, runs the test suite, applies the lockfile, calls the GitHub API, writes to the filesystem, emits the audit trail. Given the same inputs it produces the same outputs. When it fails it fails loudly: a non-zero exit code, an exception, a schema violation, a CI red light. You have been debugging this computer for your entire career.
   21 | 
   22 | The second is **the probabilistic computer**. It is the model. It takes a prompt and emits a sample from a distribution. Given the same inputs it produces *similar* outputs, not identical ones. When it fails it fails quietly: confident, plausible, wrong. The text reads well. The diff compiles. The function passes superficial review. Only the careful reviewer or the downstream test catches the error, and sometimes nobody does.
   23 | 
   24 | The two computers have different failure ergonomics, different debuggability, different trust contracts. Treating them as a single machine — pretending that "the agent" is one coherent thing — is the source of more agentic incidents than any other category of mistake. They are not one thing. They are two things glued together, and the glue is the seam.
   25 | 
   26 | The right way to read any agentic system diagram is to draw a line down the middle of the page, label the two sides, and ask: which boxes belong on which side, and what crosses the line in each direction? The table below is the spine of this chapter.
   27 | 
   28 | | | Deterministic side | Probabilistic side |
   29 | |---|---|---|
   30 | | **What it does** | File I/O, tool calls, schema validation, test execution, lockfile resolution, allowlist enforcement, audit emission | Reads code, drafts prose, proposes diffs, summarizes intent, picks among options, generates plans |
   31 | | **Failure mode** | Crash, exception, validation error — loud and traceable | Confident plausible wrong — silent and unfalsifiable from inside the model |
   32 | | **What you trust** | The exact output, byte for byte | A distribution of outputs, conditioned on a prompt |
   33 | | **What it costs** | Engineering hours per gate | Tokens per call, plus the cost of every failure that crosses the seam unverified |
   34 | | **What crosses → into it** | Structured prompts, declared tool schemas, file contents grounded by `compile`-time loaders | Proposed actions (text), proposed writes (text), structured tool-call requests |
   35 | | **What crosses ← out of it** | Parsed outputs validated against schema, writes filtered through an allowlist, flagged escalations to humans | Nothing direct: every probabilistic output passes through deterministic validation before it has consequences |
   36 | 
   37 | Read each row as a constraint. The deterministic side is what you can audit. The probabilistic side is what you cannot. Anything consequential — anything with a side effect that costs real money or real trust to undo — must be executed on the deterministic side. The probabilistic side is allowed to *propose* anything; it is allowed to *do* nothing.
   38 | 
   39 | The phrase "the agent is a junior engineer" from Chapter 10 was a mindset metaphor. The two-computers framing is the architecture metaphor that goes with it. A junior engineer with a write token to production is a liability. The cure is the same in both worlds: the junior engineer drafts a PR; the CI system, the reviewers, and the merge queue execute the change. The agent drafts an action; the substrate executes it.
   40 | 
   41 | ---
```

## 4. What the user fills

Participants sketch their intended agentic system on a large canvas with a vertical line down the middle, place every box on the deterministic or the probabilistic side, and then draw and label each arrow that crosses the line in each direction (what goes in: prompts, tool schemas, grounded file contents; what comes out: proposals, never direct writes). Anything consequential left on the probabilistic side is circled in red as a design defect to be redrawn.

## 5. Field-level schema

This is a wall canvas, and its geometry carries the argument. **Physical layout:** A0 or A1
landscape with a **heavy vertical seam line printed down the exact centre**, floor to ceiling of
the sheet. The left half is a placement zone headed **THE DETERMINISTIC COMPUTER — what you can
audit**; the right half is headed **THE PROBABILISTIC COMPUTER — what you cannot**. Down the
far-left margin runs a read-only legend strip carrying the six rows of the two-computers table
verbatim. Across the seam, two horizontal arrow channels are pre-drawn: the upper channel points
**→ right** and is labelled *what crosses into the probabilistic side*; the lower channel points
**← left** and is labelled *what crosses out of it*. The lower channel carries one pre-printed
line of book text that participants must either honour or consciously violate: **"Nothing direct:
every probabilistic output passes through deterministic validation before it has consequences."**
The kit ships with movable sticky notes for boxes and a sheet of **red dot stickers**.

Rows in block A are the boxes participants place; rows in block B are the arrows they draw. The
legend strip (block C) is printed, not filled.

**Block A — box placement register.**

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Box ID | `free text` | — | A short letter or number written on the sticky and on this row, so the canvas and the register can be read together | derived |
| 2 | Box name | `free text` | — | The component as the team names it | org |
| 3 | Side placed | `select` Deterministic / Probabilistic | — | One or the other. A box may not straddle the line | ch16 L28-29 |
| 4 | What it does | `free text` | Legend reference, printed: deterministic — file I/O, tool calls, schema validation, test execution, lockfile resolution, allowlist enforcement, audit emission. Probabilistic — reads code, drafts prose, proposes diffs, summarises intent, picks among options, generates plans | This box's actual job, in one line | ch16 L30 |
| 5 | Consequential side effect? | `checkbox` | — | Tick where the effect "costs real money or real trust to undo" | ch16 L37 |
| 6 | Red circle | `checkbox` | — | Required whenever column 5 is ticked **and** column 3 reads Probabilistic. Place a red dot on the sticky at the same time | ch16 L37 |
| 7 | Redraw — where it must move to | `free text` | — | The deterministic component that will execute the effect instead. The probabilistic box keeps only the proposal | ch16 L37 |
| 8 | Who holds the write token for this effect today | `free text` / `owner (named person)` | — | The credential and the component that carries it. `The agent` is a valid and alarming answer | ch16 L10, L145 |
| 9 | Disposition | `select` Redrawn / Accepted weak-form / Outstanding | — | — | ch16 L145 |
| 10 | If accepted weak-form — why, and the compensating control | `free text` | — | Mandatory whenever column 9 reads Accepted weak-form. The chapter allows the choice; it does not allow the choice to be implicit | ch16 L145 |

**Block B — crossing-arrow register.** One row per labelled arrow drawn across the seam.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 11 | Arrow ID | `free text` | — | Written on the canvas beside the arrow | derived |
| 12 | Direction | `select` → into the probabilistic side / ← out of it | — | — | ch16 L34-35 |
| 13 | From box / to box | `free text` (two cells) | — | Box IDs from column 1 | derived |
| 14 | What crosses | `free text` | Channel reference, printed: **inbound** — structured prompts, declared tool schemas, file contents grounded by `compile`-time loaders. **outbound** — parsed outputs validated against schema, writes filtered through an allowlist, flagged escalations to humans | The actual payload on this arrow | ch16 L34-35 |
| 15 | Deterministic validation applied (outbound only) | `free text` | — | The named gate this payload passes through. Blank is a defect, not an omission | ch16 L35 |
| 16 | Unvalidated crossing | `checkbox` | — | Ticked automatically when column 12 reads outbound and column 15 is blank. Mark the arrow on the canvas in red | ch16 L35, L37 |

**Block C — the two-computers legend (printed, read-only).** Six fixed rows down the left margin.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 17 | Legend row | `select` (fixed 6, printed) | What it does / Failure mode / What you trust / What it costs / What crosses → into it / What crosses ← out of it | — | ch16 L28-35 |
| 18 | Deterministic cell | `free text` (printed verbatim) | The six left-hand cells of @sec-seam-two-computers, reproduced word for word | — | ch16 L30-35 |
| 19 | Probabilistic cell | `free text` (printed verbatim) | The six right-hand cells, reproduced word for word | — | ch16 L30-35 |

**Block D — sheet footer.**

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 20 | System sketched | `free text` | — | The agentic system this canvas is for. One system per canvas | org |
| 21 | Sketched by / date | `owner (named person)` + `date` | — | — | org |
| 22 | Red circles raised / dispositioned / outstanding | `computed` (three counts) | — | Derived from columns 6 and 9. The outstanding count is the number that carries forward | derived |
| 23 | Design-review verdict | `select` Redrawn clean / Accepted with compensating controls / Outstanding defects | — | The place to find this out is the design review, not the post-mortem | ch16 L147 |

**Absorbed detail.** This sheet absorbed no other candidate. It is, however, the first of three
instruments that run as one session: the red circles at column 6 become the opening rows of
`WS-16-consequential-effect-register`, and each of those rows then selects a gate cell in
`WS-16-gate-selection-matrix`. Column 1 box IDs must therefore be stable and legible, because two
downstream sheets key off them.

**Deliberate omission.** The canvas asks for no cost figure, even though legend row 4 is *What it
costs*. The book's own cells there are qualitative — engineering hours per gate, tokens per call
— and any box on the canvas asking for a number would be filled with an invention. The gate
*selection* is also deliberately absent: naming the failure mode and picking the gate cell is
habit 2 and belongs to `WS-16-gate-selection-matrix`, which runs immediately after this one.
Asking the room to pick a gate while it is still arguing about placement collapses the two
decisions and produces a worse answer to both.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- None. This sheet can be filled cold.

**Consumed by:**

- `WS-16-consequential-effect-register` - Consequential Side-Effect Register: What Can Our Agents Actually Do To Us? (Pack E - Guardrails: authority, risk and proof, fill order 5)
- `WS-16-seam-design-review-gate` - Seam Design-Review Gate Checklist (Pack Z - Second wave: the practitioner kit, fill order 15)

**Feeds into (prose, from the source scan).** WS-16-consequential-effect-register - the red circles become its opening rows.

## 8. Facilitation

| | |
|---|---|
| Who fills it | The architect or tech lead who owns the system being designed, the engineer who will actually implement the gates, and at least one person who did **not** design it — challenging a box's placement is a job, and the designer cannot do it to their own sketch. Security should be in the room for column 8, because the write-token question is theirs. |
| When in the session | Fills cold; no prerequisites. It is the **first of a three-part single session** with `WS-16-consequential-effect-register` and `WS-16-gate-selection-matrix`. Do not schedule the three apart. The canvas produces the red circles; the register turns each red circle into a row; the gate matrix picks the gate for each row. Split across weeks, the register arrives without the circles and the room re-argues placement from memory. |
| Duration | 45-60 minutes for the canvas alone, 2.5-3 hours for the full three-part session including breaks. The first twenty minutes are the sketch; the value is in the next twenty-five, when boxes start moving across the line. |
| Data needed in advance | The intended component list for one system — one system per canvas, never a portfolio. Which credentials and API tokens the agent would hold or could reach. Whether the harness or platform in use offers a validated-output mechanism, such as a declared safe-outputs block, or whether the team would be building the gate itself. |
| Room format | Printed A0 or A1 on a wall with the seam line pre-printed heavy and central, boxes written on **movable stickies**, and a sheet of red dots within reach. This must not be a slide or a shared document. The redraw is a physical act — someone walks up and moves a sticky from the right of the line to the left — and a box that cannot be moved will not be moved. |

**Facilitation note carried from ch16.** Open with the story, then give the instruction verbatim.

The story is the Monday morning at the top of the chapter. A small agent reads bug reports,
drafts GitHub issues, attaches labels. For two weeks it works. Then it files an issue tagged with
a customer name that does not exist — not a misspelling, a fabrication — and a real label
belonging to a different account. An engineer is paged for a complaint no customer ever made. The
mistake was not the hallucination; models hallucinate. The mistake was that between the model's
output and the GitHub API call there was no gate, no schema, no lookup against the customer table.
The agent had been handed the write token directly. There was no place in the system where a
deterministic process could say *no*.

Then habit 1, word for word, and it is the whole facilitation instruction: **"Before you write the
prompt or the workflow, sketch the system and label which boxes are deterministic and which are
probabilistic."** Follow it with the constraint that makes the canvas bite — the probabilistic side
is allowed to *propose* anything; it is allowed to *do* nothing. When a participant defends a
consequential box on the right-hand side, the counter is the chapter's own: a junior engineer with
a write token to production is a liability, and the cure is the same in both worlds. The junior
drafts a PR; CI, the reviewers and the merge queue execute the change.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **Every box on the canvas appears in block A with a side (column 3) and a job (column 4), and
   no box straddles the seam.** A sticky placed on the line is an unmade decision, and it is the
   first thing to resolve.
2. **Every box with a ticked consequential side effect (column 5) sitting on the probabilistic
   side carries a red circle**, and the physical count of red dots on the canvas equals the raised
   count at column 22. A circle in the register that is not on the wall, or the reverse, means the
   two artefacts have diverged and neither can be trusted.
3. **Every red circle is dispositioned at column 9** — redrawn to a named deterministic component
   at column 7, or accepted weak-form with a written reason and a named compensating control at
   column 10. `Outstanding` is a permitted verdict but must be carried forward, not left silent.
4. **Every outbound arrow names the deterministic validation it passes through (column 15), or is
   marked at column 16 as an unvalidated crossing.** The pre-printed line in the lower channel is
   the book's answer; a blank cell next to it is a design defect the sheet has just found.
5. **No box on the probabilistic side is described at column 4 with a verb of execution** —
   writes, calls, deletes, merges, sends, deploys, pays. Those verbs belong on the left of the
   line. This is the single fastest read of a completed canvas.
6. **Column 8 is answered for every consequential effect**, naming which component holds the write
   token today. An unanswered token question means the room does not yet know whether it has the
   cold-open architecture.
7. **Reconciliation with the next sheet in the session.** The red-circle rows transfer into
   `WS-16-consequential-effect-register` with the same box IDs and the same names, and the
   register's row count matches the raised count at column 22. If the register opens with
   different rows, the session has quietly restarted the analysis.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** Carried unchanged from _section-clusters.md section 7 for CL-SEAM-DESIGN.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> The flagship leadership instrument in Part III. The book calls seam placement "the single most important architectural decision in any agentic design" (line 14) and habit 1 at line 143 is literally the facilitation instruction: "Before you write the prompt or the workflow, sketch the system and label which boxes are deterministic and which are probabilistic." The two-computers table at lines 28-35 supplies the canvas legend (what it does / failure mode / what you trust / what it costs / what crosses in / what crosses out). Already well structured - needs a canvas layout, not new content. Facilitation tip: WS-16-seam-placement-canvas, WS-16-consequential-effect-register and WS-16-gate-selection-matrix are designed to run back-to-back as a single three-part session; do not schedule them apart. The Monday-morning fabricated-customer opener (lines 4-12) is the cold-open story.
