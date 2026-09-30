# Wave Decomposition Plan and Self-Sufficiency Check

`WS-18-wave-decomposition-plan` &middot; **Pack Z - Second wave: the practitioner kit** &middot; fill order **21** &middot; type `roadmap` &middot; audience **practitioner** &middot; leadership priority **3**

## 1. Purpose

**Output artifact.** An executable wave plan with verified file partitioning and no task that will stall mid-wave - the direct input to dispatch.

**Cluster.** `CL-WAVE-EXECUTION` - Wave Planning and Dispatch Kit

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch18-the-execution-meta-process.qmd` |
| Chapter | The Execution Meta-Process |
| Heading | Wave Decomposition |
| Stable anchor | `#sec-meta-wave-decomposition` |
| Lines | L138-180 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch18-the-execution-meta-process.html#sec-meta-wave-decomposition> |
| Locator quote | "The wave structure is where planning becomes engineering" |

Resolve at any time with `python docs/resolve.py ws WS-18-wave-decomposition-plan`.

## 3. Source extract - the scaffolding, verbatim

```text
  138 | The wave structure is where planning becomes engineering. A poorly decomposed set of waves produces merge conflicts, stale context, and cascading failures. A well-decomposed set produces clean parallel execution with natural validation boundaries.
  139 | 
  140 | ### The Dependency Graph
  141 | 
  142 | Waves are ordered by dependency. Wave 0 contains tasks with no dependencies: foundational changes that other waves build on. Wave 1 contains tasks that depend on Wave 0 outputs. Wave 2 depends on Wave 1. The dependency is directional and strict: no task in wave N may depend on a task in wave N+1.
  143 | 
  144 | ```{mermaid}
  145 | %%| fig-width: 4.5
  146 | %%| fig-cap: "Wave dependency chain: Foundation → Core → Migration → Polish"
  147 | %%| fig-alt: "Left-to-right flowchart showing a linear dependency chain of four waves: Wave 0 connects to Wave 1 labeled No deps, Wave 1 connects to Wave 2 labeled Wave 0 outputs, and Wave 2 connects to Wave 3 labeled Wave 1 stable. Each wave depends on the completion and tested stability of the previous wave."
  148 | %%| label: fig-wave-deps
  149 | flowchart LR
  150 |     W0["Wave 0"] -->|"No deps"| W1["Wave 1"]
  151 |     W1 -->|"Wave 0 outputs"| W2["Wave 2"]
  152 |     W2 -->|"Wave 1 stable"| W3["Wave 3"]
  153 | ```
  154 | 
  155 | The most common dependency pattern is foundation-before-migration. Type definitions, protocol changes, and method signatures go in Wave 0. Code that uses those new interfaces goes in Wave 1+. If you put both in the same wave, agents will try to both define and consume new APIs simultaneously, and the consumer agents will work against a file state that doesn't yet include the definitions.
  156 | 
  157 | ### The One-File-One-Agent Rule
  158 | 
  159 | The one-file-one-agent rule from Chapter 17 shapes wave design more than any other constraint. Within a wave, no two agents may edit the same file. If two logically independent changes both touch the same file, they go in separate waves, or they're assigned to a single agent that handles both changes in sequence.
  160 | 
  161 | ### Sizing Waves
  162 | 
  163 | The size of a wave affects execution time and risk. Smaller waves (2 to 4 agents) complete faster and are easier to debug when something goes wrong. Larger waves (6 to 10 agents) have higher throughput but are dominated by the slowest agent, and a single failure in a large wave means triaging more changes.
  164 | 
  165 | | Factor | Smaller waves (2-4 agents) | Larger waves (6-10 agents) |
  166 | |---|---|---|
  167 | | Execution time | 3-5 minutes | 8-12 minutes (slowest agent dominates) |
  168 | | Debug difficulty | Low — few changes to inspect | High — more changes interacting |
  169 | | Commit granularity | Fine — easy to bisect | Coarse — harder to isolate regressions |
  170 | | Overhead | Higher — more validation cycles | Lower — fewer cycles |
  171 | 
  172 | The decision heuristic: start with smaller waves. Combine tasks into larger waves only when they are genuinely independent (different files, different concerns, no shared state) and when the validation overhead of extra cycles outweighs the debugging advantage.
  173 | 
  174 | ### The Self-Sufficiency Test
  175 | 
  176 | Before finalizing a wave, apply this test to each task: can an agent complete this task without asking me a question? If the answer is no — because the task depends on an ambiguous design decision, because the scope is unclear, because the target file has undocumented conventions — the task isn't ready. Either refine the instructions, split the task, or move it to a later wave where its dependencies are resolved.
  177 | 
  178 | Tasks that fail the self-sufficiency test are the primary source of mid-wave escalations. Catching them during planning eliminates interruptions during execution.
  179 | 
  180 | ---
```

