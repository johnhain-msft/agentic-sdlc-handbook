# Quarterly Board Scorecard: Adoption, Value, Cost, Risk

`WS-05-board-reporting-scorecard` &middot; **Pack G - The plan we leave with** &middot; fill order **7** &middot; type `canvas` &middot; audience **exec** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A one-page quarterly board artefact; and, used before launch, the measurement plan naming which instrumentation must exist on day one.

**Cluster.** `CL-BOARD-SCORECARD` - Board Scorecard: Metrics, Targets, Evidence Grade and Tripwires

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch05-governance-for-ai-assisted-delivery.qmd` |
| Chapter | Governance for AI-Assisted Delivery |
| Heading | Board Reporting Template |
| Stable anchor | `#sec-governance-board-reporting` |
| Lines | L217-247 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch05-governance-for-ai-assisted-delivery.html#sec-governance-board-reporting> |
| Locator quote | "Leaders need to communicate AI agent adoption status to executive and board audiences" |

Resolve at any time with `python docs/resolve.py ws WS-05-board-reporting-scorecard`.

## 3. Source extract - the scaffolding, verbatim

```text
  217 | Leaders need to communicate AI agent adoption status to executive and board audiences. The template below provides a one-page format that covers the four areas boards ask about: what is happening, what it costs, what the risks are, and what decisions are needed.
  218 | 
  219 | A status snapshot is a status email. A governance artifact shows where you are, where you are going, and whether you are on track. The template includes targets and trends for every metric row — without them, the board cannot distinguish progress from noise.
  220 | 
  221 | **AI-Assisted Development — Quarterly Status**
  222 | 
  223 | ::: {tbl-colwidths="[12,25,28,18,17]"}
  224 | 
  225 | | Section | Metric | Current | Target | Trend |
  226 | |---|---|---|---|---|
  227 | | **Adoption** | Developers using agent tools | *e.g., 120 of 400 (30%)* | *80% by Q4* | *↑ from 18% last quarter* |
  228 | | | PRs with agent-generated code | *e.g., 22%* | *40% by Q4* | *↑ from 12%* |
  229 | | | Phase maturity | *e.g., Phase 2 (conversational)* | *Phase 3 (agentic) by year-end* | *Advanced from Phase 1 in Q1* |
  230 | | **Value** | Cycle time (agent-assisted vs. baseline) | *e.g., −18% on eligible tasks* | *−25%* | *↑ improving (was −11%)* |
  231 | | | Deployment frequency | *e.g., 3.2/week* | *4/week* | *→ flat* |
  232 | | | Developer satisfaction (survey) | *e.g., 7.4/10* | *≥7.5* | *↑ from 6.8* |
  233 | | **Cost** | Tool licensing | *e.g., $42K/quarter* | *≤$50K* | *→ stable* |
  234 | | | Model API / token spend | *e.g., $28K/quarter* | *≤$35K* | *↑ from $19K (adoption growth)* |
  235 | | | Total cost of ownership | *e.g., $85K/quarter* | *≤$100K* | *↑ tracking to plan* |
  236 | | **Risk** | Governance readiness (lowest capability) | *e.g., Basic in 4/6 areas* | *Basic in 6/6 by Q3* | *↑ was None in 3/6* |
  237 | | | Open audit findings (agent-related) | *e.g., 2 open* | *0* | *↓ from 5* |
  238 | | | Agent-related incidents | *e.g., 1 this quarter* | *0* | *→ flat* |
  239 | | | Data boundary compliance | *e.g., Compliant* | *Maintain* | *→ stable* |
  240 | | | Insurance / liability coverage | *e.g., E&O and cyber reviewed; agent clause pending* | *Agent-specific coverage confirmed* | *In progress* |
  241 | | **Decisions needed** | | *Budget approval for next quarter. Data classification policy update requiring board awareness. Vendor contract renewal. Risk acceptance for identified gaps.* | | |
  242 | 
  243 | :::
  244 | 
  245 | The template is deliberately brief. Board reporting should communicate status and surface decisions, not educate the audience on how agents work. The trend column is the most important: it tells the board whether the investment is producing directional progress or whether intervention is needed.
  246 | 
  247 | ---
```

