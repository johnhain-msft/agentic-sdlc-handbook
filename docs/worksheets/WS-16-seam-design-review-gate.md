# Seam Design-Review Gate Checklist

`WS-16-seam-design-review-gate` &middot; **Pack Z - Second wave: the practitioner kit** &middot; fill order **15** &middot; type `checklist` &middot; audience **architect** &middot; leadership priority **2**

## 1. Purpose

**Output artifact.** A standing design-review gate that every agentic system must pass - the operating control the workshop leaves behind.

**Cluster.** `CL-ARCH-REVIEW-STANDARD` - Agentic Design Review Standard

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch16-deterministic-probabilistic-boundary.qmd` |
| Chapter | The Deterministic/Probabilistic Boundary |
| Heading | The Architect's Discipline |
| Stable anchor | `#sec-seam-architects-discipline` |
| Lines | L138-146 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch16-deterministic-probabilistic-boundary.html#sec-seam-architects-discipline> |
| Locator quote | "Three habits make the seam visible in everyday work" |

Resolve at any time with `python docs/resolve.py ws WS-16-seam-design-review-gate`.

## 3. Source extract - the scaffolding, verbatim

```text
  138 | Three habits make the seam visible in everyday work. They are unglamorous and they pay off every week.
  139 | 
  140 | ::: {.callout-tip}
  141 | ## The seam, in three habits
  142 | 
  143 | 1. **Draw the line on the diagram.** Before you write the prompt or the workflow, sketch the system and label which boxes are deterministic and which are probabilistic. Anything consequential on the probabilistic side is a design defect; redraw until consequential side effects sit on the deterministic side, behind a gate.
  144 | 2. **Pick the gate before you pick the model.** For each consequential effect, name the failure mode you fear and pick the gate cell — programmatic-internal, judgement-internal, programmatic-external, judgement-external — that catches it. Then implement the gate. The model choice is downstream.
  145 | 3. **Refuse the write token.** When a vendor or a tool offers the agent a credential that allows direct externalization, ask whether the client offers a strong-form alternative. If it does, take it. If it does not, document why you accepted weak-form and what the compensating control is. Never accept the token without making the choice explicit.
  146 | :::
```

## 4. What the user fills

Three tick-boxes plus evidence, completed for every new agentic design before it is approved: (1) is the deterministic/probabilistic line drawn on the diagram, and is every consequential box on the deterministic side? (2) for each consequential effect, is the failure mode named and the gate cell chosen *before* the model was chosen? (3) was a direct write token offered, and if accepted, is the reason and compensating control documented? Reviewer name, date, verdict.

## 5. Field-level schema

Four regions on one gate, completed by the **reviewer** rather than the author, once per design.
Region A is the gate proper — the chapter's three habits, one row each. Regions B, C and D carry the
three absorbed instruments and are what make this a standard rather than a tick-box. Header text
across the top, from the chapter's closing line: *the place to find out is in the design review, not
in the post-mortem.* Header block: design under review; author; reviewer; date; verdict (`APPROVED` /
`APPROVED WITH CONDITIONS` / `RETURNED`).

**Region A — the three habits. One row per habit; this is the gate.**

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Habit | `select` (fixed 3 rows) | Draw the line on the diagram / Pick the gate before you pick the model / Refuse the write token | — | ch16 L143-145 |
| 2 | What the habit requires | `free text` (read-only) | The chapter's own wording per habit | — | ch16 L143-145 |
| 3 | Verdict | `select` — `pass` / `fail` | — | — | derived |
| 4 | Evidence | `free text` | — | For habit 1, the diagram itself with boxes labelled deterministic or probabilistic | ch16 L143 |
| 5 | Consequential effects still on the probabilistic side | `free text` list | — | **Must be empty.** The chapter calls anything consequential on the probabilistic side a design defect; a non-empty list returns the design | ch16 L143 |
| 6 | Reviewer | `owner (named person)` | — | Per habit | org |

**Habit 2 sub-table — one row per consequential effect**, drawn from `WS-16-consequential-effect-register`.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 2a | Consequential effect | `free text` | — | Carried over from the register; do not invent new ones here | `WS-16-consequential-effect-register` |
| 2b | Failure mode feared | `free text` | — | Named before the gate is chosen | ch16 L144 |
| 2c | Gate cell | `select` — `programmatic-internal` / `judgement-internal` / `programmatic-external` / `judgement-external` | The four cells, printed as the only permitted answers | One per effect | ch16 L144 |
| 2d | Gate implemented? | `checkbox` | — | Chosen but not built is a `fail` | ch16 L144 |
| 2e | Was the gate chosen before the model? | `checkbox` + `free text` | — | Evidence, not assertion: a dated decision record, an ADR, a commit order | ch16 L144 — "The model choice is downstream" |

