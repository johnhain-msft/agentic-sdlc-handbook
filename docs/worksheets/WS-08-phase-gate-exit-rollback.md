# Phase Gate Cards — Exit Signals, Rollback Triggers, and the Kill Switch

`WS-08-phase-gate-exit-rollback` &middot; **Pack G - The plan we leave with** &middot; fill order **4** &middot; type `checklist` &middot; audience **eng-leader** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A set of signed gate cards with organization-specific numeric thresholds and a named decision-maker per gate — including an explicit, pre-agreed kill switch for the programme.

**Cluster.** `CL-PHASE-GATES` - Expectation Contract and Kill Switch

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch08-planning-the-transition.qmd` |
| Chapter | Planning the Transition |
| Heading | Phase 1: Pilot (1–5 months) |
| Stable anchor | `#sec-transition-phase-1-pilot` |
| Lines | L121-130 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch08-planning-the-transition.html#sec-transition-phase-1-pilot> |
| Locator quote | "**Exit signals.** Move to Phase 2 when: (1) the pilot team has a documented" |

Resolve at any time with `python docs/resolve.py ws WS-08-phase-gate-exit-rollback`.

## 3. Source extract - the scaffolding, verbatim

```text
  121 | **Exit signals.** Move to Phase 2 when: (1) the pilot team has a documented context layer that improves agent output quality, (2) the team has a review workflow for agent-generated code that they trust, (3) you have baseline and pilot metrics for at least four weeks, and (4) the pilot team can articulate what worked and what other teams would need.
  122 | 
  123 | **Rollback criteria.** Pause or restructure Phase 1 if any of the following hold after six weeks of active piloting:
  124 | - **Review rejection rate exceeds 60%.** This is a starting threshold to calibrate; your baseline rejection rate should inform the actual trigger. Agents are producing output the team cannot trust. This is almost always a context quality problem. Pause generation work, invest in the context layer, and restart the pilot clock.
  125 | - **Human intervention rate is not declining week over week.** The first two weeks will be rough. In our experience, teams on well-scoped pilots see declining intervention by weeks 3–5. A flat or rising line means the team is fighting the tool, not learning from it. Diagnose whether the problem is context, skill, or tool fit before continuing.
  126 | - **Developer satisfaction drops below pre-pilot baseline.** If the people using the tools are less productive or less satisfied than before, the pilot is not validating; it is eroding trust. Stop, debrief, and determine whether the issue is remediable or fundamental.
  127 | 
  128 | The rollback process: revert affected teams to their pre-pilot workflow. Preserve all context assets and metrics; they are not wasted, they are diagnostic. Conduct a structured retrospective focused on *why* the signals triggered, not *who* is responsible. A failed pilot that produces clear lessons is more valuable than a limping pilot that produces ambiguous data.
  129 | 
  130 | **Common failure.** Declaring the pilot a success based on enthusiasm rather than evidence. "The team loves it" is a data point, not a conclusion. The exit signals are structural, not emotional.
```

## 4. What the user fills

One card per phase boundary. Exit signals ticked as met / not met with evidence. Rollback thresholds CALIBRATED to the organization's own baseline rather than copied: review rejection rate (book starting point 60%), human intervention rate trend week over week, developer satisfaction against pre-pilot baseline, share of expanding teams needing daily coaching after four weeks (book threshold: more than half), coach time spent on enablement (book threshold: a quarter to a third), and the programme kill criterion (book suggestion: fewer than 40% of participating teams showing measurable improvement after a full Phase 1 and 2 cycle). Each row also names who calls the gate and on what date.

## 5. Field-level schema

