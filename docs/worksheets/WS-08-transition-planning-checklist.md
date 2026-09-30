# The Transition Plan — Task-Level Checklist Across Five Blocks

`WS-08-transition-planning-checklist` &middot; **Pack G - The plan we leave with** &middot; fill order **10** &middot; type `checklist` &middot; audience **mixed** &middot; leadership priority **1**

> **Split back out in the re-opening pass.** The source scan explicitly forbids merging these two zoom levels; this is the terminal task-level artefact -- 36 pre-written tasks plus owner, target date and evidence -- that a delivery lead loads into a tracker on day one.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** The operational transition plan: every task owned, dated, and evidenced, organised by phase, ready to load into a delivery tracker on day one.

**Cluster.** `CL-TRANSITION-CHECKLIST` - The Transition Plan: Task-Level Checklist

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch08-planning-the-transition.qmd` |
| Chapter | Planning the Transition |
| Heading | Transition Planning Template |
| Stable anchor | `#sec-transition-planning-template` |
| Lines | L257-308 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch08-planning-the-transition.html#sec-transition-planning-template> |
| Locator quote | "Use this template to plan your organization's transition. It is a starting point" |

Resolve at any time with `python docs/resolve.py ws WS-08-transition-planning-checklist`.

## 3. Source extract - the scaffolding, verbatim

```text
  257 | Use this template to plan your organization's transition. It is a starting point, not a specification. Adapt it to your context.
  258 | 
  259 | ### Pre-Transition (Weeks 1-4)
  260 | 
  261 | - [ ] Conduct readiness assessments for all candidate teams
  262 | - [ ] Establish baseline metrics (DORA + quality) for pilot candidates
  263 | - [ ] Identify pilot team(s): one to two teams scoring "ready" across all dimensions
  264 | - [ ] Define pilot scope: specific workstreams with clear boundaries
  265 | - [ ] Assign executive sponsor and transition lead
  266 | - [ ] Determine tool selection based on the evaluation framework from Chapter 2
  267 | - [ ] Review governance requirements from Chapter 5; identify minimum viable policies
  268 | 
  269 | ### Phase 1 — Pilot (1–5 months, depending on org size and documentation maturity)
  270 | 
  271 | - [ ] Build minimum viable context layer for pilot team's codebase (Chapters 9–10)
  272 | - [ ] Train pilot team on context engineering basics and agent interaction patterns
  273 | - [ ] Begin pilot with structured observation: log intervention points, failure modes, and successes
  274 | - [ ] Conduct weekly retrospectives focused on what agents get right and wrong
  275 | - [ ] Collect pilot metrics for at least four consecutive weeks
  276 | - [ ] Monitor rollback signals at week six: rejection rate, intervention trend, developer satisfaction
  277 | - [ ] Document lessons learned: what other teams need to know before starting
  278 | - [ ] Evaluate Phase 1 exit signals before proceeding
  279 | 
  280 | ### Phase 2 — Expand (3–9 months from start, depending on org size)
  281 | 
  282 | - [ ] Select three to five expansion teams based on readiness
  283 | - [ ] Assign pilot team members as coaches (budget for dedicated enablement if expanding beyond five teams)
  284 | - [ ] Build shared context assets: organizational standards, architectural patterns, cross-project conventions
  285 | - [ ] Establish governance processes for agent-generated code
  286 | - [ ] Begin role-specific skill development
  287 | - [ ] Track organizational metrics
  288 | - [ ] Monitor rollback signals: coach dependency, metric divergence, capacity strain
  289 | - [ ] Conduct monthly cross-team retrospectives
  290 | - [ ] Evaluate Phase 2 exit signals before proceeding
  291 | 
  292 | ### Phase 3 — Scale (6–24 months from start, depending on org size)
  293 | 
  294 | - [ ] Extend to remaining teams with self-service onboarding
  295 | - [ ] Transition from peer coaching to dedicated enablement function
  296 | - [ ] Establish continuous context maintenance (ownership, review, pruning)
  297 | - [ ] Mature metrics from adoption tracking to effectiveness optimization
  298 | - [ ] Evaluate advanced workflows: multi-agent orchestration, CI/CD integration
  299 | - [ ] Assign permanent ownership of context assets and governance
  300 | - [ ] Monitor per-team rollback signals; pause individual teams showing sustained negative trends
  301 | - [ ] Report organizational impact using metrics framework
  302 | 
  303 | ### Ongoing
  304 | 
  305 | - [ ] Review context asset quality quarterly
  306 | - [ ] Update skill development as tools and practices evolve
  307 | - [ ] Reassess governance policies as agent capabilities expand
  308 | - [ ] Track the generation-to-review time ratio as the primary health indicator
```

