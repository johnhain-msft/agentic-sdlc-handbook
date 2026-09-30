# Agent Dispatch Brief Template and Quality Check

`WS-17-dispatch-brief-template` &middot; **Pack Z - Second wave: the practitioner kit** &middot; fill order **20** &middot; type `checklist` &middot; audience **practitioner** &middot; leadership priority **3**

> **Split back out in the re-opening pass.** A reusable per-dispatch brief plus a five-point pre-flight gate, named in the canonical's own feeds_into; it is the instrument the wave plan consumes, not a part of it.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A reusable dispatch brief plus a pre-flight quality check - the template that turns the third orchestration run into a copy-paste exercise.

**Cluster.** `CL-DISPATCH-BRIEF` - Agent Dispatch Brief and Pre-Flight Quality Check

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch17-multi-agent-orchestration.qmd` |
| Chapter | Multi-Agent Orchestration |
| Heading | Concrete Dispatch: What It Actually Looks Like |
| Stable anchor | `#sec-multi-agent-dispatch-example` |
| Lines | L90-132 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch17-multi-agent-orchestration.html#sec-multi-agent-dispatch-example> |
| Locator quote | "The Domain Teams pattern describes structure. Here is what a dispatch actually" |

Resolve at any time with `python docs/resolve.py ws WS-17-dispatch-brief-template`.

## 3. Source extract - the scaffolding, verbatim

```text
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
```

## 4. What the user fills

Fill the five blocks of a dispatch: the instruction files loaded (and only those), the exclusively owned file list, the committed reference the agent must read rather than a description of it, the explicit constraints (do-not-modify list, signatures, behaviour preservation), and the verification command the agent runs before reporting done. Then tick the five quality criteria before dispatching.

## 5. Field-level schema

Three parts, three different row semantics. **Part A** is the brief itself — one filled instance per
dispatch, fields as rows, issued as a repository template so it can be copied rather than retyped.
**Part B** is the pre-flight check — five checkboxes on a card that sits at the orchestrator's desk
and gates the dispatch. **Part C** is the first-run record — rows are steps through one real ticket,
filled at the desk after the session, one grid per person.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| A1 | Dispatch ID, wave, agent | `free text` | — | Keyed to `WS-18-wave-decomposition-plan` | derived |
| A2 | Agent team | `select` | — | Chosen from `WS-17-agent-team-charter`; determines which instruction files are legitimate at A4 | ch17 L77-86 |
| A3 | Transformation rule, one sentence | `free text` | Worked instance: "Migrate the following files from print-based output to the structured logger established in Wave 0." | The rule for this dispatch, stated as a transformation rather than a goal | ch17 L104-105 |
| A4 | Instruction files loaded | `free text` (list of paths) | Worked instance: a project-wide conventions file always loaded, plus one integration-specific file. Pre-printed constraint beside the field: two instruction files, not twelve | The actual paths, from the team's charter | ch17 L97-98, L128 |
| A5 | Exclusively owned file list | `free text` (list of paths) | Worked instance: three named command modules, with "exclusive ownership this wave" stated in the prompt | Explicit paths. Not a directory, not a glob | ch17 L108-111, L126 |
| A6 | Committed reference | `free text` (path + commit) | Worked instance: a factory pattern in a named source file, "committed and tested"; the prompt says "established in Wave 0" so the agent reads real code | The artefact, its path, and evidence it is committed | ch17 L105-106, L127 |
| A7 | **Structural context** | `free text` | The category: module boundaries, dependency relationships, file organisation conventions — what a new function should be named, where it should live, which existing patterns it follows | This task's structural facts | ch10 L52 |
| A8 | **Constraint context** | `free text` | The category: what the agent must not do, which files are off-limits, which behavioural contracts must be preserved. Worked constraint block: do not modify any file outside the list; do not change function signatures or public APIs; preserve all existing behaviour; use the named helpers and see the named examples file | This task's constraints | ch10 L53; ch17 L113-118 |
| A9 | **Domain context** | `free text` | The category: business logic, edge cases, the implicit rules that exist in the team's understanding but not in the code — why a seemingly redundant check exists, why error messages are worded as they are | This task's domain facts, or an explicit `none for this task` | ch10 L54 |
| A10 | Explicit exclusions | `free text` | Pre-printed: "Do NOT modify any file not in this list" is the one-file-one-agent rule stated in the agent's own terms | Anything off-limits beyond the complement of A5 | ch17 L114, L130 |
| A11 | Verification command the agent runs before reporting done | `free text` (runnable) | Worked instance: a scoped test command with a fail-fast flag, followed by "Fix any failures before reporting done." | The actual command, with arguments | ch17 L120-121, L129 |
| A12 | Escalation instruction | `free text` | Self-validation before reporting completion is L1 self-heal; anything the agent cannot resolve routes up the ladder | What this agent does when it cannot proceed, and to whom | ch17 L129; ch17 L344-349 |
| A13 | Dispatched by, date | `owner (named person)` + `date` | — | — | org |
| A14 | Calibration pair — the bad specification | `free text` | Worked instance: a one-line migration rule that sounds precise until the agent meets a call that was a deliberate workaround, migrates it dutifully, and the regression surfaces weeks later under load | The team's own bad spec, for its own codebase | ch10 L46-47 |
| A15 | Calibration pair — the good specification | `free text` | Worked instance: the same rule plus the named exception, the reason for it, and the marker the agent must leave behind — requiring knowledge of the codebase the agent cannot infer | The team's own good spec, same transformation | ch10 L48 |
| B1 | Exclusive file list confirmed | `checkbox` | "The agent knows exactly which files it owns. No ambiguity, no overlap with other agents in this wave." | Checked against the wave's partition | ch17 L126 |
| B2 | Committed reference confirmed | `checkbox` | "The agent reads the actual committed code, not a description of what it should look like." | — | ch17 L127 |
| B3 | Scoped instructions confirmed | `checkbox` | "Two instruction files, not twelve." Nothing irrelevant to this task is carried | — | ch17 L128 |
| B4 | Built-in validation confirmed | `checkbox` | "The prompt ends with a test command. The agent self-validates before reporting completion." | — | ch17 L129 |
| B5 | Explicit constraints confirmed | `checkbox` | The one-file-one-agent rule is stated in the agent's own terms inside the prompt | — | ch17 L130 |
| — | Dispatch gate | `computed` | — | Blocked until B1-B5 are all ticked. The card records the block, not just the release | ch17 L124-130 |
| C1 | Elapsed time | `free text` | Shape only: `0:00`, `0:04`, `0:08`, … | — | ch10 L150-172 |
| C2 | Role you were in | `select` Architect / Reviewer / Escalation handler | The three roles, pre-printed with their one-line definitions | Which one, this step | ch10 L150-172 |
| C3 | Dispatched or typed by hand | `select` dispatched / typed / both, plus `free text` | Worked instance: the middleware was dispatched, the three-line wiring was typed, the two-line policy fix was typed rather than re-dispatched because the specification-to-code ratio would have been absurd | What, and why that choice | ch10 L150-172 |
| C4 | **Which context file was improved as a result** | `free text` (path) | Worked instance: a fail-closed policy added to the middleware instruction file; a warning against sleep-based assertions added to the test instruction file | The path, and the line added | ch10 L150-172 |
| C5 | Outcome of the step | `free text` | — | — | org |
| — | Instruction-file edit list | `computed` (list) | — | Every C4 entry collated: the evidence that the improvement loop actually closes | derived |

