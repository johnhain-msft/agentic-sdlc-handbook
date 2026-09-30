# Agent Failure Triage Log

`WS-12-failure-triage-log` &middot; **Pack Z - Second wave: the practitioner kit** &middot; fill order **14** &middot; type `diagnostic` &middot; audience **practitioner** &middot; leadership priority **3**

## 1. Purpose

**Output artifact.** A running triage log that converts individual failures into permanent primitive fixes — the mechanism by which instrumentation compounds.

**Cluster.** `CL-FAILURE-OPS` - Failure Triage and Recovery Runbook

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch12-the-instrumented-codebase.qmd` |
| Chapter | The Instrumented Codebase |
| Heading | The Feedback Loop |
| Stable anchor | `#sec-codebase-feedback-loop` |
| Lines | L574-603 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch12-the-instrumented-codebase.html#sec-codebase-feedback-loop> |
| Locator quote | "When an agent produces incorrect output, the diagnosis follows a consistent pattern" |

Resolve at any time with `python docs/resolve.py ws WS-12-failure-triage-log`.

## 3. Source extract - the scaffolding, verbatim

```text
  574 | Instrumentation is not a one-time setup. It is a continuous practice, like testing.
  575 | 
  576 | When an agent produces incorrect output, the diagnosis follows a consistent pattern:
  577 | 
  578 | ```
  579 | Failure observed
  580 |     |
  581 |     v
  582 | Root cause: which context file failed?
  583 |     |
  584 |     +-- Agent too generic?          --> Add domain knowledge to agent config
  585 |     +-- Skill rules incomplete?     --> Add the missing case to the skill
  586 |     +-- Instructions missing scope? --> Add a scoped instruction file
  587 |     +-- No decision framework?      --> Extract a new skill
  588 |     +-- Context gap?                --> Update the memory file
  589 |     +-- No repeatable process?      --> Create a prompt
  590 | ```
  591 | 
  592 | Four examples from a real project, where fixing the instrumentation file fixed the class of error permanently:
  593 | 
  594 | | Failure | Root cause | Context fix |
  595 | |---------|-----------|---------------|
  596 | | Agent used `_rich_info()` directly instead of `logger.progress()` | Skill didn't explicitly ban direct calls | Added "never call `_rich_*` directly in commands" to CLI skill |
  597 | | Agent invented a new collision detection pattern | Instructions didn't list all base-class methods | Added "use, don't reimplement" table to integrator instructions |
  598 | | Agent produced inconsistent Unicode symbols in output | No single source of truth for status symbols | Created `STATUS_SYMBOLS` reference in skill, added to anti-patterns |
  599 | | Agent used deprecated `SessionAuth` in new code | Memory file didn't record the deprecation | Added deprecation notice with migration tracking reference |
  600 | 
  601 | This feedback loop is how context file quality compounds over time. Every failure you diagnose and fix is a failure that never recurs. After 20-30 iterations, your instrumentation set covers the conventions that actually matter, not the ones you theorized about, but the ones agents actually violate. That practical grounding is what makes an instrumented codebase effective.
  602 | 
  603 | ---
```

## 4. What the user fills

One row per observed agent failure: what the agent produced, which context file should have prevented it, the root cause routed through the chapter's decision tree (agent too generic / skill rules incomplete / instructions missing scope / no decision framework / context gap / no repeatable process), the primitive edit that closed it, and the date.

## 5. Field-level schema

