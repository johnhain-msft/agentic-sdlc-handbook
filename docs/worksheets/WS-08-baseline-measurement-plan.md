# Baseline Measurement and Instrumentation Plan

`WS-08-baseline-measurement-plan` &middot; **Pack A - Groundwork (pre-work)** &middot; fill order **4** &middot; type `inventory` &middot; audience **eng-leader** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A baseline metrics pack captured before the pilot starts, with named owners and an agreed instrumentation level — without which the phase gates in WS-08-phase-gate-exit-rollback cannot be evaluated at all.

**Cluster.** `CL-BASELINE` - Delivery Baseline Capture Pack

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch08-planning-the-transition.qmd` |
| Chapter | Planning the Transition |
| Heading | Metrics That Matter |
| Stable anchor | `#sec-transition-metrics` |
| Lines | L204-236 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch08-planning-the-transition.html#sec-transition-metrics> |
| Locator quote | "Measure what predicts long-term value, not what flatters short-term adoption." |

Resolve at any time with `python docs/resolve.py ws WS-08-baseline-measurement-plan`.

## 3. Source extract - the scaffolding, verbatim

```text
  204 | Measure what predicts long-term value, not what flatters short-term adoption.
  205 | 
  206 | ::: {tbl-colwidths="[10,25,35,30]"}
  207 | 
  208 | | Category | Metric | What It Tells You | What It Doesn't |
  209 | |---|---|---|---|
  210 | | Quality | Review rejection rate for agent-generated PRs | Whether agents are producing code your team trusts | Whether the accepted code has latent defects |
  211 | | Quality | Human intervention rate per task | How often agents need correction mid-task | Why they need correction (context gap? tool limitation?) |
  212 | | Efficiency | Time-to-confident-merge | End-to-end time from task start to merged, reviewed code | Whether faster merges translate to faster feature delivery |
  213 | | Efficiency | Rework rate on agent-generated code (30-day) | Whether agent output survives contact with production | What the rework costs (trivial fixes vs. architectural changes) |
  214 | | Adoption | Context asset coverage | What percentage of your codebase has structured context | Whether that context is good (coverage without quality is noise) |
  215 | | Adoption | Active usage rate vs. license count | Whether people who have the tools are using them | Whether they're using them well |
  216 | | DORA | Deployment frequency, lead time, change failure rate, MTTR | Baseline delivery performance and trends | Causation — many factors affect DORA metrics simultaneously |
  217 | 
  218 | :::
  219 | 
  220 | Start with the DORA metrics as your shared language. They are well-understood, widely adopted, and provide a baseline that predates your agentic adoption. Then add the agent-specific metrics — intervention rate, rejection rate, rework rate — as leading indicators of whether the tools are producing genuine value or shifting effort between phases.
  221 | 
  222 | The single most important metric is one that most organizations do not track: the ratio of time spent *generating* code with agents to time spent *reviewing and correcting* agent-generated code. If that ratio is improving — less time reviewing per unit of generation — the tools are working. If it is flat or worsening, you have a context quality problem, a skill problem, or both.
  223 | 
  224 | ### Instrumenting the Generation-to-Review Ratio
  225 | 
  226 | A metric you cannot measure is a vanity metric in disguise. Here is how to actually capture the generation-to-review ratio, from least to most investment.
  227 | 
  228 | **Level 1: PR metadata (low effort, moderate accuracy).** Most teams can start here. Tag agent-generated PRs with a label — `agent-generated`, `ai-assisted`, or whatever your tooling supports. Many AI coding tools already add metadata to commits or PR descriptions. Measure two timestamps per PR: creation time (proxy for generation end) and final approval time (proxy for review end). The ratio is aggregate review time divided by aggregate generation time across tagged PRs. This is noisy — PRs vary in size, review includes non-agent concerns — but it produces a directional trend. Tools: GitHub labels + a weekly query against your PR analytics.
  229 | 
  230 | **Level 2: Annotation tags in workflow (medium effort, good accuracy).** Developers annotate their task tracking with structured tags: `[gen-start]`, `[gen-end]`, `[review-start]`, `[review-end]`. This can be as lightweight as a comment in the task tracker or a structured field in your project management tool. The annotations capture the actual time developers spend in each mode, not proxy timestamps. The overhead is roughly 30 seconds per task. Accuracy improves significantly because you are measuring developer time, not PR lifecycle time. Tools: task tracker custom fields, or a shared spreadsheet during the pilot phase.
  231 | 
  232 | **Level 3: Git hooks and editor telemetry (higher effort, high accuracy).** For organizations that want precision, instrument the development environment directly. A pre-commit hook can detect agent-generated code (by presence of agent metadata, co-author trailers, or configurable markers) and log generation events. Editor extensions can track time spent in "generation mode" versus "review mode" based on active tool state. This data feeds a dashboard that computes the ratio automatically. This level of instrumentation is Phase 3 investment — do not attempt it in the pilot. Tools: custom git hooks, editor extension APIs, a lightweight telemetry pipeline.
  233 | 
  234 | **What healthy looks like.** These are starting benchmarks based on the author's observation of early adopter teams, not industry-validated thresholds. Calibrate against your own baseline. Early in adoption, expect a generation-to-review ratio around 1:1 — for every hour of agent-assisted generation, roughly an hour of review and correction. As context quality improves and teams calibrate their delegation patterns, healthy teams reach 3:1 or better. Below 1.5:1 after four weeks of active use indicates a context quality problem — the agents are producing output that costs almost as much to verify as it saves in creation. Above 5:1 warrants scrutiny in the other direction — verify that review rigor has not declined along with review time.
  235 | 
  236 | ---
```