**Absorbed detail.** `WS-10-agent-task-brief` is carried by A3 (the transformation rule), A5 and A10
(the in-scope set and its explicit exclusions), and above all by A7, A8 and A9, which print the
chapter's three context categories — structural, constraint, domain — as the brief's content
taxonomy rather than leaving "context" as one undifferentiated box. Its bad-spec/good-spec
calibration pair is carried by A14 and A15, printed as a worked pair on the reverse with a blank
pair the team completes for its own codebase. `WS-10-first-day-walkthrough` is carried entirely by
Part C: elapsed time at C1, the role at C2, dispatched-versus-typed at C3, and the column its own
description calls the one that matters — which context file was improved — at C4, rolled up into the
instruction-file edit list.

**Deliberate omission.** No per-dispatch time budget and no field for orchestrator preparation time.
The chapter costs a dispatch at roughly two to three minutes of orchestrator time; that is one
experienced practitioner's observation on one codebase, and printing it beside a blank would push
briefs towards being written fast rather than written well — which is precisely the failure mode
A14's bad specification illustrates. The figure belongs to `WS-17-coordination-tax-calculator`,
where it is explicitly an input to be replaced by the org's own measurement.

## 6. Absorbed members (2)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-10-agent-task-brief` - Agent Task Brief Template

