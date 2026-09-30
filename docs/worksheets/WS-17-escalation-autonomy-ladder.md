# Our Escalation and Autonomy Ladder (L1-L4)

`WS-17-escalation-autonomy-ladder` &middot; **Pack E - Guardrails: authority, risk and proof** &middot; fill order **6** &middot; type `rubric` &middot; audience **eng-leader** &middot; leadership priority **2**

## 1. Purpose

**Output artifact.** A published autonomy ladder with named owners and an agreed intervention-rate target - the operating policy for how much an agent may decide unsupervised.

**Cluster.** `CL-ESCALATION` - Escalation, Autonomy and the Stop Rule

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch17-multi-agent-orchestration.qmd` |
| Chapter | Multi-Agent Orchestration |
| Heading | The Escalation Protocol |
| Stable anchor | `#sec-multi-agent-escalation` |
| Lines | L340-357 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch17-multi-agent-orchestration.html#sec-multi-agent-escalation> |
| Locator quote | "Not every problem requires human attention. A well-designed orchestration system handles most" |

Resolve at any time with `python docs/resolve.py ws WS-17-escalation-autonomy-ladder`.

## 3. Source extract - the scaffolding, verbatim

```text
  340 | Not every problem requires human attention. A well-designed orchestration system handles most failures automatically. The four-level escalation protocol:
  341 | 
  342 | ::: {tbl-colwidths="[10,28,30,32]"}
  343 | 
  344 | | Level | Trigger | Response | Example |
  345 | |---|---|---|---|
  346 | | L1: Self-heal | Agent hits a test failure it can debug | Agent fixes and continues | Type error in generated code |
  347 | | L2: Retry | Agent produces incomplete output | Re-dispatch with refined prompt | Agent missed 3 of 12 files in scope |
  348 | | L3: Human decides | Trade-off between competing principles | Human makes design call | UX convention vs. architectural purity |
  349 | | L4: Scope change | Finding requires work outside the current plan | Human creates follow-up task | Discovery of a pre-existing bug unrelated to the change |
  350 | 
  351 | :::
  352 | 
  353 | The L1 and L2 levels are automated. L3 and L4 require human judgment. The goal is to minimize L3 and L4 interventions not by suppressing them, but by making the plan specific enough that most decisions resolve at L1 or L2.[^ch12-autonomy]
  354 | 
  355 | In the PR #394 execution ([case study](../case-study-apm-overhaul.qmd)), the distribution across all decision points within the ~25 agent dispatches was roughly two-thirds autonomous (L1), one-eighth automated retry (L2), and one-fifth human decision (L3/L4) — three interventions during wave execution out of ~25 dispatches. That ~20% rate is characteristic of what we observed in a well-planned execution on a non-trivial change. If your L3+ rate exceeds 25%, the plan needs more specific principles or better task scoping.
  356 | 
  357 | ---
```

## 4. What the user fills

Starting from the book's four levels, the team writes its own trigger, response, owner and worked example for each: L1 self-heal, L2 automated retry, L3 human decides, L4 scope change. Then it sets a target L3+ intervention rate and the two alarm thresholds - too high (plan underspecified) and too low (work too simple, or review insufficient).

## 5. Field-level schema

A3 landscape, two sides. **Front — block A, the ladder**, which is the published artefact: it
gets pinned into the orchestration runbook and read at three in the morning, so every cell on
it is short. **Back — block B, the rate calibration**, and **block C, the stop rule and handoff
checklist**, which are working pages.

