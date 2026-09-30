# Context Budget Allocation Worksheet

`WS-15-context-budget-allocation` &middot; **Pack Z - Second wave: the practitioner kit** &middot; fill order **9** &middot; type `calculator` &middot; audience **practitioner** &middot; leadership priority **2**

> **Split back out in the re-opening pass.** A per-repository token budget across eleven context categories with a committed eager-load ceiling a team can regression-test against -- a different unit, a different owner and a durable number, not a wave-sizing step.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A per-repository context budget with a hard eager-load ceiling and a named treatment for every category - the number a team can regression-test against.

**Cluster.** `CL-CONTEXT-BUDGET` - Context Budget Allocation and Eager-Load Ceiling

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch15-attention-and-context-economy.qmd` |
| Chapter | Attention and Context Economy |
| Heading | A practitioner's budget |
| Stable anchor | `#sec-attention-budget` |
| Lines | L102-120 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch15-attention-and-context-economy.html#sec-attention-budget> |
| Locator quote | "The disciplines are easier to apply when you have a categorical sense" |

Resolve at any time with `python docs/resolve.py ws WS-15-context-budget-allocation`.

## 3. Source extract - the scaffolding, verbatim

```text
  102 | The disciplines are easier to apply when you have a categorical sense of the cost-versus-benefit of common context loads. The table below is not a benchmark; it is a starting calibration drawn from the author's practice across Copilot CLI, Claude Code, and similar harnesses. Numbers will shift with model, harness, and task; the *order* is what the author has found stable.
  103 | 
  104 | | Context category                                       | Typical cost           | Typical benefit                                  | Recommended treatment                                                       |
  105 | |---------------------------------------------------------|------------------------|--------------------------------------------------|------------------------------------------------------------------------------|
  106 | | Project-base rules (always relevant)                    | low (under 500 tokens) | high (frames every turn)                         | Always-loaded at head                                                        |
  107 | | Scope-attached rules (relevant to current path)         | low to moderate        | high (when in scope)                             | Always-loaded by scope predicate; carve scope tightly                        |
  108 | | On-demand skill body                                    | moderate               | high (when activated)                            | Progressive disclosure; description-driven activation                        |
  109 | | Reference architectural docs                            | high                   | low per turn, occasionally critical              | Skill that pulls only on matching diff; never always-loaded                  |
  110 | | Source files for the current change                     | moderate to high       | essential                                        | Load directly; trim unrelated files; rely on type stubs over full sources    |
  111 | | Tool output from earlier turns                          | grows without bound    | low after one or two turns                       | Summarise into the plan; let the raw output sediment                         |
  112 | | Pasted error tracebacks                                 | high                   | low past the first paste                         | After two pastes, reset; carry forward a one-line summary                    |
  113 | | Conversation history beyond the last ten turns          | high                   | low, mostly recency illusions                    | Reset session; carry forward `plan.md`                                       |
  114 | | External documentation pulled by web fetch              | very high              | high *for one decision*, low afterward           | Bounded-scope grounding;[^ch13-bounded-scope] cite the answer, drop the dump |
  115 | | Repository-wide grep/search results                     | very high              | rarely needed                                    | Replace with targeted reads                                                  |
  116 | | Vendor model card or general guidance                   | high                   | near zero for the agent's task                   | Do not load                                                                  |
  117 | 
  118 | Two heuristics fall out of the table. *Anything that is needed on every turn earns a place at the head; everything else should be progressive.* And *anything that grows without bound across a session is a candidate for a periodic reset and a one-paragraph summary*. These heuristics are crude, but they correctly classify perhaps eighty per cent of the loading mistakes a team will make in its first months of agentic practice.
  119 | 
  120 | ---
```

## 4. What the user fills

Starting from the book's eleven context categories, the team fills in its own numbers: measured or estimated token cost per category, benefit rating, the treatment chosen (always-loaded at head / scope-predicate / progressive / do not load / summarise-and-reset), and a running total against the model's window. A footer computes the percentage of window consumed before any source code is loaded.

## 5. Field-level schema