## 4. What the user fills

Fourteen metric rows across four sections. Per row the leader fills Current, Target and Trend and - critically when used before groundbreaking - the Month 0 baseline value and the named system of record that will produce the number each quarter. The Decisions Needed block is filled with the specific budget, policy and risk-acceptance asks for the quarter.

## 5. Field-level schema

Rows are the fourteen metric lines of the chapter's template, grouped under Adoption / Value /
Cost / Risk, plus the Decisions Needed block. **Page one is the board page and stays one page** —
ch05 L245 is explicit that the template is deliberately brief. Columns 1–14 fit on it. The four
absorbed blocks (columns 18–39) are the annex the leader keeps behind it, and they are what make
page one defensible; they are not what goes to the board.

**This is the kit's structural control point for integrity, and columns 8, 9 and 10 are the
mechanism.** Every metric row carries an **evidence grade** and a **falsifier in the same row as
the target**, so a hedged anecdote cannot be reported upward without its grade travelling with
it. A target graded `author estimate` prints with the book's own dagger convention (ch01 L140:
"Tables containing author estimates are marked with † throughout") and cannot be rendered as a
bare number. The grade is a required field: a row cannot be printed with column 8 empty.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Section | `select` (five fixed) | Adoption · Value · Cost · Risk · Decisions needed | — | ch05 L226-241 |
| 2 | Metric | `free text`, locked (fourteen rows) | Developers using agent tools · PRs with agent-generated code · Phase maturity · Cycle time (agent-assisted vs. baseline) · Deployment frequency · Developer satisfaction (survey) · Tool licensing · Model API / token spend · Total cost of ownership · Governance readiness (lowest capability) · Open audit findings (agent-related) · Agent-related incidents · Data boundary compliance · Insurance / liability coverage | — | ch05 L227-240 |
| 3 | Month 0 baseline | `free text` / `currency` | — | **Mandatory.** ch05 L245 calls the trend column the most important thing on the page, and a trend is impossible without a starting point. A blank here makes columns 7 and 11 undefined | ch05 L219, L245 |
| 4 | System of record | `free text` | — | The named report, query or dashboard that will produce this number every quarter without anyone reconstructing it | derived |
| 5 | Owner of the number | `owner (named person)` | — | The person who produces it, not the person who presents it | derived |
| 6 | Current | `free text` / `currency` | The chapter's italic placeholders — *120 of 400 (30%)*, *22%*, *−18% on eligible tasks*, *$42K/quarter* and the rest — printed greyed and explicitly labelled as the template's illustrative values | Our own figure | ch05 L227-240 |
| 7 | Target | `free text` / `currency` | The chapter's italic placeholders — *80% by Q4*, *−25%*, *≤$50K* — printed greyed and labelled illustrative | Our own target, with a date | ch05 L227-240 |
| 8 | **Evidence grade** | `select` `measured` / `author estimate` / `vendor claim` | — | **Mandatory; the row cannot print without it.** `measured` means we have the number from column 4 for this organisation. `author estimate` means it came from the book or an adjacent source and is the author's observation, not industry-validated. `vendor claim` means a supplier told us | ch01 L136-142 |
| 9 | Grade source | `free text` | — | Where the grade comes from. For `author estimate`, cite the chapter and line. For `vendor claim`, name the vendor and the document | ch01 L136-142 |
| 10 | **Falsifier** | `free text` | — | **Mandatory, in the same row as the target.** The specific observation that would tell us this target or claim was wrong. Not a risk — an observation. "Rejection rate flat at week 12 despite a completed context layer" is a falsifier; "adoption might be slow" is not | ch01 L136-142 |
| 11 | Trend, with the prior value | `select` ↑ improving / → flat / ↓ declining, plus `free text` | *↑ from 18% last quarter*, *→ flat*, *↓ from 5* — printed greyed as the template's illustrative values | The direction and the actual prior figure | ch05 L227-240, L245 |
| 12 | Our confidence | `H/M/L` | — | Confidence in the number itself, distinct from the grade. A `measured` number from an immature pipeline can still be Low | ch01 L136-142 |
| 13 | Tripwire: what we do when it trips | `free text` | — | The pre-agreed action, written before the quarter it is needed | ch27 L199-211 |
| 14 | Watcher | `owner (named person)` | — | — | derived |
| 15 | **Decisions needed** — Decision requested | `free text` | Budget approval for next quarter · data classification policy update requiring board awareness · vendor contract renewal · risk acceptance for identified gaps | Our actual asks this quarter | ch05 L241 |
| 16 | **Decisions needed** — Who must decide | `owner (named person)` | — | — | derived |
| 17 | **Decisions needed** — Needed by | `date` | — | — | derived |
| 18 | **Annex A: claims** — Claim the plan depends on | `free text` | — | Each load-bearing claim the transformation rests on | ch01 L136-142 |
| 19 | **Annex A: claims** — Source | `free text` | — | — | ch01 L136-142 |
| 20 | **Annex A: claims** — Evidence grade | `select` (same three values as column 8) | — | Same vocabulary, deliberately. A claim and a metric are graded on one scale | ch01 L136-142 |
| 21 | **Annex A: claims** — Our confidence | `H/M/L` | — | — | ch01 L136-142 |
| 22 | **Annex A: claims** — Falsifier | `free text` | — | The specific observation that would tell us we were wrong | ch01 L136-142 |
| 23 | **Annex B: outcomes** — Claimed output | `free text`, locked (four rows) | Bisectable history · Auditable decisions · Reproducible process · Proportional cost | — | ch18 L304-314 |
| 24 | **Annex B: outcomes** — Baseline today | `free text` | — | — | ch18 L304-314 |
| 25 | **Annex B: outcomes** — Observable evidence that would prove it | `free text` | The chapter's own tests, printed as prompts: can we bisect to a wave? is there a decision record per PR? would a different developer with the same codebase, context files and plan produce substantially similar output? does cost scale with change scope rather than codebase size? | Our own observable test | ch18 L306-314 |
| 26 | **Annex B: outcomes** — Evidence grade | `select` (same three values) | Pre-set to `author estimate` for *reproducible process* (ch18 L310 states plainly: "This is our hypothesis, not a tested claim") and for *proportional cost* (ch18 L314: "we have verified this only at the scale documented in the reference case study") | Confirm or upgrade once we have measured it ourselves | ch18 L310, L314 |
| 27 | **Annex B: outcomes** — Target and review date | `free text` + `date` | — | — | ch18 L304-314 |
| 28 | **Annex B: outcomes** — Struck through | `checkbox` | — | Ticked where we are not willing to be measured on this outcome. A struck row is honest; a blank row that nobody intends to measure is not | ch18 L302-316 |
| 29 | **Annex C: assumptions** — Assumption | `free text`, locked (five rows) | The pace of capability improvement may outrun governance · the emphasis on human-in-the-loop may prove too conservative · the human-as-orchestrator model may be transitional rather than enduring · the documentation burden may not pay for itself · human judgement as a differentiator may be temporal rather than structural | — | ch27 L199-211 |
| 30 | **Annex C: assumptions** — Does it hold for us | `select` holds / does not hold / unknown | — | `unknown` is a legitimate answer and requires a watcher | ch27 L199-211 |
| 31 | **Annex C: assumptions** — Observable signal it broke | `free text` | — | — | ch27 L199-211 |
| 32 | **Annex C: assumptions** — Who watches, and what we do | `owner (named person)` + `free text` | — | — | ch27 L199-211 |
| 33 | **Annex C: assumptions** — Quarterly review date | `date` | — | The chapter's framing is that this register keeps the plan honest as the field moves; an undated register does not | ch27 L199-211 |
| 34 | **Annex D: bets** — Investment | `free text` | — | Each planned investment in the transformation, one per row | ch27 L112-125 |
| 35 | **Annex D: bets** — Tier | `select` Available now / Emerging / Directional / Structural | The chapter's own eight-row table ships alongside as the worked example, with its guidance printed: invest confidently in *available now*, prepare for *emerging*, be aware of *directional* without betting the organisation on specific timelines | Our classification of our own investment | ch27 L112-125 |
| 36 | **Annex D: bets** — Our confidence | `H/M/L` | The book's own confidence column shown as the exemplar | Our rating, which may differ from the book's | ch27 L112-125 |
| 37 | **Annex D: bets** — Budget attached | `currency` | — | Reconciles to `WS-07-spend-pool-budget-model` and `WS-04-intent-build-operate-investment-balance` | derived |
| 38 | **Annex D: bets** — Hedge if the tier proves wrong | `free text` | — | What we do instead, and what it would cost | ch27 L112-125 |
| — | Page-one legend | printed, non-editable | "† author estimate — not industry-validated. Every target on this page carries its evidence grade and its falsifier." | — | ch01 L140 |

