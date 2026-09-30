# Target-State Primitive Bundle Definition

`WS-27-starter-shape-target` &middot; **Pack Z - Second wave: the practitioner kit** &middot; fill order **4** &middot; type `inventory` &middot; audience **architect** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A one-page definition of what "done" looks like for the primitive layer - the thing the transformation is actually building toward.

**Cluster.** `CL-TARGET-BUNDLE` - Target State: Starter Bundle, Personas and Pods

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch27-what-comes-next.qmd` |
| Chapter | What Comes Next |
| Heading | The Starter Shape |
| Stable anchor | `#sec-next-starter-shape` |
| Lines | L217-231 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch27-what-comes-next.html#sec-next-starter-shape> |
| Locator quote | "The shape is **a small bundle**, not a comprehensive one." |

Resolve at any time with `python docs/resolve.py ws WS-27-starter-shape-target`.

## 3. Source extract - the scaffolding, verbatim

```text
  217 | The shape is **a small bundle**, not a comprehensive one. The early signal — and we name it as a signal, not a settled finding — is that organizations that mature past the experimentation phase converge on something close to:
  218 | 
  219 | - **A handful of skill bundles** (typically three to seven) covering the highest-leverage recurring tasks — code review, refactoring, test authoring, documentation generation, incident triage. Not thirty skills covering every conceivable workflow.
  220 | - **A small set of scope-attached rule files** (`.instructions.md` with `applyTo` globs) carrying the team's load-bearing conventions — error handling, logging, security boundaries, cross-platform encoding rules. The set is small because each rule is reviewed every time it loads; the budget is attention, not disk.
  221 | - **One agent file per repository** (`AGENTS.md` or its harness-specific equivalent) that names what the agent should know about *this* repository before it does anything — the build commands, the test commands, the directories it should not touch, the conventions that apply globally.
  222 | - **A lockfile and a manifest** (Chapter 21's package layer) that pins the bundle's transitive closure so that the agent that runs in CI today is reading the same primitives as the agent that runs in CI six months from now.
  223 | - **A panel-ready review configuration** that lets the team escalate any non-trivial PR to a multi-specialist Panel (Chapter 17) when the change crosses the trivial threshold.
  224 | 
  225 | Three properties distinguish the starter shape from the ad-hoc shape teams typically begin with.
  226 | 
  227 | **It is small enough to read.** A new team member should be able to read the entire bundle in an afternoon and know what the agent will do on their first PR. If the bundle is too large to read, no one will read it, and the convention that nobody can recite is a convention the agent will violate undetected.
  228 | 
  229 | **It is composed, not stacked.** Each primitive has a single concern (the 3-concern triplet from Chapter 21) and depends explicitly on the primitives it builds on. The bundle has a dependency graph, not a flat list. When the team adds a new convention, it lands in the right primitive, not in a new one.
  230 | 
  231 | **It is governed by the lockfile.** Every release of every primitive is pinned. When a primitive ships an update, the lockfile diff appears in the next CI run, and the change goes through the same review the source diff goes through. Drift becomes visible; provenance becomes auditable.
```

## 4. What the user fills

The team names its own instance of each of the five bundle elements: three to seven skill bundles for its highest-leverage recurring tasks, the scope-attached rule files carrying load-bearing conventions, the one repository-level agent file per repo, the manifest and lockfile that pin the bundle, and the panel-ready review configuration with its trivial-change threshold. Each element gets an owner and a target date. Then the bundle is tested against the three stated properties.

## 5. Field-level schema