## 4. What the user fills

A wave table: wave number, tasks, the exclusive file list per agent, what it depends on from the previous wave, agent count, and the checkpoint criterion. Foundation work (types, protocols, shared conventions) is forced into Wave 0. Every file is checked for appearing under two agents in the same wave. Then each task is run through the self-sufficiency test - can an agent complete this without asking me a question? - and anything failing is refined, split, or moved to a later wave.

## 5. Field-level schema

Four parts, four different row semantics. **Part A** sizes the work — rows are candidate work items.
**Part B** is the wave table — rows are waves. **Part C** is the task table — rows are tasks, at the
session granularity an agent actually receives, one block per wave. **Part D** is the file-partition
check — rows are files, one row per file per wave, and it is the only part that proves the plan is
dispatchable. Parts A and B fit a projected page. Part C prints one sheet per epic. **Part D must be
a spreadsheet or a script run against the repository**, never a printed form: the duplicate
detection at D4 works by sorting on file path, and a printed table cannot be re-sorted.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| A1 | Work item | `free text` | — | The candidate unit of work, named | cs-apm L135-144 |
| A2 | Touchpoint type | `select` call sites / files / endpoints / other | — | What is being counted for this item | cs-apm L135-144 |
| A3 | Touchpoint count | `free text` (counted from the repository) | — | A count taken from the codebase, not estimated | cs-apm L135-144 |
| A4 | Per-agent ceiling — **starting calibration, re-measure after the first wave** | `free text` | One project's observed threshold: ~25 call sites, after a single dispatch carrying 58 in one file ran for 45+ minutes and stopped producing coherent edits. Printed with that sentence attached | The ceiling this team adopts to begin with | cs-apm L26 (the figure); cs-apm L135-144 (the evidence) |
| A5 | Sub-waves required | `computed` | — | A3 divided by A4, rounded up | cs-apm L141-144 |
| A6 | Split boundary used | `free text` | Worked instance: structural calls in one sub-wave, verbose calls in the next — a boundary of kind, not of line number | The boundary this team used, stated so a dispatcher can apply it | cs-apm L141-144 |
| A7 | **Re-measured ceiling after the first wave** | `free text` + `date` | — | The team's own observed ceiling, replacing A4. This column is the reason A4 is a prior and not a rule | derived; required by section 10 |
| B1 | Wave number | `select` 0, 1, 2, 3, … | Wave 0 is defined as tasks with no dependencies; the ordering is directional and strict | — | ch18 L142 |
| B2 | Wave name | `free text` | Two worked sets: Foundation → Core → Migration → Polish; and Foundation, Auth wiring, Logger wiring, Tests, Ship | The org's wave names | ch18 L146; cs-apm L105-111 |
| B3 | Parallel agent count | `free text` | The trade-off table is reprinted beside this column as a decision aid, with the heuristic: start with smaller waves; combine into larger ones only when tasks are genuinely independent — different files, different concerns, no shared state — and the validation overhead of extra cycles outweighs the debugging advantage | The count for this wave | ch18 L163-172 |
| B4 | Depends on | `select` (previous wave) | Pre-printed rule: no task in wave N may depend on a task in wave N+1 | Which committed output this wave builds on | ch18 L142 |
| B5 | Scope boundary | `free text` | Pre-printed: one file, one agent, per wave | The boundary for this wave, in its own terms | ch18 L159; cs-apm L115-117 |
| B6 | **Named checkpoint assertion** | `free text` | Pre-printed rejection rule: "tests pass" is not an acceptable entry | The observable behaviour, its observing command and expected output — authored in `WS-CS-APM-checkpoint-assertions` and transcribed here | cs-apm L207-210 |
| B7 | Commit made before the next wave starts | `checkbox` | Pre-printed: the committed state after a wave is the ground truth for the next wave's agents | Ticked, or the deviation written down | ch17 L289 |
| B8 | Documented exception to one-file-one-agent | `checkbox` + `free text` | The reference execution carried exactly one and documented it | Ticked only with a written reason | cs-apm L115-117 |
| C1 | Session / task number | `free text` | Shape from the worked five-session table | — | ch13 L509-523 |
| C2 | The task, in one sentence | `free text` | Worked instances are one line each, verb first, scope explicit | The task | ch13 L509-523 |
| C3 | Key context to load | `free text` (list) | Worked instances name the instruction file, the prior session's output, and the external reference — three items, not twelve | The context this session loads | ch13 L509-523 |
| C4 | Single deliverable | `free text` (path) | Worked instances are file paths or a named test suite — one deliverable per session | The deliverable | ch13 L509-523 |
| C5 | Exclusive file list for this task | `free text` (paths) | — | Feeds Part D. Must not overlap another task in the same wave | ch18 L159 |
| C6 | **Self-sufficiency verdict** | `select` self-sufficient / not ready | The test, printed verbatim: *can an agent complete this task without asking me a question?* | The verdict, given by someone other than the task's author | ch18 L176 |
| C7 | If not ready, why | `select` ambiguous design decision / unclear scope / undocumented conventions in the target file / other | The chapter's three named causes are the first three options | Which cause, plus a line | ch18 L176 |
| C8 | Action taken | `select` refine the instructions / split the task / move to a later wave | The chapter's three permitted responses are the only options offered | Which was taken | ch18 L176 |
| C9 | Path whitelist enforced for this session | `free text` (paths) | Worked instance: a session restricted to two directories, where the agent began extending its change into a third and the boundary stopped it — the suggestion was reported in its summary and handled later by the agent that had the right context | The whitelist, expressed as the agent's tooling enforces it | ch13 L495-497, L525-529 |
| C10 | Hand-off contract to the next session | `free text` | Worked instance: the downstream session received only the API contract — endpoint URLs, request and response shapes — not the implementation details | What the next session receives, and what it deliberately does not | ch13 L523 |
| D1 | File path | `free text` | — | One row per file per wave | ch18 L159 |
| D2 | Wave | `select` | — | — | ch18 L142 |
| D3 | Agent | `free text` | — | — | ch18 L159 |
| D4 | Appears under another agent in this wave? | `computed` yes / no | — | Any `yes` is a blocking planning error, not a risk to accept | ch17 L277 |
| D5 | Resolution if yes | `select` merge into a single agent's scope / move one task to a later wave | The chapter's two resolutions are the only options offered | Which was applied | ch17 L279 |
| — | Dispatch readiness | `computed` | — | Green only when every D4 reads `no`, every C6 reads `self-sufficient`, and every B6 is non-empty and is not a paraphrase of "tests pass" | derived |