One row per triage event — and a triage event is opened by *either* a failure the agent produced
*or* a gap the process surfaced. The six root causes and the six fixes they route to are
**pre-printed from the diagnosis tree at ch12 L584-589**; the organisation supplies the observation,
the named file, the primitive edit and the dates. This is a living file in the repository, not a
wall artefact: landscape, one row per event, with two footer rules that govern the whole sheet.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Entry no. | `computed` | — | Sequential. Column 12 reads it | derived |
| 2 | Date observed | `date` | — | — | org |
| 3 | Trigger | `select` — `Failure observed` / `Gap noticed` | — | Which of the two habits opened this row | ch12 L579 (failure); `WS-CS-HB-persona-gap-register` (gap) |
| 4 | What we saw | `free text` | Four worked rows from a real project, printed once as a greyed exemplar band above the log — never as data rows | The agent's actual incorrect output, or the gap the process surfaced | ch12 L596-599 |
| 5 | Which context file should have prevented it | `free text` | — | The named file — a path, not a category | ch12 L582 |
| 6 | Root cause | `select` (fixed 6) | Agent too generic / Skill rules incomplete / Instructions missing scope / No decision framework / Context gap / No repeatable process | Pick one. "Unclear" is not an option — follow the tree until it resolves to a diagnosis, not a guess | ch12 L584-589 |
| 7 | Routed fix | `computed` from col 6 | Add domain knowledge to agent config / Add the missing case to the skill / Add a scoped instruction file / Extract a new skill / Update the memory file / Create a prompt | Pre-fills from column 6. Override only with a written reason in column 8 | ch12 L584-589 |
| 8 | Primitive edited or created | `free text` | — | The file path **and** the exact text added, quotable in review | ch12 L596-599 |
| 9 | One-off or structural | `select` — `One-off` / `Structural` | — | Structural rows are the ones that justify a new primitive rather than an edit to an existing one | `WS-CS-HB-persona-gap-register` |
| 10 | Primitive created, not patched with an ad-hoc prompt? | `checkbox` | Pre-ticked — this is the house policy, printed as such | Untick only with the reason written in column 8 | `WS-CS-HB-persona-gap-register` |
| 11 | Cascade? | `checkbox` | — | Tick when this fix was made *during* an unresolved cascade — i.e. the previous fix exposed it | `WS-CS-PUB-cascade-log` |
| 12 | Cascade step | `computed` | — | Running count within the current cascade; resets when column 13 is left blank | `WS-CS-PUB-cascade-log` |
| 13 | What the rebuild then exposed | `free text` | — | Blank means the cascade closed here. Anything written here opens the next row | `WS-CS-PUB-cascade-log` |
| 14 | Committed before the next fix was attempted? | `checkbox` | — | Unticked is the anti-pattern the case study names: speculative batching | `WS-CS-PUB-cascade-log` |
| 15 | Owner | `owner (named person)` | — | Who makes the primitive edit. Never a team | org |
| 16 | Date closed | `date` | — | The date the primitive edit merged — not the date the symptom stopped | org |
| 17 | Recurred since? | `checkbox` | — | Ticked means the fix did not hold: reopen and re-route through column 6 | derived from ch12 L601 |

**Footer rule 1 — stop and reassess.** A single blank the team fills in *before* its first cascade,
never during one: `Our cascade threshold: ___ consecutive fixes, then we stop and reassess.` The
published case ran five fixes deep before it closed; that is one project's history, printed as a
reference point, not as a recommended limit. When column 12 reaches the team's own number, the
next action is a reassessment of the approach, not a sixth fix.

**Footer rule 2 — the discipline.** Printed across the head of the sheet, above column 1:
*fix the file that should have prevented the mistake, not the generated code.* A row whose
column 8 records a manual correction to generated output is an unclosed row wearing a closed row's
clothes; it is the anti-pattern the whole log exists to convert.

**Absorbed detail.**

- `WS-CS-HB-persona-gap-register` (Gap-to-Primitive Register) is carried by **columns 3, 9 and 10**.
  Column 3 is the distinction that earns the merge: a gap noticed is a legitimate trigger with no
  failure attached to it, and a log that only accepts failures quietly discards half the habit.
  Column 9 is its one-off-versus-structural judgement and column 10 is its explicit policy field —
  we create a primitive rather than patching with an ad-hoc prompt.
- `WS-CS-PUB-cascade-log` (Cascade Fix Log and Micro-Wave Discipline) is carried by **columns 11 to
  14 and Footer rule 1**. Column 13 is the cascade's defining move — the rebuild exposing the next
  issue — and column 14 is the one-fix-rebuild-commit discipline made checkable. Footer rule 1 is
  its pre-set stop-and-reassess threshold.

**Deliberate omission.** No severity, effort or time-to-fix column. Those turn a triage log into a
ticketing system, and a triage log that feels like a ticketing system stops being filled at the
bench. Equally, no cumulative "failures prevented" counter and no progress bar towards a primitive
count — see §10.

## 6. Absorbed members (2)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-CS-HB-persona-gap-register` - Gap-to-Primitive Register

- **Address.** `case-study-handbook-writing.qmd` L170-214, Dynamic Persona Creation (`#sec-cs-handbook-persona-creation`)
- **Why folded.** The same habit and the same output column (the primitive edit that closed it); contributes the gap-versus-failure trigger distinction and the explicit create-a-primitive-not-an-ad-hoc-prompt policy field.
- **Fill detail to absorb.** Each time the process surfaces a gap, one row: the gap observed, whether it is a one-off or structural, the new primitive created in response (persona, skill, rule file), and the date. Includes an explicit policy field: we create a primitive rather than patching with ad-hoc prompts.
- **Its output was.** A living register that shows the primitive set growing from observed gaps rather than from up-front guesswork.

### `WS-CS-PUB-cascade-log` - Cascade Fix Log and Micro-Wave Discipline

