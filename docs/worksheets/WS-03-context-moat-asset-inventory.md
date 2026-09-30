# Context Asset & Debt Inventory

`WS-03-context-moat-asset-inventory` &middot; **Pack A - Groundwork (pre-work)** &middot; fill order **2** &middot; type `inventory` &middot; audience **architect** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A baseline of the asset the entire business case rests on, and a ranked context-engineering backlog with the debt register attached.

**Cluster.** `CL-CONTEXT-DEBT` - Context Asset and Debt Inventory

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch03-the-business-case.qmd` |
| Chapter | The Business Case |
| Heading | The Context Moat |
| Stable anchor | `#sec-business-case-context-moat` |
| Lines | L321-333 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch03-the-business-case.html#sec-business-case-context-moat> |
| Locator quote | "Of the six investment categories above, one earns its own treatment because" |

Resolve at any time with `python docs/resolve.py ws WS-03-context-moat-asset-inventory`.

## 3. Source extract - the scaffolding, verbatim

```text
  321 | Of the six investment categories above, one earns its own treatment because it is the asset whose returns, if the compounding hypothesis holds, the rest of the business case rests on. Tool licenses commoditize; context infrastructure does not. Two organizations adopting the same vendor on the same day, from the same starting point, will diverge in agent reliability over the following year by a factor that is mostly explained by what each invested in the layer the new reference architecture (Chapter 4) names **Context & Capabilities**: the markdown primitives, conventions, agent configurations, and grounded references the harness loads on every invocation. The license is the same. The model is the same. The context is what differs. We hypothesise that this differential compounds; the early signal from teams 12+ months in is consistent with the hypothesis, but it is not yet a closed case.
  322 | 
  323 | The mechanism is mundane. Every agent invocation is a fresh actor with no memory of the codebase, the team, or last week's review. What the agent sees on each turn is exactly the context the harness loads — instruction files, scope-attached rules, skill bodies, ground-truth references, the diff under review. A team whose context layer encodes its conventions, its architectural decisions, its rejected approaches, and its house style is briefing an unbriefed expert at the start of every session. A team without that layer is asking a stranger to guess. Output quality tracks that briefing quality. So does the rate at which agent-generated code is sent back at review.
  324 | 
  325 | What we hypothesise compounds is not the volume of documentation; it is its operational quality. Each cycle through the team — a postmortem, a sharpened convention, a corrected agent failure — produces, when the discipline is in place, a small, durable improvement to a primitive that every subsequent agent invocation reads. The improvements layer on each other. The same convention does not need to be re-discovered; the same misunderstanding does not need to be re-corrected; the same violation does not recur. The early signal is that organizations with eighteen months of accumulated context on a given codebase report agent intervention rates a fraction of what they were at month three, while a peer organization adopting the same tools without the same discipline reports intervention rates that are flat — or, in some accounts, rising as agent usage spreads to more domains.
  326 | 
  327 | The strategic implication is the second-order one. If the compounding hypothesis holds, the layers of the agentic stack that get cheaper over time are the foundations: model inference cost has fallen by orders of magnitude per token across each generation, and there is no reason to expect that trend to break. The layers that get more valuable over time are the ones that the team itself builds — the primitives, the context infrastructure, the distribution standards — because their value depends on accumulated, organization-specific judgement that no vendor can ship pre-loaded. The early signal from the field today is consistent with where `npm` was in 2012: package management and the framework layer above it are embryonic; the investment thesis is that the layers that compound are the ones to invest in, while the layers that commoditize do not need a budget line. Models get cheaper. Context, if the hypothesis holds, gets more valuable.
  328 | 
  329 | **Technical debt gets a new cost.** A poorly factored module that a human team learned to work around becomes, in an agentic team, a recurring source of agent failure: the agent has no tribal knowledge of the workaround and produces clean-looking code that compounds the underlying mess. The early signal from instrumented adoption is that the modules that were already painful for humans become disproportionately painful for agents, because every agent invocation re-discovers the same trap. Refactoring a load-bearing module is, in this view, not just a cleanup project; it is a context investment that pays back on every subsequent agent task touching that module. The corollary is uncomfortable: organizations carrying significant technical debt should expect the early productivity returns from agentic tools to be lower than peers with cleaner codebases — not because the tools are worse, but because the debt taxes every invocation.
  330 | 
  331 | This is the asset class the next chapter is about. The reference architecture in Chapter 4 names where the moat lives (the **Context & Capabilities** layer of the 5-layer landscape), what ships it between teams (**Governance and Distribution**), and what loads it at runtime (the **Agent Harness**). For the purposes of the business case, the load-bearing point is the one above: the context investment is not a cost line that reduces ROI — it is, on the working hypothesis the field is now testing, the asset whose returns make the ROI possible.
  332 | 
  333 | ---
```