**Absorbed detail.** All three merged members are visible and separately addressable.
`WS-CS-APM-wave-plan` is carried by Part B: the wave name at B2, the parallel agent count at B3, the
one-file-one-agent-per-wave scope boundary at B5, its single documented exception at B8, and —
the column its own description singles out as critical — the named checkpoint assertion at B6.
`WS-CS-APM-context-budget` is carried by Part A in full: touchpoints counted at A3, divided by the
per-agent ceiling at A4, reading off the sub-waves required at A5, with the split boundary at A6 and
the re-measurement at A7. `WS-13-session-decomposition-plan` is carried by Part C: its four-column
session table is C1 to C4 exactly — session number, the task in one sentence, key context to load,
single deliverable — its sizing test is the same self-sufficiency test at C6 to C8, and its
scope-creep counter-example is carried as two fields rather than as an anecdote, the enforced path
whitelist at C9 and the deliberately narrow hand-off contract at C10.

**Deliberate omission.** No execution-time column on the wave table, and no field in which a team
records a target duration for a wave. The chapter's sizing table prints observed times for small and
large waves and those times are reprinted beside B3 **as an exhibit within the trade-off table they
belong to** — where they sit alongside debug difficulty, commit granularity and overhead, and are
plainly one input among four. A standalone duration cell would strip that context and invite the
room to plan to a clock it has never measured. Also omitted: total agent count, total file count and
any planned-versus-actual file reconciliation, all of which belong to `WS-CS-APM-plan-gate`.

## 6. Absorbed members (3)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-13-session-decomposition-plan` - Session Decomposition Plan

- **Address.** `handbook\ch13-the-prose-specification.qmd` L509-523, The task decomposition (`#sec-prose-task-decomposition`)
- **Why folded.** The canonical's task rows at session granularity, governed by the identical self-sufficiency test; contributes the four-column session table and the scope-creep counter-example.
- **Fill detail to absorb.** Take one real epic and fill the chapter's four-column table: session number, the task stated in one sentence, the key context that must be loaded, and the single deliverable. Then apply the sizing test to each row — could the agent finish this without asking a follow-up question? — and split any row that fails.
- **Its output was.** A decomposed delivery plan of agent-sized sessions with one deliverable each: the pilot's executable work breakdown.

