# The Coordination Tax Calculator: When Does Orchestration Pay?

`WS-17-coordination-tax-calculator` &middot; **Pack D - Architecture and ownership** &middot; fill order **7** &middot; type `calculator` &middot; audience **mixed** &middot; leadership priority **1**

> **Split back out in the re-opening pass.** Answers a different decision in a different unit -- human coordination minutes as a percentage, yielding a multi-agent go/no-go threshold -- and sits between two Pack D worksheets, so leaving it in Pack C inverted the fill order.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A defensible cost model and a go/no-go threshold for multi-agent orchestration on this codebase - plus an honest statement of what the investment actually buys (quality and reduced context degradation, not elapsed time).

**Cluster.** `CL-COORDINATION-TAX` - The Coordination Tax: When Does Orchestration Pay

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch17-multi-agent-orchestration.qmd` |
| Chapter | Multi-Agent Orchestration |
| Heading | The Coordination Tax: Honest Numbers |
| Stable anchor | `#sec-multi-agent-coordination-tax` |
| Lines | L361-382 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch17-multi-agent-orchestration.html#sec-multi-agent-coordination-tax> |
| Locator quote | "Multi-agent orchestration saves time through parallelism and improves quality through focused context" |

Resolve at any time with `python docs/resolve.py ws WS-17-coordination-tax-calculator`.

## 3. Source extract - the scaffolding, verbatim

```text
  361 | Multi-agent orchestration saves time through parallelism and improves quality through focused context. It also costs time through planning, monitoring, and intervention. Here is the honest accounting, based on the PR #394 execution ([The APM Auth + Logging Overhaul](../case-study-apm-overhaul.qmd)).
  362 | 
  363 | In the PR #394 case, the human time in a well-planned multi-agent execution broke down into four activities: planning and partitioning (~30% of human time), monitoring execution (~20%), handling interventions (~25%), and post-execution review (~25%). Total human time was roughly 45 minutes against 24 minutes of agent computation time, with a total wave execution time of roughly 90 minutes because human work overlaps with agent execution.
  364 | 
  365 | The same change executed sequentially by a single agent would take an estimated 60-75 minutes of agent time — but with compounding context degradation after file 20. Based on similar single-agent attempts at this scale, expect 2-3 additional rework cycles to fix quality issues caused by context overload, adding 30-45 minutes. Total single-agent elapsed time: roughly 90-120 minutes with lower output quality.
  366 | 
  367 | The multi-agent approach did not save total elapsed time on this change. It traded human planning time for agent quality. The 45 minutes the orchestrator spent coordinating replaced the 30-45 minutes they would have spent debugging context-degraded output — with better results.
  368 | 
  369 | ### The Sweet Spot
  370 | 
  371 | Multi-agent orchestration pays for itself when:
  372 | 
  373 | - **File count exceeds 20 across 2+ concerns.** Below this threshold, planning overhead exceeds the parallelism benefit. One agent with good instructions handles 15 files in a single concern faster than two agents with coordination overhead.
  374 | - **Concerns partition cleanly.** If most files need changes from multiple concerns, you spend more time managing file ownership conflicts than you save through parallelism.
  375 | - **Context degradation is the real bottleneck.** For changes that require deep architectural understanding — not mechanical find-and-replace — the quality benefit of focused context outweighs the coordination cost.
  376 | - **You will do this more than once.** The first multi-agent orchestration on a codebase takes longest because you are building instruction files, learning partition boundaries, and developing intuition for wave sizing. The second takes half the planning time. By the third, the dispatch prompts are templates.
  377 | 
  378 | The overhead for a well-planned multi-agent execution is roughly 40-60% of total human time spent on coordination rather than direct value work. For a poorly planned execution — vague dispatch prompts, unclear file ownership, missing instruction files — based on the contrast between our reference execution and less-structured attempts, we estimate it can reach 70-80% or higher, at which point a single agent with good context would have been faster.
  379 | 
  380 | This is not a tool for every change. It is a tool for changes that exceed what a single agent can hold in focus. Know the threshold for your codebase, and do not orchestrate for the sake of orchestrating.
  381 | 
  382 | ---
```

## 4. What the user fills

For a representative change, the team enters: files touched, number of concerns, human minutes for planning/partitioning, monitoring, interventions and review; agent compute minutes; and the estimated single-agent baseline including rework cycles from context degradation. The sheet computes coordination overhead as a percentage of human time and flags it against the book's bands (40-60% well-planned, 70-80% poorly planned, above which a single agent wins). A second block ticks the four sweet-spot conditions.

