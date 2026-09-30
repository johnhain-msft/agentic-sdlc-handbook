# Agent Conflict Playbook: File, Semantic, Design

`WS-17-conflict-resolution-playbook` &middot; **Pack Z - Second wave: the practitioner kit** &middot; fill order **19** &middot; type `diagnostic` &middot; audience **practitioner** &middot; leadership priority **3**

> **Split back out in the re-opening pass.** Produces the named list of coordination-bottleneck files that constrains how waves may be partitioned; already a declared prerequisite of WS-18-wave-decomposition-plan, a different canonical.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A conflict playbook plus a named list of the repository's coordination-bottleneck files - the partitioning constraints that wave planning must respect.

**Cluster.** `CL-CONFLICT-PLAYBOOK` - Agent Conflict Playbook and Bottleneck-File Register

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch17-multi-agent-orchestration.qmd` |
| Chapter | Multi-Agent Orchestration |
| Heading | Conflict Resolution |
| Stable anchor | `#sec-multi-agent-conflict-resolution` |
| Lines | L273-322 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch17-multi-agent-orchestration.html#sec-multi-agent-conflict-resolution> |
| Locator quote | "Despite careful partitioning, conflicts arise. They fall into three categories" |

Resolve at any time with `python docs/resolve.py ws WS-17-conflict-resolution-playbook`.

## 3. Source extract - the scaffolding, verbatim

```text
  273 | Despite careful partitioning, conflicts arise. They fall into three categories, each with a different resolution strategy.
  274 | 
  275 | ### File Conflicts
  276 | 
  277 | Two agents need to modify the same file in the same wave. This is a planning error, not a runtime error.
  278 | 
  279 | **Resolution.** Merge the two tasks into a single agent's scope, or move one task to a later wave. If the modifications are to genuinely independent sections of a large file, a single agent can handle both sets of changes in one pass — it carries the context for both and applies edits sequentially.
  280 | 
  281 | Files that attract changes from multiple concerns are a signal. If `install.py` needs auth changes, logging changes, and type safety changes, that file is a coordination bottleneck. In the plan, assign it to a single agent per wave, even if that agent handles multiple concerns for that file.
  282 | 
  283 | ### Semantic Conflicts
  284 | 
  285 | Two agents produce output that is independently correct but mutually inconsistent. Agent A introduces a new error-handling pattern. Agent B, working on a different file, follows the old pattern because its instructions referenced the pre-change codebase.
  286 | 
  287 | **Resolution.** Foundation-before-migration wave ordering. Changes that establish new patterns (type definitions, utility functions, shared conventions) go in early waves. Changes that consume those patterns go in later waves. Agent B's instructions reference the committed output of Wave 0, not the original codebase.
  288 | 
  289 | This is why the wave model requires testing and committing after each wave. The committed state after Wave 0 is the ground truth for Wave 1 agents. If you skip the commit, Wave 1 agents work against stale context and semantic conflicts multiply.
  290 | 
  291 | #### Semantic Conflict Recovery: A Walkthrough
  292 | 
  293 | Prevention is the ideal. But when a semantic conflict slips through wave ordering, you need a recovery procedure, not a principle. The PR #394 execution hit exactly this case. Here is what happened.
  294 | 
  295 | Wave 0 established a new `OperationError` type in the resolver module — a structured error with fields for error code, operation name, and a recoverable flag. This replaced the previous pattern of raising bare `ValueError` with message strings. The architecture agent committed the new type, updated the resolver, and all Wave 0 tests passed.
  296 | 
  297 | Wave 1 dispatched a domain agent to migrate logging in three command modules. The agent's instructions referenced the committed Wave 0 codebase, but the dispatch prompt focused on logging patterns, not error handling. The domain agent correctly migrated all logging calls — and, in the process, added new error paths that used the old `ValueError` pattern. It had no reason to do otherwise. Its context included the logging migration guide, not the error-handling changes from Wave 0.
  298 | 
  299 | **Detection.** Wave 1's unit tests passed. The individual files were correct in isolation. But the integration test suite — run at the wave checkpoint — caught mixed error types. Callers updated in Wave 0 now expected `OperationError`. The new error paths added in Wave 1 raised `ValueError`. Three integration tests failed with unhandled exception types.
  300 | 
  301 | **Diagnosis.** The orchestrator reviewed the failures and identified the root cause in under two minutes: the Wave 1 dispatch prompt loaded the logging context but not the error-handling context. The agent had no visibility into the pattern change.
  302 | 
  303 | **Recovery.** The fix was not to revert Wave 1. The logging migration was correct. Instead, the orchestrator dispatched Wave 2b — two targeted agents:
  304 | 
  305 | 1. Agent 2b-A received the three command modules plus `OperationError`'s type definition. Its single task: replace every `ValueError` raise in the migrated files with the equivalent `OperationError`. Six files in context. Completed in 3 minutes.
  306 | 2. Agent 2b-B updated the corresponding test files to assert on `OperationError` fields instead of exception message strings.
  307 | 
  308 | Wave 2b committed, all tests passed, and execution continued to Wave 3.
  309 | 
  310 | **The lesson.** Wave ordering prevents most semantic conflicts. When one slips through, the recovery follows a pattern: identify which context was missing from the dispatch, create a targeted recovery wave that carries the missing context, and fix forward rather than reverting. The recovery wave is small — scoped to exactly the files affected by the missing context — and fast, because the agents start with clean sessions and concentrated context.
  311 | 
  312 | The mistake to avoid: redispatching the entire original wave. The logging migration was 90% correct. A full redo wastes the work and risks introducing new issues. Surgical recovery waves are the right response to surgical failures.
  313 | 
  314 | ### Design Conflicts
  315 | 
  316 | Two agents, each following their specialization's best practices, produce output that reflects genuinely different design philosophies. The architecture agent consolidates error handling into a central module. The domain agent keeps error handling local to each command because the domain's UX conventions require command-specific error messages.
  317 | 
  318 | **Resolution.** This is an escalation to the human. Design conflicts are not bugs. They are trade-offs that require judgment. The plan's priority-ordered principles resolve most of them mechanically: if UX is prioritized above architectural purity, the domain agent's approach wins. When the principles don't resolve the conflict, the human decides and documents the rationale.
  319 | 
  320 | The frequency of design conflicts is itself a metric. In the PR #394 execution ([case study](../case-study-apm-overhaul.qmd)), 3 human interventions were needed across ~25 agent dispatches. None were design conflicts between agents; all were judgment calls that the plan could not automate. The intervention rate was approximately 12%. We use 15–20% as a starting hypothesis for well-planned work, though this has not been validated across multiple teams. These thresholds are calibration points from our reference case study, not validated benchmarks. Rates significantly above 20% may indicate underspecified plans. Rates below 5% warrant scrutiny — the work may be too simple for multi-agent orchestration, or review may be insufficient.
  321 | 
  322 | ---
```

