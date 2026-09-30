# Orchestration Layer Requirements: What the Harness Must Track

`WS-17-orchestration-state-requirements` &middot; **Pack D - Architecture and ownership** &middot; fill order **8** &middot; type `checklist` &middot; audience **architect** &middot; leadership priority **2**

> **Split back out in the re-opening pass.** A build-or-buy requirements checklist used to evaluate harnesses and internal tooling against a named feature list -- a buying question, not a design question.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A build-or-buy requirements list for the orchestration layer - the concrete feature checklist to evaluate harnesses and internal tooling against.

**Cluster.** `CL-ORCH-STATE` - Orchestration State Requirements: What the Harness Must Track

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch17-multi-agent-orchestration.qmd` |
| Chapter | Multi-Agent Orchestration |
| Heading | Session Management |
| Stable anchor | `#sec-multi-agent-session-management` |
| Lines | L386-442 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch17-multi-agent-orchestration.html#sec-multi-agent-session-management> |
| Locator quote | "Every agent dispatch creates a session: a context window with its own" |

Resolve at any time with `python docs/resolve.py ws WS-17-orchestration-state-requirements`.

## 3. Source extract - the scaffolding, verbatim

```text
  386 | Every agent dispatch creates a session: a context window with its own conversation history, loaded instructions, and accumulated state. Managing these sessions is a practical concern that directly affects output quality.
  387 | 
  388 | ### Session Isolation
  389 | 
  390 | Each agent session is independent. Agent A cannot see Agent B's conversation history, edits, or reasoning. This is a feature, not a limitation. Session isolation ensures that one agent's context degradation does not propagate to others. If Agent A's session becomes cluttered after a complex debugging sequence, Agent B starts fresh with a clean context.
  391 | 
  392 | The implication: information flows between agents through committed artifacts, not through shared sessions. When Agent B needs to build on Agent A's work, it reads the committed files — the same files that passed tests and were validated at the wave checkpoint. It does not read Agent A's internal reasoning or discarded alternatives.
  393 | 
  394 | ```{mermaid}
  395 | %%| fig-width: 4.5
  396 | %%| fig-cap: "Session isolation: agents share filesystem, not conversation state"
  397 | %%| fig-alt: "Flowchart showing three agents, each in its own isolated subgraph: Agent 1 with its own isolated Conversation, Agent 2 with its own isolated Conversation, and Agent 3 with its own isolated Conversation. All three agents connect downward to a single shared Shared filesystem node labeled committed files equals ground truth between waves. Agents do not connect to each other, only to the shared filesystem."
  398 | %%| label: fig-session-isolation
  399 | flowchart TD
  400 |     subgraph A1["Agent 1"]
  401 |         C1["Conversation<br/>(isolated)"]
  402 |     end
  403 |     subgraph A2["Agent 2"]
  404 |         C2["Conversation<br/>(isolated)"]
  405 |     end
  406 |     subgraph A3["Agent 3"]
  407 |         C3["Conversation<br/>(isolated)"]
  408 |     end
  409 |     FS["Shared filesystem<br/>(committed files = ground truth between waves)"]
  410 |     C1 --> FS
  411 |     C2 --> FS
  412 |     C3 --> FS
  413 | ```
  414 | 
  415 | ### Session Lifetime
  416 | 
  417 | Shorter sessions produce better output. A session that has been running for 40 turns carries 40 turns of conversation history, which consumes context that could hold source code or instructions. The marginal value of each additional turn decreases as history accumulates.
  418 | 
  419 | Three guidelines for session lifetime:
  420 | 
  421 | 1. **One task per session.** An agent dispatched to "migrate logging in `resolver.py` and update tests in `test_resolver.py`" is one task. Reusing that session for a second, unrelated task inherits the first task's conversation history, dead weight for the second task.
  422 | 
  423 | 2. **Reset on failure.** If an agent gets stuck — looping on the same error, producing the same incorrect output — terminate the session and dispatch a fresh one with refined instructions. The fresh session starts without the accumulated confusion of the failed attempt.
  424 | 
  425 | 3. **State through files, not memory.** Any information that needs to survive across sessions must be written to the filesystem: committed code, plan documents, checkpoint records. Session-internal state (the agent's reasoning, intermediate attempts, debugging output) is ephemeral and should be treated as such.
  426 | 
  427 | ### Cross-Session Coordination
  428 | 
  429 | The orchestration layer — whether a human with multiple terminal windows or an automated harness — maintains the coordination state that individual agent sessions cannot.
  430 | 
  431 | This state includes:
  432 | 
  433 | - **Task status.** Which tasks are pending, in progress, complete, or blocked.
  434 | - **File ownership.** Which agent is currently modifying which files — the enforcement mechanism for the one-file-one-agent rule.
  435 | - **Wave progress.** Which waves have been completed and tested, which is currently executing.
  436 | - **Escalation log.** What has been escalated, what decision was made, and why.
  437 | 
  438 | The agent sessions are stateless workers. The coordination layer is the stateful manager. Keeping this separation clean is what makes multi-agent orchestration predictable. When the coordination state is mixed into agent sessions — when an agent is asked to "track which files you've changed and tell the next agent" — the result is fragile and error-prone.
  439 | 
  440 | What we have been describing is the **Agent Harness** layer of the 5-layer landscape (Chapter 4). Just as an operating system manages processes, memory, and I/O for a CPU, the orchestration harness manages sessions, context loading, and file I/O for the LLM. The harness doesn't do the thinking — it creates the conditions under which thinking produces reliable results.
  441 | 
  442 | ---
```