One row per context category — the eleven the chapter names, pre-printed and not to be deleted.
Columns 3-5 are the book's calibration, reproduced verbatim and visually set apart (grey, italic, or
a ruled block) from the team's own columns; columns 6-14 are what the team measures and decides. The
sheet is landscape, one page per repository, with a computed footer block and a caveat banner at the
head. **This is a per-repository instrument, not a per-organisation one.**

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Context category | `select` (fixed 11 rows) | Project-base rules; Scope-attached rules; On-demand skill body; Reference architectural docs; Source files for the current change; Tool output from earlier turns; Pasted error tracebacks; Conversation history beyond the last ten turns; External documentation pulled by web fetch; Repository-wide grep/search results; Vendor model card or general guidance | — | ch15 L106-116 |
| 2 | Applies to this repo? | `checkbox` | — | Untick rather than delete. A category the team believes it never loads is a finding, not a blank | derived |
| 3 | Book's typical cost | `free text` (read-only) | low (under 500 tokens) / low to moderate / moderate / high / moderate to high / grows without bound / very high — per the category | — | ch15 L106-116 |
| 4 | Book's typical benefit | `free text` (read-only) | high (frames every turn) / high (when in scope) / high (when activated) / low per turn, occasionally critical / essential / low after one or two turns / low past the first paste / low, mostly recency illusions / high *for one decision*, low afterward / rarely needed / near zero for the agent's task | — | ch15 L106-116 |
| 5 | Book's recommended treatment | `free text` (read-only) | Always-loaded at head; Always-loaded by scope predicate, carve scope tightly; Progressive disclosure, description-driven activation; Skill that pulls only on matching diff, never always-loaded; Load directly, trim unrelated files, rely on type stubs; Summarise into the plan, let raw output sediment; After two pastes reset, carry a one-line summary; Reset session, carry forward `plan.md`; Bounded-scope grounding, cite the answer and drop the dump; Replace with targeted reads; Do not load | — | ch15 L106-116 |
| 6 | What this category actually is, here | `free text` | — | The named files, tools or sources this category resolves to in **this** repository | org |
| 7 | Our token figure | `free text` (integer) | — | The team's own number for this category in a representative session | org |
| 8 | Measured or estimated? | `select` — `measured` / `estimated` | — | Measured means read off the harness's token report, not inferred from file length | org |
| 9 | Our benefit rating | `H/M/L` | — | The team's own judgement for its own work, which may disagree with column 4 | org |
| 10 | Our treatment | `select` — `always-loaded at head` / `always-loaded by scope predicate` / `progressive / description-driven` / `pull on matching diff only` / `load directly and trim` / `summarise and let sediment` / `reset and carry a summary` / `do not load` | Options are the book's treatments, normalised into a picklist | Choose one per applicable category | ch15 L106-116 |
| 11 | Divergent from column 5? Why | `free text` | — | Mandatory whenever column 10 differs from column 5. A silent divergence is the loading mistake the chapter is about | derived from ch15 L118 |
| 12 | Owner | `owner (named person)` | — | Who owns this category's loading decision in this repository | org |
| 13 | Counts towards the eager load? | `computed` | Ticks automatically when column 10 is `always-loaded at head` or `always-loaded by scope predicate` | — | derived from ch15 L118 |
| 14 | Regression check | `free text` | — | The named check that fails when this category's figure grows past what the team committed to | org |

**Footer block — the number the sheet exists to produce.**

| Footer field | Input type | Notes |
|---|---|---|
| Eager-load subtotal | `computed` | Sum of column 7 where column 13 is ticked |
| Model and harness this budget is written against | `free text` | Named explicitly. The chapter is clear that numbers shift with model, harness and task, so a budget with no named model is not a budget |
| Window size for that model | `free text` | The denominator, stated |
| Share of window consumed before any source file is loaded | `computed` | Eager-load subtotal ÷ window |
| **Committed eager-load ceiling** | `free text` (integer) | The team's own number, written down and regression-tested. This is the durable output of the sheet |
| Ceiling owner | `owner (named person)` | — |
| Date written / next review | `date` | — |

**Caveat banner — print this verbatim at the head of the sheet, above column 1.** *"The table below
is not a benchmark; it is a starting calibration drawn from the author's practice across Copilot CLI,
Claude Code, and similar harnesses. Numbers will shift with model, harness, and task; the* order *is
what the author has found stable."* Without it, columns 3-5 read as authoritative figures and the
team calibrates to another organisation's practice. Say on the sheet which of the eleven rows a team
is expected to disagree with: all of them, on the numbers; few of them, on the ordering.

**Footer rules — the two heuristics, printed under the table.** *Anything that is needed on every
turn earns a place at the head; everything else should be progressive.* And *anything that grows
without bound across a session is a candidate for a periodic reset and a one-paragraph summary.*
They are the test to apply when column 10 and column 5 disagree.

**Absorbed detail.** None — this sheet absorbed no other candidate. It deliberately stays at
category level: where `WS-14-primitive-binding-inventory` exists, that ledger supplies asset-level
measured token costs and this sheet aggregates them into column 7. Keep the boundary — eleven
category rows here, one row per asset there — or the two instruments duplicate each other and
disagree at the totals.

**Deliberate omission.** No recommended ceiling, no target share of window, no per-category budget
figure and no "healthy" band. The organisation's committed ceiling in the footer is the only number
on the sheet that functions as a limit, and the team writes it. Printing any suggested value beside a
blank cell would convert the chapter's explicit calibration into the benchmark it says it is not.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-21-primitive-governance-policy` - Primitive Supply Chain: Registry, Pinning, Versioning and Ownership Decisions (Pack Z - Second wave: the practitioner kit, fill order 3)

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** WS-06-skill-gap-and-hiring-bar; the totals also feed any cost-per-session model in the exec-facing ROI track.

## 8. Facilitation

