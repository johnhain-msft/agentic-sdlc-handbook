# When It Goes Wrong: Our Six-Step Recovery Runbook

`WS-20-recovery-runbook` &middot; **Pack Z - Second wave: the practitioner kit** &middot; fill order **10** &middot; type `checklist` &middot; audience **practitioner** &middot; leadership priority **2**

> **Split back out in the re-opening pass.** A runbook pinned in the repo whose load-bearing field is who is authorised to call the stop -- an authority decision the triage log never makes; the cluster rationale itself calls it the front door.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A team recovery runbook pinned in the repo, with the failure-mode decision tree as its front door.

**Cluster.** `CL-RECOVERY-RUNBOOK` - Recovery Runbook and the Named Stop Authority

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch20-anti-patterns-and-failure-modes.qmd` |
| Chapter | Anti-Patterns and Failure Modes |
| Heading | The Recovery Playbook |
| Stable anchor | `#sec-anti-recovery-playbook` |
| Lines | L381-395 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch20-anti-patterns-and-failure-modes.html#sec-anti-recovery-playbook> |
| Locator quote | "When you've hit an anti-pattern and need to get back on track" |

Resolve at any time with `python docs/resolve.py ws WS-20-recovery-runbook`.

## 3. Source extract - the scaffolding, verbatim

```text
  381 | When you've hit an anti-pattern and need to get back on track, six steps:
  382 | 
  383 | 1. **Stop and assess.** Identify which anti-pattern from the taxonomy table. The symptom tells you where to look; the constraint tells you what's structurally wrong. Use the decision tree below — follow it until you reach a diagnosis, not a guess.
  384 | 
  385 | 2. **Snapshot what works.** Commit all passing code. Working code on a branch is preserved progress; code in an agent session is ephemeral.
  386 | 
  387 | 3. **Revert what doesn't.** If agent output has contaminated files beyond the task's scope, revert to the last known-good state. Don't salvage sprawling changes.
  388 | 
  389 | 4. **Decompose.** The most common recovery action. Whatever task was too large, too broad, or too underspecified: break it down. Write sub-tasks explicitly. Assign scope boundaries.
  390 | 
  391 | 5. **Fix the primitive.** Before re-dispatching, add whatever instruction was missing or insufficient. This is the step that converts a one-time recovery into a permanent improvement. Ask: which rule, if it had existed, would have prevented this failure? Write that rule. Scope it to the right level in the hierarchy.
  392 | 
  393 | 6. **Re-execute with constraints.** Fresh session, clean context, updated primitives, explicit scope boundaries. Re-execution costs less than debugging a contaminated session.
  394 | 
  395 | The hardest part is step 1 — not because identifying anti-patterns is difficult, but because it requires admitting the current approach isn't working. The sunk cost of a long session creates pressure to push forward. The playbook works only if you're willing to stop.
```

## 4. What the user fills