## 4. What the user fills

For each of the four coordination-state items the chapter names - task status, file ownership, wave progress, escalation log - the team records where that state will live today (spreadsheet, issue tracker, harness feature, custom tool), whether it is enforced or merely recorded, and who maintains it. A second block ticks the three session-lifetime rules (one task per session, reset on failure, state through files not memory) as Enforced / Convention / Absent.

## 5. Field-level schema

Rows vary by block; blocks A and B are fixed-row checklists taken straight from the chapter's own
enumerations. The sheet is A3 landscape with @fig-session-isolation reproduced beside block C —
three agents, each with its own isolated conversation, all connecting **downward to a single
shared filesystem** labelled *committed files = ground truth between waves*, and **no edges
between the agents**. That absent edge is the requirement the whole sheet is built around, so the
diagram is printed, not summarised. Blocks A and B take one column group per candidate harness or
tool under evaluation.

**Block A — the four coordination-state items.**

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Coordination state item | `select` (fixed 4) | Task status / File ownership / Wave progress / Escalation log | — | ch17 L433-436 |
| 2 | What it must track | `free text` (printed) | **Task status** — which tasks are pending, in progress, complete or blocked. **File ownership** — which agent is currently modifying which files; the enforcement mechanism for the one-file-one-agent rule. **Wave progress** — which waves have been completed and tested, which is currently executing. **Escalation log** — what has been escalated, what decision was made, and why | — | ch17 L433-436 |
| 3 | Where it lives today | `free text` | — | Spreadsheet, issue tracker, harness feature, custom tool — or `nowhere`, which is a finding and not a blank | ch17 L429 |
| 4 | Enforced or merely recorded? | `select` Enforced / Recorded / Neither | — | The load-bearing distinction. File ownership written in a spreadsheet does not stop two agents editing the same file | ch17 L434 |
| 5 | Who maintains it | `owner (named person)` | — | A person or a named process. **Not an agent** — see the facilitation note | ch17 L438 |
| 6 | Provided by | `select` Harness-native / External tool / Human process / Nothing | — | — | derived |
| 7 | Requirement verdict | `select` Must have / Should have / Nice to have | — | Set before evaluating any candidate | derived |
| 8 | Candidate meets it | `select` Yes / Partial / No (one column per candidate) | — | Column headers blank; the org writes the harnesses and tools it is evaluating | derived |
| 9 | Evidence | `select` Demonstrated / Asserted / Not shown | — | Applies per candidate column | derived |

**Block B — the three session-lifetime rules.**

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 10 | Rule | `select` (fixed 3) | One task per session / Reset on failure / State through files, not memory | — | ch17 L421-425 |
| 11 | What it means | `free text` (printed) | **One task per session** — reusing a session for a second, unrelated task inherits the first task's conversation history, dead weight for the second. **Reset on failure** — when an agent loops on the same error or produces the same incorrect output, terminate the session and dispatch a fresh one with refined instructions; the fresh session starts without the accumulated confusion. **State through files, not memory** — anything that must survive across sessions is written to the filesystem: committed code, plan documents, checkpoint records. Session-internal state — reasoning, intermediate attempts, debugging output — is ephemeral and should be treated as such | — | ch17 L421-425 |
| 12 | Status here | `select` Enforced / Convention / Absent | — | — | derived |
| 13 | Enforcement mechanism | `free text` | — | Mandatory wherever column 12 reads `Enforced`. What actually stops the violation | derived |
| 14 | Owner | `owner (named person)` | — | — | derived |