**Absorbed detail.** `WS-01-evidence-and-claim-register` is not appended — it is **dissolved into
the row schema**, which is the entire point of this sheet. Columns 8 (grade), 9 (source), 12
(confidence) and 10 (falsifier) are its five fields applied to every metric row, with Annex A
(columns 18–22) carrying the claims that are not metrics. `WS-18-outcome-scorecard` is Annex B,
columns 23–28, including its strike-through for outcomes the organisation will not be measured
on, and with two of the four outcomes pre-graded `author estimate` on the book's own admission.
`WS-27-assumption-risk-register` is Annex C, columns 29–33: five named assumptions, the observable
break signal, the watcher, the action and the quarterly date. `WS-27-bet-register` is Annex D,
columns 34–38: the investment, its tier, our confidence, the budget and the hedge, with the
chapter's eight-row table shipped as the worked example rather than as our data.

**Deliberate omission.** No composite score, RAG status or overall health index. A single
red/amber/green rolls fourteen rows of different evidence grades into one symbol and destroys
exactly the information this sheet exists to preserve — a `measured` cost overrun and a
`vendor claim` adoption target would average into the same colour.

**Deliberate omission.** The annexes do not go to the board. They are the leader's working papers,
and the chapter is explicit that board reporting should surface decisions rather than educate the
audience. What travels upward from them is the grade and the falsifier already printed on page one.

