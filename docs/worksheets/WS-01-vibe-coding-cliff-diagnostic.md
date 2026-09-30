# Vibe Coding Cliff Symptom Diagnostic

`WS-01-vibe-coding-cliff-diagnostic` &middot; **Pack B - Where we actually are** &middot; fill order **1** &middot; type `diagnostic` &middot; audience **eng-leader** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A named, evidence-backed list of where this organisation's own cliff is steepest - the input to deciding which repositories get context engineering first.

**Cluster.** `CL-OPENING-DIAGNOSTIC` - Where Our Cliff Is Steepest

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch01-the-agentic-sdlc-thesis.qmd` |
| Chapter | The Agentic SDLC Thesis |
| Heading | The Vibe Coding Cliff |
| Stable anchor | `#sec-thesis-vibe-coding-cliff` |
| Lines | L19-33 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch01-the-agentic-sdlc-thesis.html#sec-thesis-vibe-coding-cliff> |
| Locator quote | "The degradation follows a pattern. On a greenfield project" |

Resolve at any time with `python docs/resolve.py ws WS-01-vibe-coding-cliff-diagnostic`.

## 3. Source extract - the scaffolding, verbatim

```text
   19 | The degradation follows a pattern. On a greenfield project — no legacy code, no implicit conventions, no architecture to respect — the agent has almost nothing to get wrong. The context window is empty, and empty context can't mislead. As codebase complexity increases, the cliff gets steeper:
   20 | 
   21 | - **Context exhaustion.** A 10-million-line enterprise codebase cannot fit in any context window. The agent works with whatever fragment it receives, which means it works without the architectural decisions, the dependency constraints, and the tribal knowledge that make your system coherent. It's not working with less information — it's working with *different* information than a human engineer would use for the same task.
   22 | - **Hallucinated interfaces.** Without visibility into your actual API surface, the agent invents plausible-looking method signatures that don't exist. The code compiles in the agent's imagination and fails at build time. Worse, it sometimes calls real methods with wrong semantics — code that compiles, passes superficial review, and breaks in production.
   23 | - **Convention violations.** Your team's error-handling pattern, your logging standards, your module boundaries. None of these are visible to an agent unless someone has made them explicit. The agent doesn't break your rules on purpose. It doesn't know they exist.
   24 | 
   25 | The cliff isn't a bug in any particular tool. It's a structural property of how language models interact with complex systems. And it explains why adoption surveys consistently show the same split: high satisfaction on simple tasks, declining returns on complex ones. Cross-referencing the 2025 Stack Overflow survey and GitClear's code churn analysis suggests roughly 30–60% of agent-generated code on complex tasks requires significant rework, though no controlled study has established a definitive figure.[^ch1-rework] Not because the models are weak, but because the context is.
   26 | 
   27 | Name any experienced engineering team that has tried to move beyond autocomplete into agentic workflows on a production codebase. They've hit this cliff. The symptoms vary: a sprint spent cleaning up agent-generated code that "worked" but violated every architectural boundary, a security review that caught agent output bypassing the team's auth patterns, a junior developer who trusted agent output that a senior would have immediately flagged. But the underlying cause is always the same.
   28 | 
   29 | The cliff is not about intelligence. It's about information.
   30 | 
   31 | Most teams respond in one of two ways. Some retreat. They restrict AI tools to autocomplete and simple boilerplate, accepting a fraction of the potential value. Others push forward with brute force: longer prompts, more files stuffed into context, increasingly elaborate workarounds. They find that the problems get worse, not better.
   32 | 
   33 | Neither response addresses the root cause.
```

## 4. What the user fills

For each of the three named failure modes (context exhaustion, hallucinated interfaces, convention violations) the team writes a concrete incident from their own codebase: the repo/module, how often it recurs, and the undocumented knowledge that would have prevented it. A fourth column rates current pain 1-5.

## 5. Field-level schema

Four panels, filled in a deliberate order. **Panel D is filled first** — it is the front door of
the whole kit and takes ten minutes at the room door. **Panel A** is the diagnostic proper: one row
per named failure mode, three fixed rows, one sheet per team. **Panel B** is a three-row honesty
strip. **Panel C** is the constraint-pair self-diagnosis, three fixed rows. Panel A prints A3 per
team; B and C share the reverse; Panel D is a single wall sheet for the room.