**Block A — the ladder.** One row per level; four rows, fixed.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Level | `select` (fixed 4) | L1: Self-heal / L2: Retry / L3: Human decides / L4: Scope change | — | ch17 L346-349 |
| 2 | The book's trigger | `free text` (pre-printed, read-only) | Agent hits a test failure it can debug / agent produces incomplete output / trade-off between competing principles / finding requires work outside the current plan | — | ch17 L346-349 |
| 3 | The book's response | `free text` (pre-printed, read-only) | Agent fixes and continues / re-dispatch with refined prompt / human makes design call / human creates follow-up task | — | ch17 L346-349 |
| 4 | The book's example | `free text` (pre-printed, read-only) | Type error in generated code / agent missed 3 of 12 files in scope / UX convention vs architectural purity / discovery of a pre-existing bug unrelated to the change | — | ch17 L346-349 |
| 5 | Automated or human judgement | `free text` (pre-printed, read-only) | L1 and L2 automated; L3 and L4 require human judgement | — | ch17 L353 |
| 6 | The case study's variant wording | `free text` (pre-printed, read-only) | Printed on the L2, L3 and L4 rows only: *agent needs guidance* / *agent cannot complete* / *plan scope changes*. The reference case runs a three-tier variant with no L1 and a narrower L3 | — | case study APM L125-131 |
| 7 | Our trigger | `free text` | — | In our vocabulary, for our stack | org |
| 8 | Our response | `free text` | — | One line. This is runbook text | org |
| 9 | Our worked example | `free text` | — | A real incident from our own delivery, not a hypothetical | org |
| 10 | Who is paged | `owner (named person)` | — | A named individual or a named rota position | case study APM L125-131 |
| 11 | Response window | `free text` | — | Must fit the on-call rota that already exists | case study APM L125-131 |
| 12 | Authority to approve a scope change | `owner (named person)` | — | Printed on the L4 row only. The person who can say yes to work outside the plan | case study APM L125-131 |
| 13 | Where the escalation is logged | `free text` | — | A system that exists today | case study APM L125-131 |
| 14 | Consequential effects that must resolve here or above | `free text` | — | Carried from `WS-16-consequential-effect-register` column 25: every judgement-external gate lands at L3 or L4 | derived |

**Block B — rate calibration.** One row per published figure, each printed with its status
label. This block is deliberately more label than number.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 15 | The book's figure | `free text` (pre-printed, read-only) | Four rows: the reference case's observed intervention rate of approximately 12% across ~25 dispatches; 15-20% offered as a starting hypothesis for well-planned work; an upper alarm where an L3+ rate above 25% means the plan needs more specific principles or better task scoping; a lower alarm where a rate below 5% warrants scrutiny | — | ch17 L320, L355 |
| 16 | Status label | `free text` (pre-printed, read-only, printed beside **every** row of column 15) | **"Starting hypothesis, replace after one quarter."** | — | worksheet-map section 8; ch17 L320 — "calibration points from our reference case study, not validated benchmarks" |
| 17 | Our measured rate | `free text` | — | **Ships blank.** Filled at the first quarterly review from our own dispatch log, never in the session | org |
| 18 | Our target L3+ rate | `free text` | — | Written by us, in a column adjacent to column 15 and not derived from it | org |
| 19 | Our upper alarm, and the action we take at it | `free text` | — | The chapter's response to a high rate is more specific principles or better task scoping — not suppressing escalations | ch17 L353, L355 |
| 20 | Our lower alarm, and the action we take at it | `free text` | — | The chapter offers two readings: the work may be too simple for orchestration, or review may be insufficient | ch17 L320 |
| 21 | Who measures it, from what data, how often | `owner (named person)` + `free text` | — | The dispatch log or equivalent. "We'll know" is not a data source | org |
| 22 | Date of the first replacement review | `date` | — | One quarter from publication | derived |

**Block C — the stop rule and handoff checklist.** A single block, filled once.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 23 | How many distinct approaches before we stop | `free text` | The reference case stopped after three genuinely distinct approaches — **printed as one case, not as a rule** | Our number, decided in advance | case study growth L58-106 |
| 24 | What distinguishes a platform limitation from an application-logic problem | `free text` | The case study's test: the platform rejects the operation by construction, rather than our inputs being wrong | Our test, in our own terms, written before we need it | case study growth L58-106 |
| 25 | Who declares the stop | `owner (named person)` | — | A named individual. Abandoning automation must be someone's call to make | case study growth L58-106 |
| 26 | Required format of the manual handoff checklist | `free text` | The case study's shape: a short numbered list of concrete steps a human with no context can execute directly | Our template | case study growth L58-106 |
| 27 | Where the stop and the handoff are logged | `free text` | — | — | org |
| 28 | Published by | `signature` + `date` | — | The owner of the orchestration runbook | derived |

**Absorbed detail.** `WS-CS-APM-escalation-ladder` is carried by columns 10-13 plus column 6:
who is paged, the response window, the authority to approve an L4 scope change (printed on that
row alone, because it is the only row where it means anything), and where the escalation is
logged. Its three-tier variant wording is printed in column 6 rather than reconciled away — the
reference case and the chapter number the middle of the ladder slightly differently, and a team
that writes its own triggers in columns 7-9 should see both rather than inherit one by accident.
`WS-CS-GROWTH-stop-rule` is block C entire: the count of approaches, the platform-limitation
test, the named declarer and the handoff-checklist template. It sits on this sheet because a
stop is an escalation — the one the ladder does not otherwise name, where the answer is not a
different level but an exit.