Two surfaces on one page. **A** is the bundle definition — five fixed rows, one per named element.
**B** is the acceptance test — three fixed rows, one per stated property. The book's hedge prints
as a boxed standing note at the head of surface A, not as a footnote; the reasons are set out
below the table.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| — | Scope | `free text` | — | The repository, team or org unit this target state covers | org |
| — | "Signal, not settled finding" — acknowledged | `checkbox` + `owner (named person)` | The hedge printed verbatim in the box above | Ticked and named by whoever chairs the session, before filling begins | ch27 L217 |
| — | Whole-bundle target date | `date` | — | — | org |
| A1 | Bundle element | `select` (fixed 5) | Skill bundles; scope-attached rule files (`.instructions.md` with `applyTo` globs); one agent file per repository; a lockfile and a manifest; a panel-ready review configuration | — | ch27 L219-223 |
| A2 | The book's sizing guidance | `free text`, pre-printed, read-only | Per row: "typically three to seven … not thirty skills covering every conceivable workflow"; "the set is small because each rule is reviewed every time it loads; the budget is attention, not disk"; "one agent file per repository"; "pins the bundle's transitive closure"; "escalate any non-trivial PR to a multi-specialist Panel" | — | ch27 L219-223 |
| A3 | Our instance | `free text` | — | The actual named skills, rule files, agent files, manifest path and panel configuration | org |
| A4 | Count | `computed` | — | Count of the items named in A3 | derived |
| A5 | Highest-leverage recurring task covered | `free text` | The five candidate tasks named for the skills row — code review, refactoring, test authoring, documentation generation, incident triage | The org's own, which may not be these five | ch27 L219 |
| A6 | Owner | `owner (named person)` | — | A named individual per element | org |
| A7 | Target date | `date` | — | — | org |
| A8 | Status | `select` — absent / drafted / shipped / pinned | — | Where this element stands today | derived |
| A9 | Evidence | `free text` | — | Repository path, registry entry, lockfile line or CI job that proves A8 | derived |
| A10 | Deviation from the book's shape, and why | `free text` | The permission printed beside the column: *"The starter shape is a starting point, not a ceiling. Teams will adapt and extend it; some will abandon parts that do not fit their domain."* | The deviation and the reasoning | ch27 L241 |
| A11 | Our definition of "non-trivial" (row 5 only) | `free text` | The phrase "when the change crosses the trivial threshold", printed undefined because the book leaves it undefined | The org's own test for when a PR escalates to the Panel | ch27 L223 |
| B1 | Property | `select` (fixed 3) | It is small enough to read; it is composed, not stacked; it is governed by the lockfile | — | ch27 L227-231 |
| B2 | The book's test | `free text`, pre-printed, read-only | Per row: a new team member reads the entire bundle in an afternoon and knows what the agent will do on their first PR; each primitive has a single concern and depends explicitly on what it builds on, so the bundle has a dependency graph rather than a flat list; every release of every primitive is pinned, the lockfile diff appears in the next CI run, and that change goes through the same review the source diff goes through | — | ch27 L227-231 |
| B3 | Result | `select` — pass / partial / fail | — | The outcome of actually running the test | derived |
| B4 | How it was tested | `free text` | — | For row 1, the named person who read the bundle and the date; for row 2, the rendered dependency graph; for row 3, a CI run showing a lockfile diff in review | derived |
| B5 | Tested by | `owner (named person)` | — | — | org |
| B6 | Date tested | `date` | — | Later than surface A's date, necessarily | derived |
| B7 | If not pass — the gap and its owner | `free text` + `owner (named person)` | — | — | org |

**The hedge, carried onto the sheet — and not as a footnote.** Section 10 names this as the
integrity rule for this worksheet, and it is load-bearing here because the damage is done by
layout rather than by prose: a printed "three to seven" beside a blank count cell reads as a target
however the surrounding text is worded. Three devices carry it. First, the book's own sentence
prints in a box at the head of surface A, verbatim — *"The early signal — and we name it as a
signal, not a settled finding — is that organizations that mature past the experimentation phase
converge on something close to…"* (ch27 L217) — and the header box records who read it to the room.
Second, column A2 is titled **the book's sizing guidance**, never *target* or *benchmark*, and is
set in the same weight as the rest of the row rather than as a headline. Third, A10 is a
first-class column rather than an exceptions box: deviating from the shape is a recorded design
decision, which is what the book itself invites (ch27 L241).

**Deliberate omission — no maturity score and no percent-complete.** Surface B returns pass,
partial or fail per property and nothing rolls up. A composite figure would convert an early signal
into a grade, and a grade is exactly the artefact that outlives the caveat attached to it.

**Deliberate omission — no timeline benchmark.** The book says the shape is "reachable in months,
not years" (ch27 L241) — hedged, and deliberately unquantified. A7 therefore holds the
organisation's own target date with no printed comparison beside it.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- None. This sheet can be filled cold.

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** WS-12-failure-triage-log (how the bundle fills in over time) and WS-27-first-week-plan (Day 2 writes the first three)

## 8. Facilitation