## 4. What the user fills

One row per metric from the chapter table (review rejection rate, human intervention rate, time-to-confident-merge, 30-day rework rate, context asset coverage, active usage vs license count, and the four DORA metrics). Per row: our baseline value captured today, the source system, the named owner, the reporting cadence, and what this metric explicitly does not tell us. A second block selects the instrumentation level for the generation-to-review ratio — Level 1 PR metadata and labels, Level 2 workflow annotation tags, or Level 3 git hooks and editor telemetry — and records the chosen thresholds.

## 5. Field-level schema

Four panels. **Panel A** is the metric baseline register: one row per metric, eighteen fixed rows.
**Panel B** is a single instrumentation decision for the generation-to-review ratio. **Panel C** is
the time-allocation baseline: one row per activity, seven fixed rows. **Panel D** is the
first-initiative canonical metrics record. Panel A prints A3 landscape and is the widest sheet in
the kit; the rest fit one page each. The whole pack is dated once, on the front, and that date is
the before-picture.

**The column that makes this sheet safe.** Every figure the book supplies in this range is
author-observed or a survey composite, and the chapter says so itself. They are therefore confined
to a single column on each panel, headed **"Book's stated prior — author-observed, not a target"**,
always immediately to the left of a blank **"Ours, measured"** column. No gate, threshold or
acceptance criterion anywhere in the kit may reference the prior column.

**Panel A — metric baseline register.** One row per metric.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Category | `select` (fixed) | Quality / Efficiency / Adoption / DORA / Instrumentation | — | ch08 L210-216 |
| 2 | Metric | `select` (fixed 18 rows) | Review rejection rate for agent PRs · Human intervention rate per task · Time-to-confident-merge · Rework rate on agent code (30-day) · Context asset coverage · Active usage rate vs licence count · Deployment frequency · Lead time · Change failure rate · MTTR · Median PR cycle time · Post-deploy defects per release · Developer satisfaction (AI tools) · Convention-violating outputs · Review comments per agent PR · Agent code requiring rewrite · Time from agent output to merge · Generation-to-review ratio | — | ch08 L210-216; ch03 L293-299; ch12 L560-565; ch08 L222 |
| 3 | What it tells you | `free text` | Printed verbatim per row | — | ch08 L210-216 |
| 4 | **What it does NOT tell you** | `free text` | Printed verbatim per row — e.g. "Whether the accepted code has latent defects"; "Coverage without quality is noise"; "Causation — many factors affect DORA metrics simultaneously" | Not editable. This column is the sheet's defence against metric theatre and is printed, not filled. | ch08 L210-216 |
| 5 | Book's stated prior — author-observed, not a target | `free text` | Populated only where the book states one, labelled with its hedge: convention-violating outputs 40-60% uninstrumented; review comments per agent PR 4-8; agent code requiring rewrite 30-50%; time from agent output to merge "hours". All four are "based on the author's experience... directional, not guaranteed" | Blank on the fourteen rows where the book states nothing. **Leave blank. Do not fill by analogy.** | ch12 L560-568 |
| 6 | Chapter's illustrative target — not ours | `free text` | Populated only on the five ch03 rows: median PR cycle time −15% / −25%; review rejection rate −10% / −20%; post-deploy defects −10% / −20%; developer satisfaction >3.5/5 then >4.0/5; human intervention rate "establish baseline" then −20% | Blank elsewhere | ch03 L293-299 |
| 7 | **Ours, measured** | `free text` | — | The number, or the words `not measurable today` | org |
| 8 | Date measured | `date` | — | — | org |
| 9 | Source system | `free text` | Printed as prompts where the book names one: Git analytics · Code review platform · Issue tracker · Quarterly survey · Agent session logs | The actual system and query target | ch03 L293-299 |
| 10 | Measurement method | `free text` | — | The query, filter or report definition, written so someone who was not in the room can re-run it unchanged | org |
| 11 | Owner | `owner (named person)` | — | A named individual per row | org |
| 12 | Reporting cadence | `select` weekly / monthly / quarterly | — | — | ch08 L220 |
| 13 | Our 6-month target | `free text` | — | Set against column 7, never against column 5 or 6 | org |
| 14 | Our 12-month target | `free text` | — | — | org |
| 15 | Re-measure date | `date` | — | — | ch12 L570 |