**Deliberate omission.** The sheet prints **no recommended target** in column 18 and ships
column 17 blank. Every figure the book supplies lives in column 15, fenced by column 16's label,
in a physically separate column from the one the organisation fills — because a blank cell next
to a printed number is read as a target by layout alone, and these numbers come from three
interventions in a single case. There is also no computed rate, no ratio and no score anywhere
on the sheet: column 17 is arithmetic the organisation does against its own dispatch log a
quarter from now, and printing a formula would invite the room to estimate it today.

## 6. Absorbed members (2)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-CS-APM-escalation-ladder` - Escalation Ladder: Define L2/L3/L4 For Our Organization

- **Address.** `case-study-apm-overhaul.qmd` L125-131, Escalation Events (`#sec-cs-apm-escalations`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** One row per tier (L2 agent needs guidance, L3 agent cannot complete, L4 plan scope changes) with our own columns filled: who is paged, what the response window is, who has authority to approve an L4 scope change, and where the escalation is logged.
- **Its output was.** A signed escalation protocol that can be pinned into the orchestration runbook before any agent is dispatched.

### `WS-CS-GROWTH-stop-rule` - Automation Stop Rule and Human Handoff Checklist

- **Address.** `case-study-growth-engine.qmd` L58-106, The Kit Automation Escalation (`#sec-cs-growth-automation-escalation`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** The team sets its stop rule in advance: how many distinct approaches before we stop, what distinguishes a genuine platform limitation from an application-logic problem, who declares the stop, and the required format of the manual handoff checklist handed to the human.
- **Its output was.** A written stop rule plus a handoff checklist template, so abandoning automation is a planned outcome rather than a failure nobody wants to declare.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-16-consequential-effect-register` - Consequential Side-Effect Register: What Can Our Agents Actually Do To Us? (Pack E - Guardrails: authority, risk and proof, fill order 5)

**Consumed by:**

- `WS-CS-APM-plan-gate` - Plan Gate and Scope-Change Protocol (Pack Z - Second wave: the practitioner kit, fill order 17)

**Feeds into (prose, from the source scan).** WS-06-role-map-and-staffing-triggers (who answers an L3) and the staffing model; reviewed against WS-16-consequential-effect-register so in-flight escalation and externalization gating stay consistent.

## 8. Facilitation

| | |
|---|---|
| Who fills it | The engineering leader who owns the orchestration runbook, with the tech leads who will actually be paged at L3. **Security, legal, compliance and HR are not needed** — this is an operating policy, not a control, and the control that constrains it was already signed on `WS-16-consequential-effect-register`. The one outside attendee worth insisting on is whoever owns the on-call rota, because columns 10 and 11 create a paging obligation and it has to fit the rota that exists rather than the one the room would prefer. |
| When in the session | Pack E, sixth and last, after `WS-16-consequential-effect-register`, which is a hard prerequisite: column 14 carries that register's judgement-external gates across, and a ladder built without them will cheerfully place a human-gated production deploy at L1. It must also run before `WS-06-role-map-and-staffing-triggers` in Pack F, which consumes the answer to "who answers an L3" as a staffing input. |
| Duration | 60-75 minutes. Block A moves quickly because five of its columns are pre-printed; the time goes into columns 10-12, where a paging obligation becomes real and someone has to accept it. Block B is 15 minutes if the facilitator holds the line on column 17 and half an hour if they do not. Block C is 20 minutes and is the part every room tries to skip. |
| Data needed in advance | The current on-call rota with its real response windows; where incidents and escalations are logged today; **two or three genuine recent examples of an agent getting stuck**, for column 9 — a ladder illustrated with invented examples is a ladder nobody recognises at 3am; and the completed `WS-16-consequential-effect-register`. |
| Room format | A3 landscape, two-sided. Block A is the published artefact: design it to be pinned above a desk, keep columns 7-9 to one line each, and resist the room's urge to write paragraphs. Blocks B and C are working pages and may be messy. Do not circulate block B as pre-work — the figures need the facilitator's framing in the room, not a week alone in someone's inbox. |

**Facilitation note carried from ch17.** Two things, and the second is the whole integrity risk
of this sheet. First, the SAE-levels analogy in the chapter's autonomy footnote is the framing
that lands with an exec audience: higher autonomy means *different* human involvement, not less.
Reach for it the moment someone reads the ladder as a plan to remove people. Pair it with the
goal statement at L353 — the aim is to minimise L3 and L4 **not by suppressing them** but by
making the plan specific enough that most decisions resolve at L1 or L2 — which is the sentence
that stops a team gaming its own rate.

Second: say out loud, before block B is opened, that every figure printed there comes from a
single reference execution of roughly twenty-five dispatches with three interventions, and that
the chapter itself calls them calibration points rather than validated benchmarks (ch17 L320).
Then refuse the question the room will ask next — *so what should our number be?* Column 17
ships blank on purpose and is filled a quarter from now from our own dispatch log. The value of
this block is that it forces the organisation to measure; a room that leaves with the book's
number transcribed into its own column has extracted the opposite.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All four levels carry our own trigger, response and a worked example taken from a real
   incident in our own delivery.** A ladder whose column 9 repeats the book's examples — a type
   error, three of twelve files missed — has been printed, not adapted, and will not be
   recognised by the person reading it during an actual stall.
2. **Every level names who is paged and a response window, and the L4 row additionally names
   the individual with authority to approve a scope change.** Named people or named rota
   positions; "the tech lead" is not a page target. Every level also names a log location that
   exists today.
3. **Column 14 reconciles to `WS-16-consequential-effect-register`.** Every consequential effect
   whose gate cell is judgement-external sits at L3 or L4 here, with the same owner. Anything
   human-gated there and resolving at L1 or L2 here is a contradiction between two sheets filled
   by the same room.
4. **No figure in block B appears without its "starting hypothesis, replace after one quarter"
   label**, and the label is on the printed sheet rather than in a facilitator's notes. A copy
   circulated with the numbers and without the label is not this artefact.
5. **Column 17 is blank at publication and column 22 carries a date within one quarter.** A
   sheet that leaves the session with a measured rate filled in has either measured nothing or
   copied the book's figure into our column, and both failures look identical a quarter later.
6. **Column 18 is written by us with a rationale that is not "the book says", and both alarm
   directions carry an action rather than a number.** The chapter's response to a high rate is
   more specific principles or better task scoping; to a low rate it is scrutiny of whether the
   work suits orchestration at all or whether review has gone thin. An alarm with a threshold
   and no action is a metric, not a control.
7. **Block C names a count, a test and a person.** How many distinct approaches before we stop;
   what distinguishes a genuine platform limitation from an application-logic problem; and the
   named individual who can declare the stop — plus the handoff checklist template. A stop rule
   with no declarer leaves abandoning automation as an outcome nobody wants to own, which is
   precisely how a team reaches a fourth attempt.

## 10. Integrity constraint

**Named rule for this sheet.** The 12% / 15-20% / >25% rates print as 'starting hypothesis, replace after one quarter.'

**Hedged figures reachable from this source range.** Each is listed with the book's own hedge, verbatim, and where that hedge lives. Present the figure as a pre-filled prior the organisation overwrites, or as a facilitation prompt - never as a benchmark, target or acceptance threshold. **Carry the hedge onto the sheet with the number; do not restate it in your own words.**

- **The L1/L2/L3-L4 distribution (roughly two-thirds autonomous, one-eighth retry, one-fifth human) and the >25% L3+ trigger.**
  - *Appears at* `handbook\ch17-multi-agent-orchestration.qmd` L350-358
  - *The book's hedge (ch17 L356):* 'That ~20% rate is characteristic of what we observed in a well-planned execution on a non-trivial change' - three interventions in one execution of one project.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Carried unchanged from _section-clusters.md section 7 for CL-ESCALATION.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Already structured: the L1-L4 table is at lines 344-350 and the rate calibration is at lines 320 and 355-357 (~12% observed, 15-20% starting hypothesis, >25% means the plan needs work, <5% warrants scrutiny). Scored 2 rather than 1 only because it sits downstream of the ch16 gate matrix and is largely an operating detail beneath it - but it is a close call: an autonomy policy determines staffing shape and is arguably an exec decision. If the synthesizer builds an explicit autonomy/governance track, promote it. NUMBERS CAVEAT: the rates come from ~25 dispatches in one case study and the book says so in terms ("calibration points from our reference case study, not validated benchmarks") - the worksheet must present them as starting hypotheses. The SAE-levels analogy in footnote ch12-autonomy is a useful facilitation framing for an exec audience: higher autonomy means different human involvement, not less.