### `WS-CS-APM-context-budget` - Context Budget Sizing Calculator

- **Address.** `case-study-apm-overhaul.qmd` L135-144, 1. The install.py Agent (Anti-pattern #11: Context Window Exhaustion) (`#sec-cs-apm-context-exhaustion`)
- **Why folded.** The arithmetic behind the canonical's own agent-count column (touchpoints / per-agent ceiling = sub-waves); same fill, same person, same sitting.
- **Fill detail to absorb.** Per candidate work item: count the touchpoints (call sites, files, endpoints), divide by the per-agent ceiling the team adopts (the case uses ~25 and shows 58 failing), and read off the number of sub-waves required. Includes a column for the split boundary used.
- **Its output was.** A sized decomposition showing how many agents and waves each work item needs, with any item over the ceiling pre-split.

### `WS-CS-APM-wave-plan` - Wave Plan Canvas

- **Address.** `case-study-apm-overhaul.qmd` L101-119, Wave Execution (`#sec-cs-apm-wave-execution`)
- **Why folded.** The same wave table at case-study resolution; contributes the named-checkpoint-assertion column and the one-file-one-agent-per-wave rule with its single documented exception.
- **Fill detail to absorb.** One row per planned wave: wave name, parallel agent count, scope boundary (the one-file-one-agent-per-wave rule), and - critically - the named checkpoint assertion that must pass before the next wave starts.
- **Its output was.** A wave-by-wave execution plan with explicit checkpoints, ready to hand to whoever orchestrates the pilot.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-18-plan-charter-and-principles` - The Plan Charter: Scope, Teams, Waves, Principles, Constraints (Pack G - The plan we leave with, fill order 1)
- `WS-17-conflict-resolution-playbook` - Agent Conflict Playbook: File, Semantic, Design (Pack Z - Second wave: the practitioner kit, fill order 19)

**Consumed by:**

- `WS-CS-APM-checkpoint-assertions` - Definition of Done: Behavioural Checkpoint Assertions (Pack Z - Second wave: the practitioner kit, fill order 22)

**Feeds into (prose, from the source scan).** Dispatch execution via WS-17-dispatch-brief-template; failures route to WS-18-adapt-loop-protocol.

## 8. Facilitation

| | |
|---|---|
| Who fills it | The person who will orchestrate the waves, plus an engineer from **every** human team whose files appear in Part D. Part D cannot be completed by one person: it requires agreement about who owns which path, and that agreement is the expensive part of this sheet. Add a tech lead with the standing to arbitrate when two teams both claim a file, because someone will. |
| When in the session | Pack Z, late — second to last. It needs the plan charter from Pack G, the approved plan from `WS-CS-APM-plan-gate`, the bottleneck register from `WS-17-conflict-resolution-playbook` and the territory columns from `WS-17-agent-team-charter`. It produces the wave list and checkpoint cells that `WS-CS-APM-checkpoint-assertions` then fills properly. Attempting it before the pilot's scope is fixed produces a plan for work nobody has approved. |
| Duration | **This is not a single-session sheet, and pretending otherwise is the most common way it fails.** Parts A and B fit a 90-minute working session. Part C takes roughly a working day per epic. Part D is done against the repository, asynchronously, and finishes only when the ownership disagreements are settled. Budget the session for A and B, then schedule a named follow-up to close C and D before any dispatch. |
| Data needed in advance | The real repository, cloned and readable by everyone in the room, with a churn listing for the target modules. The completed bottleneck register and team charters. And the item that actually gates completion: **a prior cross-team agreement, or a named arbiter, for every file that two teams both claim.** This sheet is near-free to build and heavy to fill precisely because the cost is not in the printing — it is in the ownership negotiation the sheet forces into the open. A room that has not been warned will discover mid-session that it cannot finish, and the honest response is to stop at Part B and reconvene rather than to guess at Part D. |
| Room format | Parts A and B projected and filled live, with the wave-sizing trade-off table visible beside B3. Part C printed, one sheet per epic, and worked through task by task. Part D built in a spreadsheet or generated by a script against the repository — sortable by path, because sorting by path is how D4 actually detects anything. |

**Facilitation note carried from the source scan.** Run the self-sufficiency test aloud, task by
task, with the question phrased exactly as the chapter phrases it — *can an agent complete this task
without asking me a question?* — and answered by somebody other than the task's author. Authors say
yes to their own tasks almost without exception, because the missing context is in their head and is
therefore invisible to them. The chapter is unusually direct about the stakes: tasks that fail this
test are the primary source of mid-wave escalations, and catching them during planning eliminates
interruptions during execution. That single pass is the largest return this sheet produces. Note
also that the first time a team runs this whole process end to end it should expect to take
substantially longer than a practised run — the chapter's own guidance is roughly three times, and
it frames the first run as an investment in instrumentation that makes later runs faster. Say so at
the start, so a slow first pass reads as expected rather than as failure.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **No file appears under two agents in the same wave.** Part D is sorted by file path and every
   duplicate is resolved before the plan is dispatchable — merged into a single agent's scope, or
   moved to a later wave. This is a planning error rather than a runtime one, which means it is
   cheap to fix here and expensive everywhere after here.
2. **Every task in Part C carries a self-sufficiency verdict, and no task still reading `not ready`
   remains in a dispatchable wave.** Each one has been refined, split or moved, with the action
   recorded at C8. Tasks that fail this test are the primary source of mid-wave escalations; leaving
   one in the plan is choosing an interruption later instead of five minutes now.
3. **The dependency column reads cleanly top to bottom.** Wave 0 contains only tasks with no
   dependencies, and no task in wave N depends on a task in wave N+1. A backwards arrow is a
   blocking defect, not a scheduling preference.
4. **Every wave's checkpoint at B6 names an observable behaviour, the command that observes it and
   the expected output.** An entry reading "tests pass", "green build" or any paraphrase is rejected
   and routed to `WS-CS-APM-checkpoint-assertions` before the wave may be dispatched. The book's own
   evidence for this criterion is a suite of 2,829 passing tests, none of which asserted that a
   feature produced any output at all.
5. **Every wave carries a commit-before-next-wave tick at B7**, or the deviation is written down. The
   committed state after a wave is the next wave's ground truth; skipping it hands the next wave
   stale context and makes semantic conflicts multiply rather than merely occur.
6. **The per-agent ceiling has been re-measured against this team's own work and recorded at A7 with
   a date** — or the sheet is visibly marked as still carrying a borrowed starting calibration. A
   team that completes its pilot still using the figure it was given has not performed the sizing
   calculation; it has copied one project's observed threshold and printed it as a rule.
7. **Every exception to one-file-one-agent at B8 is written down with a reason.** The reference
   execution carried exactly one exception across five waves and documented it; an undocumented
   exception is a partitioning failure that has quietly been granted permission.

## 10. Integrity constraint

**Named rule for this sheet.** The ~25-call-sites-per-agent split is one project's observed threshold. It seeds the sheet as calibration, never as a standard.

**Hedged figures reachable from this source range.** Each is listed with the book's own hedge, verbatim, and where that hedge lives. Present the figure as a pre-filled prior the organisation overwrites, or as a facilitation prompt - never as a benchmark, target or acceptance threshold. **Carry the hedge onto the sheet with the number; do not restate it in your own words.**

- **The evidence behind the ~25 threshold: install.py's 58 `_rich_*` call sites stalling a single agent, and the context-budgeting lesson drawn from it.**
  - *Appears at* `case-study-apm-overhaul.qmd` L133-145
  - *The book's hedge (case-study-apm-overhaul.qmd L135-144):* A single file in a single project. The number that generalises is the practice - count touchpoints before dispatch - not the threshold.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** The wave table, the wave-sizing trade-off table (ch18 L165-172) and the self-sufficiency test are all printed. Near-free to BUILD; the effort-L rating is fill load, not build cost.
- **Fill (the organisation completing it): `L`.** L - needs the real repository, finance input or cross-team agreement

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> SINGLE CANDIDATE FOR A DUPLICATED TOPIC - the synthesizer must not create a second wave-planning worksheet from ch17. Wave planning appears in both of my chapters: ch17 lines 156-244 ("Parallelization Strategies": the one-file-one-agent rule with its safe/unsafe table at lines 168-174, wave-based parallelism, the wave-dependency and gantt mermaids, and pipeline parallelism at line 245) and ch18 lines 138-180 (dependency graph, one-file-one-agent restated, the wave-sizing trade-off table at lines 165-172, and the self-sufficiency test at lines 174-180). This row covers both; ch18 is the better anchor because it adds the sizing table and the self-sufficiency test. Effort is L because it needs the real repository and cross-team input on file ownership. Sizing guidance to print: start small (2-4 agents, 3-5 min) and combine only when tasks are genuinely independent; the self-sufficiency test at line 180 is the highest-yield line in the section - failing tasks are "the primary source of mid-wave escalations."
