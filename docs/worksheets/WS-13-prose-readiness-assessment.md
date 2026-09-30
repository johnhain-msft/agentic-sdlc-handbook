# PROSE Readiness Assessment and Remediation Plan

`WS-13-prose-readiness-assessment` &middot; **Pack Z - Second wave: the practitioner kit** &middot; fill order **7** &middot; type `rubric` &middot; audience **mixed** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A dated PROSE scorecard per repository or team, plus a remediation backlog ordered by blast radius.

**Cluster.** `CL-SPEC-CONTEXT-DESIGN` - Specification and Context Design Kit

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch13-the-prose-specification.qmd` |
| Chapter | The PROSE Constraints |
| Heading | Compliance Checklist |
| Stable anchor | `#sec-prose-compliance-checklist` |
| Lines | L535-565 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch13-the-prose-specification.html#sec-prose-compliance-checklist> |
| Locator quote | "Use this checklist to evaluate whether your current setup satisfies PROSE constraints" |

Resolve at any time with `python docs/resolve.py ws WS-13-prose-readiness-assessment`.

## 3. Source extract - the scaffolding, verbatim

```text
  535 | Use this checklist to evaluate whether your current setup satisfies PROSE constraints. Each question is specific enough to answer with a definitive yes or no.
  536 | 
  537 | ::: {tbl-colwidths="[5,18,70,7]"}
  538 | 
  539 | | # | Constraint | Question | Pass |
  540 | |---|---|---|---|
  541 | | P1 | Progressive Disclosure | Does every instruction file over 100 lines use links (not inline content) for subsidiary topics? | |
  542 | | P2 | Progressive Disclosure | Does every cross-reference link include a description of what the target contains (not just a filename)? | |
  543 | | R1 | Reduced Scope | Can you state each agent task in one sentence with a single deliverable? | |
  544 | | R2 | Reduced Scope | Do multi-step workflows start each phase with a fresh context (no accumulated session state)? | |
  545 | | O1 | Orchestrated Composition | Does each instruction file address exactly one concern (check: could you name the file after its single topic)? | |
  546 | | O2 | Orchestrated Composition | Do workflow prompts reference shared instruction files by link rather than pasting their content? | |
  547 | | S1 | Safety Boundaries | Does every agent configuration have an explicit `tools` list (no wildcards)? | |
  548 | | S2 | Safety Boundaries | Is there a `**STOP**` gate before every operation that modifies auth, database schemas, or production config? | |
  549 | | S3 | Safety Boundaries | Does every agent have a file-path boundary (explicit list of directories it may modify)? | |
  550 | | E1 | Explicit Hierarchy | Do instructions exist at three or more specificity levels (e.g., root → domain → module)? | |
  551 | | E2 | Explicit Hierarchy | Can you add module-specific rules without editing any file above that module's scope? | |
  552 | 
  553 | :::
  554 | 
  555 | **If you fail S1, S2, or S3** — start there regardless of your total score. Safety gaps have the highest blast radius and are the fastest to close (one YAML change per agent).
  556 | 
  557 | **If you fail E1 or E2** — address these next. Hierarchy is the fastest architectural change to implement (create two scoped files and you have three levels).
  558 | 
  559 | **If you fail P1, P2, R1, R2, O1, or O2** — these are discipline and refactoring issues. Prioritize whichever constraint maps to the failure mode you are currently experiencing. Scope creep? Fix R1/R2. Context dilution? Fix P1/P2. Debugging nightmares? Fix O1/O2.
  560 | 
  561 | ---
  562 | 
  563 | The five constraints are the specification. The chapters that follow (the load lifecycle and attention economy in Chapters 14 and 15, multi-agent orchestration in Chapter 17, and the execution meta-process in Chapter 18) are the implementation. Every technique in those chapters traces back to one or more constraints defined here. When a technique works, it is because it satisfies the relevant constraint. When it fails, the constraint it violates tells you where to look.[^ch10-spec]
  564 | 
  565 | ---
```

## 4. What the user fills

Answer the eleven yes/no compliance questions (P1, P2, R1, R2, O1, O2, S1, S2, S3, E1, E2) with evidence — a file path or a counter-example — for each, then roll the answers up into a score per constraint and order the failures using the chapter's own triage: safety gaps first, hierarchy next, discipline and refactoring last.

## 5. Field-level schema

