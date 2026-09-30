# First Week Commitment Register (Day 1 to Day 5)

`WS-27-first-week-plan` &middot; **Pack G - The plan we leave with** &middot; fill order **3** &middot; type `roadmap` &middot; audience **mixed** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A signed one-week commitment register - the concrete artifact a pre-groundbreaking workshop should send participants home with.

**Cluster.** `CL-FIRST-WEEK` - First Week Commitment Register

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch27-what-comes-next.qmd` |
| Chapter | What Comes Next |
| Heading | Your First Week: What to Do Starting Monday |
| Stable anchor | `#sec-next-first-week` |
| Lines | L147-177 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch27-what-comes-next.html#sec-next-first-week> |
| Locator quote | "For leaders who read Parts I–II and practitioners who read Part III" |

Resolve at any time with `python docs/resolve.py ws WS-27-first-week-plan`.

## 3. Source extract - the scaffolding, verbatim

```text
  147 | For leaders who read Parts I–II and practitioners who read Part III, here is the concrete version. Not principles. Actions.
  148 | 
  149 | ### Day 1: Audit One Module
  150 | 
  151 | Pick the module your team changes most frequently. Not the biggest module, the most-changed one. Run the methodology from Chapter 12: identify implicit knowledge, undocumented conventions, architectural decisions that exist only in your team's memory. Write down what you find. You are not fixing anything today. You are measuring the gap between what an agent can see and what your team knows.
  152 | 
  153 | **Deliverable:** A list of 5–10 implicit conventions that an agent would violate on its first task in this module.
  154 | 
  155 | ### Day 2: Write Your First Three Primitives
  156 | 
  157 | Take the top three conventions from yesterday's audit. Write each as an instruction file — one organizational standard, one architectural constraint, one domain-specific rule. Follow the format from Chapter 12, under the constraints from Chapter 13: scoped, testable, specific. Do not try to document everything. Three primitives that cover the most common mistakes are worth more than thirty that cover edge cases.
  158 | 
  159 | **Deliverable:** Three instruction files, committed to your repository.
  160 | 
  161 | ### Day 3: Test Against a Real Task
  162 | 
  163 | Pick a task from your current sprint — something an agent would plausibly handle. Run it twice: once without your new context files, once with them. Compare the output. Did the context files prevent the mistakes you predicted? Did they cause new problems? Record the before-and-after. This is your first data point, not your conclusion.
  164 | 
  165 | **Deliverable:** A before-and-after comparison with specific examples of what changed.
  166 | 
  167 | ### Day 4: Measure and Adjust
  168 | 
  169 | Review yesterday's comparison honestly. Which files made a difference? Which were ignored or misinterpreted by the agent? Revise the ones that didn't land. This is the calibration loop from Chapter 15: context files are not documentation, they are engineering artifacts that need testing and iteration like any other code.
  170 | 
  171 | **Deliverable:** Revised instruction files based on observed agent behavior.
  172 | 
  173 | ### Day 5: Share and Plan
  174 | 
  175 | Show your team the before-and-after. Not a presentation — a 15-minute demo at standup. Show the worst agent output without instrumentation and the improved output with it. Then plan: which modules get instrumented next? Who owns which instruction files? How do you keep them current as the code evolves?
  176 | 
  177 | **Deliverable:** A team agreement on next steps and ownership.
```

## 4. What the user fills

Five dated rows, one per day, each carrying the chapter's named deliverable plus three fields the reader supplies: the named owner, the specific module or team it applies to, and a done/not-done signature. Day 1 the most-changed module and 5-10 implicit conventions; Day 2 three instruction files; Day 3 a with/without comparison on a real sprint task; Day 4 revised files; Day 5 a 15-minute demo and an ownership agreement.

## 5. Field-level schema

Rows are time horizons: the five days, then Week 2, Week 3 and the Ongoing monthly band, then a
clearly separated extension band. The format is an A3 landscape register with one signature strip
per row — this is the artefact participants take home, so every row is individually signable and
the sheet reads top to bottom as a week, not as a project plan.