Rows are threshold and signal lines, grouped into four cards: **Gate 1** (Phase 1 → Phase 2),
**Gate 2** (Phase 2 → Phase 3), **Gate 3** (Phase 3, selective and with no endpoint) and the
**Programme kill switch**. The physical format is a set of signed cards — A4 landscape,
double-sided, one per gate. The front carries signals and thresholds; the back carries the
rollback process verbatim. Two lines are printed on every card front, in the same weight as the
thresholds themselves: *these thresholds are starting points to calibrate, not standards to hit*
(ch04 L240, ch08 L124, ch08 L180) and *a transition plan without a kill switch is an escalation of
commitment* (ch08 L180).

Every number the book prints appears on these cards **only in the greyed "book's starting point"
column**, never in the column the organisation will be measured against. Column 12 (our Month 0
baseline) and column 14 (why we set it there) are both mandatory on every threshold row, including
rows where the book's figure is adopted unchanged — because these gates are deltas from a baseline
and an inherited number is not a calibration.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | **Card header** — Gate | `select` (four fixed cards) | Gate 1: Phase 1 → Phase 2 · Gate 2: Phase 2 → Phase 3 · Gate 3: Phase 3 selective, no endpoint · Programme kill switch | — | ch08 L86, L88, L177, L180, L182 |
| 2 | **Card header** — Who calls this gate | `owner (named person)` | — | One named person per card. A gate called by a committee is called by nobody | derived |
| 3 | **Card header** — Scheduled review date | `date`, marked PROVISIONAL | — | **Locked until column 4 reads `captured`** | ch08 L117; ch04 L252 |
| 4 | **Card header** — Baseline status + Month 0 date | `select` captured / not captured, plus `date` | — | From `WS-08-baseline-measurement-plan`. Nothing below this row may be committed while it reads `not captured` | ch08 L117 |
| 5 | **Card header** — Calibration recorded by, and date | `owner (named person)` + `date` | — | The person who accepted or overrode every printed figure on this card. Calibration is an act with a name on it, not a default | ch04 L240; ch08 L124 |
| 6 | **Exit signal** — Signal | `free text`, locked | Gate 1 (four): a documented context layer that improves agent output quality · a review workflow for agent-generated code the team trusts · baseline and pilot metrics for at least four weeks · the pilot team can articulate what worked and what other teams would need. Gate 2 (four): expanding teams productive without daily support from pilot members · shared context assets exist and have a responsible owner · governance processes documented and followed without enforcement · organisational metrics show a trend you can explain. Gate 3: **none** — Phase 3 has no endpoint; it is the steady state | — | ch08 L121, L148, L182 |
| 7 | **Exit signal** — Met / not met | `select` met / partial / not met | — | — | derived |
| 8 | **Exit signal** — Evidence | `free text` | — | What was looked at. ch08 L130: "The team loves it" is a data point, not a conclusion | ch08 L130 |
| 9 | **Exit signal** — Evidence artefact reference | `free text` | — | The dashboard, document or metric export. An exit signal with no artefact is enthusiasm | ch08 L130 |
| 10 | **Rollback trigger** — Trigger | `free text`, locked | Gate 1: review rejection rate · human intervention rate trend week over week · developer satisfaction against pre-pilot baseline. Gate 2: share of expanding teams needing daily coach intervention · divergence of organisational from pilot metrics · coach time spent on enablement. Gate 3: per-team sustained negative trend · organisational metrics plateau or decline · programme kill criterion | — | ch08 L124-126, L151-153, L178-180 |
| 11 | **Rollback trigger** — The book's printed starting point | `computed`, locked, **printed greyed and labelled "author-observed, calibrate"** | 60% review rejection rate (*"a starting threshold to calibrate; your baseline rejection rate should inform the actual trigger"*) · intervention not declining week over week, with declining intervention by weeks 3–5 given as the author's experience on well-scoped pilots · satisfaction below pre-pilot baseline · more than half the expanding teams needing daily coaching after four weeks · a 3:1 generation-to-review ratio against 1:1 as the divergence example · coach time above roughly a quarter to a third · eight weeks of sustained per-team negative trend · a full quarter of organisational plateau · fewer than 40% of participating teams showing measurable improvement (*"a suggested threshold; adjust based on your organization's risk tolerance"*) | — | ch08 L124-126, L151-153, L178-180 |
| 12 | **Rollback trigger** — Our Month 0 baseline for this measure | `free text` | — | **Mandatory.** The number we measured before starting. Where we cannot measure it, write `not measurable` and the trigger becomes qualitative — never inherit the book's figure in its place | ch08 L117, L124; ch04 L240 |
| 13 | **Rollback trigger** — Our calibrated trigger | `free text` | — | Expressed as a delta from column 12 wherever column 12 carries a number | ch08 L124 |
| 14 | **Rollback trigger** — Why we set it there | `free text` | — | **Mandatory, including where we adopt the book's figure unchanged.** "Adopted 60% because our Month 0 rejection rate is 41% and we will not tolerate a 19-point regression" is a calibration. A blank is an inheritance | ch04 L240; ch08 L124 |
| 15 | **Rollback trigger** — Who measures it | `owner (named person)` | — | — | derived |
| 16 | **Rollback trigger** — Measurement source | `free text` | — | The named system, query or survey. A trigger nobody can read is not a trigger | derived |
| 17 | **Rollback trigger** — Observation window | `free text` | Gate 1: after six weeks of active piloting · Gate 2: after four weeks · Gate 3: eight weeks for per-team trends, a full quarter for organisational plateau | Our own window, or the book's confirmed | ch08 L123, L151, L178-179 |
| 18 | **Rollback trigger** — State at review | `select` not tripped / watch / tripped | — | — | derived |
| 19 | **Card footer** — Gate decision | `select` go / hold / rollback / kill | — | One decision per card | ch08 L72 |
| 20 | **Card footer** — Decision date | `date` | — | — | derived |
| 21 | **Card footer** — Signature | `signature` | — | Signed by the person in column 2 | derived |
| 22 | **Milestone gate** — Milestone | `select`, locked (five rows) | Month 1 · Month 3 · Month 6 · Month 12 · Month 18 | — | ch04 L242-250 |
| 23 | **Milestone gate** — Our calendar date | `date`, marked PROVISIONAL | — | **Locked until column 4 reads `captured`.** ch04 L252: "This is a planning horizon, not a schedule" | ch04 L252 |
| 24 | **Milestone gate** — Team, phase and investment in scope | `free text` | Month 1: one team, one phase (usually Code), one investment — custom instructions encoding your top five conventions · Month 3: extend to Review · Month 6: add Test · Month 12: evaluate Plan and Build · Month 18: assess readiness for Operate | Our own team, phase and investment | ch04 L242-250 |
| 25 | **Milestone gate** — The book's printed gate threshold | `computed`, locked, **printed greyed and labelled "starting point, calibrate to your baseline"** | M1: first-attempt lint pass 70% or more, and at least five conventions documented machine-readably · M3: rejection rate no worse than the human-only baseline, and median review turnaround down 15% or more · M6: coverage up 10 percentage points or more on agent-covered modules, and agent-generated tests needing human rework less than 30% of the time · M12: human intervention rate down 20% or more from the Month 3 baseline, and at least two context feedback cycles producing measurable improvement · M18: structured runbooks for 80% or more of common incident types, and agent-assisted alert correlation at 90% or more accuracy in retrospective testing | — | ch04 L242-250 |
| 26 | **Milestone gate** — Baseline taken before starting | `free text` | — | **Mandatory.** Every threshold in column 25 is a delta; without this cell the milestone is undecidable | ch04 L240; ch08 L117 |
| 27 | **Milestone gate** — Our calibrated threshold | `free text` | — | — | ch04 L240 |
| 28 | **Milestone gate** — Who measures it | `owner (named person)` | — | — | derived |
| 29 | **Milestone gate** — Gate met / not met / hold, and date | `select` + `date` | — | — | ch04 L242-250 |
| 30 | **Valley contract** — Months expected to be negative | `free text` | — | Written before the programme starts, by the people who will be asked to explain them | ch03 L131-164 |
| 31 | **Valley contract** — Three signals leadership agrees NOT to treat as failure | `free text` (three rows) | — | Three, named specifically enough to be recognised when they appear | ch03 L131-164 |
| 32 | **Valley contract** — Who is authorised to stop the programme | `owner (named person)` | — | One name. Anyone else raising the question routes to this person | ch03 L131-164; ch08 L180 |
| 33 | **Valley contract** — On what evidence | `free text` | — | Must be the calibrated kill criterion from column 13 of the kill-switch card, quoted. Two different stop conditions in one plan is no stop condition | ch08 L180 |
| 34 | **Valley contract** — What leadership says to the board at month 3 | `free text` | — | The prepared sentence, written now, while nobody is under pressure | ch03 L131-164 |
| 35 | **Valley contract** — Review gate dates | `date` | — | The dates leadership commits to reviewing at, rather than reacting at | ch03 L131-164 |
| — | **Card back** — Rollback process | printed, non-editable | Gate 1: revert affected teams to their pre-pilot workflow; preserve all context assets and metrics — they are not wasted, they are diagnostic; run a structured retrospective focused on *why* the signals triggered, not *who* is responsible. Gate 2: teams that are not self-sufficient revert; teams that are functioning continue; coaching concentrates on fewer teams; the goal is to shrink to a sustainable expansion rate, not to abandon the transition | — | ch08 L128, L155 |
| — | **Kill switch card** — What we preserve and revisit | `free text` | Document what you learned, preserve what worked at the team level, and revisit when conditions change | Our own preservation plan | ch08 L180 |

