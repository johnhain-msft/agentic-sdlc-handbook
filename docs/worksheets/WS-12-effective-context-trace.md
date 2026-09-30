# Effective Context Trace

`WS-12-effective-context-trace` &middot; **Pack Z - Second wave: the practitioner kit** &middot; fill order **5** &middot; type `diagnostic` &middot; audience **practitioner** &middot; leadership priority **2**

> **Split back out in the re-opening pass.** A per-file composition trace whose pass/fail test is that no layer contradicts the layer above; already a declared prerequisite of WS-12-failure-triage-log, a different canonical.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A per-file context trace showing what the agent actually sees, with a list of gaps and contradictions to fix.

**Cluster.** `CL-CONTEXT-TRACE` - Effective Context Trace: What the Agent Actually Sees

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch12-the-instrumented-codebase.qmd` |
| Chapter | The Instrumented Codebase |
| Heading | How Primitives Compose |
| Stable anchor | `#sec-codebase-composition` |
| Lines | L385-414 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch12-the-instrumented-codebase.html#sec-codebase-composition> |
| Locator quote | "Primitives are not independent. They form a layered system" |

Resolve at any time with `python docs/resolve.py ws WS-12-effective-context-trace`.

## 3. Source extract - the scaffolding, verbatim

```text
  385 | Primitives are not independent. They form a layered system, and the agent's effective context for a task is the composition of every applicable file:
  386 | 
  387 | ```{mermaid}
  388 | %%| fig-cap: "Composition cascade. Each layer narrows scope and adds specificity; the agent's effective context for a task is the union of every applicable layer. Hooks operate across all layers as event-driven triggers."
  389 | flowchart TD
  390 |     G["<b>Global principles</b><br/><span style='font-size:11px'>copilot-instructions.md</span>"]
  391 |     I["<b>Scoped instructions</b><br/><span style='font-size:11px'>*.instructions.md, matched by applyTo</span>"]
  392 |     S["<b>Skills</b><br/><span style='font-size:11px'>activated by code patterns</span>"]
  393 |     A["<b>Agent configuration</b><br/><span style='font-size:11px'>persona, model, tool boundaries</span>"]
  394 |     P["<b>Prompt or spec</b><br/><span style='font-size:11px'>the specific workflow being executed</span>"]
  395 |     M["<b>Memory</b><br/><span style='font-size:11px'>accumulated project context</span>"]
  396 |     H["<b>Hooks</b><br/><span style='font-size:11px'>event-driven triggers, cross-cutting</span>"]
  397 |     G --> I --> S --> A --> P --> M
  398 |     H -.->|cross-cutting| G
  399 |     H -.-> I
  400 |     H -.-> S
  401 |     H -.-> A
  402 |     H -.-> P
  403 |     H -.-> M
  404 |     classDef layer fill:#f5f5f5,stroke:#333,stroke-width:1px,color:#000
  405 |     classDef cross fill:#fff3e0,stroke:#e65100,stroke-width:1px,color:#000
  406 |     class G,I,S,A,P,M layer
  407 |     class H cross
  408 | ```
  409 | 
  410 | When an agent is asked to modify `src/api/users.py`, the effective context assembles from global principles, the `applyTo: "src/api/**"` instruction file (frontend instructions stay out), the API middleware skill (activated by route patterns), the backend-dev agent (persona, model, tools), and the memory file (versioning decisions, deprecated `SessionAuth`, rate limit timeouts). Each layer adds specificity; none contradicts the layer above. A conflict indicates a design error in the instrumentation, not a resolution the agent should attempt.
  411 | 
  412 | This composition is what Chapter 13's *Explicit Hierarchy* constraint makes concrete. Global rules provide consistency, scoped rules provide domain adaptation, skills provide decision frameworks, agent configurations provide expertise, prompts and specs provide task structure, memory provides history, hooks provide event-driven reactivity. Together, they give the agent the same information a tenured team member would bring to the task — without requiring that information to fit in anyone's head.[^ch9-scope]
  413 | 
  414 | ---
```

## 4. What the user fills

Pick two or three representative files from the repository. For each, walk the composition cascade and list every primitive that loads — global principles, matching scoped instructions, activated skills, the agent persona, the prompt or spec, memory — then flag any layer that is empty (a gap) and any two layers that disagree (a design error).

## 5. Field-level schema