## 5. Field-level schema

Rows vary by block; the unit throughout is **minutes of human time**, never currency. The
calculator's defining physical feature is a **two-column split running the length of the sheet**:
a narrow left column headed *The book's prior — single case, partly estimated* printed in grey
italic, and a wide right column headed *Our measured value* printed in full black. Every
computed cell derives from the right column only. A prior set in the same weight as a measurement
is read as a target within about ten seconds, which is the whole reason for the typographic split.
A3 portrait, one side.

**Block A — the change being measured.**

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Change measured | `free text` | — | One real change. Not a category, not an average | derived |
| 2 | Date executed | `date` | — | — | derived |
| 3 | Files touched | `free text` (count) | — | — | ch17 L373 |
| 4 | Number of distinct concerns | `free text` (count) | — | — | ch17 L373 |
| 5 | Which execution is this on this codebase? | `select` First / Second / Third or later | — | Drives block G | ch17 L376 |

**Block B — human time by activity.** Four fixed rows.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 6 | Activity | `select` (fixed 4) | Planning and partitioning / Monitoring execution / Handling interventions / Post-execution review | — | ch17 L363 |
| 7 | *Prior — share of human time* | `free text` (printed grey, read-only) | ~30% / ~20% / ~25% / ~25%. **Single case (PR #394); several figures in this source range are explicitly estimated rather than measured. Overwrite with your own.** | — | ch17 L363 |
| 8 | Our measured minutes | `free text` | — | Actual minutes, recorded during or immediately after the execution | derived |
| 9 | Our share of human time | `computed` % | — | Column 8 ÷ total human minutes | derived |
| 10 | Variance from the prior | `computed` | — | For information only. Not a target and not a defect | derived |

**Block C — totals.**

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 11 | Total human minutes | `computed` (sum of column 8) | *Prior: roughly 45 minutes* | — | ch17 L363 |
| 12 | Agent computation minutes | `free text` | *Prior: roughly 24 minutes* | — | ch17 L363 |
| 13 | Total wave elapsed minutes | `free text` | *Prior: roughly 90 minutes, because human work overlaps with agent execution* | — | ch17 L363 |

**Block D — the single-agent counterfactual.** Every prior in this block is labelled an estimate
in the book itself.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 14 | Estimated single-agent agent-time | `free text` | *Prior: an estimated 60-75 minutes for the same change* | Our estimate, with the basis stated | ch17 L365 |
| 15 | Rework cycles expected from context degradation | `free text` | *Prior: 2-3 additional cycles, "based on similar single-agent attempts at this scale"* | Ours | ch17 L365 |
| 16 | Minutes added by rework | `free text` | *Prior: 30-45 minutes* | Ours | ch17 L365 |
| 17 | Total single-agent elapsed | `computed` | *Prior: roughly 90-120 minutes, with lower output quality* | — | ch17 L365 |
| 18 | Elapsed delta, multi-agent vs single | `computed` | — | Expect this to be small, zero or negative. Read block H before interpreting it | ch17 L367 |

**Block E — coordination overhead and reference bands.**

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 19 | Coordination overhead | `computed` % | — | Coordination minutes ÷ total human minutes, per the definition at column 20 | ch17 L378 |
| 20 | Our definition of "coordination" | `free text` | The book's phrasing: human time spent "on coordination rather than direct value work" | Which of the four block-B activities this organisation counts as coordination. State it before computing | ch17 L378 |
| 21 | *Prior band — well-planned* | `free text` (printed grey, read-only) | *roughly 40-60% of total human time. Single case.* | — | ch17 L378 |
| 22 | *Prior band — poorly planned* | `free text` (printed grey, read-only) | *estimated at 70-80% or higher, at which point a single agent with good context would have been faster. The book states this band is an estimate drawn from a contrast between its reference execution and less-structured attempts — not a measurement.* | — | ch17 L378 |
| 23 | Our own bands | `free text` | — | **Filled only after three executions**, and then used in place of columns 21 and 22. Until then this cell reads `insufficient data` | ch17 L376, L380 |
| 24 | Basis of this sheet | `select` Measured execution / Forecast against the book's priors | — | A forecast is legitimate and must be re-run against actuals | derived |

**Block F — the sweet-spot conditions.** Four fixed rows.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 25 | Condition | `select` (fixed 4, printed) | File count exceeds 20 across 2+ concerns / Concerns partition cleanly / Context degradation is the real bottleneck / We will do this more than once | — | ch17 L373-376 |
| 26 | Met? | `select` Yes / Partial / No | — | — | derived |
| 27 | Evidence | `free text` | — | Why. "Concerns partition cleanly" in particular is usually asserted and rarely checked | ch17 L374 |

**Block G — first-run multiplier.**

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 28 | First-run multiplier applied? | `checkbox` + `free text` | *Prior: a first pass takes roughly 3× the reference timings, which reflect an experienced practitioner with battle-tested instruction files, established personas and conventions already externalised into the codebase.* Single source, stated as "roughly" | Ticked automatically when column 5 reads `First`. Our own multiplier once we have one | ch18 L188 |
| 29 | What the first run buys | `free text` | Reference: the first run is an investment in infrastructure — instruction files, partition boundaries, wave-sizing intuition — that makes every subsequent run faster | Our answer | ch18 L188 |
| 30 | Planning-time trend across runs | `free text` | Reference: the second run takes half the planning time; by the third the dispatch prompts are templates | Our observed trend | ch17 L376 |

**Block H — what the investment actually bought.** The sheet's real output.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 31 | What did orchestration actually buy us? | `select` (multi-select) + `free text` | Options printed: reduced elapsed time / improved output quality / reduced context degradation / reduced rework / nothing measurable. **The chapter's own answer for its own case: it did not save total elapsed time. It traded human planning time for agent quality.** | Our honest answer | ch17 L367 |
| 32 | Evidence for that claim | `free text` | — | `Reduced elapsed time` may not be ticked unless column 18 is negative | ch17 L367 |
| 33 | Our go/no-go threshold going forward | `free text` | — | Expressed in this organisation's own units — file count, concern count, overhead percentage — and dated | ch17 L380 |
| 34 | Threshold set by / on / review by | `owner (named person)` + `date` + `date` | — | "Know the threshold for your codebase" is the chapter's instruction; a threshold with no owner and no review date is a rule of thumb | ch17 L380 |

**Absorbed detail.** This sheet absorbed no other candidate, but block G folds in the ch18
first-run multiplier and its phase-by-phase timeline rather than spawning a separate sheet for
them. The ch18 timeline table (audit, planning, wave 0, waves 1-2, recovery, polish, ship) is
reproduced in the facilitator pack as a shape-of-the-run illustration, **not** on the calculator:
its per-phase durations come from the same single execution and would function as stage budgets
the moment they were printed next to a blank cell.

**Deliberate omission.** No target overhead percentage, no pass/fail threshold, and no currency
anywhere. The bands at columns 21 and 22 are reference points the organisation replaces at column
23, and they are typographically subordinate to the measured column for exactly that reason.
Converting minutes into money is a Pack C activity and is deliberately not available here — a
calculator that outputs a saving is a calculator that will be asked to produce one.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-17-orchestration-topology-selector` - Orchestration Topology Selector: Which Patterns Do We Sanction? (Pack D - Architecture and ownership, fill order 6)

**Consumed by:**

- `WS-17-single-vs-multi-agent-decision-matrix` - Single Agent or Many? Scoping Decision Matrix (Pack D - Architecture and ownership, fill order 9)

**Feeds into (prose, from the source scan).** The business case and the transformation plan's benefits section; WS-17-single-vs-multi-agent-decision-matrix uses the resulting threshold.

## 8. Facilitation

| | |
|---|---|
| Who fills it | The person who actually orchestrated the execution being measured — not a manager reconstructing it afterwards, because columns 8 and 15 cannot be recalled reliably at one remove. Plus the engineering leader who will apply the threshold at column 33, and whoever holds the timing data. |
| When in the session | After `WS-17-orchestration-topology-selector`, its declared prerequisite: the topology chosen there is what determines the coordination cost measured here. It must close before `WS-17-single-vs-multi-agent-decision-matrix`, which uses the threshold at column 33 as its local recalibration value. |
| Duration | 60-75 minutes for a retrospective fill against one completed change. Once the sheet is habitual it takes about 20 minutes per subsequent change, and the third fill is the one worth waiting for, because only then can column 23 be written. |
| Data needed in advance | One real multi-agent execution with its timings — start and finish per activity, agent compute time if the harness reports it, and the rework that followed. If no such execution exists yet, the sheet can be run as a forecast against the book's priors, but column 24 must read `Forecast` and the re-run against actuals must be scheduled in the same session, not promised. |
| Room format | Projected calculator, with the prior column rendered grey and italic and captioned *single case, partly estimated* on every block. Print it that way too. This is not cosmetic: a prior set in the same weight as a measurement will be read as a benchmark, and the numbers in this source range are precisely the ones the book is most careful to hedge. |

**Facilitation note carried from ch17.** Open by reading the chapter's own conclusion about its
own case, before anyone enters a figure: *"The multi-agent approach did not save total elapsed
time on this change. It traded human planning time for agent quality. The 45 minutes the
orchestrator spent coordinating replaced the 30-45 minutes they would have spent debugging
context-degraded output — with better results."* A kit that lets a leadership team walk out
believing orchestration is a speed play will be found out on the first execution. Block H exists
so the room has to say out loud what it is actually buying.

Two supporting cautions. First, every figure printed in grey on this sheet derives from a single
execution, and several — the poorly-planned band, the single-agent counterfactual, the rework
cycles — are described in the book as estimates rather than measurements. Say that once, plainly,
and point at the typography. Second, the sweet-spot condition most often ticked without evidence is
*concerns partition cleanly*; when most files need changes from more than one concern, the time
goes into managing file-ownership conflicts instead of into parallelism, and the sheet will report
a healthy overhead figure for an execution that should never have been orchestrated. Make column
27 mandatory on that row.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **Block A identifies one real change, with a date, a file count and a concern count.** A sheet
   filled against a hypothetical or an average is a forecast, and column 24 must say so.
2. **Every activity row carries measured minutes at column 8, and the overhead at column 19 is
   computed from those minutes** — never from the book's percentages at column 7. A sheet whose
   computed shares reproduce 30/20/25/25 has been filled from the prior, not from the execution.
3. **The prior columns are visually distinguished from the measured columns on the printed
   artefact**, and each carries its single-case caveat. This is checkable by looking at the sheet
   and is the most commonly lost property when a worksheet is rebuilt in a spreadsheet.
4. **Column 20 states what this organisation counts as coordination, and it is stated before
   column 19 is computed.** An overhead percentage with no stated denominator cannot be compared
   with anything, including its own next run.
5. **Block H is complete.** Column 31 names what the orchestration bought, column 32 gives the
   evidence, and `reduced elapsed time` is not ticked unless column 18 is actually negative.
   This is the criterion that stops the sheet becoming a speed claim.
6. **All four sweet-spot conditions carry a Yes / Partial / No and an evidence line**, with the
   clean-partition row in particular answered from the file list rather than from impression.
7. **The threshold at column 33 is expressed in this organisation's own units and carries an
   owner and a review date at column 34**, and column 23 either holds the org's own bands or
   explicitly reads `insufficient data`.
8. **Reconciliation with `WS-17-single-vs-multi-agent-decision-matrix`.** The threshold at column
   33 appears as that sheet's local recalibration value. If the decision matrix still carries the
   book's default boundary, this calculator has been filled but not applied.

## 10. Integrity constraint

**Named rule for this sheet.** Every figure derives from a single case (PR #394) and several are explicitly estimated. Print them as priors to be replaced, not as benchmarks.

**Hedged figures reachable from this source range.** Each is listed with the book's own hedge, verbatim, and where that hedge lives. Present the figure as a pre-filled prior the organisation overwrites, or as a facilitation prompt - never as a benchmark, target or acceptance threshold. **Carry the hedge onto the sheet with the number; do not restate it in your own words.**

- **Coordination overhead bands (40-60% well-planned, 70-80% poorly planned) and the PR #394 timings.**
  - *Appears at* `handbook\ch17-multi-agent-orchestration.qmd` L358-384
  - *The book's hedge (ch17 L378):* 'based on the contrast between our reference execution and less-structured attempts, we estimate'. Single case, several values explicitly estimated rather than measured.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** Every figure sits in prose rather than a table; the input rows, the overhead computation and the band thresholds all need laying out.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> The chapter's own honesty is the reason this is leadership-grade: it states plainly at line 367 that "The multi-agent approach did not save total elapsed time on this change. It traded human planning time for agent quality." An exec kit that promises speed will fail; this calculator forces the org to state the benefit it is actually buying. Numbers are in prose, not a table (planning ~30%, monitoring ~20%, interventions ~25%, review ~25% of human time; 45 min human vs 24 min agent; 40-60% vs 70-80% overhead bands; sweet-spot conditions at lines 373-376). CAVEAT that must survive into the worksheet: every figure derives from a single case (PR #394) and several are explicitly estimated rather than measured - print them as priors to be replaced, not as benchmarks. CROSS-CHAPTER OVERLAP: ch18 lines 192-200 gives a phase-by-phase timeline table and line 188 warns "Your first time through will take roughly 3x" - fold that 3x first-run multiplier into this calculator rather than making a separate ch18 sheet.
