# Orchestration Topology Selector: Which Patterns Do We Sanction?

`WS-17-orchestration-topology-selector` &middot; **Pack D - Architecture and ownership** &middot; fill order **6** &middot; type `decision` &middot; audience **architect** &middot; leadership priority **1**

> **Split back out in the re-opening pass.** An organisation-wide sanctioned-topology standard carrying the recursion-depth and fan-out bounds the harness must enforce; contested-merge #9 named exactly this as the split-back condition.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A sanctioned-topology table: work class, topology, recursion depth, max fan-out, enforcing harness - the reference architecture for how the org runs agents.

**Cluster.** `CL-TOPOLOGY-STANDARD` - Orchestration Topology Standard and Recursion Bounds

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch17-multi-agent-orchestration.qmd` |
| Chapter | Multi-Agent Orchestration |
| Heading | Agent Specialization Patterns |
| Stable anchor | `#sec-multi-agent-specialization` |
| Lines | L50-154 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch17-multi-agent-orchestration.html#sec-multi-agent-specialization> |
| Locator quote | "The key insight behind multi-agent orchestration is that specialization produces better results" |

Resolve at any time with `python docs/resolve.py ws WS-17-orchestration-topology-selector`.

## 3. Source extract - the scaffolding, verbatim

```text
   50 | The key insight behind multi-agent orchestration is that specialization produces better results than generalization — for the same reason that a team of specialists outperforms a team of generalists on complex projects. A security expert and a logging expert, each working within their domain, produce more reliable output than a single agent told to "handle security and logging."
   51 | 
   52 | Specialization works because it reduces the context each agent needs to carry. An architecture agent loaded with type definitions, module boundaries, and architectural patterns does not also need logging conventions, output formatting rules, and symbol dictionaries. The context it receives is concentrated, not diluted.
   53 | 
   54 | Three specialization patterns recur across most multi-agent workflows.
   55 | 
   56 | ### Pattern 1: Writer / Reviewer / Tester
   57 | 
   58 | The most common pattern separates code production from code validation. One agent writes the code. A second agent reviews it. A third writes or updates tests.
   59 | 
   60 | ```{mermaid}
   61 | %%| fig-width: 4.5
   62 | %%| fig-cap: "Writer, Reviewer, Tester pattern"
   63 | %%| fig-alt: "Flowchart showing a three-stage pipeline: Writer agent produces code changes, which flow to Reviewer agent that identifies bugs, logic errors, and security issues, which then flow to Tester agent that produces test updates and verification, ending at Verified output."
   64 | %%| label: fig-writer-reviewer-tester
   65 | flowchart TD
   66 |     W["Writer agent"] -->|"Code changes"| R["Reviewer agent"]
   67 |     R -->|"Findings: bugs,<br/>logic errors, security"| T["Tester agent"]
   68 |     T -->|"Test updates +<br/>verification"| Done["Verified output"]
   69 | ```
   70 | 
   71 | This pattern maps directly to the human workflow of author, reviewer, and QA — and for the same reason. The writer optimizes for correctness and completeness. The reviewer optimizes for catching what the writer missed. The tester optimizes for verifiable behavior. These are different cognitive tasks that benefit from different contexts.
   72 | 
   73 | In practice, the reviewer agent receives the diff plus the original source, not the writer's full conversation history. This is deliberate. The reviewer should evaluate the output on its own merits, not be anchored by the writer's reasoning. If the writer had a good reason for a decision but the code doesn't reflect it, that is a signal, not an excuse.
   74 | 
   75 | ### Pattern 2: Domain Teams {#sec-multi-agent-domain-teams}
   76 | 
   77 | For cross-cutting changes, organize agents by area of expertise rather than by workflow stage. Each team owns a concern and is responsible for all files related to that concern.
   78 | 
   79 | | Aspect | Architecture Team | Domain Expert Team |
   80 | |--------|-------------------|---------------------|
   81 | | **Context loaded** | Type definitions, Module boundaries, Pattern catalog, Dependency graph | Output conventions, Symbol dictionaries, UX guidelines, Migration patterns |
   82 | | **Owns** | Type safety fixes, Dead code removal, API consolidation | Verbose coverage, Logger migration, Formatting cleanup |
   83 | 
   84 | In the auth-logging overhaul ([PR #394](https://github.com/microsoft/apm/pull/394), detailed in the [case study](../case-study-apm-overhaul.qmd) and summarized in Chapter 18), this two-team structure (architecture team led by an architect agent, domain team led by a logging expert agent) handled a 75-file change across five concerns. The architecture team carried type definitions and architectural patterns. The domain team carried output conventions and migration examples. Neither team needed the other's context, and both produced output consistent with their specialization.
   85 | 
   86 | This pattern scales by adding teams. A security concern adds a security team. A documentation concern adds a documentation team. Each team brings its own specialized context, its own instruction files, and its own validation criteria. The coordination cost is between teams, not within them.[^ch15-genesis-panel]
   87 | 
   88 | #### Concrete Dispatch: What It Actually Looks Like {#sec-multi-agent-dispatch-example}
   89 | 
   90 | The Domain Teams pattern describes structure. Here is what a dispatch actually looks like in practice: the instruction files, the prompt, and the file list. This example uses a terminal-based agent, but the pattern applies regardless of tool.
   91 | 
   92 | Before dispatching, the orchestrator prepares three things: the instruction files the agent will load, the file list it owns exclusively, and the task prompt.
   93 | 
   94 | **Instruction files loaded into context:**
   95 | 
   96 | ```text
   97 | .ai/instructions.md              # Project-wide conventions (always loaded)
   98 | .ai/integrations/logging.md      # Logging-specific patterns and examples
   99 | ```
  100 | 
  101 | **The dispatch prompt:**
  102 | 
  103 | ```text
  104 | Migrate the following files from print-based output to the structured
  105 | logger established in Wave 0. Use the LoggerFactory pattern from
  106 | src/core/logger.py (committed and tested).
  107 | 
  108 | Files assigned to you (exclusive ownership this wave):
  109 |   - src/commands/install.py
  110 |   - src/commands/resolve.py
  111 |   - src/commands/validate.py
  112 | 
  113 | Constraints:
  114 |   - Do NOT modify any file not in this list.
  115 |   - Do NOT change function signatures or public APIs.
  116 |   - Preserve all existing behavior — update log output only.
  117 |   - Use _rich_info() for informational messages, _rich_warning()
  118 |     for warnings. See .ai/integrations/logging.md for examples.
  119 | 
  120 | When complete, run: pytest tests/commands/ -x
  121 | Fix any failures before reporting done.
  122 | ```
  123 | 
  124 | **What makes this dispatch effective:**
  125 | 
  126 | - **Exclusive file list.** The agent knows exactly which files it owns. No ambiguity, no overlap with other agents in this wave.
  127 | - **Committed reference.** "Established in Wave 0" means the agent reads the actual committed code, not a description of what it should look like.
  128 | - **Scoped instructions.** Two instruction files, not twelve. The agent carries logging conventions and project conventions. It does not carry type system rules, security policies, or deployment procedures irrelevant to this task.
  129 | - **Built-in validation.** The prompt ends with a test command. The agent self-validates before reporting completion (L1 self-heal).
  130 | - **Explicit constraints.** "Do NOT modify any file not in this list" is the one-file-one-agent rule, stated in the agent's own terms.
  131 | 
  132 | The orchestrator dispatches this prompt in a fresh session, monitors for completion or escalation, and moves to the next dispatch. Total orchestrator time per dispatch: roughly 2-3 minutes to prepare the prompt and file list, plus monitoring time shared across all active agents in the wave.
  133 | 
  134 | ### Pattern 3: Audit / Execute / Validate
  135 | 
  136 | For exploratory work where the scope is not fully known in advance, separate the agents that discover what needs to change from the agents that make the changes.
  137 | 
  138 | ```{mermaid}
  139 | %%| fig-width: 4.5