**Block C — the session-isolation contract.**

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 15 | The isolation model | `free text` (printed beside the diagram) | Each agent session is independent: agent A cannot see agent B's conversation history, edits or reasoning. This is a feature, not a limitation — isolation stops one agent's context degradation propagating to others. Information flows between agents through **committed artefacts**, not shared sessions: when agent B builds on agent A's work it reads the committed files that passed tests at the wave checkpoint, not agent A's internal reasoning or discarded alternatives | — | ch17 L390-392 |
| 16 | Does our tooling preserve isolation? | `select` Yes / Partial / No | — | — | ch17 L390 |
| 17 | Where isolation leaks | `free text` | — | Any shared session, shared scratchpad, or agent asked to carry state on another agent's behalf | ch17 L438 |

**Block D — per-workflow handoff contract (absorbed).** One row per multi-step or multi-agent
workflow.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 18 | Workflow | `free text` | — | — | ch11 L159-167 |
| 19 | The file that carries state between threads | `free text` | Reference, printed: *inference is per-thread; the filesystem is shared.* The filesystem is the shared memory of every multi-thread agentic system that has ever existed | The actual path | ch11 L159-167 |
| 20 | Who writes it | `owner (named person)` or agent role | — | — | ch11 L159-167 |
| 21 | Who reads it | `owner (named person)` or agent role | — | — | ch11 L159-167 |
| 22 | Decision points at which it is re-read | `free text` | Reference: *plan-write-then-reload* — the agent writes its plan to a file mid-session and re-reads the file at decision points. The plan survives the inference; the inference does not survive the plan | Ours, named | ch11 L159-167 |
| 23 | What a child thread is guaranteed to inherit | `free text` | The book's answer, printed: **only what the parent wrote down.** A worker that needs to know the architecture decision its parent just made cannot ask the parent; it must read a file the parent wrote | Confirm this holds for our workflow, or name the assumption we are making instead | ch11 L159-167 |

**Block E — the build-or-buy verdict.**

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 24 | Requirement met by | `select` Harness-native / Existing tool / Build / Human process / Unmet | — | One per block-A and block-B row | derived |
| 25 | If Build — owner and effort | `owner (named person)` + `free text` | — | Effort stated qualitatively, in the org's own planning vocabulary | derived |
| 26 | Gap accepted? | `checkbox` + `free text` justification | — | An accepted gap is a decision; an unmarked gap is an oversight | derived |
| 27 | Evaluated on / re-evaluate by | `date` + `date` | — | Harness orchestration features move quickly | derived |

**Absorbed detail.** `WS-11-thread-handoff-design` is block D in full: the file that carries state
between threads at column 19, who writes it at 20, who reads it at 21, the decision points at
which it is re-read at 22, and what a child thread is guaranteed to inherit at 23 — where the
book's own answer, *only what the parent wrote down*, is printed rather than left to be
rediscovered. Column 19's reference line carries the chapter's load-bearing asymmetry verbatim,
because block D is unreadable without it.

**Deliberate omission.** This sheet does not score the organisation's *capability* at subagent
isolation — that assessment belongs to the ch15 levers sheet. Here the question is narrower and
procurement-shaped: does the tooling we are about to standardise on actually track and enforce
these four things. Block A columns 8 and 9 therefore evaluate candidates, not teams. The sheet
also prints no recommended tool and no reference architecture for the coordination layer; the
chapter describes what the layer must hold, not what to buy, and inventing a product shortlist
here would substitute a vendor answer for a requirements answer.

## 6. Absorbed members (1)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-11-thread-handoff-design` - Shared-State Handoff Design Sheet

- **Address.** `handbook\ch11-the-runtime-machine.qmd` L159-167, Inference is per-thread; the filesystem is shared (`#sec-runtime-thread-model`)
- **Why folded.** Both specify where coordination state lives between threads; contributes the per-workflow handoff contract -- which file carries state, who writes it, who re-reads it, what a child inherits.
- **Fill detail to absorb.** Per multi-step or multi-agent workflow: the file that carries state between threads, who writes it, who reads it, at which decision points it is re-read, and what a child thread is guaranteed to inherit from its parent (answer: only what the parent wrote down).
- **Its output was.** A handoff contract per workflow naming the file paths that constitute the system's shared memory.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-17-orchestration-topology-selector` - Orchestration Topology Selector: Which Patterns Do We Sanction? (Pack D - Architecture and ownership, fill order 6)

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** Tooling selection and the platform backlog; WS-17-dispatch-brief-template (file ownership is the enforcement point for the one-file-one-agent rule).

## 8. Facilitation