## 4. What the user fills

A row per context asset type (machine-readable conventions, architecture decisions, agent configurations, house style, rejected approaches, grounded references) scored present / partial / absent with an owner and a target date; plus a second panel listing the load-bearing modules whose technical debt will tax every agent invocation, with a refactor priority.

## 5. Field-level schema

Three panels with three different row units. **Panel A** is the leadership face: one row per
context asset type, six fixed rows, one page. **Panel B** is the working register: one row per
convention, thirty to sixty rows, a continuation sheet. **Panel C** is the debt register: one row
per load-bearing module. Panel A's marks are *rolled up from* Panel B — it is a summary, not an
independent opinion. Print A3 landscape; Panels B and C run to as many sheets as the register needs.

**Panel A — context asset inventory.** One row per asset type. All six sit in the
`Context & Capabilities` layer of the five-layer reference architecture (ch04 L147); the row exists
because the harness loads it on every invocation (ch03 L323).

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Context asset type | `select` (fixed 6 rows) | Machine-readable conventions / Architecture decisions / Agent configurations / House style / Rejected approaches / Grounded references | — | ch03 L321, L323 |
| 2 | What it would encode | `free text` | One line per row, drawn from L323 — e.g. Rejected approaches: "the approaches the team tried and abandoned, and why" | Edit only to use the org's own vocabulary | ch03 L323 |
| 3 | Present / Partial / Absent | `select` | Anchors printed: **Present** — written down, current, and loaded by the harness. **Partial** — written down but stale, incomplete, or not loaded. **Absent** — lives only in heads. | The mark | derived from Panel B |
| 4 | Panel B rows evidencing this mark | `free text` | — | The register row numbers; a mark with no rows is an opinion | derived |
| 5 | Owner | `owner (named person)` | — | A named individual accountable for this asset type | ch03 L323 |
| 6 | Target date | `date` | — | When Partial or Absent becomes Present | org |
| — | Instrumentation debt figure | `computed` | — | Count of Panel B rows marked "In heads" | ch12 L436 |

**Panel B — convention register.** One row per convention. The five passes of the chapter's
instrumentation audit are the five fillable columns; do not filter or organise during the first
pass (ch12 L420).

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 7 | Convention, pattern or constraint | `free text` | Three greyed exemplar rows printed from the chapter — "All error responses use the `APIError` class"; "The `SessionAuth` class is deprecated; use `JWTAuth`"; "The logging module wraps Rich; never call `print()` directly" | Thirty to sixty of the org's own, unfiltered | ch12 L420-431 |
| 8 | Where it lives today | `select` In code / In docs / In heads | — | — | ch12 L433-438 |
| 9 | Agent visibility | `computed` from col 8 | In code → Partially visible, if it is in the context window. In docs → Invisible unless explicitly loaded. In heads → Completely invisible. | — | ch12 L435-437 |
| 10 | Failure cost | `select` Critical / High / Medium / Low | Descriptors printed: Critical — security, data corruption, outages. High — architectural violations that accumulate as debt. Medium — convention violations requiring rework at review. Low — style preferences that do not affect correctness. | The mark | ch12 L440-445 |
| 11 | Target primitive type | `select` instruction file / agent configuration / skill / prompt / memory file / specification / hook | The chapter's mapping rule printed above the column as a key | The mark | ch12 L447-457 |
| 12 | Maps to Panel A asset type | `select` (the six) | — | — | derived |
| 13 | In the starter set? | `checkbox` | Column header states: three to five files only | — | ch12 L459 |
| 14 | Starter-set file path | `free text` | — | The file this convention will live in | ch12 L459 |
| 15 | Starter-set owner | `owner (named person)` | — | Named individual per starter file | ch12 L459 |
| 16 | Target date | `date` | — | — | org |