**Panel A — cliff symptom diagnostic.** One row per failure mode, three fixed rows, one sheet per
team. No telemetry and no repository access are required to fill it — only memory and honesty,
which is why it is issued as a pre-read.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Failure mode | `select` (fixed 3 rows) | Context exhaustion / Hallucinated interfaces / Convention violations | — | ch01 L21-23 |
| 2 | What the book says goes wrong | `free text` | One line per row: the agent works with a fragment and therefore with *different* information than a human would use · the agent invents plausible method signatures, or calls real methods with wrong semantics · the agent does not break your rules on purpose, it does not know they exist | — | ch01 L21-23 |
| 3 | Our incident | `free text` | — | One concrete occurrence: what happened, when, what it cost | ch01 L27 |
| 4 | Repository / module | `free text` | — | Named. "Across the codebase" is not an answer. | org |
| 5 | Recurrence | `select` once / occasional / most sprints / continuous | — | The mark | derived |
| 6 | The undocumented knowledge that would have prevented it | `free text` | — | The specific convention, constraint or decision the agent could not see | ch01 L23, L29 |
| 7 | Where that knowledge lives today | `select` In code / In docs / In heads | Vocabulary deliberately shared with `WS-03`'s convention register | The mark | ch12 L433-438 |
| 8 | Current pain | `1-5 scale` | Anchors printed: **1** — we have never hit this. **2** — it has happened once and we absorbed it. **3** — it costs us review time most sprints. **4** — it has caused rework we had to schedule. **5** — it has caused a production incident, a failed security review, or a blocked release. | The mark | derived from ch01 L27 |
| 9 | Evidence type | `select` incident ticket / pull request / review comment / recollection | — | The mark. `recollection` is permitted and is itself a finding. | derived |
| 10 | Named by | `free text` | — | Who brought the incident | org |
| — | Book's stated prior — hedged, not a target | `free text` | Printed once as a boxed strip below the table, with its hedge intact: "roughly 30-60% of agent-generated code on complex tasks requires significant rework, though no controlled study has established a definitive figure" — a cross-reference of the 2025 Stack Overflow survey and GitClear's churn analysis, not a measurement of anyone's codebase | Not editable | ch01 L25 |
| — | **Our own rework rate** | `free text` | — | Adjacent blank cell. Either a measured figure sourced from `WS-08-baseline-measurement-plan` column 7, or the words `not measured`. Never inferred from the strip above it. | org |

**Panel B — current-state honesty strip.** One row per symptom, three fixed rows, filled by each
participant for their own team.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 11 | Symptom | `select` (fixed 3 rows) | "A single instructions file is being called AI-native development" · "Success is being measured by lines of code generated" · "AI-assisted code requires more rework, not less" | — | index L89 |
| 12 | Our mark | `select` true / partly true / not us | — | The mark | index L89 |
| 13 | Evidence for the mark | `free text` | — | Required for every mark including `not us` | index L89 |
| 14 | Marked by, and for which team | `free text` | — | — | org |

**Panel C — constraint-pair self-diagnosis.** One row per pair, three fixed rows.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 15 | Missing pair | `select` (fixed 3 rows) | Hierarchy without progressive disclosure · Reduced scope without composition · Safety boundaries without reduced scope | — | ch13 L378-384 |
| 16 | The chapter's failure story, in one line | `free text` | Printed per row, under a standing caveat that the chapter's stories are **fictional composites** distilled from consulting observations, not specific engagements: the agent received all the right rules at once and could not tell the relevant from the adjacent · pasted copies of a shared standard drifted and two services produced two error formats · a long session buried the security rule it was given at session start | Not editable | ch13 L376-384 |
| 17 | Symptoms we recognise | `checkbox` set | — | Tick what is true of this team | ch13 L378-384 |
| 18 | Our matching incident | `free text` | — | From the team's own history | ch13 L374 |
| 19 | Weakest pair | `checkbox` | — | Exactly one tick across the three rows | ch13 L386 |

**Panel D — stakeholder, track and decision map.** One row per person in the room. Filled before
anything else.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 20 | Name | `owner (named person)` | — | — | org |
| 21 | Role | `free text` | — | — | org |
| 22 | Reading-path row | `select` | Everyone · CEO / CTO / CIO / VP Engineering / Director / Head of Platform · Staff or principal engineer, tech lead, senior developer · Case-study reader | The row they identify with | reading-paths L11-16 |
| 23 | Track | `select` leadership (Parts I-II) / practitioner (Part III) / both | Track descriptions printed: what to decide and why · what to do Monday morning | — | ch01 L148-160 |
| 24 | The decision they personally own | `free text` | — | Required. An attendee with no decision is marked `observer` explicitly. | ch01 L148-152 |
| 25 | Deliverable they own | `free text` | — | — | ch01 L152 |
| 26 | Worksheets they are accountable for | `free text` | — | The assigned subset of the kit | derived |
| 27 | Due by | `date` | — | — | org |
| 28 | Decision rights | `select` signs off / executes / consulted / informed | — | — | derived |
| — | Unstaffed worksheets | `computed` | — | Any worksheet in the kit with nobody accountable — the gap this panel exists to surface | derived |