| | |
|---|---|
| Who fills it | The platform engineer evaluating harnesses and orchestration tooling, a practitioner who has actually run a wave and therefore knows where the state lives today — usually a terminal window and somebody's memory — and whoever holds the tooling budget, for block E. |
| When in the session | After `WS-17-orchestration-topology-selector`, its declared prerequisite: the sanctioned topologies determine which of the four state items the org actually needs enforced. No other worksheet declares this one as a prerequisite, so where two rooms are available it can run in parallel with `WS-17-coordination-tax-calculator`. |
| Duration | 45-60 minutes. Blocks A and B move quickly and uncomfortably: the honest entry at column 3 for wave progress is frequently "a terminal window", and for the escalation log it is frequently "nowhere". Let those answers stand — writing them down is what makes them a requirement. |
| Data needed in advance | The harness shortlist from `WS-APXA-harness-selection-matrix`; the vendor documentation for any orchestration or session-management features a candidate claims, so block A column 9 can read `Demonstrated` rather than `Asserted`; and whatever the org currently uses to track multi-agent work, even if that is a chat thread. |
| Room format | Projected checklist with @fig-session-isolation printed and visible, and one column group per candidate in block A columns 8-9. Keep the candidate columns narrow and the requirement columns wide: the requirement is durable, the candidates are this quarter's. |

**Facilitation note carried from ch17.** Two sentences set up the whole sheet. The first is the
separation: *the agent sessions are stateless workers; the coordination layer is the stateful
manager.* Keeping that separation clean is what makes multi-agent orchestration predictable, and
the chapter names the failure precisely — when coordination state is mixed into agent sessions,
when an agent is asked to "track which files you've changed and tell the next agent", the result
is fragile and error-prone. That is why column 5 will not accept an agent as a maintainer.

The second is the framing that makes this a buying question rather than a coding one: what the
chapter has been describing is the Agent Harness layer of the five-layer landscape. Just as an
operating system manages processes, memory and I/O for a CPU, the orchestration harness manages
sessions, context loading and file I/O for the model — *"the harness doesn't do the thinking, it
creates the conditions under which thinking produces reliable results."* Ask the room the question
in that form: does the harness we are about to standardise on actually track file ownership, and
does it enforce it, or does it merely let us write it down somewhere.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All four coordination-state items carry a location at column 3**, with `nowhere` written
   where that is the truth. A blank cell is indistinguishable from an unasked question; `nowhere`
   is a requirement that has just been discovered.
2. **File ownership is explicitly marked Enforced or Recorded at column 4.** It is the enforcement
   mechanism for the one-file-one-agent rule, so `Recorded` must be accompanied by a stated,
   owned risk at columns 5 and 26 rather than passed over.
3. **Every state item names a maintainer at column 5, and no maintainer is an agent.** An agent
   asked to hold coordination state on another agent's behalf is the named failure mode, and a
   sheet that records one has documented the anti-pattern rather than the control.
4. **All three session-lifetime rules carry a status at column 12, and every `Enforced` carries a
   mechanism at column 13.** `Enforced` with an empty mechanism cell is a convention that has
   been promoted by wishful marking.
5. **Block C answers whether the tooling preserves isolation (column 16) and names every leak
   (column 17).** A `Yes` with no examination of shared scratchpads or hand-off prompts has not
   been tested.
6. **Every workflow in block D names the file (19), the writer (20), the reader (21) and the
   re-read decision points (22).** A workflow whose shared state cannot be named as a path does
   not have shared state; it has an assumption.
7. **Every requirement marked `Must have` at column 7 is either met at column 24 or carries an
   accepted and justified gap at column 26 — and the candidates evaluated in columns 8-9 are the
   harnesses marked `Standardise` or `Support via shim` in `WS-APXA-harness-selection-matrix`.**
   Evaluating a declined harness produces a requirement list nobody will act on, and a `Must have`
   that the standardised harness cannot enforce must be reconciled against the enforcing-harness
   column of `WS-17-orchestration-topology-selector` before Pack D closes.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** The four coordination-state items and the three session-lifetime rules are already enumerated; the sheet adds where-it-lives, enforced-or-recorded and maintainer columns.
- **Fill (the organisation completing it): `S`.** S - one sitting, data already in the room

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Already structured: the coordination-state list is at lines 433-436 and the three session-lifetime guidelines at lines 421-425. Genuinely useful as a procurement/evaluation checklist, which is why it is scored 2 rather than 3 - the question "does the harness we are about to standardise on actually track file ownership and enforce it" is a buying question, not a coding one. The chapter's own framing supports this at line 440: the harness is the operating system of the agentic stack - "the harness doesn't do the thinking - it creates the conditions under which thinking produces reliable results." The session-isolation mermaid at lines 402-413 (agents share the filesystem, not conversation state) is the diagram to reproduce on the sheet. Overlaps ch15 lever two (subagent isolation) - score the capability in ch15, specify the tooling here.