Four surfaces, one dated scorecard per repository or team. **A** is the eleven-question compliance
checklist — the book prints that table already carrying an empty `Pass` column, and this sheet is
that table plus the evidence column it needs to be worth anything. **B** is the five-constraint
rollup and the executive-reporting layer. **C** is the file-by-file disclosure and refactor
inventory, one row per existing primitive file. **D** is the structural-properties control map. A
and B face each other on one A3; C is a spreadsheet; D is a five-row block filled last. Every
surface carries the same header date and assessor, because the output artefact is a *dated*
scorecard.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| — | Scope | `free text` | — | The repository or team assessed | org |
| — | Assessment date | `date` | — | — | org |
| — | Assessor | `owner (named person)` | — | — | org |
| A1 | # | `select` (fixed 11) | P1, P2, R1, R2, O1, O2, S1, S2, S3, E1, E2 | — | ch13 L541-551 |
| A2 | Constraint | `free text`, pre-printed | Progressive Disclosure ×2, Reduced Scope ×2, Orchestrated Composition ×2, Safety Boundaries ×3, Explicit Hierarchy ×2 | — | ch13 L541-551 |
| A3 | Question | `free text`, pre-printed verbatim | All eleven questions, unedited — each one specific enough to answer with a definitive yes or no | — | ch13 L535-551 |
| A4 | Pass | `select` — Pass / Fail | The book's own column, which ships empty | Pass or Fail | ch13 L539-551 |
| A5 | Evidence | `free text` | — | **Mandatory.** A file path for a Pass; a named counter-example file for a Fail | derived |
| A6 | Remediation band | `computed` | Band 1 = S1, S2, S3 — start here regardless of total score, highest blast radius and fastest to close, one YAML change per agent. Band 2 = E1, E2 — fastest architectural change, two scoped files gives three levels. Band 3 = P1, P2, R1, R2, O1, O2 — discipline and refactoring | — | ch13 L555-559 |
| A7 | Owner | `owner (named person)` | — | Required for every Fail | derived |
| A8 | Target date | `date` | — | Required for every Fail | derived |
| B1 | Constraint | `select` (fixed 5) | Progressive Disclosure, Reduced Scope, Orchestrated Composition, Safety Boundaries, Explicit Hierarchy | — | ch13 L16-22 |
| B2 | Addresses / Induces | `free text`, pre-printed | The constraint-model pairs — context overload / efficient context utilization; scope creep / manageable complexity; monolithic collapse / flexibility and reusability; unbounded autonomy / reliability and verifiability; flat guidance / modularity and domain adaptation | — | ch13 L16-22; ch01 L63-69 |
| B3 | Today's practice | `select` — absent / ad hoc / documented / enforced | — | Which | derived |
| B4 | Artefact or control that satisfies it | `free text` | — | The named file, gate, job or policy | derived |
| B5 | Checklist items rolling up | `computed`, pre-printed | P → P1, P2; R → R1, R2; O → O1, O2; S → S1, S2, S3; E → E1, E2 | — | ch13 L541-551 |
| B6 | Matching anti-pattern exhibited | `checkbox` | The five pre-printed with their consequences — Context dumping (P), Scope creep (R), Monolithic prompt (O), Unbounded agent (S), Flat instructions (E) | Tick per row | ch01 L112-118 |
| B7 | One example of the anti-pattern | `free text` | — | **Mandatory when B6 is ticked.** A file, a prompt, an agent configuration or a session | ch01 L112-118 |
| C1 | Path | `free text` | — | Every existing instruction file, skill, persona and prompt | ch13 L75-104 |
| C2 | Line count | `computed` | — | Measured | derived |
| C3 | Over the ch12 design **target** of 40-50 lines | `checkbox` | The statement printed beside the column: "If your instruction file exceeds 40-50 lines, it's trying to do too much," with its mechanical reason — every line of instruction competes for attention with the source code the agent needs to read | Tick | ch12 L74 |
| C4 | Over the ch13 P1 **hard trigger** of 100 lines | `checkbox` | Checklist item P1 printed beside the column: does every instruction file over 100 lines use links, not inline content, for subsidiary topics? | Tick | ch13 L541 |
| C5 | Subsidiary topics currently inlined | `free text` | The before/after pair printed as the worked example — five inlined sections against five labelled pointers | Listed, by heading | ch13 L81-102 |
| C6 | Target file each inlined topic extracts to | `free text` | The after block's target paths shown as the shape | The org's own paths | ch13 L93-102 |
| C7 | Every cross-reference carries a descriptive label | `select` — yes / no / not applicable | The after block's labelled pointers ("Authentication patterns and token lifecycle", not `auth.md`) | Which | ch13 L93-102, L542 |
| C8 | Single concern — could you name the file after its one topic? | `checkbox` | — | Tick per file | ch13 L545 |
| C9 | Refactor action | `select` — split / extract / relabel links / none | The chapter's own fix: pointers with descriptive labels, same information, a fraction of the context cost per task | Which | ch13 L91-104 |
| C10 | Owner and target date | `owner (named person)` + `date` | — | Required for every action other than `none` | derived |
| C11 | Rolls up to | `computed` | P1 (C4 + C5), P2 (C7), O1 (C8) | — | ch13 L541-545 |
| D1 | Structural property | `select` (fixed 5) | Context will remain finite and fragile; output will remain probabilistic; explicit knowledge will remain more valuable than implicit; human judgment will remain the bottleneck and the differentiator; composition will remain necessary | — | ch27 L96-104 |
| D2 | PROSE constraint it maps to | `free text` — marked `derived` on the printed sheet | The book's assertion that the five properties "map directly to the PROSE constraints", printed beside the column **without** a row-by-row correspondence, because the book does not print one | The team's own mapping, labelled as the team's reading | ch27 L106 — mapping is `derived` |
| D3 | Our named control | `free text` | — | The specific control, not an intention | ch27 L96-104 |
| D4 | Owner | `owner (named person)` | — | — | org |
| D5 | How it is verified | `free text` | — | The check that would catch the control having lapsed | derived |
| D6 | Control in place | `select` — present / partial / absent | — | Which | derived |