## 4. What the user fills

One block per conflict class. File conflicts: which files in our repo attract changes from multiple concerns (the coordination bottlenecks), and which agent owns each per wave. Semantic conflicts: what our foundation-before-migration ordering is, and what detection signal catches a mixed pattern (which test layer, run when). Design conflicts: who decides, and against which priority-ordered principles. Each block records the last occurrence and the resolution.

## 5. Field-level schema

Three parts. **Part A** is the bottleneck-file register — rows are files, and this part is the
carry-out that constrains `WS-18-wave-decomposition-plan`. **Part B** is the standing policy, one
block per conflict class, filled once. **Part C** is the ADAPT incident record — rows are incidents,
accruing over the life of the execution. Parts B and C print as a two-page playbook that lives in
the repository; Part A must be a live, sortable file, because a register that cannot be re-sorted by
path cannot be checked against a wave plan.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| A1 | File path | `free text` | Worked instance: `install.py` | Actual paths, evidenced from churn data | ch17 L281 |
| A2 | Concerns that touch it | `free text` (list) | Worked instance: auth changes, logging changes, type safety changes | The org's concerns, named from this sheet's team charter | ch17 L281 |
| A3 | Bottleneck? | `select` yes / watch / no | — | `yes` where more than one concern lands; `watch` where one does today and two are planned | ch17 L281 |
| A4 | Rule for this file | `select` | Default pre-ticked: single agent per wave, even if that agent handles multiple concerns for that file | Override to `split across waves` or `sequential within one agent` with a reason | ch17 L279, L281 |
| A5 | Owning agent or team, this wave | `free text` | — | One name per wave; blank means the file is unassigned and the wave cannot dispatch | ch17 L281 |
| A6 | Documented exception granted? | `checkbox` + `free text` | — | Ticked only with a written reason. An undocumented exception is a planning error dressed as a decision | cs-apm L115-117 |
| A7 | Split boundary, if split | `free text` | Worked instance: structural calls in one sub-wave, verbose calls in the next | The boundary this org used, stated so a dispatcher can apply it | cs-apm L141-144 |
| B1 | File conflicts — where a same-file collision is detected | `free text` | Pre-printed: this is a planning error, not a runtime error — it is caught by the partition check before dispatch, not by a test | The org's actual check, and who runs it | ch17 L277 |
| B2 | File conflicts — standing resolution | `select` (pre-filled) | Merge the two tasks into a single agent's scope, **or** move one task to a later wave | Which is this org's default, and who decides | ch17 L279 |
| B3 | File conflicts — last occurrence | `date` + `free text` | — | What happened and which resolution was used | org |
| B4 | Semantic conflicts — our foundation-before-migration ordering rule | `free text` | Pre-printed: changes that establish new patterns — type definitions, utility functions, shared conventions — go in early waves; changes that consume those patterns go in later waves | The org's rule, naming its own pattern-establishing artefacts | ch17 L287 |
| B5 | Semantic conflicts — commit after every wave | `checkbox` | Pre-printed: the committed state after Wave 0 is the ground truth for Wave 1 agents. Skip the commit and Wave 1 agents work against stale context | Ticked, or the deviation written down | ch17 L289 |
| B6 | Semantic conflicts — detection signal | `free text` (test layer + command + when it runs) | Worked instance: unit tests passed and individual files were correct in isolation; the integration suite, run at the wave checkpoint, caught the mixed error types | The org's actual layer and command. It must not be the unit suite alone | ch17 L299 |
| B7 | Semantic conflicts — recovery rule | `free text` (pre-printed, not editable) | "Identify which context was missing from the dispatch, create a targeted recovery wave that carries the missing context, and fix forward rather than reverting." And: "Surgical recovery waves are the right response to surgical failures." | Countersignature only | ch17 L310, L312 |
| B8 | Semantic conflicts — prohibited response | `free text` (pre-printed) | Redispatching the entire original wave. A full redo wastes correct work and risks introducing new issues | Countersignature only | ch17 L312 |
| B9 | Semantic conflicts — last occurrence | `date` + `free text` | — | What happened, and which context was missing | org |
| B10 | Design conflicts — who decides | `owner (named person)` | Pre-printed: this is an escalation to the human. Design conflicts are not bugs; they are trade-offs requiring judgement | A named individual | ch17 L318 |
| B11 | Design conflicts — priority-ordered principles | `free text` (ordered list) | Worked instance: if UX is prioritised above architectural purity, the domain agent's approach wins | The org's own principles, in priority order, sourced from `WS-18-plan-charter-and-principles` | ch17 L318 |
| B12 | Design conflicts — where the rationale is written when the principles do not resolve it | `free text` (path) | Pre-printed: the human decides *and documents the rationale* | The file or record where that documentation lands | ch17 L318 |
| B13 | Design conflicts — last occurrence | `date` + `free text` | — | What was decided, and which principle decided it | org |
| C1 | Incident ID and date | `free text` + `date` | — | — | ch18 L240-260 |
| C2 | DETECT — signal that fired | `select` red tests / agent stalled / dependency missed / other | The three named triggers are pre-printed | Which fired, plus a line of detail | ch18 L240 |
| C3 | DIAGNOSE — root cause | `free text` | — | The cause, in one sentence | ch18 L240-260 |
| C4 | DIAGNOSE — which context was missing from the dispatch | `free text` | Pre-printed as a required, separate question | The specific instruction file, committed artefact or convention the agent did not carry | ch17 L301, L310 |
| C5 | ADJUST — conservative move taken | `select` add task / split task / reorder wave | The three permitted moves are the only options offered | Which one, and its shape | ch18 L258 |
| C6 | EXECUTE — the re-run and its result | `free text` + `select` pass / fail | — | What was re-dispatched and what came back | ch18 L240-260 |
| C7 | Guardrail confirmation | three `checkbox` | Validation was not skipped · no unvalidated work was merged · the whole wave was not redispatched | All three ticked, or the incident did not follow the protocol | ch18 L258; ch17 L312 |
| C8 | Root-cause class | `select` planning defect / dispatch-context defect | — | Aggregated across incidents, this is what the log is for | derived from the absorbed member |
| — | Root-cause roll-up | `computed` (list) | — | Every C8 value collated, so the org can see whether its failures are planning defects or dispatch-context defects | derived |