```

*(15 further lines in range; read the file for the remainder.)*

## 4. What the user fills

For each class of work the org actually does (routine feature change, cross-cutting refactor, exploratory modernisation, review, incident response), the team selects the sanctioned topology - Writer/Reviewer/Tester, Domain Teams, Audit/Execute/Validate, or single-agent - and records the declared recursion depth and maximum fan-out for each, plus which harnesses can actually enforce that bound.

## 5. Field-level schema

Rows in block A are the classes of work this organisation actually does. Block B is a printed
reference transcribed from the chapter's three pattern diagrams and its Domain Teams table; it is
read, not filled, except for the org's own instantiation at column 14. The sheet is A3 landscape
with the three pattern diagrams reproduced across the head of the page.

**Block A — the sanctioned-topology standard.**

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Class of work | `select` (starter list, editable) + free rows | Routine feature change / Cross-cutting refactor / Exploratory modernisation / Code review / Incident response | The org's own classes, in its own words | derived |
| 2 | Sanctioned topology | `select` | Single agent / Writer-Reviewer-Tester / Domain Teams / Audit-Execute-Validate | One per class | ch17 L56, L75, L134 |
| 3 | Composition-pattern name | `select` Panel / Wave / Scatter-Gather / Subagent | Pre-filled **Panel** for Domain Teams only — the chapter's own footnote names it so. The other three mappings are deliberately left open | Which of the four names the chosen topology instantiates here | ch09 L73; ch17 L475 |
| 4 | Declared recursion depth | `free text` (the org's own integer) | — | **The book supplies no number.** The organisation declares one and starts low | ch17 L12 |
| 5 | Maximum fan-out | `free text` (the org's own integer) | — | As above. An undeclared fan-out is a fan-out tree nobody can price or audit | ch17 L12 |
| 6 | Declared at the dispatch site? | `checkbox` | — | The bound must be declared where the dispatch happens, not only in this document | ch17 L12 |
| 7 | Enforcing harness | `select` (from `WS-APXA-harness-selection-matrix` block A) | — | The harness that will actually enforce the bound. `None` is a valid answer and a disqualifying one | ch17 L12 |
| 8 | Enforcement status | `select` Verified / Asserted / Not enforceable | — | `Verified` means somebody tried to exceed the bound and the harness stopped them | derived |
| 9 | Sanctioned by / date | `owner (named person)` + `date` | — | This is an organisation-wide standard; it needs a signature | derived |

**Block B — topology reference (printed, read-only except column 14).**

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 10 | Topology | `select` (fixed 4) | Single agent / Writer-Reviewer-Tester / Domain Teams / Audit-Execute-Validate | — | ch17 L56, L75, L134 |
| 11 | Stages, and what passes between them | `free text` (printed, transcribed from the diagrams) | **Writer-Reviewer-Tester** — Writer agent →*code changes*→ Reviewer agent →*findings: bugs, logic errors, security*→ Tester agent →*test updates + verification*→ Verified output. **Audit-Execute-Validate** — Audit agents (read-only) →*findings: files, severity, recommendations*→ Planning (human decision) →*scoped tasks with file assignments*→ Execution agents (read-write) →*code changes*→ Validation agents (read-only) →*review findings, test results*→ Ship. **Domain Teams** — parallel teams, each owning a concern and every file related to it; the pattern scales by adding a team per concern. **Single agent** — no stages | — | ch17 L65-68, L139-152, L77-86 |
| 12 | The constraint that makes the topology work | `free text` (printed) | **Writer-Reviewer-Tester** — the reviewer receives the diff plus the original source, *not* the writer's conversation history, so it evaluates the output on its own merits rather than being anchored by the writer's reasoning. **Audit-Execute-Validate** — audit and validation agents are read-only and can therefore be dispatched in parallel over the same files with no risk of interference; only execution agents hold write, and the human decision between audit and execution is the highest-impact point in the process. **Domain Teams** — neither team needs the other's context; the coordination cost is between teams, not within them | — | ch17 L73, L154-156, L84-86 |
| 13 | Domain Teams reference split | `free text` (printed) | **Architecture team** — context loaded: type definitions, module boundaries, pattern catalogue, dependency graph. Owns: type-safety fixes, dead-code removal, API consolidation. **Domain expert team** — context loaded: output conventions, symbol dictionaries, UX guidelines, migration patterns. Owns: verbose coverage, logger migration, formatting cleanup | — | ch17 L79-82 |
| 14 | Our instantiation | `free text` | — | For each topology the org sanctions: our team names, our concerns, and the exclusive file-ownership boundary per team | ch17 L108-130 |

**Block C — per-workflow recursion policy (absorbed).** One row per intended agent workflow.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 15 | Intended agent workflow | `free text` | — | Named, one row each | ch09 L65-69 |
| 16 | Composition pattern | `select` Panel / Wave / Scatter-Gather / Subagent | Definitions printed: **Panel** — a Mediator with a Scatter-Gather distribution; specialist threads review the same artefact in parallel and a synthesiser reconciles their findings into one decision. **Wave** — a Pipeline; one thread's output becomes the next thread's input. **Scatter-Gather** — fan out, collect, return, with no synthesis lens on top. **Subagent** — any thread the harness spawns with its own context budget | — | ch09 L73 |
| 17 | Maximum dispatch depth | `free text` | — | The org's own value; must not exceed column 4 for the matching work class | ch09 L69; ch17 L12 |
| 18 | Context budget per thread | `free text` | — | Expressed in whatever unit the harness exposes | ch09 L69 |
| 19 | The eval that gives the parent a stop condition | `free text` | Convention printed: every Skill carries an eval, so the parent has a stop condition | The actual eval, named and located | ch09 L69 |
| 20 | Path where the dispatched plan is persisted | `free text` | Convention printed: every dispatch persists its plan, so the parent can read the artefact instead of re-dispatching | The actual path | ch09 L69 |

**Block D — Panel guardrails (printed).** Filled only where a sanctioned topology is Panel.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 21 | Anti-pattern | `select` (fixed 3, printed verbatim) | PANEL-WITHOUT-SYNTHESIS / PANEL-IN-ONE-CONTEXT / IMBALANCED PANEL | — | ch17 L475 |
| 22 | What it looks like | `free text` (printed) | **PANEL-WITHOUT-SYNTHESIS** — N lenses then a concatenation; the user reads N reports instead of one decision. **PANEL-IN-ONE-CONTEXT** — the dominant senior-engineer failure: all N lenses played sequentially in a single window, each contaminating the next. **IMBALANCED PANEL** — the dissenting lens is the highest-information signal; the synthesis ignores it | — | ch17 L475 |
| 23 | Our control against it | `free text` | — | One per anti-pattern. For the second, the control is structural: separate contexts, not sequential prompting | ch17 L475 |
| 24 | Named synthesiser | `owner (named person)` or named arbiter agent | Reference: a synthesiser — human or named arbiter agent — reconciles the findings into one decision | Who or what it is here | ch17 L10 |

**Absorbed detail.** `WS-09-orchestration-policy-matrix` is block C in full — one row per intended
workflow, the composition pattern at column 16, the maximum dispatch depth at 17, the context
budget per thread at 18, the eval that gives the parent a stop condition at 19, and the
plan-persistence path at 20. Its four pattern definitions are printed in column 16 rather than
kept as facilitator notes, because the four names recur across Pack D and a room that has not
seen them will use "panel" loosely.

**Deliberate omission.** The sheet prints **no recommended depth and no recommended fan-out.** The
chapter is emphatic that the bound must be declared at the dispatch site and enforced by the
harness, and equally clear that it "is not a tuning parameter" — but it supplies no value, and
printing one would convert an architectural constraint into a benchmark the organisation would
then treat as validated. Columns 4 and 5 are blank by design. The chapter's orchestrator-time
observation (roughly two to three minutes to prepare a dispatch prompt and file list) is likewise
kept out of the fields: it derives from the single PR #394 execution, and it belongs in
`WS-17-coordination-tax-calculator` as a prior to be replaced, not here as a planning constant.

## 6. Absorbed members (1)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-09-orchestration-policy-matrix` - Multi-Agent Orchestration Policy Matrix