**Two different tests, and the book does not reconcile them.** Columns C3 and C4 are both present
by design and both must be filled.

- **C3 is a target.** Ch12 (L74) states it as a design ceiling with a mechanical justification:
  *"If your instruction file exceeds 40-50 lines, it's trying to do too much… every line of
  instruction competes for attention with the source code the agent needs to read."*
- **C4 is a hard trigger.** Ch13's checklist item P1 (L541) asks whether every instruction file
  **over 100 lines** uses links rather than inline content for subsidiary topics.

The book states these in two different chapters and does not reconcile them, and the practical
consequence is real rather than academic: a 70-line file passes P1 and fails ch12's design test at
the same moment, so a team auditing only against P1 will certify files ch12 calls broken. A reading
that reconciles them exists — 40-50 as the size a well-factored file naturally sits at, 100 as the
point where progressive disclosure stops being advisable and becomes mandatory — **but the book
never states it, and settling it is not this worksheet's job.** Carry both columns, label them on
the sheet as printed here (*target* and *hard trigger*), and print this line beneath them:

> *The book states 40-50 lines (ch12) and 100 lines (ch13, checklist item P1) in different chapters
> without reconciling them. This sheet records both, as two different tests. The intended reading
> is an open question for the author.*

Do not average the two. Do not choose one. And do not allow C3 to be dropped in a later revision on
the grounds that C4 is "the checklist one" — C3 is the column that surfaces the files nobody would
otherwise open.

**Absorbed detail.** All three merged candidates occupy named surfaces; none was reduced to a
mention. `WS-01-prose-constraint-readiness` is **surface B in full** — its five-constraint
scorecard is B1/B3/B4, its four-level scale (absent / ad hoc / documented / enforced) is B3's
select list, and its anti-pattern hit-list is B6/B7 with all five anti-patterns pre-printed and one
concrete example demanded per tick. B5 is the one addition: it exists so that the executive rollup
and the eleven-question detail cannot report different answers about the same estate.
`WS-13-disclosure-refactor-audit` is **surface C in full** — path C1, line count C2, the threshold
flags C3 and C4, the inlined subsidiary topics C5, the extraction target C6 and the
descriptive-label check C7 — and it is where the 40-50 versus 100 conflict prints, as its folding
note required. C8 and C11 are additions, so the file-level backlog rolls up into the checklist
items it actually evidences (P1, P2, O1) instead of sitting beside them unreconciled.
`WS-27-structural-properties-map` is **surface D in full** — the five properties D1, the named
control D3, its owner D4, and the verification method D5. D2 is an addition and is marked
`derived`, for the reason given in its own row.