Per step of the six (stop and assess, snapshot what works, revert what doesn't, decompose, fix the primitive, re-execute with constraints): our concrete command or tool, our snapshot branch convention, our revert command, our decomposition rule of thumb, where the fixed primitive lands and who reviews it -- and, critically, WHO IS AUTHORISED TO CALL THE STOP.

## 5. Field-level schema

Two regions on one page. **Region A is the authority block at the head** — it is the reason the sheet
exists and is filled before anything else. **Region B is the step grid**, one row per step of the six,
with the book's step name and intent pre-printed and the team's concrete command supplied. A
diagnosis block sits between them as the front door to step 1. The sheet is portrait, one page,
pinned in the repository rather than framed on a wall.

**Region A — the authority block. Mandatory; the sheet is decoration without it.**

| # | Field | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| A1 | **Who is authorised to call the stop** | `owner (named person)` | — | A named individual. "The team", "whoever is driving" and "we'd discuss it" are not answers | ch20 L395 — "The playbook works only if you're willing to stop" |
| A2 | Deputy stop authority | `owner (named person)` | — | The named person who can call it when A1 is unavailable | derived from A1 |
| A3 | May anyone else call a stop? | `select` — `any engineer may call it` / `only A1 or A2` | — | If `any engineer`, A1 becomes the person who may **not** overrule it without writing a reason | derived |
| A4 | If the stop is contested, who decides | `owner (named person)` | — | The delivery-accountable person. Usually not A1 | derived |
| A5 | Where this runbook is pinned | `free text` | — | The repository path. A runbook nobody can find mid-session is not a runbook | ch20 L381 |
| A6 | Runbook owner | `owner (named person)` | — | Who keeps it current | org |
| A7 | Last rehearsed | `date` | — | Against the worked example or a real recovery | derived from ch20 L399-447 |

**Diagnosis block — the front door to step 1.** Pre-printed from the chapter's decision tree; the
team ticks its way through during a live recovery.

| # | Field | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| D1 | Which anti-pattern from the taxonomy | `select` (1-19) | The nineteen named anti-patterns, printed with their symptom line | Pick one | ch20 L20-38 |
| D2 | Syntax error? | `checkbox` | Yes routes to: model issue — upgrade or do it manually | — | ch20 fig-failure-decision-tree |
| D3 | Tests fail — agent's code or pre-existing? | `select` — `agent's` / `pre-existing` / `tests pass` | `agent's` routes to: context issue, narrow scope. `pre-existing` routes to: separate issue, skip | — | ch20 fig-failure-decision-tree |
| D4 | Follows conventions? | `checkbox` | No routes to: primitive gap — add a rule | — | ch20 fig-failure-decision-tree |
| D5 | Integrates correctly? | `checkbox` | No routes to: architecture issue — fix boundaries. Yes routes to: probably fine — check edges | — | ch20 fig-failure-decision-tree |
| D6 | Terminal reached | `select` (the five terminals above) | — | Tick only when the tree has resolved | ch20 L383 — "follow it until you reach a diagnosis, not a guess" |

**Region B — the step grid. One row per step; the six steps are fixed and ordered.**

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Step | `select` (fixed 6 rows) | Stop and assess / Snapshot what works / Revert what doesn't / Decompose / Fix the primitive / Re-execute with constraints | — | ch20 L383-393 |
| 2 | What the step is for | `free text` (read-only) | The chapter's one-line intent per step, printed | — | ch20 L383-393 |
| 3 | Our concrete action | `free text` | — | What we actually do — a command, a tool, a named convention. Not a restatement of column 1 | org |
| 4 | Worked example | `free text` (read-only) | The auth-module recovery printed once as a greyed exemplar band: the two-file commit, the `git checkout --` revert, the decomposition into three separately-contexted tasks, the auth-constraints primitive, the single-task re-dispatch | — | ch20 L399-447 |
| 5 | Who does it | `owner (named person)` or role | Step 1 defaults to A1 | The others are the engineer in the session unless named otherwise | derived |
| 6 | Evidence it happened | `free text` | — | The artefact left behind — commit SHA, branch name, primitive diff, ticket reference. A step with no artefact cannot be shown to have run | derived from ch20 L385 |
| 7 | Done | `checkbox` | — | Ticked during a live recovery, in order | ch20 L381 |

**Step 5 detail — the step that changes the economics.** Because step 5 is the one that converts a
one-time recovery into a permanent improvement, its row carries three extra blanks the other five do
not: *where the fixed primitive lands* (the file path and the level in the hierarchy it is scoped
to), *who reviews the primitive edit*, and the chapter's own question written out as a prompt —
**"which rule, if it had existed, would have prevented this failure?"** A step 5 row whose answer is
a corrected file rather than a corrected rule has not run.

**Absorbed detail.** None — this sheet absorbed no other candidate. It shares the fix-the-primitive
move with `WS-12-failure-triage-log`, deliberately: this sheet is the in-the-moment recovery
sequence, that one is the standing log across recoveries. Step 5 is the hand-off — the primitive edit
recorded here should appear as a row there, using the same file path. Keep the vocabularies
identical.

**Deliberate omission.** No time box, no "acceptable number of retries before stopping" and no
session-length threshold. The chapter is explicit that the obstacle is psychological rather than
procedural — sunk cost creates pressure to push forward — and a printed retry count would give that
pressure a number to argue with. The control is A1: a named person with the authority to stop,
which is why that field is mandatory and a threshold is not offered.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-20-nineteen-failure-mode-premortem` - Pre-Mortem: Which of the 19 Failure Modes Will We Hit? (Pack G - The plan we leave with, fill order 2)

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** WS-20-nineteen-failure-mode-premortem and team onboarding

## 8. Facilitation

| | |
|---|---|
| Who fills it | The team that will actually run it — the tech lead and the engineers who drive agent sessions — **plus whoever holds delivery accountability for the work those agents are doing**. Region A is an authority decision, not a technical one. If the person who can be named in A1, and the person who would be entitled to overrule them in A4, are not both in the room, the sheet cannot be completed and the session should be rescheduled rather than filled with a placeholder. |
| When in the session | Pack Z, once `WS-20-nineteen-failure-mode-premortem` has been completed in the leadership session and its output is available — the pre-mortem names which of the nineteen the team expects to hit, and D1 is the same taxonomy. This is a post-launch instrument in the sense that it earns its keep only once agents are running against real work; the condition that makes it worth running is that **the team has already had at least one session it wished it had abandoned earlier**. But fill it *before* the next one. A recovery runbook drafted mid-cascade is not a runbook, it is a rationalisation written by the person under sunk-cost pressure. |
| Duration | 60–90 minutes. Region B goes quickly: six rows of commands a team already knows. Region A is the session. Budget at least half the time for A1 through A4 and do not treat overrunning there as a failure of facilitation — it is the sheet working. |
| Data needed in advance | The completed `WS-20-nineteen-failure-mode-premortem`; the team's actual branch and commit conventions, so column 3 carries real commands rather than invented ones; the paths where primitives live, at each level of the hierarchy, for step 5; and agreement beforehand on who holds delivery accountability, so A4 is a recognition rather than a negotiation. |
| Room format | Drafted on a screen, then **pinned in the repository at the path recorded in A5** before the session ends. Rehearse it once in the room against the worked auth-module example before filing it — walk all six steps aloud with the example's specifics, so that the first time anyone reads the runbook is not the first time they are also in trouble. |

**Facilitation note.** The chapter names the obstacle precisely and it is worth reading aloud before
Region A is attempted: *"The hardest part is step 1 — not because identifying anti-patterns is
difficult, but because it requires admitting the current approach isn't working. The sunk cost of a
long session creates pressure to push forward. The playbook works only if you're willing to stop."*
The room will try to resolve A1 to "the team decides" or "we'd talk about it", and a facilitator
must not accept either. A collective is not an authority at the exact moment authority is needed,
because the collective is the thing under sunk-cost pressure. Either a named individual can call the
stop, or any engineer can call it and a named individual may not overrule it without writing down
why — those are the two shapes that survive contact with a bad Friday afternoon. Everything else on
this sheet is commands the team already knows.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **A1 names an individual, or A3 is set to `any engineer may call it`.** A stop authority recorded
   as "the team", "the lead and the PM together", "whoever is in the session" or any other collective
   fails this criterion outright, and the runbook must be treated as incomplete. This is the single
   field that distinguishes this sheet from decoration.
2. **A2 and A4 are both filled with named individuals, and A4 is not the same person as A1.** An
   authority with no deputy stops working the week they are on leave; an authority who is also the
   contest-resolver is not an authority anyone will contest.
3. **All six rows in Region B carry a concrete action in column 3** — a command, a tool invocation or
   a named convention. A row whose column 3 paraphrases column 1 ("assess the situation", "break it
   down") has not been filled; the test is whether an engineer who has never read the chapter could
   execute it.
4. **Step 5 names the primitive file path, the hierarchy level it is scoped to, and a named
   reviewer**, and answers the chapter's question in writing: which rule, if it had existed, would
   have prevented this failure. A step 5 row that records a corrected source file rather than a
   corrected rule has performed a fix, not a recovery.
5. **Every step names its evidence in column 6.** Recovery is auditable or it is remembered, and
   remembered recoveries are the ones that get skipped under pressure.
6. **A5 records a real repository path and A7 records a rehearsal date.** An unpinned, unrehearsed
   runbook is a document that was written rather than a procedure that exists.
7. **Reconciliation with `WS-20-nineteen-failure-mode-premortem`: every failure mode the pre-mortem
   flagged as likely for this team can be routed through the diagnosis block to one of the five
   terminals.** Where a flagged mode has no route — it produces no syntax error, breaks no test,
   violates no convention and integrates correctly — that is a real gap in the front door, and it is
   recorded on the sheet rather than discovered during the incident.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Six numbered steps plus a Failure Mode Decision Tree mermaid as the front door; the sheet adds our-command columns and the stop-authority field.
- **Fill (the organisation completing it): `S`.** S - one sitting, data already in the room

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Two locations, one candidate: the six steps at 381-393 and the Failure Mode Decision Tree mermaid at 451-478, which is the diagnostic front door for step 1 (syntax error -> tests fail -> follows conventions -> integrates correctly). The worked auth-module example at 399-447 is the facilitation walk-through for the session, not a separate worksheet. The chapter names the real organisational blocker at 395 -- "The playbook works only if you're willing to stop" -- which is why the worksheet must have a named stop authority, otherwise it is decoration. Step 5 (fix the primitive) is the step that converts a one-off recovery into a permanent improvement and links this page to the feedback-loop amplifier in WS-20-org-failure-amplifier-assessment. Post-launch operational instrument: valuable, but not part of the pre-groundbreaking exec kit.