**A visible rule is printed across the sheet beneath the Ongoing band, and it is not decorative:**
*Everything below this line is authored for this kit. The handbook's own plan ends at Day 5
(ch27 L149-177); Chapter 12 carries it to Week 3 and a monthly cadence (ch12 L717-734). Days 30,
60 and 90 are our extension.* Column 2 carries the same distinction per row so it survives being
photocopied.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Horizon | `select`, locked | Day 1 · Day 2 · Day 3 · Day 4 · Day 5 · Week 2 · Week 3 · Ongoing (monthly) · Day 30 · Day 60 · Day 90 | — | ch27 L149-177; ch12 L719-725 |
| 2 | Source band | `computed`, locked | `ch27` for Days 1–5 · `ch12` for Weeks 2–3 and Ongoing · **`AUTHORED — not in the book`** for Days 30, 60 and 90 | — | derived |
| 3 | Action | `free text`, locked | Audit one module · write your first three primitives · test against a real task · measure and adjust · share and plan | — | ch27 L149-175 |
| 4 | Deliverable | `free text`, locked | A list of 5–10 implicit conventions an agent would violate on its first task in this module · three instruction files, committed to your repository · a before-and-after comparison with specific examples of what changed · revised instruction files based on observed agent behaviour · a team agreement on next steps and ownership | — | ch27 L153, L159, L165, L171, L177 |
| 5 | Module or team it applies to | `free text` | — | The specific module and the specific team. A register filled at organisation level is not executable on Monday | derived |
| 6 | Owner | `owner (named person)` | — | One named person per row. The same name may recur | derived |
| 7 | Target date | `date` | — | Real calendar dates, Monday to Friday of a named week. "Next week" is not a date | derived |
| 8 | Done | `checkbox` | — | — | derived |
| 9 | Done, signed | `signature` | — | Signed per row. This is the register's mechanism: five small signatures, not one large one | derived |
| 10 | Evidence artefact | `free text` | — | The commit, the file path, the comparison document, the standup date. Every row has one | derived |
| 11 | **Day 1** — The most-changed module, and how we know | `free text` | "Pick the module your team changes most frequently. Not the biggest module, the most-changed one." | The module, plus the query or commit count that identified it. Picking by intuition reproduces the bias the day exists to remove | ch27 L151 |
| 12 | **Day 1** — Implicit conventions found | `free text` | The deliverable's shape is a list of 5–10 conventions an agent would violate on its first task here — the book's specification for the deliverable, not a performance target | The conventions, written out | ch27 L151-153 |
| 13 | **Day 2** — The three primitives | `free text` + `owner (named person)` (three rows) | One organisational standard · one architectural constraint · one domain-specific rule. Scoped, testable, specific. "Three primitives that cover the most common mistakes are worth more than thirty that cover edge cases" | The three files, with an author each | ch27 L157 |
| 14 | **Day 2** — Commit reference | `free text` | The deliverable is explicitly "committed to your repository" | A commit SHA or PR link. An uncommitted primitive is a draft | ch27 L159 |
| 15 | **Day 3** — The sprint task used | `free text` | "Pick a task from your current sprint — something an agent would plausibly handle" | The actual ticket | ch27 L163 |
| 16 | **Day 3** — Result without context files / with context files | `free text` (two cells) | "Run it twice: once without your new context files, once with them" | Both outputs, recorded. One run is not a comparison | ch27 L163 |
| 17 | **Day 3** — Predicted mistakes: prevented? | `select` prevented / not prevented / new problem introduced | The day asks both questions: did the context files prevent the mistakes you predicted, and did they cause new problems | Per predicted mistake. "This is your first data point, not your conclusion" | ch27 L163 |
| 18 | **Day 4** — Which files made a difference, which were ignored or misinterpreted | `free text` | — | Named per file. A day-4 row that says "all three helped" has not reviewed honestly | ch27 L169 |
| 19 | **Day 4** — Revision made | `free text` | "Revise the ones that didn't land… context files are not documentation, they are engineering artifacts that need testing and iteration like any other code" | The revision, with a commit reference | ch27 L169 |
| 20 | **Day 5** — Demo held: date and attendees | `date` + `free text` | A 15-minute demo at standup, not a presentation. Show the worst agent output without instrumentation and the improved output with it | The date it actually happened and who was there | ch27 L175 |
| 21 | **Day 5** — Next modules to instrument, in order | `free text` | — | An ordered list, not a set | ch27 L175 |
| 22 | **Day 5** — Who owns which instruction file | `owner (named person)` per file | — | One named owner per file, not one owner for all files | ch27 L175 |
| 23 | **Day 5** — How we keep them current as the code evolves | `free text` | — | The mechanism, not the intention. "We'll review them" is not a mechanism; a calendar entry with an owner is | ch27 L175 |
| 24 | **Week 1 files** — File | `free text`, locked (three rows) | Global instructions: 10–15 lines of non-negotiable principles · one scoped instruction file for your most-edited module · one agent configuration for the task agents perform most often | — | ch12 L719 |
| 25 | **Week 1 files** — Author | `owner (named person)` | — | A named author per file. These three reconcile to the three primitives in column 13 | ch12 L719 |
| 26 | **Week 2** — The real work these files will be exercised on | `free text` | "Use these files on real work" | The named workstream | ch12 L721 |
| 27 | **Week 2** — Conventions violated and added | `free text` | "When the agent violates a convention not covered by your files, add it. When it does something right that surprised you, check whether your instrumentation contributed" | Both directions recorded | ch12 L721 |
| 28 | **Week 2** — Memory file updated | `checkbox` + `free text` | "Update the memory file with the decisions and trade-offs you resolved this week" | The tick and the file reference | ch12 L721 |
| 29 | **Week 3** — First skill extracted | `free text` | The trigger is named: "you'll know it's time when you've written the same guidance in two different instruction files." Package the shared knowledge as a skill with a decision framework | The skill, and the two files that triggered it | ch12 L723 |
| 30 | **Week 3** — First prompt file | `free text` | The trigger is named: a task you have now asked an agent to do three or more times | The prompt file and the task it covers | ch12 L723 |
| 31 | **Ongoing** — Monthly review owner and date | `owner (named person)` + `date` | "Review context files monthly" | A named person and a recurring calendar date, set now | ch12 L725 |
| 32 | **Ongoing** — Rules removed / tightened / added | `free text` | Remove rules that never trigger · tighten rules that trigger but don't prevent the failure · add new rules only in response to observed failures. "Treat your instrumentation like a test suite: it should grow with the codebase, stay accurate, and never contain dead rules" | The three counts and the reasoning, each month | ch12 L725 |
| 33 | **Extension (AUTHORED)** — Commitment | `free text` | — | What we commit to at Day 30, 60 and 90. Printed below the rule and labelled in column 2 as not from the book | derived |
| 34 | **Extension (AUTHORED)** — Owner, evidence and review date | `owner (named person)` + `free text` + `date` | — | Same three fields as every other row, so the extension is held to the same standard it extends | derived |