**Deliberate omission — no total score.** The chapter triages by band and by blast radius, not by
count, and says so in terms: start with S1, S2 or S3 *"regardless of your total score"*
(ch13 L555). A printed total invites "eight out of eleven" reporting, which is precisely the figure
that conceals a safety failure. Surface A rolls up to three bands; surface B rolls up to four named
states; nothing on this sheet rolls up to a number.

**Deliberate omission — no weighting across the five constraints.** The book states that each
constraint is necessary to address its own failure mode (ch01 L73). Weighting would imply one can
be traded against another, and the sheet would start producing defensible-looking estates that are
unbounded in exactly one dimension.

## 6. Absorbed members (3)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-01-prose-constraint-readiness` - PROSE Constraint Readiness Assessment

- **Address.** `handbook\ch01-the-agentic-sdlc-thesis.qmd` L59-118, PROSE: Architectural Constraints for Human-AI Collaboration (`#sec-thesis-prose-intro`)
- **Why folded.** The same assessment at five-constraint resolution, which the canonical already claims as its rollup and executive-reporting layer; contributes the anti-pattern hit-list as the scorecard's failure view.
- **Fill detail to absorb.** For each of the five PROSE constraints, score today's practice (absent / ad hoc / documented / enforced) and name the artefact or control that satisfies it; then tick which of the five matching anti-patterns the organisation currently exhibits and give one example each.
- **Its output was.** A five-row constraint scorecard plus an anti-pattern hit-list that becomes the initial backlog for the context-engineering workstream.

### `WS-13-disclosure-refactor-audit` - Instruction File Size and Disclosure Audit

- **Address.** `handbook\ch13-the-prose-specification.qmd` L77-106, Anti-pattern: Context dumping (`#sec-prose-context-dumping`)
- **Why folded.** Produces the file-level backlog behind checklist items P1 and P2, and the canonical's own title already claims remediation; contributes the per-file inventory columns and is where the 40-50 vs 100-line conflict must print.
- **Fill detail to absorb.** One row per existing primitive file: path, line count, whether it exceeds the 100-line threshold, the subsidiary topics currently inlined, the target file each should be extracted to, and whether every cross-reference carries a descriptive label rather than a bare filename.
- **Its output was.** A prioritised refactor backlog for the instruction estate: which files get split, what gets extracted, and which links need descriptive labels.

### `WS-27-structural-properties-map` - Structural Properties Control Map