**Habit 3 sub-table — the write-token decision.**

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 3a | Was a direct write credential offered? | `checkbox` | — | By a vendor, a tool or the runtime | ch16 L145 |
| 3b | Does the client offer a strong-form alternative? | `select` — `yes` / `no` / `not checked` | — | `not checked` is a `fail`: the chapter requires the question be asked | ch16 L145 |
| 3c | Form accepted | `select` — `strong-form` / `weak-form` | The preference rule, printed: when the client offers strong-form, use it | — | ch16 L130 |
| 3d | If weak-form: why | `free text` | — | Mandatory | ch16 L145 |
| 3e | If weak-form: compensating control | `free text` | — | Mandatory. A blank here is a `fail` regardless of how good 3d is | ch16 L145 |

**Region B — pattern selection and trade-off register** *(absorbed `WS-19-pattern-selection-trade-off-register`)*.
Eighteen rows pre-printed from the chapter's per-layer decision matrix; the team adds three columns
and a signature.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| B1 | Layer | `free text` (read-only) | Composition / Assembly / Dispatch / Boundary / Recovery | — | ch19 L163-181 |
| B2 | When you have… | `free text` (read-only) | The matrix's condition per row | — | ch19 L163-181 |
| B3 | Reach for | `free text` (read-only) | The named pattern | — | ch19 L163-181 |
| B4 | Trade-off you accept | `free text` (read-only) | The matrix's trade-off — *the load-bearing field* | — | ch19 L161, L183 |
| B5 | Failure mode if you skip | `free text` (read-only) | Per row | — | ch19 L163-181 |
| B6 | Does this condition describe us? | `select` — `yes` / `no` / `not yet` | — | Per row | absorbed member |
| B7 | Pattern we commit to | `free text` | — | Required wherever B6 is `yes` | absorbed member |
| B8 | The trade-off we are explicitly accepting | `free text` | — | **Mandatory** wherever B7 is filled. The chapter's reviewer rule, printed under the table: *a design that names a pattern from column three without naming the trade-off in column four is structurally incomplete* | ch19 L183 |
| B9 | Architect | `signature` | — | A named architect signs the accepted trade-offs | absorbed member |

**Region C — design compliance scorecard, before and after** *(absorbed `WS-APXB-design-compliance-scorecard`)*.
Five fixed checks, scored twice.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| C1 | Check | `select` (fixed 5 rows) | Reduced scope (per-lens fresh window) / Orchestrated composition (independent contracts) / Single-writer interlock on output / God-module avoidance / Fan-out where applicable | — | appendix-b L33-41 |
| C2 | Current design | `select` — `PASS` / `FAIL` | — | Score our design as it stands today | absorbed member |
| C3 | Evidence, current | `free text` | — | Auditable line by line, per the absorbed instrument's intent | absorbed member |
| C4 | Redesigned | `select` — `PASS` / `FAIL` / `n/a` | — | Score the proposed redesign | absorbed member |
| C5 | Evidence, redesigned | `free text` | — | — | absorbed member |
| C6 | If still FAIL: backlog item + owner | `free text` + `owner (named person)` | — | Every remaining FAIL becomes the redesign backlog | absorbed member |

**Region D — the pattern-rejection record** *(absorbed `WS-APXB-pattern-rejection-record`)*.
One row per near-miss pattern the design considered and did not adopt.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| D1 | Pattern | `free text` | Two worked rows printed as a greyed exemplar: an alignment-loop pattern and a wave-execution pattern | Ours | appendix-b L80 |
| D2 | Verdict | `select` — `CONSIDERED` / `ADOPTED` / `REJECTED` | — | — | absorbed member |
| D3 | The pattern's own WHEN-clause, quoted verbatim | `free text` | Exemplar quotes carried from the appendix, including *"No DAG; lenses are mutually independent."* | Quote it; do not paraphrase | appendix-b L80 |
| D4 | Why our case fails that clause | `free text` | Exemplar: a binary verdict against a fixed rubric is one-shot per event, so an iterative alignment loop does not apply | Ours, in one line | appendix-b L80 |

**Absorbed detail.**

- `WS-19-pattern-selection-trade-off-register` is **Region B** in full: the eighteen-row matrix with
  its five printed columns, the three added columns (B6 `yes`/`no`/`not yet`, B7 the committed
  pattern, B8 the explicitly accepted trade-off) and B9's named architect signature. B8's mandatory
  status and the printed reviewer rule beneath it are the register's whole point and must not be
  softened into an optional notes field.