**Absorbed detail.** `WS-18-adapt-loop-protocol` is carried entirely by Part C: DETECT at C2,
DIAGNOSE at C3 with its missing-context question broken out to its own column at C4, ADJUST at C5
restricted to exactly the three permitted moves, EXECUTE at C6, the guardrail block at C7, and the
aggregation its output depended on at C8 and the roll-up row. Its guardrail is preserved verbatim
from ch18 L258 and must be printed as a boxed rule immediately above C7:

> The key discipline: adaptation is conservative. You add tasks, split tasks, reorder waves. You do
> not skip validation. You do not merge unvalidated work. The checkpoint discipline holds even —
> especially — when things go wrong.

**Deliberate omission.** No escalation-rate, intervention-rate or human-touch field anywhere on the
sheet. The chapter prints an observed rate from a single execution, a starting hypothesis it has not
validated across teams, and two bands that it labels in its own words as "calibration points from
our reference case study, not validated benchmarks". A printed cell next to any of those numbers
converts a hypothesis into a target, and a team that is measured on its escalation rate will stop
escalating rather than stop needing to. If the organisation wants rate tracking, it builds that
instrument after a quarter of its own data, against its own baseline. Also omitted: the "90%
correct" figure from the worked recovery, which is a narrator's estimate of one migration.