## 6. Absorbed members (4)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-01-evidence-and-claim-register` - Evidence & Falsification Register

- **Address.** `handbook\ch01-the-agentic-sdlc-thesis.qmd` L136-142, Scope and Limitations (`#sec-thesis-scope-limits`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Each claim the transformation plan depends on, with its source, whether it is measured evidence or an author/vendor estimate, the organisation's confidence, and the specific observation that would falsify it.
- **Its output was.** A board-ready statement of what the organisation is betting on and how it will know it was wrong - the honesty artefact that survives a CFO challenge.

### `WS-18-outcome-scorecard` - Success Criteria Scorecard: What We Expect To Get

- **Address.** `handbook\ch18-the-execution-meta-process.qmd` L302-316, What the Meta-Process Produces (`#sec-meta-outputs`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** For each of the four claimed outputs - bisectable history, auditable decisions, reproducible process, proportional cost - the group records the baseline today, the observable evidence that would prove the outcome (can we bisect to a wave? is there a decision record per PR? does cost scale with change scope rather than codebase size?), the target, and the review date. Claims the org is not willing to be measured on are struck through.
- **Its output was.** An agreed, measurable definition of success for the transformation, written before it starts - the benefits-realisation basis for the later review.

### `WS-27-assumption-risk-register` - Assumption Risk Register and Tripwires

- **Address.** `handbook\ch27-what-comes-next.qmd` L199-211, What the Author Probably Got Wrong (`#sec-next-author-caveats`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Each of the five named assumptions becomes a row - governance outpaced by capability, human-in-the-loop too conservative, human-as-orchestrator only transitional, documentation burden not paying for itself, and human judgment as a temporal rather than structural moat - and the team adds: does this assumption hold for us, what observable signal would tell us it broke, who watches for it, and what we do when it trips.
- **Its output was.** A risk register with tripwires, reviewed quarterly - the artifact that keeps a transformation plan honest as the field moves.

### `WS-27-bet-register` - Investment Tier Register: Available Now / Emerging / Directional

- **Address.** `handbook\ch27-what-comes-next.qmd` L112-125, Three-Tier Honesty Applied to This Chapter's Own Claims (`#sec-next-three-tier-honesty`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Each planned investment in the transformation becomes a row, classified into the book's three tiers with our own confidence rating, the budget attached, and the hedge if the tier proves wrong. The chapter's own eight-row table ships alongside as the worked example.
- **Its output was.** A tiered investment register that separates what we fund confidently, what we prepare for, and what we merely watch.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-05-governance-readiness-assessment` - Governance Readiness Self-Assessment (Six Capabilities) (Pack E - Guardrails: authority, risk and proof, fill order 4)
- `WS-04-intent-build-operate-investment-balance` - Intent / Build / Operate Investment Balance Sheet (Pack C - The case and the money, fill order 7)

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** Board and steering-committee cadence; consumes WS-05-governance-readiness-assessment and WS-08-phase-gate-exit-rollback

## 8. Facilitation

| | |
|---|---|
| Who fills it | The executive who will actually stand in front of the board, with the person who owns each number in column 5 and whoever holds the governance readiness assessment. Finance must be present for the three Cost rows — they reconcile to `WS-04-intent-build-operate-investment-balance` and `WS-07-spend-pool-budget-model`, and a cost row assembled without finance will be contradicted in the meeting it is written for. |
| When in the session | After `WS-05-governance-readiness-assessment` and `WS-04-intent-build-operate-investment-balance`, which supply the Risk and Cost rows. Used before groundbreaking it runs in reverse: reading the fourteen rows tells you exactly which instrumentation must exist on day one, and every blank in column 3 is a baseline `WS-08-baseline-measurement-plan` has to go and capture. |
| Duration | 90 minutes. Columns 3 and 4 take the first 40 — the honest answer for several rows is "we don't measure that and nothing produces it", and that finding is worth more than the cell. Columns 8 and 10 take the next 30; the grade is quick, the falsifier is not. The annexes are pre-drafted and confirmed in 20. |
| Data needed in advance | Current seat counts and licence spend; PR analytics with any existing agent-generated tagging; the last four quarters of DORA figures; the completed governance readiness assessment; the open audit findings list; the current E&O and cyber policy wording; the draft budget by tier. Also, critically: the previous quarter's version of this scorecard if one exists — column 11 is meaningless without it. |
| Room format | Projected and filled live, because the arguments in columns 8 and 10 are the session. Then printed as a single page for the board and re-read aloud once, end to end, before anyone signs off on it. The annexes stay as a separate stapled document that does not leave the leadership team. |

**Facilitation note.** Two rows are routinely skipped and both cost more than they save. The
**insurance / liability** row (ch05 L240) maps to chapter checklist item 11 — confirm E&O and
cyber policies address agent-generated code, and raise it with the CFO before the board does;
flag it explicitly and do not let the room mark it `Compliant` on the basis that nobody has
checked. The **phase maturity** row invites a self-flattering answer; ask for the evidence in
column 9 rather than the assessment. Beyond that, the facilitator's job on this sheet is narrow
and absolute: **no target is written without its grade and its falsifier in the same row.** When
someone offers a figure, the next question is always "measured, author estimate, or vendor
claim?" and then "what would we see if that were wrong?" A room that cannot answer the second
question has not got a target, it has an aspiration, and the sheet should record it as one.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **Every one of the fourteen rows carries an evidence grade in column 8 and a falsifier in
   column 10.** No exceptions, including the Risk rows where the answer feels self-evident. A row
   with a target and no grade is the failure this entire sheet exists to prevent, and the page must
   not print.
2. **Every target graded `author estimate` or `vendor claim` is marked with the dagger and its
   source is named in column 9.** A reader who has never seen the book must be able to tell, from
   page one alone, which numbers this organisation measured and which it inherited.
3. **Every row has a Month 0 baseline (column 3) and a named system of record (column 4), or an
   explicit `not instrumented` with an owner and a date to fix it.** ch05 L245 makes the trend
   column the most important on the page; a trend computed from nothing is a drawing.
4. **Every falsifier is an observation, not a risk.** Applied as a test: a colleague reading column
   10 must be able to say what they would have to look at, and when, to determine whether the target
   was wrong. "Adoption may be slower than planned" fails; "fewer than half the licensed developers
   have opened an agent session in the last 30 days, per the licence console" passes.
5. **The Cost rows reconcile.** The three cost figures agree with
   `WS-04-intent-build-operate-investment-balance` and with the funded pools in
   `WS-07-spend-pool-budget-model`; the Annex D budget column sums to the same total. A discrepancy
   is an unfunded commitment or a missed cost, and both must be resolved before the page is issued.
6. **The insurance / liability row is answered on evidence, not assumption**, with the policy
   document named in column 9. ch05 L275 asks for this before the board does.
7. **Page one is one page**, and no annex content has migrated onto it. The annexes are complete
   and dated, and Annex C carries a quarterly review date.
8. **Annex B's two hedged outcomes remain graded `author estimate`** until this organisation has
   measured them itself. Upgrading *reproducible process* or *proportional cost* to `measured`
   without our own evidence contradicts the source directly.
9. **The Risk section reconciles with `WS-05-governance-readiness-assessment`**, and the
   adoption and value rows reconcile with the calibrated triggers on
   `WS-08-phase-gate-exit-rollback` — a board target that is more aggressive than the gate
   threshold the same organisation signed is a contradiction that will surface in the meeting.

## 10. Integrity constraint

**Named rule for this sheet.** STRUCTURAL CONTROL POINT for the whole kit. Every metric row carries an evidence grade (measured / author estimate / vendor claim) and a falsifier, in the same row as the target. A hedged anecdote cannot be reported upward without its grade travelling with it.

**Hedged figures reachable from this source range.** Each is listed with the book's own hedge, verbatim, and where that hedge lives. Present the figure as a pre-filled prior the organisation overwrites, or as a facilitation prompt - never as a benchmark, target or acceptance threshold. **Carry the hedge onto the sheet with the number; do not restate it in your own words.**

- **The two productivity poles the passage sets against each other, 15-20% and 2-3x.**
  - *Appears at* `handbook\ch27-what-comes-next.qmd` L203-213
  - *The book's hedge (ch27 L207):* The book states the problem and explicitly declines to resolve it: the break-even is 'less obviously favorable than the book implies' and the author has not seen enough longitudinal data. Any sheet using these must output a RANGE, never a single figure.
- **The italic placeholder values printed in every cell of the board scorecard.**
  - *Appears at* `handbook\ch05-governance-for-ai-assisted-delivery.qmd` L215-240
  - *The book's hedge (ch05 L263):* 'Use this as a starting point. Adapt the specifics to your organization's risk profile, regulatory environment, and adoption stage.' They are layout placeholders, not targets.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Carried unchanged from _section-clusters.md section 7 for CL-BOARD-SCORECARD.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Already the most worksheet-like artefact in the chapter - it ships with italic placeholder values in every cell, effectively a filled example. Its pre-groundbreaking value is the reverse-engineering: reading it before you start tells you exactly which baselines and instrumentation must exist on day one, and the chapter stresses the trend column is the most important (line 247) - trends are impossible without a Month 0 baseline. Add a baseline column and a system-of-record column. The insurance / liability row (line 245) is easy to skip and maps to chapter checklist item 11 (line 275) on E and O and cyber cover - flag it in facilitation. Cost rows overlap WS-04-intent-build-operate-investment-balance and the dedicated cost chapter.
