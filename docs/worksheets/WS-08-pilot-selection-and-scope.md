# Pilot Selection and Scope Contract

`WS-08-pilot-selection-and-scope` &middot; **Pack G - The plan we leave with** &middot; fill order **9** &middot; type `decision` &middot; audience **mixed** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A one-page pilot contract: named teams, bounded scope, named sponsor and lead, and a captured pre-pilot baseline — signed before any tooling is provisioned.

**Cluster.** `CL-PILOT-SELECTION` - Pilot Selection and Scope Contract

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch08-planning-the-transition.qmd` |
| Chapter | Planning the Transition |
| Heading | Phase 1: Pilot (1–5 months) |
| Stable anchor | `#sec-transition-phase-1-pilot` |
| Lines | L114-120 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch08-planning-the-transition.html#sec-transition-phase-1-pilot> |
| Locator quote | "**Scope.** One or two teams. Select teams that scored" |

Resolve at any time with `python docs/resolve.py ws WS-08-pilot-selection-and-scope`.

## 3. Source extract - the scaffolding, verbatim

```text
  114 | **Scope.** One or two teams. Select teams that scored "ready" in the readiness assessment. Limit scope to well-defined work: a new feature, a contained refactor, a test suite expansion, not a sprawling cross-cutting change. The goal is controlled conditions, not maximum impact.
  115 | 
  116 | **Activities.**
  117 | - Establish baseline measurements before the pilot begins. You cannot measure improvement without a starting point. Capture current cycle time, review rejection rate, defect rate, and developer satisfaction on the selected workstreams.
  118 | - Build the minimum viable context layer: project-level instructions, core coding conventions, architecture boundaries. Part III (Chapters 9–10) provides the methodology. For the pilot, you need enough context to prevent the most common agent failures, not a comprehensive instrumentation layer.
  119 | - Run the pilot with close observation. The goal is to learn, not to prove a point. Document what agents get right, what they get wrong, and what they can't do. Track human intervention points, every moment a developer had to correct, override, or redo agent output.
  120 | 
```

## 4. What the user fills

Name one or two pilot teams from the ready pool, and write the justification against a representative-not-exceptional test (team seniority mix, codebase age, greenfield versus legacy). Define scope as a bounded workstream — a new feature, a contained refactor, a test suite expansion — and write explicitly what is out of scope. Name the executive sponsor and the transition lead. Record the baseline measurements captured before day one: cycle time, review rejection rate, defect rate, developer satisfaction.

## 5. Field-level schema

Rows are candidate teams (block B), the scope contract (C), the four baseline measures (D), the
three context-layer components (E), the eight lifecycle phases (F) and the checkpoint readiness
assessment (G). **Page one is the contract and is one page, signed:** the framing rule, blocks B
through E, the single chosen phase with its budget, owner and date, and the signature strip.
Blocks F and G are the two-page annex the contract cites. The contract is signed *before any
tooling is provisioned* — ch08 L117 requires the baseline in block D to exist before day one.