- **Address.** `handbook\ch27-what-comes-next.qmd` L94-108, What Will Not Change (`#sec-next-invariants`)
- **Why folded.** The book states at ch27 line 106 that these five properties map directly onto the PROSE constraints; its own note directs keeping the PROSE version and attaching the four case-study What Held True sections as pre-filled examples.
- **Fill detail to absorb.** The five properties as rows - context is finite and fragile, output is probabilistic, explicit beats implicit knowledge, human judgment is the bottleneck, composition is necessary - and for each the team names the specific control it will put in place, who owns it, and how it is verified.
- **Its output was.** A five-row map proving every structural constraint has a named control, not an intention.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-02-shadow-ai-usage-inventory` - Shadow AI Usage Inventory (Pack A - Groundwork (pre-work), fill order 1)

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** The transformation plan; WS-13-instruction-hierarchy-canvas; WS-05-decision-rights-gate-matrix

## 8. Facilitation

| | |
|---|---|
| Who fills it | Mixed, by surface. A and B: the architect or platform lead, with the engineering leader present — B is the layer that gets reported upward and it should not be assembled without the person who will report it. C: whoever can run a line count across the estate, **before** the session. D: the same group as B, at the end. |
| When in the session | Pack Z, fill order 7, after `WS-02-shadow-ai-usage-inventory` and after `WS-13-instruction-hierarchy-canvas` where that has been run. E1 and E2 are checked here against what the canvas designed; assessing before the canvas produces a documented fail that the canvas is about to fix, which wastes both sheets. |
| Duration | Surface C: one to two hours of preparation outside the room — a script plus a read. Surfaces A and B: 90 minutes together; the eleven questions go quickly, the evidence column is where the time goes and that is the point. Surface D: 30 minutes. |
| Data needed in advance | Surface C, completed. Every agent configuration with its `tools:` list (for S1) and its file-path boundary (for S3). The list of operations currently behind a `**STOP**` gate (for S2). The outputs of `WS-13-instruction-hierarchy-canvas` (E1, E2) and `WS-12-agent-persona-design-canvas` (S1, S3) where those exist. |
| Room format | A and B projected side by side and filled live — the evidence column is an interrogation and it works considerably better with an audience. C stays in the spreadsheet. D on paper, at the end, when the room is tired and will therefore write short controls, which is the correct length for a control. |

**Facilitation note — Pack Z prerequisite condition.** This sheet assesses an estate and most of it
is meaningless without one; surface C in particular needs existing instruction files to count lines
in. The condition that makes it worth a session is the shadow-AI census having turned up
substantial existing instruction files — in practice, the point at which root instruction files
have grown large enough that nobody in the room has read one end to end recently. Where the census
found little, run surfaces B and D only. Both are design-forward: the constraint scorecard records
`absent` honestly, and the control map is a commitment rather than an audit. Defer A and C, and
**record on the sheet that they were deferred, not that they passed.** An empty estate scores
eleven passes by vacuity, and a vacuous pass is worse than a fail because it stops anyone looking
again.

**Second note — the asymmetry is the line that moves an executive.** Ch13 L555 says safety failures
carry both the highest blast radius and the fastest fix: one YAML change per agent. Say that
sentence out loud as surface A closes. It is the only place in the whole assessment where "worst"
and "cheapest" land on the same items, and it is what converts a scorecard into a decision that
gets funded.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **No Pass is self-certified.** Every Pass in A4 cites a file path in A5, and every Fail cites a
   named counter-example. The book's table ships with an empty Pass column and nothing else; the
   evidence column is the entire reason this is a worksheet rather than a photocopy.
2. **Every Fail carries a band, an owner and a target date.** The bands are the book's own
   (ch13 L555-559) and are not re-ordered locally. Safety comes first regardless of how few or how
   many failures there are.
3. **Surfaces A and B agree.** Every constraint marked `enforced` in B3 has all of its rolled-up
   checklist items passing in A4. A constraint reported as enforced upward while one of its items
   fails below is the precise failure the merge of these two instruments exists to prevent.
4. **Every ticked anti-pattern in B6 carries a concrete example in B7** — a file, a prompt, an
   agent configuration, a session. An anti-pattern acknowledged in the abstract generates no
   backlog and no behaviour change.
5. **Surface C carries both threshold columns, filled, for every file.** Neither C3 nor C4 is blank
   or deleted, and the open-question note is printed on the sheet. This is a standing integrity
   requirement of the worksheet, not an instruction for the first run: the two numbers come from
   two chapters that the book does not reconcile, and the sheet's job is to carry the
   disagreement intact to the author, not to resolve it.
6. **Every D2 mapping is written by the team and marked `derived`.** The book asserts that the five
   structural properties map to the PROSE constraints (ch27 L106) without printing the
   correspondence. A mapping presented on the sheet as the book's own would be a fabrication.
7. **It reconciles against its named neighbours.** E1 and E2 match `WS-13-instruction-hierarchy-canvas`;
   S1 and S3 match the tool-whitelist and file-path-boundary columns of
   `WS-12-agent-persona-design-canvas`; surface C's file list is at least as long as the shadow-AI
   census's. Any shortfall in that last comparison is a gap in the census and is recorded as one,
   not quietly absorbed.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Carried unchanged from _section-clusters.md section 7 for CL-SPEC-CONTEXT-DESIGN.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> LEADERSHIP PRIORITY 1 and the closest structural sibling to the Chapter 2 seed table: the source already carries a Pass column with nothing in it — a worksheet in embryo. It answers the readiness question the brief asks to be flagged: is our specification estate ready for agents? RECORDED AS ONE WORKSHEET COVERING TWO PASSAGES: the eleven-question checklist at lines 535-565 is the fill-in surface, and the five-row Constraint Model table at lines 14-26 (constraint / addresses / induces) is the rollup and executive-reporting layer. Do not ship them as two instruments. The remediation ordering is supplied verbatim at lines 555-561, including the observation that safety failures are both the highest blast radius and the fastest to close (one YAML change per agent) — that asymmetry is the line that gets an executive to act. Authoring cost is very low; the main work is adding an evidence column so a Pass cannot be self-certified.