| | |
|---|---|
| Who fills it | The engineer who owns the repository's primitive set, paired with someone who can read the harness's token report for a real session. Not a leadership exercise and not a whole-team one: two people and one repository. The named owner of the committed ceiling in the footer should be in the room, because that footer line is the only commitment the sheet makes. |
| When in the session | Pack Z, after `WS-21-primitive-governance-policy` — the registry and pinning decisions are what make column 6 resolvable to actual named assets rather than to categories in the abstract. The condition that makes this worth running: **the repository has accumulated enough always-loaded material that loading is now a choice**, which in practice means somebody has already noticed an instruction being ignored. Running it on a repository with three instruction files produces a tidy sheet and no insight. |
| Duration | 90 minutes to two hours for one repository, provided the measuring was done beforehand. If the team arrives without a token report, the session becomes a measuring session and the budget waits for the next one — say so when scheduling rather than discovering it in the room. |
| Data needed in advance | A harness token report for one representative session on this repository, broken down far enough to attribute tokens to the eleven categories; the current inventory of always-loaded files with their sizes; the model and window the team actually runs against, named precisely; the completed `WS-21-primitive-governance-policy`; and the `WS-14-primitive-binding-inventory` ledger if the team keeps one. |
| Room format | One repository, one screen, the harness's verbose log open beside the sheet. Fill column 7 from the log rather than from anyone's recollection — the gap between what a team believes it loads and what the log says it loads is most of the value of the exercise. |

**Facilitation note.** The chapter opener is the ready-made way in, and it is worth telling in full
rather than summarising: a staff engineer finds her agentic reviewer missing a deprecated-helper rule
three times running. The rule is loaded — she checks the verbose log to be certain. What changed two
weeks earlier was that someone added an eight-hundred-line architectural-decisions document to the
same scope, on the entirely reasonable grounds that a code reviewer ought to have the architecture in
mind. The rule now sits on line 62 of a file landing in the middle third of a thirty-five-thousand
token payload. The model read it; the model did not see it. Tell that story before anyone fills a
cell, then ask the room which of the eleven categories their own eight-hundred-line document would
be. The answer is usually row 4, reference architectural docs, and the book's recommended treatment
for it — a Skill that pulls only on a matching diff, never always-loaded — lands very differently
once the room has supplied its own example.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All eleven categories are present and each is explicitly ticked or unticked in column 2.** None
   has been deleted for not applying. An unticked row is a claim the team is making about its own
   loading behaviour and is checkable against the harness log.
2. **Every applicable category carries a figure in column 7 and a `measured` or `estimated` flag in
   column 8**, and the majority are `measured`. A sheet of estimates is a sheet of opinions about
   token cost, which is the condition the chapter says produces the mistake in the first place.
3. **Every applicable category has exactly one treatment in column 10**, and every divergence from
   the book's recommendation in column 5 carries a written reason in column 11. Divergence is
   allowed and often correct; silent divergence is not.
4. **The footer names the model, the harness and the window.** A committed ceiling written without
   the denominator it was computed against is not portable to the next model and will be read as a
   universal figure the moment the team changes harness.
5. **A committed eager-load ceiling is written, owned by a named individual, and has at least one
   regression check behind it** — column 14 populated for every eager category, or a single check at
   the footer that fails when the subtotal crosses the ceiling. A ceiling nothing tests is a wish.
6. **The calibration caveat is printed verbatim on the sheet and the book's columns are visually
   distinguishable from the team's.** If a reader cannot tell at a glance which figures came from the
   book and which from this repository, the sheet has laundered a calibration into a benchmark and
   fails §10 regardless of how well the rest is filled.
7. **Every file counted in the eager-load subtotal is a registered, pinned, owned primitive in
   `WS-21-primitive-governance-policy`.** A file that is always in context but appears in no registry
   is an ungoverned standing instruction, and reconciling the two sheets is how it surfaces. Where a
   `WS-14-primitive-binding-inventory` ledger exists, each category figure in column 7 should equal
   the sum of its asset-level rows; a gap is an asset nobody has bound to a category.

## 10. Integrity constraint

**Named rule for this sheet.** ch15 L102 states outright that its table 'is not a benchmark; it is a starting calibration'. That sentence prints on the sheet.

**Hedged figures reachable from this source range.** Each is listed with the book's own hedge, verbatim, and where that hedge lives. Present the figure as a pre-filled prior the organisation overwrites, or as a facilitation prompt - never as a benchmark, target or acceptance threshold. **Carry the hedge onto the sheet with the number; do not restate it in your own words.**

- **The eleven-category context cost-versus-benefit table.**
  - *Appears at* `handbook\ch15-attention-and-context-economy.qmd` L100-122
  - *The book's hedge (ch15 L102):* 'The table below is not a benchmark; it is a starting calibration.'

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** The eleven-category table supplies rows and three of four columns; the sheet adds a 'your number / your treatment' column and a footer total.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Already structured: the table at lines 104-116 supplies rows and three of four columns; the worksheet only adds a "your number / your treatment" column. The book is explicit that its numbers are calibration, not benchmark (line 102: "not a benchmark; it is a starting calibration") - the worksheet must carry that caveat or teams will treat the figures as authoritative. Two heuristics at line 118 make good footer rules. Overlaps WS-14-primitive-binding-inventory (asset-level token costs) - keep this one category-level and let the ledger supply the measured numbers. The chapter opener (lines 6-12, the 800-line architecture document) is the ready-made facilitation story.