The framing rule is printed across the head of page one, in the same weight as the title:
**Select pilot teams that are representative, not exceptional** — with the hero pilot set beneath
it in full: *the pilot team includes your three best developers and a greenfield project; the
pilot succeeds brilliantly; nothing learned transfers to a team of mixed seniority working on a
legacy codebase* (ch08 L247). Column 7 is mandatory because of that sentence.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | **B. Candidates** — Team | `free text` | — | Every team considered, not only those selected. The rejected rows are the evidence that a choice was made | ch08 L114 |
| 2 | **B. Candidates** — Readiness rating | `select` ready / partially ready / not ready | Phase 1 takes teams that scored "ready" | Carried from `WS-06-team-readiness-scorecard`, not re-scored here | ch08 L114 |
| 3 | **B. Candidates** — Seniority mix vs our organisation's norm | `select` representative / somewhat atypical / exceptional | `exceptional` is the hero-pilot flag | A comparison, not a rating of the team's quality | ch08 L247 |
| 4 | **B. Candidates** — Codebase: age, and greenfield or legacy | `select` representative / somewhat atypical / exceptional | A greenfield project is named explicitly as half the hero pilot | Which of our codebases this resembles | ch08 L247 |
| 5 | **B. Candidates** — Documentation maturity vs our norm | `select` representative / somewhat atypical / exceptional | The chapter names documentation maturity as the dominant driver of Phase 1 duration | — | ch08 L110, L247 |
| 6 | **B. Candidates** — Enthusiasm vs our norm | `select` representative / somewhat atypical / exceptional | Phase 3 is where "mixed enthusiasm" teams arrive; a uniformly enthusiastic pilot is not representative of them | — | ch08 L163, L247 |
| 7 | **B. Candidates** — Written justification against the hero-pilot test | `free text` | — | **Mandatory for every selected team.** Answer the question directly: *what about this team is unlike the rest of our engineering organisation, and why will what we learn here still transfer?* Three `representative` ratings and a blank here fails the sheet | ch08 L247 |
| 8 | **B. Candidates** — Selected | `checkbox` | One or two teams. Not three | Tick at most two | ch08 L114 |
| 9 | **B. Candidates** — Reason not selected | `free text` | — | For every unticked row. A team excluded without a written reason will be re-proposed in a fortnight | derived |
| 10 | **C. Scope** — The bounded workstream | `free text` | Well-defined work: a new feature, a contained refactor, a test suite expansion | The specific workstream, named the way the team names it | ch08 L114 |
| 11 | **C. Scope** — Explicitly out of scope | `free text` | Not a sprawling cross-cutting change | The exclusions, written | ch08 L114 |
| 12 | **C. Scope** — Why this is controlled conditions, not maximum impact | `free text` | "The goal is controlled conditions, not maximum impact" | Our answer. A scope chosen for visibility rather than control belongs in column 11 | ch08 L114 |
| 13 | **C. Scope** — Executive sponsor | `owner (named person)` + `signature` | Task 5 of the Pre-Transition block names both roles | A named person, signing | ch08 L265 |
| 14 | **C. Scope** — Transition lead | `owner (named person)` | — | A named person, distinct from the sponsor | ch08 L265 |
| 15 | **D. Baseline** — Measure | `free text`, locked (four rows) | Current cycle time · review rejection rate · defect rate · developer satisfaction, on the selected workstreams | — | ch08 L117 |
| 16 | **D. Baseline** — Value at Month 0 | `free text` | — | **Mandatory before provisioning.** "You cannot measure improvement without a starting point." Where a measure genuinely cannot be captured, write `not measurable` and say what will be used instead — never leave it blank | ch08 L117 |
| 17 | **D. Baseline** — Capture date | `date` | — | Before the pilot begins, not retrofitted in week three | ch08 L117 |
| 18 | **D. Baseline** — Captured by | `owner (named person)` | — | — | derived |
| 19 | **D. Baseline** — Source | `free text` | — | The named system or survey instrument. This becomes the system of record for the same measure on `WS-08-phase-gate-exit-rollback` | derived |
| 20 | **E. Context layer** — Component | `free text`, locked (three rows) | Project-level instructions · core coding conventions · architecture boundaries | — | ch08 L118 |
| 21 | **E. Context layer** — Owner | `owner (named person)` | — | — | derived |
| 22 | **E. Context layer** — Planned effort | `free text` | The chapter reports 4–6 weeks for a team starting from zero documentation, explicitly as early-adopter experience rather than a standard | Our own estimate, given our documentation rating in column 5 | ch08 L110 |
| 23 | **E. Context layer** — Built inside Phase 1 | `checkbox`, pre-ticked and locked | "That work happens *inside* Phase 1, not before it." Treating the context layer as a prerequisite is a common and expensive planning error | Acknowledge; this tick is not a choice | ch08 L110 |
| 24 | **E. Context layer** — Sufficiency bar | `free text` | "Enough context to prevent the most common agent failures, not a comprehensive instrumentation layer" | What "enough" means for this codebase | ch08 L118 |
| 25 | **F. Phase entry** — Lifecycle phase | `select`, locked (eight rows) | Code · Review · Test · Plan · Build · Release · Ideate · Operate | — | ch04 L193-202 |
| 26 | **F. Phase entry** — "Start here if…" | `free text`, locked | Your developers already use AI tools · PR review is a bottleneck · test coverage is low or tests are brittle · planning is slow and produces inconsistent artifacts · CI failures consume significant developer time · release process is manual and error-prone · research and discovery are ad hoc · incident response is slow to diagnose | — | ch04 L195-202 |
| 27 | **F. Phase entry** — True of us | `checkbox` | — | Tick every trigger that is genuinely true, not only the one we want | ch04 L195-202 |
| 28 | **F. Phase entry** — First investment | `free text`, locked | Custom instructions encoding your conventions · agent-assisted review with human sign-off · agent-generated tests with human-defined strategy · ADR templates and specification structures · agent-assisted build diagnostics · agent-drafted changelogs and breaking-change detection · agent-assisted research synthesis · agent-assisted alert correlation and timeline drafting | — | ch04 L195-202 |
| 29 | **F. Phase entry** — Maturity prerequisite | `free text`, locked | Linter, test suite, CI pipeline · documented quality standards and clear review criteria · test framework, coverage tooling, defined test policy · issue tracker, documented architecture decisions · CI/CD pipeline with structured error output · semantic versioning, structured commit history · knowledge base, searchable decision history · observability stack, structured runbooks | — | ch04 L195-202 |
| 30 | **F. Phase entry** — Present / partial / absent | `select` present / partial / absent | — | Per prerequisite | ch04 L195-202 |
| 31 | **F. Phase entry** — Evidence for that claim | `free text` | — | **Mandatory for every `present`.** Name the linter, the CI pipeline, the documented standard, the runbook location. "We have a test suite" without a name is a `partial` | ch04 L206 |
| 32 | **F. Phase entry** — The book's expected timeline | `computed`, locked, **printed greyed** | 2–4 weeks (Code) · 4–8 weeks (Review, Test, Build) · 8–12 weeks (Plan, Release) · 12–18 weeks (Ideate, Operate) | — | ch04 L195-202 |
| 33 | **F. Phase entry** — Our calibrated timeline | `free text`, range only | — | A range, calibrated to our documentation maturity and org size exactly as `WS-08-transition-roadmap` requires. ch04 L252: "This is a planning horizon, not a schedule" | ch04 L240, L252 |
| 34 | **F. Phase entry** — Chosen phase | `checkbox` | The chapter advises starting where tooling is mature and payoff is immediate — Code, Review and Test | Exactly one ticked | ch04 L204 |
| 35 | **F. Phase entry** — Ranked shortlist, next two | `select` 2nd / 3rd | — | The expansion path, ranked now rather than argued later | ch04 L208 |
| 36 | **F. Phase entry** — First investment budget | `currency` | — | Reconciles to `WS-07-spend-pool-budget-model` | derived |
| 37 | **F. Phase entry** — Accountable owner and target date | `owner (named person)` + `date` | — | One name, one date | ch04 L195-202 |
| 38 | **G. Checkpoint readiness** — Repository | `free text` | — | One row per repository the pilot will touch | ch18 L216-236 |
| 39 | **G. Checkpoint readiness** — Full suite runtime | `free text` | — | Measured, not remembered | ch18 L222 |
| 40 | **G. Checkpoint readiness** — Flake rate | `free text` | — | Measured. A flaky suite cannot gate a wave | ch18 L216-236 |
| 41 | **G. Checkpoint readiness** — Coverage of the behaviour agents will change | `free text` | — | Coverage of *the pilot's workstream*, not global coverage | ch18 L216-236 |
| 42 | **G. Checkpoint readiness** — Runs locally, or CI only | `select` local / CI only / both | — | CI-only changes the cost of a checkpoint materially | ch18 L216-236 |
| 43 | **G. Checkpoint readiness** — Test gate: which suite, what pass criterion | `free text` | "The full test suite runs. If any test fails, the wave is not committed." | Our suite and our criterion | ch18 L228 |
| 44 | **G. Checkpoint readiness** — Spot-check: who, sampling what | `free text` | Focus on boundary conditions, pattern compliance and scope discipline: did the agent handle the edge case, follow existing patterns rather than invent new ones, and change only what was specified? | A named reviewer and a named sampling rule | ch18 L230 |
| 45 | **G. Checkpoint readiness** — Commit convention | `free text` | "Every wave gets its own commit with a descriptive message," producing a clean bisectable history | Our convention | ch18 L232 |
| 46 | **G. Checkpoint readiness** — Plan review trigger | `free text` | Reviewed when the current wave revealed something unexpected: a missed dependency, a task that should be split, a wave that should be reordered | What fires it for us | ch18 L234 |
| 47 | **G. Checkpoint readiness** — Verdict: can we afford to run this after every wave? | `select` yes / no | — | A straight answer | ch18 L216-236 |
| 48 | **G. Checkpoint readiness** — If no: remediation and its cost | `free text` + `currency` | — | A costed test-investment item that must precede the transformation. A `no` in column 47 with a blank here is an unfunded blocker | ch18 L216-236 |
| — | Contract signature + date | `signature` | — | Signed by the executive sponsor in column 13, before any tooling is provisioned | ch08 L117, L265 |