## 4. What the user fills

Thirty-six pre-written checkbox tasks across five blocks (Pre-Transition weeks 1-4, Phase 1, Phase 2, Phase 3, Ongoing). The team adds three columns to every row: named owner, target date, and evidence of done. The Pre-Transition block alone — readiness assessments, baseline metrics, pilot team identification, pilot scope, executive sponsor and transition lead, tool selection, minimum viable governance policies — is the complete pre-groundbreaking task list.

## 5. Field-level schema

Rows are the thirty-six tasks, reprinted verbatim and grouped under the five shared phase blocks
(7 + 8 + 9 + 8 + 4). The format is a portrait multi-page checklist built to be exported straight
into a delivery tracker, one row per ticket, with the block as the epic. The Pre-Transition block
is printed on its own separable first page: it is the complete pre-groundbreaking task list and is
useful on day one, before the rest of the plan has dates.

**Shared phase vocabulary.** Identical to `WS-08-transition-roadmap`, which is this same plan at
strategic zoom. Neither sheet may rename, merge or reorder them:

`Pre-Transition` · `Phase 1 — Pilot` · `Phase 2 — Expand` · `Phase 3 — Scale` · `Ongoing`
(ch08 L259, L269, L280, L292, L303)

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Block | `select` (five fixed) | Pre-Transition · Phase 1 — Pilot · Phase 2 — Expand · Phase 3 — Scale · Ongoing | — | ch08 L259, L269, L280, L292, L303 |
| 2 | Task number | `computed` | 1–36, in the chapter's order | — | derived |
| 3 | Task | `checkbox` + locked label | All thirty-six task lines, verbatim | The tick, and nothing else. The wording is not editable — a reworded task is a different task and breaks the mapping to the roadmap | ch08 L261-308 |
| 4 | Owner | `owner (named person)` | — | One named individual per task. Thirty-six names, with repetition expected and concentration visible | derived |
| 5 | Target date | `date` | — | Real dates in the Pre-Transition block (it sits inside Weeks 1–4). **Provisional and locked in the Phase 1/2/3 blocks** until `WS-08-baseline-measurement-plan` is captured, and then bounded by that phase's range on `WS-08-transition-roadmap` | ch08 L259; ch08 L76 |
| 6 | Evidence of done | `free text` | — | What a third party would look at to agree this is finished. Not "completed" — the thing itself | derived |
| 7 | Evidence artefact reference | `free text` | — | Usually the completed worksheet, document or dashboard that proves it. A link, a filename or a sheet ID | derived |
| 8 | Status | `select` not started / in progress / done / not applicable | — | `not applicable` requires a written reason in column 9; it is the only status that needs defending | derived |
| 9 | Blocked by, or reason not applicable | `free text` | — | — | derived |
| 10 | Kit sheet that satisfies this task | `free text` | Pre-printed where the mapping is unambiguous: task 1 → `WS-06-team-readiness-scorecard` · task 2 → `WS-08-baseline-measurement-plan` · tasks 3, 4 and 5 → `WS-08-pilot-selection-and-scope` · task 7 → `WS-05-governance-readiness-assessment` · tasks 14 and 16 → `WS-08-phase-gate-exit-rollback` · tasks 21 and 25 → `WS-08-phase-gate-exit-rollback` · tasks 20 and 32 → `WS-05-board-reporting-scorecard` | Confirm, or write the local artefact that satisfies it instead | derived |
| 11 | Forward reference in the book | `free text`, locked | Task 6 → Chapter 2's evaluation framework · task 7 → Chapter 5 · task 8 → Chapters 9–10 for context-layer methodology · task 13 → the metrics section · task 18 → the Chapter 4 context moat · task 19 → the Chapter 5 governance framework | — | ch08 L266-267, L271, L284-285 |
| 12 | Roadmap band | `computed` | — | Derived from column 1; must resolve to exactly one phase band on `WS-08-transition-roadmap` | derived |
| 13 | Instrumentation level (task 36 only) | `select` Level 1 / Level 2 / Level 3 | Level 1 PR metadata — low effort, moderate accuracy, GitHub labels plus a weekly PR-analytics query · Level 2 annotation tags in workflow — medium effort, good accuracy, structured `[gen-start]`/`[gen-end]`/`[review-start]`/`[review-end]` tags in the task tracker · Level 3 git hooks and editor telemetry — higher effort, high accuracy, explicitly a Phase 3 investment that the chapter says not to attempt in the pilot | Which level we are starting at, and the tool that will produce the number | ch08 L226-232 |
| — | Pre-Transition page: transition lead | `owner (named person)` | Task 5 names both roles: executive sponsor and transition lead | Both named on the separable first page, at the top | ch08 L265 |
| — | Pre-Transition page: executive sponsor | `signature` | — | Signed on the day-one page. The Pre-Transition block is the only part of this sheet that is actionable before the roadmap is calibrated, and it should leave the room signed | ch08 L265 |