**Panel B — generation-to-review ratio instrumentation decision.** One row per level; exactly one
is chosen. The chapter calls this ratio the single most important metric most organisations do not
track (ch08 L222), which is why the decision has its own panel rather than a cell on Panel A.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 16 | Level | `select` (fixed 3 rows) | 1 — PR metadata · 2 — Annotation tags in workflow · 3 — Git hooks and editor telemetry | — | ch08 L228-232 |
| 17 | How it measures | `free text` | Printed verbatim: tagged PRs, creation and final-approval timestamps · developer-applied `[gen-start]` / `[gen-end]` / `[review-start]` / `[review-end]` tags · pre-commit hooks detecting agent metadata plus editor mode telemetry | — | ch08 L228-232 |
| 18 | Effort and accuracy | `free text` | Printed verbatim: low effort, moderate accuracy · medium effort, good accuracy, ~30 seconds per task overhead · higher effort, high accuracy | — | ch08 L228-232 |
| 19 | Tools | `free text` | Printed: GitHub labels plus a weekly PR-analytics query · task-tracker custom fields or a shared spreadsheet during the pilot · custom git hooks, editor extension APIs, a lightweight telemetry pipeline | The org's equivalents | ch08 L228-232 |
| 20 | Phase note | `free text` | Printed against Level 3 only: "Phase 3 investment — do not attempt in the pilot" | — | ch08 L232 |
| 21 | Chosen for the pilot | `checkbox` | — | Exactly one tick | org |
| 22 | Owner | `owner (named person)` | — | — | org |
| 23 | Start date | `date` | — | — | org |
| 24 | Calibration anchors — author-observed, NOT targets and NOT acceptance thresholds | `free text` | Printed as a boxed strip, with the chapter's own caveat printed above it: "starting benchmarks based on the author's observation of early adopter teams, not industry-validated thresholds. Calibrate against your own baseline." Anchors: ~1:1 early in adoption · 3:1 or better as teams calibrate · below 1.5:1 after four weeks of active use suggests a context-quality problem · above 5:1 warrants checking that review rigour has not declined | Not editable | ch08 L234 |
| 25 | **Our measured ratio** | `free text` + `date` | — | The number and the date. Blank until Level 1, 2 or 3 has run. | org |

**Panel C — time allocation baseline.** One row per activity, seven fixed rows.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 26 | Activity | `select` (fixed 7 rows) | Writing new code · Reading and understanding code · Code review · Specification and design · Debugging and incident response · Context engineering · Meetings and coordination | — | ch06 L22-30 |
| 27 | Book's pre-agentic composite — survey composite, not ours | `free text` | 30-35% · 20-25% · 10-15% · 10-15% · 15-20% · 0% · 10-15%, labelled as a composite drawn from multiple 2019-2023 surveys with no single source producing the breakdown | Not editable | ch06 L22-30, footnote `ch6-time` |
| 28 | Book's projected agentic range † — author observation, not survey data | `free text` | 10-15% · 15-20% · 20-25% · 20-25% · 10-15% · 10-15% · 10-15%, carrying the chapter's † marker | Not editable | ch06 L22-30, L33 |
| 29 | **Our estimated current %** | `free text` | — | — | org |
| 30 | How that estimate was derived | `select` timesheet / sampled survey / lead's estimate | — | Required. An unlabelled estimate reads as measurement. | derived |
| 31 | **Our 12-month target %** | `free text` | — | — | org |
| 32 | Delta in FTE-equivalent hours | `computed` | — | Column 31 minus column 29, applied to headcount | derived |
| — | Context-engineering capacity ask | `computed` | Row note printed: this row is a net-new allocation that does not exist in the current model | The FTE figure carried into the business case | ch06 L28 |