**Absorbed detail.** `WS-04-phase-entry-decision` is block F, columns 25–37: its eight-phase grid
with the "Start here if…" trigger (26–27), the maturity prerequisite rated present / partial /
absent (29–30) **with the evidence for the claim forced in column 31**, and its output — one
phase, one team, one investment, one budget, one owner, one date — on page one via columns 34,
36 and 37, plus the ranked shortlist of the next two phases in column 35. Its "Expected timeline"
column is carried as a greyed prior in column 32 and calibrated in column 33, never inherited.
`WS-18-checkpoint-gate-definition` is block G, columns 38–48: the per-repository measurements
(39–42), the checkpoint's four components (43–46), and its explicit verdict plus costed
remediation (47–48) — the test-infrastructure readiness answer that must precede the
transformation rather than be discovered during it.

**Deliberate omission.** No composite readiness score across columns 3–6. A score would let two
`representative` ratings average out one `exceptional`, and the hero pilot is precisely the case
where one exceptional dimension invalidates the transfer. The four ratings are read individually,
and any `exceptional` forces column 7 to address it by name.

**Deliberate omission.** No success criteria for the pilot on this sheet. Exit signals and
rollback triggers live on `WS-08-phase-gate-exit-rollback`; a second, locally-authored definition
of pilot success on the contract would compete with the gate card and win, because it is the one
the pilot team reads.