**Absorbed detail.** `WS-FM-role-track-selector` is Panel D columns 22-23 and 26: the reading-path
row each participant identifies with, their time budget expressed as the due date in column 27, and
the worksheet set assigned to them. `WS-01-transformation-stakeholder-map` is the rest of Panel D —
named individuals on a track, with role, decision rights, the deliverable they own and by when —
and its stated output, a staffed RACI showing who is missing, is the computed unstaffed-worksheets
row. `WS-FM-current-state-symptoms` is Panel B in its entirety, including its three-value mark and
its requirement that every mark name its evidence. `WS-13-constraint-failure-diagnosis` is Panel C:
its symptom tickboxes, its named-weakest-pair verdict and its requirement for a local incident, with
the chapter's fictional-composite caveat carried onto the sheet so the stories are not mistaken for
case evidence.

**Deliberate omission.** No composite cliff-severity score. The three failure modes have three
different remedies — a context budget, exposure of the real API surface, and instrumented
conventions — and a single number tells the reader which of the three to fund exactly as well as
no number at all. Also omitted: any quantification of rework beyond the labelled prior strip. The
quantitative counterpart is `handbook\ch03-the-business-case.qmd` L269-285 and its
rework-rate sensitivity worksheet; this sheet qualifies what that one quantifies, and the two are
cross-linked rather than merged.

## 6. Absorbed members (4)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-01-transformation-stakeholder-map` - Transformation Stakeholder & Track Map