- **Address.** `handbook\ch09-part-iii-preface.qmd` L65-69, One rule, applied recursively (`#sec-part-iii-preface-recursion`)
- **Why folded.** Its own note names ch17 the canonical home and says merge rather than ship both; contributes the per-workflow policy columns (composition pattern, max depth, context budget per thread, eval, plan-persistence path).
- **Fill detail to absorb.** One row per intended agent workflow; columns: composition pattern (Panel / Wave / Scatter-Gather / Subagent), maximum dispatch depth, context budget per thread, the eval that gives the parent a stop condition, and the path where the dispatched plan is persisted.
- **Its output was.** A written recursion-governance policy naming the depth bound, the eval requirement and the plan-persistence rule per workflow.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-APXA-harness-selection-matrix` - Harness Selection and Portability Matrix: What We Standardise On, and What It Costs Us (Pack D - Architecture and ownership, fill order 5)

**Consumed by:**

- `WS-17-agent-team-charter` - Agent Team Charter: Mapping Concerns Onto Owners (Pack Z - Second wave: the practitioner kit, fill order 18)
- `WS-17-coordination-tax-calculator` - The Coordination Tax Calculator: When Does Orchestration Pay? (Pack D - Architecture and ownership, fill order 7)
- `WS-17-orchestration-state-requirements` - Orchestration Layer Requirements: What the Harness Must Track (Pack D - Architecture and ownership, fill order 8)

**Feeds into (prose, from the source scan).** WS-17-agent-team-charter (instantiates the chosen topology) and WS-17-coordination-tax-calculator (topology choice drives the coordination cost).

## 8. Facilitation

| | |
|---|---|
| Who fills it | The architect who will own the orchestration standard, the platform engineer who has to configure the bound in the harness, one practitioner who has actually run a multi-agent execution end to end, and whoever answers audit questions. The last of those is not decoration: an unbounded fan-out tree is a cost and audit exposure, and this is the sheet where it gets capped. |
| When in the session | After `WS-APXA-harness-selection-matrix`, its declared prerequisite — column 7 reads directly off that sheet's block A, and a bound assigned to a harness the org has declined is void. It must close before the three sheets that consume it: the coordination-tax calculator, the orchestration-state requirements and the agent team charter. |
| Duration | 90 minutes. Roughly 60 on blocks A and B together, 20 on block C, and 10 on block D — or nothing on block D if no sanctioned topology is Panel. Column 8 is where the session stalls, because "can the harness actually stop this?" usually has to be tested rather than answered. |
| Data needed in advance | The classes of work the organisation genuinely does, each with a recent real example rather than a category name; the harness decision from `WS-APXA-harness-selection-matrix`; and — checked, not assumed — whether the chosen harness exposes any mechanism to bound dispatch depth and fan-out at all. If a multi-agent execution has already been run somewhere in the organisation, bring what it cost. |
| Room format | Projected and filled live, with the three pattern diagrams printed and on the table so participants can point at a stage instead of describing it. One printed page per sanctioned topology for column 14, because naming the exclusive file-ownership boundary per team takes more space than a cell. |

**Facilitation note carried from ch17.** This is an architecture standard, not a coding practice,
and the recursion bound is the reason a practitioner chapter earns a leadership sheet. Put the
chapter's sentence on the wall: every Skill that dispatches subagents declares its recursion depth
and its maximum fan-out **at the dispatch site**, and the harness enforces the bound — *"the bound
is not a tuning parameter; it is the load-bearing constraint that keeps the cost and trace of a
Panel (or Wave, or Scatter-Gather) explicable after the fact."* Then say the part that matters
for how the room fills columns 4 and 5: the book gives no number. It gives a requirement. The
organisation picks the value, picks it low, and raises it on evidence — and the sheet is designed
so that a low first value is cheap to change while an unbounded default is not.

One more framing worth carrying, because it pre-empts the commonest objection in the room. The
argument for specialisation is not that specialist agents are cleverer; it is that specialisation
*reduces the context each agent must carry*. An architecture agent loaded with type definitions
and module boundaries does not also need logging conventions and symbol dictionaries. The context
it receives is concentrated, not diluted. Teams that hear "more agents" as "more overhead" have
usually missed that the topology is a context-management decision first.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **Every class of work in block A carries exactly one sanctioned topology.** Any class not
   listed defaults to single agent, and that default is written on the sheet rather than left to
   be inferred — an unlisted class is how an unsanctioned topology enters production.
2. **Every multi-agent row carries both a declared recursion depth (column 4) and a maximum
   fan-out (column 5), and both are values this organisation chose.** A blank in either is the
   unbounded case the chapter names; a value that matches some remembered figure from the book is
   a value nobody decided, because the book supplies none.
3. **Every declared bound names an enforcing harness (column 7) and an enforcement status
   (column 8).** Any row reading `Not enforceable` is either moved to unsanctioned, or carries a
   named compensating control and the person who owns it.
4. **Column 6 is ticked on every multi-agent row.** A bound that exists only in this document and
   not at the dispatch site is a policy, not a constraint, and it will not survive contact with a
   developer in a hurry.
5. **Reconciliation with `WS-APXA-harness-selection-matrix`.** Every harness named at column 7
   appears in that sheet's block A and is marked `Standardise` or `Support via shim`. A bound
   assigned to a declined harness is void and the row must be refilled.
6. **Every workflow in block C names both an eval (column 19) and a plan-persistence path
   (column 20).** A dispatch with no stop condition and no persisted plan is exactly the runaway
   the bound exists to prevent, and the two conventions are what make the recursion governable
   rather than merely limited.
7. **Where any sanctioned topology is Panel, block D names a synthesiser (column 24) and a control
   for all three anti-patterns (column 23).** A Panel with no named synthesiser is
   PANEL-WITHOUT-SYNTHESIS by construction, and the sheet has just built the anti-pattern it
   printed.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** Three patterns each presented as a mermaid the reader must instantiate; the work-class rows and the bound columns need designing.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Earns leadership priority in a practitioner chapter because it is an architecture standard, not a coding practice: choosing which orchestration shapes the org sanctions determines tooling requirements, cost ceilings and auditability. The recursion bound is the decisive leadership content - the chapter states at line 12 that "every Skill that dispatches subagents declares its recursion depth and its maximum fan-out at the dispatch site, and the harness enforces the bound... not a tuning parameter" - an unbounded fan-out tree is exactly the cost and audit exposure an engineering leader must cap before breaking ground. Sources: Panel framing at lines 10-12, three patterns at lines 56 (Writer/Reviewer/Tester), 75 (Domain Teams), 134 (Audit/Execute/Validate), each with a mermaid the reader must instantiate. DEPENDENCY the synthesizer must honour: harness spawn behaviour varies, so the harness matrix (WS-14) has to be settled first. Footnote ch15-genesis-panel also names three Panel anti-patterns (PANEL-WITHOUT-SYNTHESIS, PANEL-IN-ONE-CONTEXT, IMBALANCED PANEL) worth printing as guardrails on the sheet.