**Panel D — first-initiative canonical metrics.** Filled once, for the first initiative, before it
starts.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 33 | Metric | `select` (fixed rows) | Files in scope · Tests before · Cycle time for a comparable refactor today · Planned human-time split across planning / monitoring / interventions / review · Comparable manual refactor duration | — | case study L268-285 |
| 34 | APM case exemplar — a single documented execution, not a benchmark | `free text` | 75 files · 2,829 tests before · ~90 minutes wave execution and ~16 hours total wall-clock · ~30% planning / ~20% monitoring / ~25% interventions / ~25% review, marked "approximate, single execution" · 3-5 days for a comparable manual refactor, marked "has not been formally benchmarked" | Not editable | case study L268-287 |
| 35 | **Ours, planned** | `free text` | — | — | org |
| 36 | Date recorded | `date` | — | Must precede the initiative start | org |
| 37 | Owner | `owner (named person)` | — | — | org |

**Absorbed detail.** `WS-03-delivery-baseline-scorecard` supplies Panel A rows 11-13 and the
columns its blanks printed: baseline value (7), source (9), and 6- and 12-month targets (13-14),
with ch03's own target figures quarantined in column 6 as the chapter's illustration rather than
the organisation's commitment. `WS-06-time-allocation-baseline` is Panel C in its entirety,
including its three numbers per row — current %, 12-month target %, delta in FTE-equivalent hours
— and its closing observation that context engineering is a net-new allocation, carried as the
computed capacity ask. `WS-12-instrumentation-baseline-metrics` supplies Panel A rows 14-17 with
its four ch12 metrics, its data sources in column 9 and its re-measure date in column 15.
`WS-CS-APM-baseline-metrics` is Panel D, its blank Canonical Metrics table reproduced as column 35
against the case's own figures in column 34.

**Deliberate omission.** No projected improvement, expected saving or ROI column on any panel. The
moment a baseline sheet carries a projection it stops being a before-picture and becomes a
forecast, and the two are then impossible to separate at review. Projection belongs to
`WS-03-roi-break-even-model`. Also omitted: any composite "delivery health" index. Column 4 exists
precisely to stop metrics being read as interchangeable, and an index would undo it.

## 6. Absorbed members (4)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-03-delivery-baseline-scorecard` - Delivery Baseline & Success Scorecard

- **Address.** `handbook\ch03-the-business-case.qmd` L289-303, Step 5: Define success criteria that aren't vanity metrics (`#sec-business-case-success-criteria`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** The pre-adoption baseline value for each metric into the blanks the book already prints (median PR cycle time in hours, review rejection rate percent, post-deploy defects per release, developer satisfaction, human intervention rate), the data source, the owner, and the committed 6- and 12-month targets.
- **Its output was.** A signed baseline-and-target scorecard that makes the transformation measurable rather than anecdotal, and that can be re-run unchanged at every review.

### `WS-06-time-allocation-baseline` - Where Our Engineering Hours Actually Go — Baseline and Target