**Absorbed detail.** `WS-12-instrumentation-rollout-roadmap` is columns 24–32 plus the Week 2,
Week 3 and Ongoing rows themselves: its three named week-one files each with an author (24–25),
the real work week two exercises them on (26–27) including the memory-file update (28), week
three's first extracted skill and first prompt file with the book's own trigger conditions printed
(29–30), and the ongoing monthly review with a named owner, a date and the remove/tighten/add
discipline (31–32). Nothing of it is dropped; the three week-one files in column 24 are the same
three artefacts as the Day 2 primitives in column 13, and the sheet says so rather than asking for
them twice.

**Deliberate omission.** No metric, ratio or improvement percentage anywhere on this register.
ch27 L163 is explicit that the Day 3 comparison is "your first data point, not your conclusion",
and a quantified first week invites the team to report a number from a sample of one. Measurement
belongs to `WS-08-baseline-measurement-plan` and `WS-05-board-reporting-scorecard`.

**Deliberate omission.** The extension band carries no pre-filled content at all. The book stops at
Week 3 and a monthly cadence; pre-writing Days 30, 60 and 90 would put authored commitments in the
same visual register as sourced ones, which is the confusion the printed rule exists to prevent.

## 6. Absorbed members (1)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-12-instrumentation-rollout-roadmap` - Instrumentation Rollout Roadmap: First Three Weeks

- **Address.** `handbook\ch12-the-instrumented-codebase.qmd` L717-734, Starting Points (`#sec-codebase-starting-points`)
- **Why folded.** Two competing first-N-days plans is the same defect as two competing roadmaps; contributes weeks two and three and the three named week-one files with an author each, extending the five-day plan.
- **Fill detail to absorb.** A dated plan per pilot team following the chapter's phases: week one, the three named files (global instructions of 10-15 lines, one scoped instruction file for the most-edited module, one agent configuration for the most common task) with an author for each; week two, the real work the files will be exercised on; week three, the first skill to extract and the first prompt to write; then the ongoing monthly review owner and date.
- **Its output was.** A week-by-week rollout plan with named owners and named files — the executable annex that turns the audit into motion.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- None. This sheet can be filled cold.

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** WS-06-team-readiness-scorecard (which team executes it) and the 30/60/90 extension of the same register

## 8. Facilitation