- **Address.** `case-study-publishing-pipeline.qmd` L67-104, The "Almost Done" Trap: PDF Rendering Cascade (`#sec-cs-publishing-almost-done-trap`)
- **Why folded.** A worked exemplar of one anti-pattern rather than a separate sheet, per its own note; contributes the one-fix-rebuild-commit discipline and a pre-set stop-and-reassess threshold as a footer rule.
- **Fill detail to absorb.** One row per fix during a cascade: what was fixed, what the rebuild then exposed, whether it was committed before the next fix was attempted, and a running count. Plus a stop-and-reassess threshold the team sets in advance (the case ran five deep).
- **Its output was.** A visible cascade log that prevents speculative batching and makes an unbounded "almost done" loop obvious to the person paying for it.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-12-effective-context-trace` - Effective Context Trace (Pack Z - Second wave: the practitioner kit, fill order 5)

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** WS-12-project-decision-register; the monthly primitive review

## 8. Facilitation

| | |
|---|---|
| Who fills it | The engineer who hit the failure, in the hour they hit it. This is a bench instrument, not a workshop artefact — a facilitator only ever seeds it. The primitive owner named in column 15 closes the row by making the edit, so the two halves of every row have different authors by design. |
| When in the session | **Post-launch. This sheet is not filled in the pre-groundbreaking leadership session at all.** The condition that makes it worth standing up, stated plainly: *someone has manually corrected the same class of agent mistake twice.* Before that there is nothing to triage. Within Pack Z it follows `WS-12-effective-context-trace` — that trace tells you what was actually in context at the moment of the failure, and without it column 5 is guesswork dressed as diagnosis. |
| Duration | 45–60 minutes to stand up and seed with real failures; roughly five minutes per row thereafter, at the bench. In the standing-up session, budget most of the time for the argument about column 6 — routing a real failure to one of the six root causes is where the team learns the tree, and it is the only part a facilitator can teach. |
| Data needed in advance | Three to five real agent failures from the last fortnight, with the offending output actually kept rather than remembered; the current primitive inventory — agent configs, skills, instruction files, memory files, prompts — so column 5 can name a real path; the completed `WS-12-effective-context-trace`. |
| Room format | A screen, the repository open, and the real failures. The log lives in the repo under version control, because its commit history *is* the evidence that the loop is running. Do not ship it as a printed wall poster: a triage log that cannot be edited at the bench will not be edited at all. |

**Facilitation note.** Two things to say out loud when standing this up, both of which change how the
sheet is received. First, the discipline in Footer rule 2 — fix the file that should have prevented
the mistake, not the generated code — is the entire mechanism by which this log keeps every other
worksheet in the kit alive; the log is the "what you run after the workshop" annex to the whole pack.
Second, and for the leader in the room rather than the engineer: the chapter's observation that the
primitive set converges after roughly twenty to thirty iterations onto the conventions agents
actually violate is an **expectation about how long the loop takes to pay off**, not a target the
team is measured against. Present it as *this is roughly how long before it starts feeling worth it*.
Never as *you are behind at twelve*.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **Every row names a file in column 5.** A root cause with no named file is a description of a
   symptom, and the row cannot be closed. "The agent was confused" is not a context file.
2. **Every row's root cause is one of the six**, and column 7 either matches the book's routing or
   carries a written override reason in column 8. A row routed to a fix the tree does not sanction,
   with no reason given, is an unexamined guess.
3. **No row is closed by a manual correction.** Column 8 must name a primitive file and the text
   added to it. A row closed with "prompted again", "fixed it by hand" or "re-ran and it worked" is
   the anti-pattern the sheet exists to convert, and fails this criterion outright.
4. **Both trigger types appear in column 3.** If after a month of use every row reads
   `Failure observed`, the gap half of the habit is not running and the register is only doing half
   its job — the absorbed gap-to-primitive discipline has been silently dropped.
5. **Every cascade row has column 14 ticked**, or a stated reason why the fix was not committed
   before the next was attempted. An unbroken run of unticked column 14s is speculative batching,
   visible on the sheet by layout alone.
6. **The cascade threshold in Footer rule 1 is written, and it was written before any row carries a
   cascade step above one.** A threshold set during a cascade is a rationalisation, not a control.
7. **Every file path in column 5 resolves against the primitive inventory used for
   `WS-12-effective-context-trace`.** A path that appears here but not in that inventory is an
   undeclared primitive; a failure repeatedly routed to a file that trace shows was never loaded is
   a loading problem misfiled as a content problem, and belongs back with the trace.

## 10. Integrity constraint

**Named rule for this sheet.** The claim that the primitive set converges after ~20-30 iterations is an expectation to set, not a commitment to measure against.

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** The ASCII diagnosis tree supplies the root-cause picklist and the four-row table supplies worked examples from a real project. Adding date and owner columns completes it.
- **Fill (the organisation completing it): `S`.** S - one sitting, data already in the room

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Post-launch and practitioner-facing, hence priority 3 — but include it in the kit as the "what you run after the workshop" annex, because it is the operational habit that keeps every other worksheet alive. Structure is already there: the ASCII diagnosis tree at lines 578-588 gives the root-cause picklist and the four-row table at lines 594-601 gives worked examples from a real project. The discipline to state on the sheet: fix the file that should have prevented the mistake, not the generated code. The chapter claims the set converges after roughly 20-30 iterations onto the conventions agents actually violate rather than the ones the team theorised about — a useful expectation to set with leaders about how long the loop takes to pay off.