**Absorbed detail.** This sheet absorbed no other candidate. It is the task-level half of a matched
pair with `WS-08-transition-roadmap`: same five block names, same order, and column 12 asserts the
mapping mechanically so the two cannot drift silently. Where the roadmap carries ranges, owners
and gates, this carries tasks, dates and evidence — neither sheet restates the other's content.

**Deliberate omission.** No effort estimate, story-point or duration column per task. Duration is
a property of the phase band on the roadmap, calibrated once against org size and documentation
maturity; re-estimating it thirty-six times bottom-up produces a schedule that will contradict the
calibrated ranges and, being more granular, will be believed instead of them.

**Deliberate omission.** No percentage-complete roll-up for the Ongoing block. Its four tasks
recur by design; a completion percentage against them is the permanence assumption in numeric
form, and `WS-08-pitfall-risk-register` row 6 exists to catch exactly that.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-08-transition-roadmap` - The Transition Roadmap — Three Phases, Named Teams, Dated Gates (Pack G - The plan we leave with, fill order 5)
- `WS-08-pilot-selection-and-scope` - Pilot Selection and Scope Contract (Pack G - The plan we leave with, fill order 9)
- `WS-08-baseline-measurement-plan` - Baseline Measurement and Instrumentation Plan (Pack A - Groundwork (pre-work), fill order 4)

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** This is a terminal artifact — it is what the whole leadership kit produces. It consumes the outputs of nearly every other Part II worksheet.

## 8. Facilitation

| | |
|---|---|
| Who fills it | The transition lead, driving, with the executive sponsor present for the Pre-Transition page and the engineering managers who will supply the thirty-six names in column 4. This is the delivery lead's sheet — the sponsor's equivalent is `WS-08-transition-roadmap`, and running this one with only executives in the room produces a checklist owned by nobody who can execute it. |
| When in the session | Last. It is the terminal artefact of the whole kit and consumes `WS-08-transition-roadmap` (fill order 5), `WS-08-pilot-selection-and-scope` (9) and `WS-08-baseline-measurement-plan`. Running it earlier means guessing at columns 4, 5 and 10, and the guesses will not be revisited. |
| Duration | 60–75 minutes for the Pre-Transition and Phase 1 blocks, which are the only two anyone can honestly own today. Phases 2 and 3 and the Ongoing block are assigned owners in the room — about 20 minutes — but their dates are left provisional and closed out later by the transition lead. Do not attempt to date thirty-six tasks in one sitting. |
| Data needed in advance | The completed roadmap with its calibration header signed; the pilot contract; the baseline plan's status and Month 0 date; the organisation's holiday, freeze and release calendar for the next quarter, so Pre-Transition dates are survivable; the delivery tracker's export format, so the sheet's columns map to real ticket fields rather than being retyped. |
| Room format | Printed portrait, one page per block, taped in a row so the whole plan is visible at once and the concentration in column 4 becomes obvious. The Pre-Transition page is handed out separately at the start and collected signed at the end — it is the one page a participant can act on the next morning. |

**Facilitation note.** Run the ownership pass before the dating pass, and run it out loud: read
each task, ask "who", write the name. The value is not in the tasks — they are already written —
it is in watching where the names pile up. A plan where eleven of the thirty-six tasks belong to
the same staff engineer has already found pitfall 5, the missing middle, before it fired. Two
tasks reliably stall the room and should be pre-flagged: task 6 (tool selection) because the
organisation often has a de facto answer nobody has written down, and task 36 (the
generation-to-review ratio) because the room reaches for Level 3 telemetry when the chapter is
explicit that Level 3 is Phase 3 investment and should not be attempted in the pilot. Push it to
Level 1 and move on.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All thirty-six tasks carry a named individual in column 4.** No blanks, no team names, no
   "TBC". A task with no owner is a task that will be discovered undone at a gate.
2. **All seven Pre-Transition tasks carry a real date and evidence of done**, and the separable
   day-one page is signed by the executive sponsor with the transition lead named. The other
   blocks may leave column 5 provisional; this one may not.
3. **No Phase 1, 2 or 3 date is committed while `WS-08-baseline-measurement-plan` is
   incomplete.** Provisional dates are marked as such. Every committed date sits inside the range
   its phase band carries on `WS-08-transition-roadmap` — a task dated outside its band is either
   a wrong date or an uncalibrated roadmap, and both need resolving before the sheet ships.
4. **The five block names are byte-identical to `WS-08-transition-roadmap`, and column 12 resolves
   every task to exactly one band.** Zero orphans, zero tasks mapping to two bands. This is the
   mechanical check that the matched pair has not drifted.
5. **Every `not applicable` status carries a written reason in column 9.** It is the only status
   that requires defending, because it is the only one that removes work from the plan.
6. **Every task with a kit sheet named in column 10 points at a sheet that has actually been
   completed, or is in the pack with a fill order that precedes it.** A cross-reference to a sheet
   nobody will fill is a task with no owner wearing a disguise.
7. **Task 36 carries an instrumentation level in column 13 and the tool that will produce the
   number.** Level 3 selected during a pilot fails this criterion; the chapter is explicit that
   Level 3 is Phase 3 investment.
8. **Every task in column 6 has evidence that a third party could inspect.** "Done" in column 8
   with an empty column 6 is an assertion, and the point of this sheet is that it is the one
   artefact the organisation is left holding.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Already checkbox-formatted across five phase blocks - the closest thing in the book to a finished worksheet; it needs owner, target-date and evidence columns.
- **Fill (the organisation completing it): `L`.** L - needs the real repository, finance input or cross-team agreement

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> ALREADY CHECKBOX-FORMATTED. Every line is rendered as a markdown task checkbox, across five phase blocks — the closest thing in the entire book to a finished worksheet, and it needs owner/date/evidence columns rather than authoring. Structurally a list, not a table; source_form is recorded as numbered-phases because the five phase blocks are the organising structure. RELATIONSHIP TO THE ROADMAP: WS-08-transition-roadmap is the one-page strategic timeline for the exec conversation; this is its task-level expansion for the delivery lead. They are the same plan at two zoom levels — the synthesizer should ship them as a matched pair with identical phase names, not merge them, and must not let them drift. The Pre-Transition block (lines 259-267) is arguably the single highest-value fragment for a pre-groundbreaking kit and could be lifted out as a standalone day-one page. The template carries forward-references into Chapters 2, 5, 9, and 10, so the synthesizer should check whether those chapters' worksheets satisfy those line items and cross-link rather than duplicate.