- **Address.** `handbook\ch01-the-agentic-sdlc-thesis.qmd` L146-166, The Dual Path (`#sec-thesis-dual-path`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Named individuals placed on the leadership track or the practitioner track, each with role, decision rights, the deliverable they own, and which worksheets in this kit they are accountable for completing and by when.
- **Its output was.** A staffed RACI for the planning kit itself - who is in the room, who signs off, who executes, and who is missing.

### `WS-13-constraint-failure-diagnosis` - Constraint Pair Failure Self-Diagnosis

- **Address.** `handbook\ch13-the-prose-specification.qmd` L374-402, When Constraints Are Missing: Three Failure Stories (`#sec-prose-failure-stories`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Read the three failure stories and tick the symptoms the team recognises in itself, then name the constraint pair that is weakest using the pairing diagram — hierarchy without progressive disclosure, reduced scope without composition, safety boundaries without reduced scope — and write the concrete incident from the team's own history that matches.
- **Its output was.** A named weakest-pair diagnosis per team with a supporting local incident: the qualitative companion to the PROSE scorecard.

### `WS-FM-current-state-symptoms` - Where Are We Today? Opening Self-Diagnostic

- **Address.** `index.qmd` L87-93, Why This Book Exists (`#sec-preface-why`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Against each of the three symptoms named in the passage - a single instructions file being called AI-native development, success measured by lines of code generated, AI-assisted code requiring more rework not less - each participant marks true / partly true / not us for their own team, and names the evidence behind the mark.
- **Its output was.** A room-level honest picture of the current state, surfaced in the first ten minutes of the workshop and referenced for the rest of it.

### `WS-FM-role-track-selector` - Role and Track Selector: Which Path Am I On?

- **Address.** `reading-paths.qmd` L7-16, Reading paths (`#sec-reading-paths`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Each participant identifies their row from the For column (everyone; CEO/CTO/CIO/VP Engineering/Director/Head of Platform; staff or principal engineer, tech lead, senior developer; case-study reader), then records the decision they personally own in the transformation, their time budget, and the worksheet set assigned to them.
- **Its output was.** A per-participant track assignment that routes each person to the right subset of the worksheet pack - the front door of the whole delivery.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- None. This sheet can be filled cold.

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** WS-03-context-moat-asset-inventory

## 8. Facilitation

| | |
|---|---|
| Who fills it | Panel D: everyone in the room, including the executive sponsor, on arrival. Panel A: the engineering leader with at least one senior engineer per represented team who has personally run agents against the production codebase — this is the only qualification that matters, and a leader filling it alone will produce three plausible incidents that never happened. Panels B and C: each participant for their own team, individually. |
| When in the session | The opening page of Pack B and the opening page of the workshop. Panel D is filled at the door, before the first slide, because it routes every person present to the subset of the kit they are accountable for. Panel A follows immediately. The sheet has no prerequisites and needs nothing from any other worksheet; it is the warm-up that makes `WS-04-lifecycle-layer-coverage-canvas` and `WS-20-org-failure-amplifier-assessment` honest rather than abstract. |
| Duration | Panel D: 10 minutes at the door, plus 5 minutes to read the unstaffed-worksheets row aloud. Panel A: 30-40 minutes — walking pre-read returns, not composing them. Panel B: 10 minutes. Panel C: 20 minutes. Ninety minutes for the pack, of which the pre-read has already done the expensive part. |
| Data needed in advance | **Nothing from any system.** No telemetry, no repository access, no analytics. What is required instead is a pre-read issued a week out asking each represented team to bring one real incident per failure mode, with the repository named and the evidence type recorded. Teams that arrive without it will invent incidents in the room, and the sheet is then a description of the book rather than of the organisation. If `WS-08-baseline-measurement-plan` has already returned a measured rework rate, bring it for the adjacent-blank cell; if it has not, `not measured` is the correct entry. |
| Room format | Panel D on a flipchart at the door, filled as people arrive, left up for the duration. Panel A printed A3, one per team, filled at tables, then walked along the wall so the room sees whether the same module appears on three different sheets — it usually does, and that module is the first candidate for context engineering. Panels B and C on the reverse, filled individually and in silence before any comparison. |

**Facilitation note.** Three handles. First, the chapter names the two wrong responses — retreat to
autocomplete, or brute-force with longer prompts and more files stuffed into context (ch01 L31);
ask the room which of the two they have already done, and the answer reframes the session from
"should we adopt" to "why did what we already tried not work". Second, the cause is fixed even
though the symptoms vary: "the cliff is not about intelligence, it's about information" (L29), so
column 6 — not column 3 — is the column that carries value forward, and it should be given more of
the table's physical space than the incident column. Third, Panel C's stories are explicitly
fictional composites; say so when you hand them out, or a room will spend ten minutes trying to
work out which company they describe.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All three failure-mode rows carry a concrete incident naming a repository or module**
   (columns 3-4). "We see this generally" and "across the codebase" are not incidents. A team that
   genuinely has not hit one of the three records `not observed` and says why — most often because
   they have not yet run agents on that part of the estate, which is itself the finding.
2. **Every row names its evidence type, and at least one row per team cites an artefact** — a
   ticket, a pull request or a review comment — rather than recollection alone. A sheet that is
   entirely recollection is a set of impressions and must be marked as such before it is carried
   into Pack C.
3. **Column 6 is non-blank on every row scoring 3 or above in column 8,** and those entries are
   transcribed into `WS-03-context-moat-asset-inventory`'s convention register with the same
   In code / In docs / In heads mark. A pain-5 row with no named missing knowledge is a complaint,
   not a diagnosis.
4. **The 30-60% rework figure appears only inside the labelled prior strip, with its hedge intact,**
   and the adjacent cell holds either a figure traceable to `WS-08-baseline-measurement-plan` or the
   words `not measured`. It appears in no target, gate or acceptance criterion anywhere in the kit.
5. **Panel B has a mark and an evidence entry on all three rows,** including rows marked `not us` —
   an unevidenced `not us` is the denial the strip exists to catch.
6. **Panel C names exactly one weakest pair with a local incident,** and the printed sheet carries
   the chapter's fictional-composite caveat.
7. **Panel D has a row for every person present,** each with either a decision they personally own
   or an explicit `observer` mark, and the unstaffed-worksheets row is computed and read aloud. A
   worksheet in the kit with nobody accountable is recorded as a gap before the room disperses,
   because it will not be noticed again until the sheet is due.

## 10. Integrity constraint

**Hedged figures reachable from this source range.** Each is listed with the book's own hedge, verbatim, and where that hedge lives. Present the figure as a pre-filled prior the organisation overwrites, or as a facilitation prompt - never as a benchmark, target or acceptance threshold. **Carry the hedge onto the sheet with the number; do not restate it in your own words.**

- **Roughly 30-60% of agent-generated code on complex tasks requires significant rework.**
  - *Appears at* `handbook\ch01-the-agentic-sdlc-thesis.qmd` L20-30
  - *The book's hedge (ch01 L25):* NOT an author figure. Sourced: 'Cross-referencing the 2025 Stack Overflow survey and GitClear's code churn analysis suggests ... though no controlled study has established a definitive figure.'

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** Carried unchanged from _section-clusters.md section 7 for CL-OPENING-DIAGNOSTIC.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Source is three prose bullets (lines 21-23) plus the 30-60% rework figure at line 25. NO fillable structure exists - needs authoring, but the categories are clean and the exercise is fast. Facilitation tip: issue as a pre-read so leaders arrive with real incidents rather than inventing them in the room. Qualitative counterpart to ch03 rework-rate sensitivity (handbook\ch03-the-business-case.qmd lines 269-285), which quantifies what this qualifies - synthesizer should cross-link, not merge (different audiences, different sessions).