- `WS-APXB-design-compliance-scorecard` is **Region C** in full: the five named checks, the
  before-and-after columns, PASS/FAIL per cell with evidence behind each verdict, and C6 turning the
  residual FAILs into an owned backlog.
- `WS-APXB-pattern-rejection-record` is **Region D** in full: pattern, verdict from the three-value
  vocabulary, the WHEN-clause quoted verbatim rather than summarised, and why this case fails it —
  with the appendix's two worked rejections printed as exemplars.

**Deliberate omission.** No score, weighting or percentage anywhere across the four regions, and no
aggregate "design maturity" figure rolling C2 and C4 into a number. The instruments are deliberately
PASS/FAIL, `yes`/`no`/`not yet` and a verdict word; a composite score would let a design pass on
average while failing habit 1, which is the one failure the chapter calls a design defect outright.
Region A's verdict is not computed from the others either — habits 1, 2 and 3 each independently
return the design.

## 6. Absorbed members (3)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-19-pattern-selection-trade-off-register` - Pattern Selection and Trade-Off Register

- **Address.** `handbook\ch19-architectural-patterns-rosetta-stone.qmd` L161-184, 7. Per-layer decision matrix (`#sec-decision-matrix`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Starting from the book's 18-row matrix (Layer / When you have / Reach for / Trade-off you accept / Failure mode if you skip), the team adds three columns: does this condition describe us (yes/no/not yet), which pattern we commit to, and -- mandatory -- the trade-off we are explicitly accepting, signed by a named architect.
- **Its output was.** A design-review register in which every adopted pattern carries a named, accepted trade-off and a named owner.

### `WS-APXB-design-compliance-scorecard` - Agentic Design Compliance Scorecard: Before and After

- **Address.** `handbook\appendix-b-genesis-worked-example.qmd` L33-41, The anti-pattern — panel-in-one-thread (`#sec-genesis-anti-pattern`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Score one of our own agentic designs PASS or FAIL on each of the five checks -- reduced scope (per-lens fresh window), orchestrated composition (independent contracts), single-writer interlock on output, god-module avoidance, fan-out where applicable -- in a current-design column and a redesigned column, citing the evidence behind each verdict.
- **Its output was.** A before/after compliance scorecard for one real design, auditable line by line, with the FAIL rows becoming the redesign backlog.

### `WS-APXB-pattern-rejection-record` - CONSIDERED, REJECTED: The Pattern-Rejection Record

- **Address.** `handbook\appendix-b-genesis-worked-example.qmd` L80-80, The corrected design — fan-out with arbiter (`#sec-genesis-corrected-design`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** For every near-miss pattern the design considered and did not adopt, one row: the pattern name, the verdict (CONSIDERED / ADOPTED / REJECTED), the pattern's own WHEN-clause quoted verbatim, and why our case fails that clause. The appendix supplies two worked rows -- A8 Alignment Loop rejected because a binary PR verdict against a fixed rubric is one-shot per event, and A5 Wave Execution rejected because "No DAG; lenses are mutually independent."
- **Its output was.** An architecture decision record for agentic design in which the rejections are as legible as the adoptions.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-16-seam-placement-canvas` - Draw the Seam: Deterministic / Probabilistic Canvas (Pack D - Architecture and ownership, fill order 3)
- `WS-16-consequential-effect-register` - Consequential Side-Effect Register: What Can Our Agents Actually Do To Us? (Pack E - Guardrails: authority, risk and proof, fill order 5)

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** The org's architecture review board / ADR process; recurring input back into WS-16-consequential-effect-register as new effects appear.

## 8. Facilitation

| | |
|---|---|
| Who fills it | **The reviewer, not the author.** The architect presenting the design attends and supplies evidence; the person completing the gate is whoever the organisation's architecture review process names as reviewer. Region B's B9 signature is a third role — the architect accepting the trade-offs, who may be the author, because accepting a trade-off is an author's act while verifying one is not. Keep the three roles distinct on the page even when one person holds two of them. |
| When in the session | **This is the closing instrument of the governance track, not an optional extra.** It cannot be written before its prerequisites: `WS-16-seam-placement-canvas` (Pack D) supplies the diagram habit 1 inspects, and `WS-16-consequential-effect-register` (Pack E) supplies the rows of the habit 2 sub-table. In Pack Z it is stood up once — agreeing the standard and calibrating it — and then run per design, indefinitely. It is the artefact that makes the leadership kit stick past the workshop, which is worth saying to the room while standing it up. |
| Duration | 45 minutes to stand up the standard, assuming both prerequisites are filled. Then 60–90 minutes per design reviewed. Region B dominates the first few reviews and then shortens sharply: once the organisation's pattern commitments in B7 and B8 stabilise, most of the eighteen rows carry forward and only the changed ones are re-argued. |
| Data needed in advance | The design's own diagram, with boxes already drawn — the gate inspects a diagram, it does not draw one; the completed `WS-16-consequential-effect-register`, since habit 2's sub-table is one row per effect in it; the design's decision history, dated, so habit 2's before-the-model ordering is checkable rather than asserted; and the vendor or runtime documentation needed to answer 3b honestly. |
| Room format | The design on screen, the gate printed or projected beside it, completed live by the reviewer while the author answers. Do not circulate it as a self-assessment for the author to return — a gate scored by the person who wants to pass it is a formality, and habit 2's ordering question in particular is not one an author can grade honestly about their own work. |

**Facilitation note.** Calibrate on something real before gating something new. Region C exists in a
before-and-after shape precisely so that the first run can be against an **existing** design the team
already has: score the current design in C2, sketch the redesign, score it in C4, and let the FAIL
rows become the backlog. A standard first exercised on a design nobody is emotionally committed to is
a standard the team trusts; a standard whose first outing blocks somebody's live proposal is a
standard the team routes around.

Two lines are worth reading aloud. The chapter's closing line, which is also the sheet's header —
*the place to find out is in the design review, not in the post-mortem* — and the reviewer rule
beneath Region B: a design that names a pattern without naming the trade-off it accepts is
structurally incomplete. Region D is the same discipline inverted, and it is the region rooms skip:
reaching for a pattern is half the discipline, and declining a near-miss with its WHEN-clause quoted
is the other half. A design with only adoptions on the page has not been designed, it has been
assembled.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All three habits in Region A carry a verdict with evidence, and column 5 is empty.** A design
   with any consequential effect still sitting on the probabilistic side of the line is a design
   defect by the chapter's own words, and the gate verdict is `RETURNED` — not `APPROVED WITH
   CONDITIONS`. This criterion is not waivable.
2. **Every consequential effect in `WS-16-consequential-effect-register` appears as a row in the
   habit 2 sub-table**, with a named failure mode in 2b and exactly one of the four gate cells in
   2c. An effect in the register with no row here is an ungated consequential action, and the
   reconciliation between the two sheets is how it surfaces. Effects appearing here but not in the
   register go back to the register rather than being added locally.
3. **2e is evidenced, not asserted.** A dated decision record, an ADR or a commit order showing the
   gate was chosen before the model. "Yes, we did it that way" fails: the ordering is the whole
   content of habit 2, and it is the one thing a design cannot be retro-fitted with.
4. **Habit 3 is complete end to end.** 3b is answered (`not checked` is a fail — the chapter requires
   the question be asked), and where 3c records `weak-form`, both 3d and 3e are filled. A blank
   compensating control in 3e fails the habit regardless of how well-reasoned 3d is.
5. **Region B: no pattern committed in B7 without its accepted trade-off in B8, and B9 is signed.**
   This is the chapter's own reviewer rule and it applies row by row, not in aggregate. Every row
   where B6 reads `yes` has a B7 and a B8, or the register is incomplete.
6. **Region C is scored in both columns for all five checks with evidence behind each verdict, and
   every residual FAIL in C4 has a backlog item and a named owner in C6.** A FAIL with no owner is a
   known defect the design review chose to record and not to fix.
7. **Region D carries at least one row with a verdict of `REJECTED` and the WHEN-clause quoted
   verbatim in D3.** A gate returned with an empty rejection record means the design considered
   nothing it did not adopt, which is either untrue or a sign the alternatives were never examined.
   Paraphrased WHEN-clauses fail: the point of quoting is that the clause, not the reviewer's
   recollection of it, is what the case is being tested against.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Carried unchanged from _section-clusters.md section 7 for CL-ARCH-REVIEW-STANDARD.
- **Fill (the organisation completing it): `S`.** S - one sitting, data already in the room

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Already structured: the three habits at lines 143-145 are the three checklist items almost verbatim. Scored 2 deliberately rather than 1 - it is the standing operating control derived from the three priority-1 sheets above, and it cannot be written before they are filled. But it is the artefact that makes the leadership kit stick past the workshop, so the synthesizer should treat it as the *closing* instrument of the governance track rather than an optional extra. Low authoring effort; mostly a formatting job. The chapter's closing line - "the place to find out is in the design review, not in the post-mortem" (line 147) - is the header text for the sheet.