| | |
|---|---|
| Who fills it | The architect or platform lead who will own the bundle, plus one engineer from each team expected to consume it. Identify here the person who will later act as the "new team member" in the B1 read test — and keep them **out** of the room that designs the bundle. |
| When in the session | Pack Z, fill order 4, fillable cold. Run surface A early in the pack: it is the target the rest of the pack builds toward, and a transformation with no defined target state cannot be declared complete. Run surface B only once a bundle exists. Filling B on day one yields three fails and no information. |
| Duration | Surface A, 60-75 minutes. Surface B is not a session item at all — it is a test executed later against a real bundle, and the sheet records the result with a date and a name. |
| Data needed in advance | The recurring tasks this team actually performs most often, for A5. The current repository inventory, for the one-agent-file-per-repository row. The output of `WS-21-primitive-governance-policy` if it exists — its Part A settles whether a manifest and lockfile are mandatory, and row 4 here is that decision made concrete. |
| Room format | One page, projected, filled live. Surface B printed separately and handed to the reader who will run the test, because they must not have watched the bundle being designed. |

**Facilitation note — Pack Z prerequisite condition, and the one exception.** Most of Pack Z
assesses an estate a pre-groundbreaking organisation does not yet have. Surface A is the exception:
it defines a target state, so it can and should be filled before the estate exists. Surface B
cannot. Treat them as two separate events with two separate dates. A sheet where A and B share a
date has almost certainly had B asserted rather than run — and "small enough to read" is
specifically not a judgement the authors of a bundle are able to make about their own bundle.

**Second note — read the hedge box aloud before filling.** The room will treat "three to seven" as
a target the moment it sees a blank count cell beside it. The author's framing is that this is an
early signal rather than a settled finding (ch27 L217), and that the shape is a starting point
rather than a ceiling (ch27 L241). Say both out loud and tick the acknowledgement; do not rely on
the box to do it.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All five bundle elements carry an instance, an owner and a target date** — or are recorded as
   `absent` with a reason in A10. A blank row is not a deferral; it is an undefined target state,
   which is the condition this sheet exists to end.
2. **The hedge acknowledgement in the header box is ticked and names the person who read it.** The
   integrity rule for this worksheet (section 10) is that the hedge survives onto the artefact; an
   unticked box is evidence it did not.
3. **Row 1's count in A4 sits inside the book's three-to-seven range, or A10 states why not.** Both
   outcomes are acceptable. Only a silent deviation is not — and a count of thirty with a blank
   A10 is the failure mode the chapter names explicitly (ch27 L219).
4. **Row 5 carries the organisation's own definition of "non-trivial" in A11.** The book uses the
   phrase and leaves it undefined (ch27 L223). A panel configuration with no threshold behind it
   never fires, which makes the element present on paper and absent in practice.
5. **Surface B's date is later than surface A's, and the B1 test names an individual who was not
   involved in designing the bundle.** Same-day completion means the property was asserted rather
   than tested.
6. **Every `pass` in B3 cites how it was tested in B4** — a named reader and a date, a rendered
   dependency graph, or a CI run showing a lockfile diff going through review. A `pass` with an
   empty B4 is downgraded to `partial` before the sheet closes.
7. **Row 4 agrees with `WS-21-primitive-governance-policy` Part A.** If that sheet made the
   lockfile advisory while this one records row 4 as `pinned`, one of the two is wrong; the
   discrepancy is logged with an owner rather than reconciled in place by whichever sheet is
   nearer to hand.

## 10. Integrity constraint

**Named rule for this sheet.** The book hedges that the starter shape is an early signal, not a settled finding. The sheet must carry that hedge.

**Hedged figures reachable from this source range.** Each is listed with the book's own hedge, verbatim, and where that hedge lives. Present the figure as a pre-filled prior the organisation overwrites, or as a facilitation prompt - never as a benchmark, target or acceptance threshold. **Carry the hedge onto the sheet with the number; do not restate it in your own words.**

- **The starter bundle sizing guidance (three to seven skills, not thirty).**
  - *Appears at* `handbook\ch27-what-comes-next.qmd` L215-245
  - *The book's hedge (ch27 L241):* 'The starter shape is a starting point, not a ceiling.' The book hedges the whole section as an early signal rather than a settled finding.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Five named bundle elements with sizing guidance, plus three acceptance properties that convert directly into a pass/fail test. Only the owner and target-date columns are additions.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> The most concrete target-state description in the book: five named bundle elements with sizing guidance (three to seven skills, not thirty) and three acceptance properties that convert directly into a pass/fail test - small enough to read (a new joiner reads the whole bundle in an afternoon), composed not stacked (a dependency graph, not a flat list), governed by the lockfile (every primitive pinned, drift visible in CI). The book hedges honestly that this is an early signal, not a settled finding, and the worksheet must carry that hedge. Leadership priority 1: a transformation with no defined target state cannot be declared complete. Overlaps the Part III primitives-as-code chapter (ch21) - that chapter probably owns the HOW; this owns the WHAT and HOW MUCH.