- **Address.** `handbook\ch10-the-practitioners-mindset.qmd` L36-58, From Writing Code to Engineering Context (`#sec-mindset-context-engineering`)
- **Why folded.** The same artefact, a one-page reusable brief template; contributes the three context categories (structural / constraint / domain) as the brief's content taxonomy and the bad-spec/good-spec calibration pair.
- **Fill detail to absorb.** For one real task: the transformation rule, the in-scope file set, explicit exclusions, and the three context blocks the chapter names — structural (module boundaries, naming, where new code lives), constraint (off-limits files, behavioural contracts that must be preserved), and domain (business rules and edge cases that exist only in the team's heads).
- **Its output was.** A reusable one-page brief template plus one completed worked example, ready to paste into a session or commit as a .spec.md.

### `WS-10-first-day-walkthrough` - First-Task Dry Run

- **Address.** `handbook\ch10-the-practitioners-mindset.qmd` L150-172, First Day: A Task from Start to Finish (`#sec-mindset-first-day`)
- **Why folded.** The dispatch brief's worked first use; contributes the timeline grid (elapsed / role / dispatched-vs-typed / which context file was improved) as the brief's first-run record.
- **Fill detail to absorb.** A team takes one real ticket and fills a timeline grid: for each step, elapsed time, the role they were in (Architect / Reviewer / Escalation handler), what was dispatched versus typed by hand, and — the column that matters — which context file was improved as a result.
- **Its output was.** A completed dry-run record per team plus the list of instruction-file edits it produced: evidence that the improvement loop actually closes.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-17-agent-team-charter` - Agent Team Charter: Mapping Concerns Onto Owners (Pack Z - Second wave: the practitioner kit, fill order 18)

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** WS-18-wave-decomposition-plan (one brief per task per wave); the templates are the artefact that makes WS-17-coordination-tax-calculator's "second run costs half" claim true.

## 8. Facilitation

| | |
|---|---|
| Who fills it | Parts A and B: the person who will orchestrate the wave, with one engineer who owns the target files and can answer A9 without guessing. Part C is different — it is filled individually, at the desk, by every practitioner in the pilot after their own first real dispatch. A Part C grid filled by the facilitator on someone else's behalf is worthless. |
| When in the session | Pack Z, after `WS-17-agent-team-charter`, which supplies the legitimate instruction-file list for A4, and after `WS-17-conflict-resolution-playbook`, whose bottleneck register constrains what may appear at A5. Fill Parts A and B in the session against one real task. Part C is deliberately homework: it is filled against a real ticket, in real time, not simulated in a room. |
| Duration | 45 minutes to fill the template against one real task, most of it on A7-A9 and on A6 — teams reach for a description of the reference before they reach for its path. Part C takes as long as one real ticket takes, at the desk, over the following days. |
| Data needed in advance | One real, already-triaged ticket for the pilot repository — triaged, so the room is not doing product work. The repository's existing instruction files. The Wave 0 commit, or whichever committed artefact the first dispatch will reference, if the pilot has begun. And the team charter, because A2 determines which instruction files are even admissible at A4. |
| Room format | Fill Part A live with the chapter's worked prompt projected beside it, so the room can see the shape it is matching — this is a transcription exercise by design, and showing the source removes the temptation to invent a format. Part B ships as a printed card at the orchestrator's desk, not as a page in a binder. Part C is issued as a single-sheet grid, one per person. |

**Facilitation note carried from the source scan.** The "two instruction files, not twelve"
discipline at ch17 L128 is where progressive disclosure stops being an abstraction, so cross-
reference this sheet with the progressive-disclosure instrument rather than restating it. Use A4 as
a diagnostic: if the room lists more than a handful of instruction files for a single dispatch, the
concern split in `WS-17-agent-team-charter` is probably wrong, and it is far cheaper to re-examine
the charter now than to discover it after an agent returns output shaped by four competing
conventions. This is the most directly reusable artefact in the chapter and belongs in the
practitioner appendix of the delivery, not only in the pack.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **A5 lists explicit paths, not a directory and not a glob.** "The commands module" is not an
   exclusive file list: an agent cannot verify that it has stayed inside a wildcard, and neither can
   the person checking the wave's partition afterwards.
2. **A6 names a committed, tested artefact with a path.** A description of what the reference ought
   to look like is not a reference. If the artefact is not yet committed, the dispatch does not
   belong in this wave — it belongs in a later one, and moving it is the correct outcome of filling
   this row honestly.
3. **All five Part B boxes are ticked before dispatch, and the card shows the gate held.** A
   pre-flight check that only ever records releases is a formality; the one that records a blocked
   dispatch is the one doing work.
4. **A11 is a runnable command with its arguments**, and the brief states in the agent's own terms
   that failures are fixed before completion is reported.
5. **A7, A8 and A9 are each either filled or explicitly marked `none for this task`.** Domain context
   left blank by default is exactly how the chapter's bad specification gets written — the rule
   sounds precise, the agent obeys it, and the knowledge that would have stopped it was never
   externalised. A blank must be a decision, not an oversight.
6. **At least one Part C row has a non-empty C4.** A first run that improved no instruction file
   either found nothing — unlikely on a first run — or found something and did not write it down. In
   either case the improvement loop this template exists to close has not closed, and the run should
   be repeated rather than recorded as complete.
7. **The team has written its own bad-spec/good-spec pair at A14 and A15**, for its own codebase, in
   its own vocabulary. Reading the book's pair is comprehension; writing your own is the calibration,
   and it is the only part of this sheet that cannot be copied from the chapter.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Unusually complete already: a full worked prompt plus a five-point quality checklist. This is a transcription job.
- **Fill (the organisation completing it): `S`.** S - one sitting, data already in the room

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Already structured to an unusual degree: lines 96-124 give a complete worked prompt and lines 126-130 give the five-point quality checklist (exclusive file list, committed reference, scoped instructions, built-in validation, explicit constraints). Almost no authoring needed - this is a transcription job. Practitioner-facing, hence priority 3, but it is the most directly reusable artefact in the chapter and belongs in a practitioner appendix of the delivery. Facilitation note: the "two instruction files, not twelve" discipline at line 128 is where ch15's progressive-disclosure lever becomes concrete, so the two sheets reference each other. The chapter costs this at roughly 2-3 minutes of orchestrator time per dispatch (line 132) - a useful input to the coordination tax calculator.