| | |
|---|---|
| Who fills it | The people who will actually do it: the tech lead and the developers of the team that goes first, with the engineering leader present to accept the ownership entries rather than to fill them. The five days are practitioner work; the leader's job in this session is to confirm that Day 1 to Day 5 are protected from other commitments, and to sign against nothing. |
| When in the session | The final session of the workshop. It has no prerequisites and could be filled cold, but it should not be — run last, it consumes every earlier worksheet, and the module in column 11, the owners in column 22 and the ordered list in column 21 all fall out of decisions the room has already made. |
| Duration | 45 minutes. It is a small sheet and the content is written; the time goes on columns 5, 6 and 7 — the specific module, the specific person, the specific date — and on column 23, which is where the room discovers whether it has a maintenance mechanism or an intention. The extension band takes ten minutes and is optional. |
| Data needed in advance | Commit or change-frequency counts by module for the pilot team's repository, so Day 1 picks the most-changed module on evidence rather than on memory; next week's sprint contents, so Day 3 names a real ticket; the team's standup time and day, for Day 5; and the completed `WS-08-pilot-selection-and-scope`, so the team and module here are the team and module in the contract. |
| Room format | A3 landscape, one printed copy per participating team, filled by hand and signed in the room, then photographed before anyone leaves. The photograph is the point: this is the artefact a pre-groundbreaking workshop sends people home holding, and the version that exists only as a promise to type it up later does not survive the journey. |

**Facilitation note.** Run this last so it inherits the room's decisions, and keep it small.
The failure mode is generalisation: a register that names "the payments team" and "a module" and
"next week" is unexecutable on Monday morning, and will be quietly abandoned by Wednesday. Insist
on a named module, a named ticket, a named person and five calendar dates. Two rows earn extra
attention. **Day 1**: ask how the module was chosen and require the evidence in column 11 — the
instinct is to pick the most important module, and the chapter says explicitly *not the biggest
module, the most-changed one*. **Day 5**: the deliverable is an ownership agreement, so do not let
column 22 collapse into a single name; one owner for all the instruction files is no owner in six
weeks' time. Finally, point at the printed rule before filling the extension band and say out loud
that Days 30, 60 and 90 are the kit's authoring, not the book's — participants will otherwise cite
them back as the handbook's plan.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All five days carry a named individual (column 6) and a specific calendar date (column 7).**
   Five dates in one named week, Monday to Friday. A register with a person but no date, or a date
   but no person, does not start on Monday.
2. **Column 5 names a specific module and a specific team on every row**, and Day 1's module is
   supported by the evidence in column 11 — a commit count, a change-frequency query or an
   equivalent. Chosen by intuition, it will be the biggest module rather than the most-changed one,
   which is the failure the day's own wording rules out.
3. **Day 2's three primitives exist as committed files with a reference in column 14**, and each
   has a named author in column 25. Three uncommitted drafts do not satisfy the book's deliverable.
4. **Day 3 records both runs.** Columns 16 and 17 show a with-and-without comparison on a named
   sprint ticket, including any new problems the context files introduced. A single run recorded as
   a success fails this criterion.
5. **Day 5 names more than one file owner in column 22 and a maintenance mechanism in column 23.**
   A single owner for every instruction file, or "we'll keep them updated", means the team agreement
   the day is supposed to produce has not been reached.
6. **Every completed row is signed individually in column 9 and carries an artefact in column
   10.** The register is a commitment device; a single signature at the foot defeats it.
7. **Column 2 is correct on every row, and the printed rule is intact.** Days 30, 60 and 90 are
   labelled `AUTHORED — not in the book`. A copy of this sheet in which the extension band is
   indistinguishable from the sourced band must not be distributed.
8. **The team and module reconcile with `WS-08-pilot-selection-and-scope`.** The team here is a
   selected pilot team there, and the module sits inside the bounded workstream in that contract's
   column 10 — a first week executed outside the agreed pilot scope is an unmeasured pilot.
9. **The Week 1 files in column 24 are the same three artefacts as the Day 2 primitives in column
   13**, not a second set. If they differ, the team has committed to six files in week one and will
   deliver three.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Carried unchanged from _section-clusters.md section 7 for CL-FIRST-WEEK.
- **Fill (the organisation completing it): `S`.** S - one sitting, data already in the room

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> The flagship instrument of the entire closing chapter and the easiest to build: the book already supplies five days, five explicit **Deliverable:** lines, and specific instructions per day (pick the most-changed module not the biggest; three primitives beat thirty; run the task twice, with and without). Only owner, date and signature need adding. Facilitation tip: run this as the final session of the workshop so it consumes every earlier worksheet. Extend to 30/60/90 for the leadership delivery - the book stops at day 5, so days 6-90 need authoring and should be marked as such.