## 6. Absorbed members (1)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-18-adapt-loop-protocol` - ADAPT Loop: Mid-Execution Recovery Protocol

- **Address.** `handbook\ch18-the-execution-meta-process.qmd` L240-260, The ADAPT Loop (`#sec-meta-adapt-loop`)
- **Why folded.** Same orchestrator, same recovery discipline, and its own note offers precisely this fold; the guardrail block -- add tasks, split tasks, reorder waves; never skip validation, never merge unvalidated work -- must be preserved verbatim.
- **Fill detail to absorb.** Work the four steps and record each: Detect (what signal fired - red tests, stall, missed dependency), Diagnose (root cause, and specifically what context was missing from the dispatch), Adjust (which conservative move was taken - add task, split task, reorder wave), Execute (the re-run and its result). A guardrail block confirms what was NOT done: validation skipped, unvalidated work merged, whole wave redispatched.
- **Its output was.** A recovery record per incident and a running log of root causes - which, aggregated, shows whether failures are planning defects or dispatch-context defects.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-17-agent-team-charter` - Agent Team Charter: Mapping Concerns Onto Owners (Pack Z - Second wave: the practitioner kit, fill order 18)

**Consumed by:**

- `WS-18-wave-decomposition-plan` - Wave Decomposition Plan and Self-Sufficiency Check (Pack Z - Second wave: the practitioner kit, fill order 21)

**Feeds into (prose, from the source scan).** WS-18-wave-decomposition-plan (bottleneck files force wave ordering) and WS-18-plan-charter-and-principles (design conflicts resolve against the principles block).

## 8. Facilitation

| | |
|---|---|
| Who fills it | Whoever will orchestrate the pilot's waves, plus two or three engineers with the longest memory of the repository — Part A needs people who know, without looking, which file everything eventually lands in. Add the holder of the priority-ordered principles, usually the engineering leader, for B10 to B12. |
| When in the session | Pack Z, after `WS-17-agent-team-charter`, whose territory field supplies the candidate files for Part A, and before `WS-18-wave-decomposition-plan`, which consumes Part A as a hard partitioning constraint rather than as advice. Filling it after the wave plan inverts the dependency and produces a register that rationalises a partition already chosen. |
| Duration | 60-75 minutes. Roughly 30 on Part A, and it is only worth that if it is done against real churn data rather than from memory. About 20 on the three policy blocks in Part B. Part C is a blank form: ten minutes to walk through, and it is filled at incidents, not in the session. |
| Data needed in advance | Read access to the repository for everyone in the room, and a churn listing prepared beforehand — the files touched by the most distinct concerns over the last six to twelve months. A `git log --name-only` roll-up is sufficient and takes minutes to produce. The completed team charters. The draft priority-ordered principles from `WS-18-plan-charter-and-principles` if it exists; if it does not, B11 is the prompt that starts it. |
| Room format | Part A built live in a spreadsheet or a repository file, projected — sortable, editable, and expected to gain rows after the session. Parts B and C printed as a two-page playbook that leaves the room, goes into the repository, and is opened when something breaks. A playbook nobody can find at 6pm on the day of a failed checkpoint is not a playbook. |

**Facilitation note carried from the source scan.** Reprint the semantic-conflict recovery
walkthrough at ch17 L293-312 verbatim on the reverse and read it aloud before filling Part B. It is
the only place in the book where a room can watch a green unit-test suite fail to catch a real
conflict: Wave 0 established a new structured error type, Wave 1's domain agent migrated logging
correctly and added new error paths using the old pattern because its context carried the logging
guide and not the error-handling change, the unit tests passed, and the integration suite at the
checkpoint caught it. Rooms take B6 seriously only after they have heard that. The two durable
lessons — fix forward with a targeted recovery wave carrying the missing context, and surgical
recovery waves for surgical failures — print as rules on the sheet, not as prose in a footnote.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **Part A names real paths from the real repository, evidenced from churn data.** An empty
   register is a claim that no file in the codebase attracts more than one concern. That claim is
   occasionally true and must then be evidenced, not asserted, because it is also the claim a room
   makes when it has not looked.
2. **Every file marked `yes` at A3 carries a rule (A4) and a named owning agent per wave (A5).** The
   default is one agent per wave; any other choice is written down with a reason.
3. **Every exception at A6 is documented, and every split at A4 carries a boundary at A7.** The
   reference execution carried exactly one exception to one-file-one-agent and documented it. An
   exception with no written reason is a partitioning failure that has been granted permission.
4. **B6 names a specific test layer and the command that runs it, and that layer is not the unit
   suite alone.** In the book's own worked case the unit tests passed, every file was correct in
   isolation, and only the integration suite at the wave checkpoint caught the conflict. A detection
   signal that would have missed the reference failure is not a detection signal.
5. **B5 is ticked, or the deviation from committing after every wave is written down.** Skipping the
   commit is the mechanism by which semantic conflicts multiply rather than occur.
6. **B10 is a named individual and B11 lists the principles in priority order.** An unordered list
   of values resolves nothing; the ordering is the entire mechanism by which a design conflict
   resolves without a meeting.
7. **The guardrail block is printed verbatim above C7, and all three confirmations are ticked for
   every recorded incident.** An incident record that cannot confirm all three did not follow the
   protocol — and surfacing that is precisely what the record is for, so the honest answer is to
   leave the box unticked rather than to tidy the record.

## 10. Integrity constraint

**Hedged figures reachable from this source range.** Each is listed with the book's own hedge, verbatim, and where that hedge lives. Present the figure as a pre-filled prior the organisation overwrites, or as a facilitation prompt - never as a benchmark, target or acceptance threshold. **Carry the hedge onto the sheet with the number; do not restate it in your own words.**

- **The intervention-rate bands: ~12% observed, 15-20% as a working hypothesis, >20% indicating underspecified plans, <5% warranting scrutiny in the other direction.**
  - *Appears at* `handbook\ch17-multi-agent-orchestration.qmd` L316-324
  - *The book's hedge (ch17 L320):* 'We use 15-20% as a starting hypothesis for well-planned work, though this has not been validated across multiple teams. These thresholds are calibration points from our reference case study, not validated benchmarks.'

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** Three conflict classes in prose; each block's fields and the bottleneck-file register need designing, though the worked recovery is reprintable verbatim.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Hits the brief's "failure modes a team should diagnose themselves against" case, and the chapter is unusually generous: the semantic-conflict recovery walkthrough at lines 291-312 is a full worked example (OperationError vs ValueError across waves, detected by integration tests at the checkpoint, fixed by a surgical Wave 2b rather than a revert) that can be reprinted verbatim as the facilitation case. The two durable lessons to print as rules: "identify which context was missing from the dispatch, create a targeted recovery wave that carries the missing context, and fix forward rather than reverting" (line 310) and "Surgical recovery waves are the right response to surgical failures" (line 312). Practitioner and post-launch, hence 3. OVERLAP: the wave-level version of the same recovery discipline is ch18's ADAPT loop (WS-18-adapt-loop-protocol) - this sheet is agent-output conflicts, that one is checkpoint failure; keep both but cross-reference. The bottleneck-file observation at line 281 is the piece that feeds wave planning.