**Absorbed detail.** `WS-03-adoption-jcurve-contract` is columns 30–35 in full — the negative
months, the three signals leadership pre-commits not to read as failure, the single named person
authorised to stop, the evidence that would justify stopping, the month-3 board sentence and the
review gate dates — printed as the reverse of the kill-switch card so the stop authority and the
valley contract are physically inseparable. `WS-04-adoption-roadmap-with-gates` is columns 22–29:
its five milestone rows, its five sets of numeric thresholds (greyed, in column 25 only), its
**mandatory Month-0 baseline-capture column** (26) without which every gate in the kit is
unusable, its calibrated-threshold column (27), its named measurer (28) and its met/not-met/hold
decision with a date (29).

**Deliberate omission.** No score, index or weighted rating across the exit signals. The chapter
is explicit that the signals are structural, not emotional, and that moving forward without
meeting them is the single most common adoption mistake — a composite score lets three met signals
outvote one unmet one, which is precisely the arithmetic the chapter forbids.

**Deliberate omission.** No column for "expected" or "forecast" trigger value. A forecast next to a
threshold invites the room to manage toward the forecast rather than measure against the baseline.

## 6. Absorbed members (2)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-03-adoption-jcurve-contract` - Adoption J-Curve Expectation Contract

- **Address.** `handbook\ch03-the-business-case.qmd` L131-164, The Adoption Timeline (`#sec-business-case-adoption-timeline`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** A written pre-commitment for the valley: which months are expected to be negative, the three valley signals leadership agrees NOT to treat as failure, who is authorised to stop the programme and on what evidence, what leadership will say to the board at month 3, and the review gate dates.
- **Its output was.** A signed expectation contract that prevents the programme being cancelled in months 2-4 - the failure mode the book says stops teams ever reaching the compounding phase.

### `WS-04-adoption-roadmap-with-gates` - 18-Month Adoption Roadmap with Expansion Gates

- **Address.** `handbook\ch04-the-reference-architecture.qmd` L238-252, Start Anywhere, Expand Deliberately (`#sec-ref-arch-start-anywhere`)
- **Why folded.** Gates already have a canonical home; contributes the five numeric milestone thresholds and the mandatory Month-0 baseline-capture column, without which every gate in the kit is unusable.
- **Fill detail to absorb.** Five milestone rows (Month 1, 3, 6, 12, 18). Per row: our calendar date, the team and phase in scope, the baseline measurement taken before starting, our calibrated gate threshold (the book numbers - 70 percent first-pass lint, 15 percent review turnaround reduction, 10 points coverage, under 30 percent rework, 20 percent intervention decline, 80 percent runbook coverage, 90 percent correlation accuracy - are starting points to adjust), who measures it, and a gate met / not met / hold decision with a date.
- **Its output was.** The organisation dated transformation roadmap with explicit, measurable go/no-go gates at each expansion step - the primary deliverable of the planning workshop.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-08-baseline-measurement-plan` - Baseline Measurement and Instrumentation Plan (Pack A - Groundwork (pre-work), fill order 4)

**Consumed by:**

- `WS-03-go-no-go-readiness-gate` - Go / No-Go Readiness Gate (Pack G - The plan we leave with, fill order 6)

**Feeds into (prose, from the source scan).** WS-08-transition-roadmap (gates sit on the timeline) and the executive sponsor's reporting cadence.

## 8. Facilitation

| | |
|---|---|
| Who fills it | The engineering leader who will call the gates, with the person who owns measurement (column 15) and the executive who holds the stop authority (column 32). The stop authority must be in the room and must say out loud that they accept it — a kill switch assigned in absentia is not a kill switch. |
| When in the session | After `WS-08-baseline-measurement-plan` and before `WS-03-go-no-go-readiness-gate`, which consumes it. It sits at fill order 4 in Pack G, ahead of the roadmap, deliberately: the thresholds are agreed before the calendar exists, so the gates cannot be quietly set to whatever the dates would have delivered. |
| Duration | 90 minutes. Roughly 50 of those go on columns 12, 13 and 14 across the three gate cards — the baseline, the calibrated trigger and the written reason. The remaining 40 cover the five milestone rows and the valley contract. If the session is running short, cut the milestone rows and keep the calibration; an uncalibrated card is worse than no card. |
| Data needed in advance | The completed `WS-08-baseline-measurement-plan` with its Month 0 figures, or an honest statement of which measures could not be captured; the current review rejection rate, cycle time, defect rate and developer satisfaction from the candidate teams; the existing escalation and stop-authority structure, so column 32 names someone who genuinely holds that power; the organisation's board and steering calendar for column 35. |
| Room format | Printed cards, A4 landscape, double-sided, one per gate, filled by hand and signed in the room. Not a projected spreadsheet — a card that gets signed and pinned is re-read, and a spreadsheet tab is not. Print them with the book's figures already greyed into column 11 and column 25 so the visual distinction between *their* number and *our* number is obvious before anyone writes. |

**Facilitation note.** The failure mode of this sheet is silent acceptance. The room reads "60%",
nods, and moves on — and the kit has just laundered an author-observed figure into an
organisational standard. Block that mechanically: no threshold row may be left with column 12 or
column 14 blank, and read them back aloud at the end. Where the baseline genuinely was not
captured, write `not measurable` and convert the trigger to a qualitative statement; do not let
the book's number fill the gap. Two conversations are worth protecting time for. First, the stop
authority in column 32: ask the named person directly whether they would actually use it, and what
would have to be true. Second, the month-3 board sentence in column 34 — write it now, in the
room, while nobody is under pressure, because the version written at month 3 under pressure will
be an argument for continuing. Close by reading the card legend out loud: a transition plan
without a kill switch is an escalation of commitment.

## 9. Acceptance criteria

A well-completed set of cards satisfies all of:

1. **Every threshold row carries a Month 0 baseline (column 12) and a written reason (column
   14)** — including every row where the book's figure was adopted unchanged. A card with the book's
   numbers copied into column 13 and a blank column 14 has not been calibrated, it has been
   photocopied, and it must not be signed.
2. **No printed figure from the book appears anywhere except the greyed columns 11 and 25.** Read
   the finished card as a stranger would: if a reader cannot tell at a glance which numbers are the
   author's starting points and which are this organisation's commitments, the card has failed its
   only integrity job.
3. **No date is committed in column 3 or column 23 while column 4 reads `not captured`.** These
   gates are deltas from a baseline and are not dateable until `WS-08-baseline-measurement-plan` is
   complete. Cards may ship with those fields struck through and the gate still agreed.
4. **Each of the four cards names one individual in column 2, and the calibration in column 5 is
   signed and dated.** Two names, or a function, means no one calls the gate.
5. **The kill switch is complete and internally consistent.** Column 32 names one person, column 33
   quotes the calibrated criterion from column 13 of the kill-switch card verbatim, and column 34
   contains a sentence written in this session. A kill switch whose evidence clause disagrees with
   its own threshold row is not a stop condition.
6. **Gate 3 carries no exit signal and no end date.** Per ch08 L182, Phase 3 is the steady state.
   A Gate 3 card with a completion criterion contradicts the source and contradicts the final band
   of `WS-08-transition-roadmap`.
7. **Every measure in column 10 and column 25 has a named measurer (columns 15 and 28) and a named
   source (column 16).** A trigger nobody is instructed to read will not trip.
8. **The observation windows and gate names reconcile with `WS-08-transition-roadmap`.** Gate 1 and
   Gate 2 sit on the two decision diamonds of that timeline, the rollback loops on the card back
   match the two loops drawn on it, and the five milestone dates in column 23 fall inside the phase
   bands the roadmap's calibration produced. A milestone dated outside its band means one of the
   two sheets is wrong.

## 10. Integrity constraint

**Named rule for this sheet.** ch04's and ch08's gate thresholds are deltas from a baseline and are not dateable until WS-08-baseline-measurement-plan is complete. Printed values are calibration starting points.

**Hedged figures reachable from this source range.** Each is listed with the book's own hedge, verbatim, and where that hedge lives. Present the figure as a pre-filled prior the organisation overwrites, or as a facilitation prompt - never as a benchmark, target or acceptance threshold. **Carry the hedge onto the sheet with the number; do not restate it in your own words.**

- **The Month 1/3/6/12/18 numeric expansion gates.**
  - *Appears at* `handbook\ch04-the-reference-architecture.qmd` L236-254
  - *The book's hedge (ch04 L250):* 'This is a planning horizon, not a schedule.' Every threshold is a DELTA FROM A BASELINE the organisation has not yet measured, so none is dateable until the baseline plan is complete.
- **The rollback trigger at a review rejection rate above 60%.**
  - *Appears at* `handbook\ch08-planning-the-transition.qmd` L120-130
  - *The book's hedge (ch08 L124):* 'This is a starting threshold to calibrate; your baseline rejection rate should inform the actual trigger.'

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** Carried unchanged from _section-clusters.md section 7 for CL-PHASE-GATES.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> The highest-integrity content in Part II and the rarest thing in a transformation kit: a chapter that ships its own kill criteria. The chapter's line — a transition plan without a kill switch is an escalation of commitment — should be printed on the card. EVERY THRESHOLD IS EXPLICITLY A STARTING POINT TO CALIBRATE, not a standard: the 60% rejection rate says your baseline rejection rate should inform the actual trigger, and the 40% kill threshold says adjust based on your organization's risk tolerance. A kit that prints these as fixed thresholds misrepresents the source. This is deliberately separate from WS-08-transition-roadmap: the roadmap is sequencing and calendar, the gate card is thresholds and authority. Source spans all three phases: Phase 1 at 121-130, Phase 2 at 148-157, Phase 3 at 177-184 including the kill criteria. The rollback PROCESS text (revert affected teams, preserve context assets as diagnostic, blameless retrospective) belongs on the card back.