**Panel C — technical debt register.** One row per load-bearing module. This panel is the honest
predictor of how deep the early dip runs, and it is filled *before* a scenario is chosen.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 17 | Module / package path | `free text` | — | — | org |
| 18 | What makes it load-bearing | `free text` | — | How much of the estate touches it | ch03 L329 |
| 19 | Already painful for humans? | `H/M/L` | Anchors printed: **H** — engineers route around it and warn newcomers. **M** — it slows work but is understood. **L** — it is simply old. | The mark | ch03 L329 |
| 20 | The workaround humans learned | `free text` | Column note printed: "the agent has no tribal knowledge of this" | The workaround, written down — this cell *is* the context investment | ch03 L329 |
| 21 | Agent failures observed here | `free text` | — | Concrete instances, or `none observed yet` | ch03 L329 |
| 22 | Expected agent tax | `H/M/L` | Anchors printed: **H** — every invocation touching it re-discovers the trap. **M** — some invocations. **L** — the debt is invisible to an agent. | The mark | ch03 L329 |
| 23 | Disposition | `select` refactor first / instrument the workaround / accept and exclude from pilot scope | — | — | ch03 L329 |
| 24 | Owner | `owner (named person)` | — | — | org |
| 25 | Target date | `date` | — | — | org |

**Absorbed detail.** `WS-12-instrumentation-audit` is Panel B in its entirety. Its five passes map
one to one: pass 1 (30-60 conventions, unfiltered) is column 7; pass 2 (In code / In docs / In
heads) is column 8, with the chapter's agent-visibility consequence carried as computed column 9;
pass 3 (failure cost) is column 10; pass 4 (the mapping table to a primitive type) is column 11;
pass 5 (the three-to-five-file starter set with owners) is columns 13-15. Its stated output — the
"In heads" count as the debt figure — is the computed row at the foot of Panel A, printed on the
leadership face rather than buried in the register.

**Deliberate omission — and the integrity rule for this sheet.** There is no column anywhere for
projected compounding returns, intervention-rate improvement, or a divergence factor against a
peer. The chapter is careful that compounding is a working hypothesis, not a closed case (L321,
L325, L331), and a worksheet cell that asks for a projected improvement converts a hypothesis into
a commitment by layout alone. The sheet records present state only. Value modelling belongs to
`WS-03-roi-break-even-model` and `WS-03-tco-calculator`, where the assumption can be stated as an
assumption. Also omitted: any instruction-hierarchy design — that is `WS-13-instruction-hierarchy-canvas`,
which consumes column 11.

## 6. Absorbed members (1)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-12-instrumentation-audit` - Instrumentation Debt Audit