- **Address.** `handbook\ch06-team-structures.qmd` L15-33, What Shifts, What Stays (`#sec-team-shifts-and-stays`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** For each of the seven activity rows (write code, read code, review, spec and design, debug, context engineering, meetings) the leader writes three numbers: our estimated current %, our 12-month target %, and the delta in FTE-equivalent hours. A final row captures the currently-zero context-engineering allocation as a net-new capacity ask.
- **Its output was.** A signed capacity reallocation model showing that review and specification capacity must roughly double and that context engineering needs a named 10-15% allocation that does not exist today.

### `WS-12-instrumentation-baseline-metrics` - Instrumentation Baseline and Target Metrics

- **Address.** `handbook\ch12-the-instrumented-codebase.qmd` L557-570, What the numbers look like (`#sec-codebase-audit-numbers`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Measure the organisation's current value for each of the four metrics the chapter tabulates — share of generated output that violates conventions, "we don't do it that way" review comments per agent PR, share of agent-generated code requiring rewrite, and elapsed time from agent output to merge — then set a target and name the data source (PR history, review comments, CI timings) and the re-measure date.
- **Its output was.** A dated baseline scorecard with targets: the before-picture that makes any later claim of improvement defensible.

### `WS-CS-APM-baseline-metrics` - Pre-Groundbreaking Baseline Metrics Sheet

- **Address.** `case-study-apm-overhaul.qmd` L266-287, What Held True Regardless of the Model (`#sec-cs-apm-model-invariants`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** The reader fills a blank version of the Canonical Metrics table for their own first initiative BEFORE starting: files in scope, test count today, current cycle time for a comparable refactor, and a planned human-time split across planning / monitoring / interventions / review.
- **Its output was.** A dated baseline record that makes the post-pilot comparison honest rather than anecdotal.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- None. This sheet can be filled cold.

**Consumed by:**

- `WS-08-phase-gate-exit-rollback` - Phase Gate Cards — Exit Signals, Rollback Triggers, and the Kill Switch (Pack G - The plan we leave with, fill order 4)
- `WS-08-transition-planning-checklist` - The Transition Plan — Task-Level Checklist Across Five Blocks (Pack G - The plan we leave with, fill order 10)

**Feeds into (prose, from the source scan).** WS-08-phase-gate-exit-rollback (every rollback threshold is expressed relative to this baseline) and the exec reporting pack.

## 8. Facilitation

| | |
|---|---|
| Who fills it | The engineering leader owns the pack. Panel A cannot be filled by one person: it needs whoever runs Git and PR analytics, whoever owns the deployment pipeline and already reports DORA, whoever owns the issue tracker, and whoever can issue a developer survey. Name one of them per row in column 11 before the data is pulled, not after. Panel B needs the platform or tooling engineer who will actually implement the chosen level. Panel C needs each team lead. Panel D needs the person who will run the first initiative. |
| When in the session | **This sheet is not filled in the session.** Issue it as pre-work at least two weeks before the workshop — longer than `WS-02`, because some rows require a survey and some require analytics access that has to be requested. It must be complete and dated before the pilot starts, because `WS-08-phase-gate-exit-rollback` expresses every exit signal and rollback trigger as a delta from column 7, and once agent work begins the before-picture cannot be reconstructed. In the room, it is reviewed, not authored. |
| Duration | 30-60 minutes per data source to pull, spread across four or five people over two weeks. In the room: 45-60 minutes to agree owners, cadences and — the part that takes the time — to read column 4 aloud for every row. Panel B is a 15-minute decision. Panel C is 20 minutes. Panel D is 20 minutes with the initiative lead. |
| Data needed in advance | A PR analytics export covering at least the period you intend to compare against. Deployment pipeline metrics for the four DORA measures. Issue-tracker defect counts by release. Developer survey returns for satisfaction. Agent session logs, if any exist — most organisations will record `not measurable today` against human intervention rate, and that is a legitimate completed row. Licence counts and active-usage data from the vendor console for the adoption rows. |
| Room format | The pre-work arrives as a spreadsheet; the in-room review is projected. Print Panel A A3 landscape for the wall — it is referenced at every subsequent gate and people need to be able to point at a row. Panels B, C and D are one page each. The pack is signed and dated once on the front, and that single date is what makes every later delta defensible. |

**Facilitation note.** Two things to hold the room to. First, irreversibility: this is the only
sheet in the kit whose window closes. Every other worksheet can be improved later; a baseline
captured after the pilot has started is not a baseline. If a row genuinely cannot be measured in
time, record `not measurable today` with an owner and a date — that is a complete row, and it is
honest in a way a guessed number is not. Second, instrumentation restraint: the chapter puts
Level 3 explicitly in Phase 3, and a room that has just been persuaded of the
generation-to-review ratio's importance will want to build the telemetry pipeline immediately.
Level 1 produces a directional trend this month; Level 3 produces a project. Tick Level 1 or 2 and
put Level 3 on the roadmap where the chapter puts it.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **Every Panel A row carries either a measured value with a date, or the words `not measurable
   today` with a named individual owner and a date by which it will be** (columns 7, 8, 11). There
   are no silent blanks. An empty cell at review is indistinguishable from a zero.
2. **Every measured row's column 10 describes the method in enough detail to be re-run unchanged
   in six months by someone who was not in the room** — the query, the filter, the date window, the
   repository set. "Pulled from GitHub" fails this test.
3. **Column 4 is present on the printed sheet and unedited.** It is the chapter's built-in defence
   against metric theatre, and a version of Panel A circulated without it has removed the only
   thing stopping each row being read as a target.
4. **Panel B has exactly one level ticked, with an owner and a start date, and Level 3 is not the
   tick for a pilot** (ch08 L232). The calibration strip in column 24 is printed with its caveat
   intact.
5. **Every author-observed figure on the pack sits in columns 5, 6, 24, 27, 28 or 34 and nowhere
   else.** No target in columns 13-14, no threshold in `WS-08-phase-gate-exit-rollback`, and no
   acceptance criterion anywhere in the kit is expressed against one. Phase-gate thresholds are
   deltas from column 7 — a gate written as "reach 3:1" fails this criterion and must be rewritten.
6. **Panel C's context-engineering row carries a current figure — commonly zero — a 12-month
   target, and a derivation label in column 30,** and the resulting FTE delta appears as a named
   capacity ask in the transition plan rather than as an assumption inside it.
7. **The pack is signed and dated, and that date precedes the pilot start date recorded in
   `WS-08-transition-roadmap`.** A baseline dated after the pilot began is not a baseline, and
   `WS-08-transition-planning-checklist` cannot treat it as one.

## 10. Integrity constraint

**Named rule for this sheet.** The APM case's human-time split and 'manual comparison' figures enter as an exemplar only; the book states the comparison is unbenchmarked.

**Hedged figures reachable from this source range.** Each is listed with the book's own hedge, verbatim, and where that hedge lives. Present the figure as a pre-filled prior the organisation overwrites, or as a facilitation prompt - never as a benchmark, target or acceptance threshold. **Carry the hedge onto the sheet with the number; do not restate it in your own words.**

- **The developer time-allocation split, pre-agentic versus projected agentic.**
  - *Appears at* `handbook\ch06-team-structures.qmd` L17-34
  - *The book's hedge (ch06 L32):* † Projected agentic-era figures are based on author observation and early adopter reports, not survey data.
- **The generation-to-review ratio: around 1:1 early, 3:1 or better when healthy, below 1.5:1 a context-quality problem, above 5:1 a review-rigour problem. This is the book's only 3:1.**
  - *Appears at* `handbook\ch08-planning-the-transition.qmd` L224-238
  - *The book's hedge (ch08 L234):* 'These are starting benchmarks based on the author's observation of early adopter teams, not industry-validated thresholds. Calibrate against your own baseline.'
- **Convention-violating outputs falling from 40-60% of generated code to under 10%.**
  - *Appears at* `handbook\ch12-the-instrumented-codebase.qmd` L550-570
  - *The book's hedge (ch12 L561 / ch03 L368):* Author observation across instrumented projects. ch03 L368 notes this range differs from that chapter's 15-30% purely because of adoption stage, so the two must not be compared directly.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** Carried unchanged from _section-clusters.md section 7 for CL-BASELINE.
- **Fill (the organisation completing it): `L`.** L - needs the real repository, finance input or cross-team agreement

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Effort is L because this is the one worksheet that cannot be completed in the room — it requires pulling real data from PR analytics, deployment pipelines, and a developer survey. Schedule it as pre-work before the workshop. The chapter's What It Doesn't column is the most facilitation-valuable part and must survive into the worksheet: it is the built-in defence against metric theatre. Instrumenting the Generation-to-Review Ratio (lines 224-236, anchor instrumenting-the-generation-to-review-ratio) is folded in here deliberately rather than split out — it is the instrumentation decision for the metric the chapter calls the single most important one most organizations do not track. Its benchmarks (roughly 1:1 early, 3:1 healthy, below 1.5:1 after four weeks signals a context quality problem, above 5:1 warrants scrutiny that review rigor has not quietly declined) are explicitly the author's observation of early adopters, not industry-validated thresholds — print them as calibration anchors, never as targets. Note Level 3 is explicitly Phase 3 investment; do not let a workshop over-specify instrumentation on day one.