One trace per file; seven fixed rows per trace — the six layers of the composition cascade plus
the cross-cutting hooks layer. Physically it is one A4 side per traced file, and the chapter asks
for two or three files, so the pad ships in threes. A header box identifies the trace; the layer
table *is* the trace.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| — | File traced | `free text` | The worked trace's `src/api/users.py` printed as the ghosted example | A real, representative file from this repository | ch12 L410 |
| — | The task, in one sentence | `free text` | The worked example's framing — "an agent is asked to modify this file" | The task actually being traced | ch12 L410 |
| — | Harness, and whether verbose mode was on | `free text` | — | Which harness, and whether the trace was read from a log or from the files | org |
| — | Traced by / date | `owner (named person)` + `date` | — | — | org |
| 1 | Layer | `select` (fixed 7) | Global principles (`copilot-instructions.md`); scoped instructions (`*.instructions.md`, matched by `applyTo`); skills (activated by code patterns); agent configuration (persona, model, tool boundaries); prompt or spec (the workflow being executed); memory (accumulated project context); hooks (event-driven triggers, cross-cutting) | — | ch12 L390-396 |
| 2 | Anything at this layer | `select` — present / empty | — | Which | derived |
| 3 | File(s) that load | `free text` | The worked trace pre-printed as a ghosted row set — global principles, the `applyTo: "src/api/**"` instruction file, the API middleware skill, the backend-dev agent, the memory file | Real paths, read off the repository | ch12 L410 |
| 4 | Why it loads — the predicate | `free text` | Defaulted per layer: always, at session start; the `applyTo` glob matches the working path; the description matches the task; a parent thread spawns and names it; the request itself; session start, persistent; an event fires | The actual glob, description or trigger | ch12 L390-396; ch14 L79-85 |
| 5 | What it contributes to *this* task | `free text` | — | One line. If it cannot be written, the layer is over-scoped | ch12 L410 |
| 6 | Adds specificity to the layer above | `checkbox` | The rule printed beside the column: each layer adds specificity | Tick per layer | ch12 L410 |
| 7 | Contradicts a layer above | `checkbox` + `select` (which layer) | The rule printed beside the column: none contradicts the layer above | Tick and name | ch12 L410 |
| 8 | Contradiction detail | `free text` | — | What the two layers each say, quoted | ch12 L410 |
| 9 | Finding | `select` — clean / gap / conflict / over-scoped | The four classes defined beside the column: *gap* = the layer is empty and should not be; *conflict* = two layers disagree; *over-scoped* = the layer loads and contributes nothing to this task, the flat-instruction failure seen at file level | Which | ch12 L410; ch13 L366 |
| 10 | Action | `select` — write the missing primitive / delete the duplicate rule / rescope the glob / split the file / no action | The chapter's own fix for the flat case: split by scope | Which | ch13 L368 |
| 11 | Owner and target date | `owner (named person)` + `date` | — | Required for every finding other than `clean` | org |
| — | Trace verdict | `select` — pass / fail | The rule printed verbatim under the table: *"Each layer adds specificity; none contradicts the layer above. A conflict indicates a design error in the instrumentation, not a resolution the agent should attempt."* | Pass only if no row ticks column 7 | ch12 L410 |

**Deliberate omission — no token counts and no budget column.** This is the **design-time** trace:
it answers *what should assemble for this file*, by reading the primitives. Costing the layers
belongs to `WS-15-context-budget-allocation`, and establishing whether a layer actually reached the
model at runtime belongs to `WS-14-silent-primitive-phase-triage`. A token column here reliably
turns a design review into a debugging session, and the contradiction column — the only column that
produces findings the book calls design errors — is the one that goes unfilled when that happens.