- **Address.** `handbook\ch12-the-instrumented-codebase.qmd` L418-463, The Instrumentation Audit (`#sec-codebase-instrumentation-audit`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Five passes over one register. (1) 30-60 conventions a new engineer would need in their first two weeks, unfiltered. (2) For each, where it lives today: In code / In docs / In heads. (3) Failure cost: Critical / High / Medium / Low. (4) Target primitive type, using the chapter's mapping table. (5) The three to five files that make the starter set, with owners.
- **Its output was.** An instrumentation debt register — the "In heads" column is the debt figure — plus a ranked, typed backlog and a named week-one starter set.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- None. This sheet can be filled cold.

**Consumed by:**

- `WS-03-go-no-go-readiness-gate` - Go / No-Go Readiness Gate (Pack G - The plan we leave with, fill order 6)
- `WS-13-instruction-hierarchy-canvas` - Instruction Hierarchy Design Canvas (Pack Z - Second wave: the practitioner kit, fill order 6)

**Feeds into (prose, from the source scan).** WS-03-roi-break-even-model

## 8. Facilitation

| | |
|---|---|
| Who fills it | The architect owns the sheet. Panel B's first pass needs the whole team that works on the codebase in the room — the conventions live in their heads, which is the entire point, and a register written by one person is a register of one person's assumptions. Panel C needs the two or three engineers who have been on the codebase longest, because column 20 is tribal knowledge and nobody else has it. A tech lead with commit history access should be present to settle which modules are genuinely load-bearing. |
| When in the session | Pack A, fill order 2, after `WS-02-shadow-ai-usage-inventory`'s Panel B returns — the estate scan tells you which repositories already have primitives, so Panel B's starter set is not written against a repository that already has one. The sheet has no hard prerequisite and can be filled cold, but Panel C must be complete and dated **before** any scenario or ROI model is chosen, not after. |
| Duration | Panel B pass 1 is a hard 30 minutes, timeboxed and unfiltered (ch12 L420). Passes 2-4 take 60-90 minutes for a register of fifty rows and are the part that gets cut when time runs short; do not cut them, an unclassified register is a list. Pass 5 is 15 minutes. Panel C is 45 minutes. Panel A is a 15-minute rollup at the end. Budget half a day; this is an `L` sheet for a reason. |
| Data needed in advance | Read access to the repository. The last three months of code-review comments, which are where "we don't do it that way" conventions surface in writing. The module dependency graph or a commit-frequency report, to identify load-bearing modules by evidence rather than by reputation. Any existing architecture document, ADR set or style guide, so column 8 can distinguish In docs from In heads honestly. |
| Room format | Panel B pass 1 on sticky notes or a shared document with no columns at all — columns invite filtering, and the instruction is not to filter. Transcribe into the register afterwards. Panel C on A3 with the module list pre-printed down the left. Panel A is projected last and filled from the register in front of everyone, so nobody can argue a "Present" mark that the register does not support. |

**Facilitation note.** Two things will be resisted and both are load-bearing. First, the "In heads"
count in column 8 is the debt figure and people find it embarrassing; say out loud that a high
count is the expected result and the reason the sheet exists. Second, column 20 asks senior
engineers to write down the workaround they have been carrying, which feels like admitting the
module should have been fixed. Frame it as the chapter does: refactoring a load-bearing module is
a context investment that pays back on every subsequent agent task touching it (L329), and writing
the workaround down is the cheap half of that investment. Carry the chapter's uncomfortable
corollary into the room explicitly — an organisation with significant debt should expect lower
early returns than a peer with a cleaner codebase, and that is a property of the debt, not of the
tools.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **Panel B holds a register in the chapter's expected range** — thirty to sixty rows
   (ch12 L422) — or a written reason for fewer. A register of twelve rows means the first pass was
   filtered, which is the one thing the chapter tells you not to do.
2. **No Panel B row has a blank in column 8,** and the count of rows marked "In heads" is written
   on the face of Panel A as the instrumentation debt figure rather than left to be derived.
3. **Every Panel A mark in column 3 cites the Panel B row numbers that evidence it** (column 4).
   A "Present" with an empty column 4 is an assertion and is rejected at rollup.
4. **The starter set is three to five files, not more,** each with a file path and a named
   individual owner (columns 13-15). A starter set of twenty files is a plan nobody will execute.
5. **Panel C names at least one load-bearing module, or records `none` with the reason.** Every
   module listed has column 20 — the workaround — written out in prose, not left as "see the team".
   An empty column 20 is the tribal knowledge failing to transfer, on the sheet designed to catch it.
6. **Panel C is dated, and the date precedes** the date on `WS-03-roi-break-even-model` and on any
   scenario commitment. A debt register produced after the scenario has been chosen cannot inform it.
7. **No cell on the sheet records a projected return, improvement rate or divergence factor.**
   Every asset type marked Absent or Partial appears instead as a cost line in
   `WS-03-tco-calculator`, and the set of gaps carried into `WS-03-go-no-go-readiness-gate` matches
   Panel A exactly — a gate that clears an asset type Panel A marked Absent is an unresolved conflict.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** Carried unchanged from _section-clusters.md section 7 for CL-CONTEXT-DEBT.
- **Fill (the organisation completing it): `L`.** L - needs the real repository, finance input or cross-team agreement

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> THE HIGHEST-VALUE IMPLICIT FIND IN MY THREE CHAPTERS. Thirteen lines of dense prose (321-333), zero structure, and it describes the one asset the book says explains the divergence between two organisations that bought the same tool on the same day. Needs full authoring. Two panels because the section makes two distinct claims: the asset inventory (lines 321-329, the Context & Capabilities layer the harness loads on every invocation) and the technical-debt register (line 331: modules already painful for humans become disproportionately painful for agents because every invocation re-discovers the trap; organisations carrying significant debt should expect lower early returns than peers with cleaner codebases). The debt panel is the honest predictor of J-curve depth and should be filled BEFORE the scenario is chosen. Book is careful that compounding is a hypothesis, not a closed case - do not let the worksheet assert it as fact. Feeds the context-engineering cost line in WS-03-tco-calculator and the rework rate in WS-03-scenario-assumption-commitment. Cross-links to Chapter 4's five-layer reference architecture - synthesizer must check Ch04 does not already carry a layer-mapping worksheet.