## 6. Absorbed members (2)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-04-phase-entry-decision` - First Pilot Scoping: Which Phase Do We Start With?

- **Address.** `handbook\ch04-the-reference-architecture.qmd` L187-213, The Architecture Decision Matrix (`#sec-ref-arch-decision-matrix`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** For each of the eight phases, tick whether the "Start here if..." trigger is true of us, then tick each maturity prerequisite as present / partial / absent WITH the evidence for the claim (name the linter, the CI pipeline, the documented standards). The team then picks one phase and records the pilot team, the first investment, the budget, the accountable owner and the target date drawn from the Expected timeline column.
- **Its output was.** A signed first-pilot scope: one phase, one team, one investment, one owner, one date - plus a ranked shortlist of the next two phases.

### `WS-18-checkpoint-gate-definition` - Checkpoint Readiness: Can Our Test Suite Gate Every Wave?

- **Address.** `handbook\ch18-the-execution-meta-process.qmd` L216-236, Checkpoint Discipline (`#sec-meta-checkpoints`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Measure and record, per repository: full suite runtime, flake rate, coverage of the behaviour agents will change, and whether it runs locally or only in CI. Then define the checkpoint's four components - test gate (which suite, what pass criterion), spot-check (who, sampling what: boundary conditions, pattern compliance, scope discipline), commit convention, plan review trigger. Final verdict: can we afford to run this after every wave? If not, what is the remediation and its cost?
- **Its output was.** A checkpoint definition plus an explicit verdict on test-infrastructure readiness - including, where the answer is no, a costed test-investment item that must precede the transformation.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-06-team-readiness-scorecard` - Team Readiness Scorecard — Eight Dimensions, Scored Honestly (Pack A - Groundwork (pre-work), fill order 3)
- `WS-08-pitfall-risk-register` - Transition Risk Register — Six Predictable Failure Modes (Pack G - The plan we leave with, fill order 8)

**Consumed by:**

- `WS-08-transition-planning-checklist` - The Transition Plan — Task-Level Checklist Across Five Blocks (Pack G - The plan we leave with, fill order 10)

**Feeds into (prose, from the source scan).** WS-08-phase-gate-exit-rollback (the Phase 1 gate is evaluated against this contract) and WS-08-baseline-measurement-plan.

## 8. Facilitation

| | |
|---|---|
| Who fills it | The executive sponsor and the transition lead, with the engineering managers of every candidate team present — including the managers of teams that will not be selected, because column 9 is written in front of them and is far more honest when it is. Block G needs whoever actually knows the test suite's runtime and flake rate; that person is rarely a manager. |
| When in the session | Late in Pack G, at fill order 9: after `WS-06-team-readiness-scorecard` supplies column 2 and after `WS-08-pitfall-risk-register` has scored the hero pilot, because that score is the input to how hard column 7 is interrogated. It is the last decision before breaking ground, and `WS-08-transition-planning-checklist` consumes it immediately afterwards. |
| Duration | 90 minutes. Blocks B and C take 45 — the candidate argument is the session and should not be rushed. Block D takes 15 and is usually uncomfortable, because the honest answer for at least one of the four measures is that nobody has it. Blocks F and G are pre-drafted from data gathered in advance and confirmed in 30. |
| Data needed in advance | The completed readiness scorecards for every candidate team; the actual seniority distribution across the engineering organisation, so columns 3–6 are comparisons rather than impressions; current cycle time, rejection rate, defect rate and the most recent developer survey for the candidate workstreams; measured test-suite runtime, flake rate and workstream coverage for every repository in block G; the current tooling and CI inventory, for the evidence in column 31. |
| Room format | Printed one-page contract for page one, filled by hand and signed in the room, with the annex on a projected screen. Sign on the day. A contract taken away "to be finalised" is finalised by one person, and the representativeness justification is the first thing that softens. |

**Facilitation note.** This sheet's job is to make the hero pilot hard to choose, and the room
will try to choose it anyway — not cynically, but because the best team on the newest codebase is
genuinely the one most likely to produce a good demo. Run block B by reading the hero-pilot
sentence aloud first, then scoring columns 3–6 as *comparisons against our own median*, not as
judgements of the team. Any `exceptional` rating must be addressed by name in column 7; "they're
a strong team" is the answer the column exists to reject. Two further pressure points. Block D:
if a baseline measure cannot be captured, say so on the sheet and adjust the gate card rather
than provisioning tooling and promising to backfill — a retrofitted baseline is the pilot's own
output measured before the pilot. Block E column 23: the room will want to build the context
layer before Phase 1 starts. The chapter is explicit that it happens inside Phase 1, and the tick
is locked; treating it as a prerequisite adds four to six weeks to the plan and moves them
somewhere nobody is measuring.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **One or two teams are selected, and no more.** Three ticks in column 8 is a Phase 2 disguised
   as a pilot and contradicts both ch08 L114 and the team count on `WS-08-transition-roadmap`.
2. **Every selected team has a written justification in column 7 that addresses each
   `exceptional` or `somewhat atypical` rating by name.** A team rated `exceptional` on seniority
   with a justification that does not mention seniority fails this criterion. This is the sheet's
   load-bearing check and the reason the field is mandatory.
3. **Every unselected candidate carries a reason in column 9.** A pilot roster with no rejected
   rows means no selection happened.
4. **All four baseline measures in block D carry either a Month 0 value and a capture date, or an
   explicit `not measurable` with the substitute named.** No blanks. Tooling must not be
   provisioned until this block is closed — ch08 L117 puts baseline capture before the pilot
   begins, not inside it.
5. **The scope in column 10 is a single bounded workstream and column 11 is non-empty.** "Whatever
   the team picks up next sprint" is not a scope, and a contract with nothing out of scope has not
   bounded anything.
6. **Exactly one phase is ticked in column 34, with a budget, an owner and a date**, and every
   `present` rating in column 30 carries named evidence in column 31. A prerequisite claimed
   present without a named linter, pipeline, standard or runbook is downgraded to `partial`.
7. **Block G reaches a verdict.** Column 47 is answered, and any `no` carries a costed remediation
   in column 48 which is then carried into `WS-08-transition-planning-checklist` as a task with an
   owner and a date. An unfunded test-infrastructure blocker discovered mid-pilot costs the pilot.
8. **The sheet reconciles with its neighbours.** The Phase 1 team names match column 16 of
   `WS-08-transition-roadmap`; the four measures in block D are the same measures, from the same
   sources, as the calibrated triggers on `WS-08-phase-gate-exit-rollback`; and the hero-pilot
   score on `WS-08-pitfall-risk-register` is consistent with the justifications in column 7 — a
   `High` there and four `representative` ratings here is a contradiction one of the two sheets
   has to resolve.
9. **The executive sponsor has signed and dated it, before any tooling was provisioned.** An
   unsigned contract is a proposal, and a contract signed after provisioning is a record.

## 10. Integrity constraint

**Hedged figures reachable from this source range.** Each is listed with the book's own hedge, verbatim, and where that hedge lives. Present the figure as a pre-filled prior the organisation overwrites, or as a facilitation prompt - never as a benchmark, target or acceptance threshold. **Carry the hedge onto the sheet with the number; do not restate it in your own words.**

- **The rollback trigger at a review rejection rate above 60%.**
  - *Appears at* `handbook\ch08-planning-the-transition.qmd` L120-130
  - *The book's hedge (ch08 L124):* 'This is a starting threshold to calibrate; your baseline rejection rate should inform the actual trigger.'

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** Prose only. The representative-not-exceptional rubric (seniority mix, codebase age, greenfield versus legacy) and the exclusion criteria must be invented; the book supplies the test by negation, not a scale.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Sits at the exact moment the delivery is designed for: the last decision before breaking ground. The chapter supplies an unusually sharp selection test by negation — pitfall 4, the hero pilot (line 247): the pilot includes your three best developers and a greenfield project, it succeeds brilliantly, and nothing transfers. Select pilot teams that are representative, not exceptional. That sentence should be the worksheet's framing rule and the reason the justification field is mandatory. Also load-bearing: the chapter insists baseline measurement happens BEFORE the pilot begins, and that Phase 1 includes building a minimum viable context layer inside the phase (a 4-6 week effort from zero documentation), not as a prerequisite — a common and expensive planning error. Source is prose across the Objective/Scope/Activities block plus the pre-transition checklist at 261-267.