**Deliberate omission — no judgement on whether a layer should exist at all.** Column 9's four
classes are observations about this file. Whether the organisation ought to have a skills layer, or
a hooks layer, is the target-state question and it is answered on `WS-27-starter-shape-target`.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-02-shadow-ai-usage-inventory` - Shadow AI Usage Inventory (Pack A - Groundwork (pre-work), fill order 1)

**Consumed by:**

- `WS-12-failure-triage-log` - Agent Failure Triage Log (Pack Z - Second wave: the practitioner kit, fill order 14)

**Feeds into (prose, from the source scan).** WS-12-failure-triage-log

## 8. Facilitation

| | |
|---|---|
| Who fills it | Two practitioners who work on different parts of the repository, working together. One traces, the other challenges. A contradiction between two layers is nearly always invisible to the person who wrote one of them, which is the whole reason this is not a solo exercise. |
| When in the session | Pack Z, fill order 5, after `WS-02-shadow-ai-usage-inventory`. The dependency is substantive rather than procedural: the census supplies the list of primitives that actually exist, and that list is column 3's row set. Run it before `WS-12-failure-triage-log`, which consumes it — a triage log with no trace behind it records symptoms and calls them causes. |
| Duration | 30-45 minutes per file. The chapter asks for two or three, so 90 minutes to two hours. The first trace takes roughly twice as long as the third; budget for that rather than cutting the third. |
| Data needed in advance | The repository's primitive layout — every `copilot-instructions.md`, `*.instructions.md`, `SKILL.md`, `*.agent.md`, prompt, memory file and hook — and the `applyTo` globs. Two or three candidate files chosen to be **unalike**: one from a well-instrumented area, one from a neglected one. Three files from the same module find the same gap three times. |
| Room format | A4 per file, side by side on a table, filled by hand — but done at a machine with the repository open. Column 3 must be answered by looking, never by remembering; a trace filled from recall records the instrumentation the team believes it has. |

**Facilitation note — Pack Z prerequisite condition.** This sheet traces an estate. Where the
shadow-AI census turned up little — a repository with one `copilot-instructions.md` and no scoped
files — the trace returns six empty layers, and that is a legitimate and useful result: the empty
rows *are* the gap list, and they route directly to `WS-13-instruction-hierarchy-canvas` and
`WS-12-agent-persona-design-canvas` to be filled. What the sheet cannot do in that state is find
contradictions, because there is nothing yet to contradict. Say so when scheduling, and run one
trace rather than three to establish it.

**Second note, carried from the source scan.** This is the design-time trace, not the runtime
debug. It establishes what *should* assemble for a file by reading the primitives. It does not
establish what actually loaded — that is the four-phase test on
`WS-14-silent-primitive-phase-triage`. The two disagreeing is itself a finding worth carrying
forward, and it is one of the more valuable things Pack Z can surface.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All seven layers have a row, including the empty ones.** An omitted layer is indistinguishable
   from an absent one on the finished sheet, and the empty rows are a substantial part of the
   output.
2. **Every path in column 3 exists in the repository.** No layer is filled from memory or from
   intent. A trace of the instrumentation a team believes it has is worse than no trace, because it
   is credible.
3. **Every non-empty layer answers either column 6 or column 7.** It adds specificity, or it
   contradicts something. A layer that does neither is marked `over-scoped` in column 9 — it loaded
   and contributed nothing to this task, which is the flat-instruction failure observed at the
   level of a single file (ch13 L366).
4. **Every ticked column 7 names the layer contradicted, quotes both sides in column 8, and carries
   an owner.** It is recorded as a design error, never as a precedence rule. The book is explicit
   that a conflict is a defect in the instrumentation rather than something the agent should
   resolve (ch12 L410) — a sheet that resolves it has produced the wrong artefact.
5. **At least two files were traced, and they are unalike.** The sheet names why the two were
   chosen. Two traces of two similar files are one trace.
6. **Every finding other than `clean` carries an action and an owner** in columns 10 and 11.
7. **Nothing is closed on this sheet.** Every gap and every conflict hands forward intact — to
   `WS-12-failure-triage-log` as an open item, or to the sheet that will fix it
   (`WS-13-instruction-hierarchy-canvas` for scoping, `WS-12-agent-persona-design-canvas` for the
   agent layer, `WS-12-project-decision-register` for the memory layer). A finding fixed in the
   room and ticked off is a finding nobody can audit.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** The chapter performs the worked trace for a real file and states the pass/fail rule explicitly, so both the rows and the acceptance test are given.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Excellent candidate because the chapter already performs the worked trace for src/api/users.py and states the acceptance rule explicitly: each layer adds specificity, none contradicts the layer above, and "a conflict indicates a design error in the instrumentation, not a resolution the agent should attempt". That single sentence is the worksheet's pass/fail test. OVERLAP: Chapter 14 (load lifecycle) owns the mechanics — transitive closure, budget overflow, why a correctly-placed skill stays silent — so the ch14 scan will probably return a deeper version; merge and keep this one as the design-time trace rather than the runtime debug.
