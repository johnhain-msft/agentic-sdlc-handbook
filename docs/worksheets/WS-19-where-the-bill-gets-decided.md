# Where Does the Bill Get Decided? Cost-Lever Ownership Map

`WS-19-where-the-bill-gets-decided` &middot; **Pack C - The case and the money** &middot; fill order **5** &middot; type `decision` &middot; audience **exec** &middot; leadership priority **1**

> **Split back out in the re-opening pass.** Answers who owns each architectural cost lever rather than what it costs; its own note records the de-dup as confirmed and specifies a half-page facing the spend-pool sheet.
>
> Ships as: `facing:WS-07-spend-pool-budget-model`

## 1. Purpose

**Output artifact.** A cost-lever ownership map that says explicitly which spend decisions are engineered centrally and which are left to teams.

**Cluster.** `CL-COST-LEVER-OWNERSHIP` - Where the Bill Gets Decided: Cost-Lever Ownership

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch19-architectural-patterns-rosetta-stone.qmd` |
| Chapter | Architectural Patterns: A Rosetta Stone |
| Heading | 1. The layered model of an agentic runtime |
| Stable anchor | `#sec-layered-model` |
| Lines | L50-50 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch19-architectural-patterns-rosetta-stone.html#sec-layered-model> |
| Locator quote | "Token economics does not add a layer; it is a property that cuts across" |

Resolve at any time with `python docs/resolve.py ws WS-19-where-the-bill-gets-decided`.

## 3. Source extract - the scaffolding, verbatim

```text
   50 | **A cost overlay, not a fifth layer.** Token economics does not add a layer; it is a property that cuts across three existing ones. The *model* selected at the Foundation layer is the cost function. The *prefix* laid out at the Assembly layer decides how much of each turn is cacheable. The *dispatch* chosen at the Execution layer governs how many calls happen and on which model class. The cost-aware patterns added below — Cache-Aware Prefix at Assembly (§3′), Model Router and Gradient Workflow at Dispatch (§4), Tool Subset at the boundary (§5) — are the catalogue's answer to a single question: *where does the bill get decided?* The leaders-block economics chapter (*The Agentic SDLC Bill*) argues why an organization should engineer that bill centrally; this chapter names the patterns that do the engineering.
```

## 4. What the user fills

Three rows, one per cost lever named in the passage -- model class selected at Foundation, context-window prefix layout at Assembly, dispatch topology at Execution. Per row: who sets it (central platform / each team / vendor default), what it is set to today, the target, the guardrail, and the owner. The chapter's question is the worksheet's title: "where does the bill get decided?"

## 5. Field-level schema

One row per architectural cost lever. The three levers, the reason each moves the bill and the
pattern that engineers it are **pre-printed from ch19 L50**; the organisation supplies ownership,
current state, target and guardrail. Half a page, landscape, printed to **face**
`WS-07-spend-pool-budget-model` so that column 9 and the pool mapping read across the fold against
that sheet's budget owners.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Cost lever | `select` (fixed 3 rows) | Model class selected at the Foundation layer / Context-window prefix layout at the Assembly layer / Dispatch topology at the Execution layer | — | ch19 L50 |
| 2 | Why it moves the bill | `free text` (read-only) | "The *model* selected at the Foundation layer is the cost function" / "The *prefix* laid out at the Assembly layer decides how much of each turn is cacheable" / "The *dispatch* chosen at the Execution layer governs how many calls happen and on which model class" | — | ch19 L50 |
| 3 | The pattern that engineers it | `free text` (read-only) | Model Router and Gradient Workflow at Dispatch / Cache-Aware Prefix at Assembly / Tool Subset at the boundary | — | ch19 L50; detail at L103-107, L113-129, L135-143 |
| 4 | Who sets it today | `select` central platform / each team / individual developer / vendor default / nobody | — | Tick one. "Vendor default" and "nobody" are the two answers most rooms discover, and both are valid | derived |
| 5 | What it is set to today | `free text` | — | The actual current state, in one sentence | org |
| 6 | Who should set it | `select` central platform / each team / individual developer | — | Tick one | org |
| 7 | Target state, and by when | `free text` + `date` | — | What it should be set to, with a date | org |
| 8 | Guardrail | `free text` | — | The boundary a team may not cross without approval | org |
| 9 | Accountable owner | `owner (named person)` | — | A named individual, never a function | org |
| 10 | How a change to this lever is detected | `free text` | — | The alert, report or review that tells us it moved, and who receives it | derived |
| 11 | Gap? | `checkbox` | — | Tick where columns 4 and 6 differ. The ticked rows are the decisions this session must actually make | derived |
| — | Pool this lever moves | `select` (4 fixed) | Frontier R&D / Per-workflow run / Everyday prompting / Local models | Map each lever to the pool it moves, using the pool names verbatim | ch07 L102-105, via `WS-07-spend-pool-budget-model` |
| — | Architecture sign-off | `signature` + `date` | — | The architecture or platform owner | org |

**Absorbed detail.** This sheet absorbed no other candidate, but it is the *ownership* half of a
facing pair: `WS-07-spend-pool-budget-model` names how much money each pool holds and who owns the
budget; this sheet names which architectural decision moves that money and who owns the decision.
The pool row in the footer is the join. Use that sheet's four pool names character-for-character —
if the two sheets spell a pool differently, the pair silently stops reconciling.

**Deliberate omission.** No currency column anywhere on the sheet, and no cost figures. This
instrument is deliberately money-free: it answers *who owns the lever*, not *what the lever costs*.
The amounts live on the facing sheet, and a currency column here would make this a second,
competing budget model — the exact duplication the source scan flagged and then confirmed against.

**Deliberate omission.** No numeric spike threshold in column 10. A week-over-week token-spike
trigger already exists on `WS-05-governance-readiness-assessment`, where the monitoring that makes
it meaningful also lives. Printing a threshold here would let it be inherited as policy without
that monitoring, so column 10 records *who is told and how*, never *at what number*.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- None. This sheet can be filled cold.

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** The leaders-block economics chapter (The Agentic SDLC Bill) budget model, and WS-05-governance-readiness-assessment whose weekly row already flags >25% week-over-week token spikes

## 8. Facilitation

| | |
|---|---|
| Who fills it | The principal engineer or chief architect who owns the runtime, the platform lead, and the engineering leader who holds the budget. **Finance is not required in the room** — the sheet has no currency column, and finance's seat is at the facing sheet. What matters instead is that **the person named in column 9 is present**, or reachable during the session: naming an absent colleague as accountable owner of a cost lever is precisely how the register ends up unowned, and the absent person finds out from a PDF. |
| When in the session | Fill order 5. After `WS-07-cost-variance-baseline`, which has just shown the room these levers moving real money, and immediately before `WS-07-spend-pool-budget-model`, which it faces. **Fill the pair in the same sitting**: this one names who decides, that one names how much. Separating them by a break produces two sheets whose owners do not match. |
| Duration | 30–40 minutes. Three rows, half a page. Column 4 is quick and uncomfortable; column 6 set against column 4 is the entire conversation, and column 10 is where the room discovers that an owned lever nobody watches is unowned in practice. |
| Data needed in advance | Which harness or harnesses the organisation actually runs. Whether those harnesses expose prompt-prefix caching as a billing unit. Whether more than one model class is available today at all. Who currently holds admin rights over model selection in each tool. The completed `WS-07-cost-variance-baseline`. |
| Room format | Half a page, printed landscape to face `WS-07-spend-pool-budget-model` in the same spread. Fill live. It is short enough to redo cleanly if the room changes its mind about central versus team ownership, which it usually does once, about twenty minutes in. |

**Facilitation note.** The chapter is explicit that token economics is **a property cutting across
three existing layers, not a fourth layer** — so resist the room's instinct to add a fourth row.
Whatever it wants to add is almost always an instance of one of the three. The chapter also names
the patterns that do the engineering — Model Router, Gradient Workflow, Cache-Aware Prefix, Tool
Subset — and places them in the practitioner block: **leadership funds those patterns, it does not
design them here.** If the room starts specifying routing rules or debating cache-key layout, it
has drifted out of this sheet and into Part III; note the question, park it, and bring it back to
column 7. The useful provocation to open with is the chapter's own question, which is also this
worksheet's title: *where does the bill get decided?* In most organisations, on the day, the honest
first answer to all three rows is "vendor default", and that is the finding.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All three levers carry a tick in column 4 and a tick in column 6.** "Vendor default" and
   "nobody" are permitted, common and honest answers in column 4; a blank is not, because a blank
   records that nobody checked rather than that nobody owns it.
2. **Every row names an individual in column 9**, and that person was either in the room or was
   notified before the session ended. An owner who learns of the role afterwards is a name on a
   sheet, not an owner.
3. **Every row where columns 4 and 6 differ is ticked in column 11 and carries a target state with
   a date in column 7.** An identified gap with no date is an observation, not a decision, and this
   is a decision sheet.
4. **Every lever names how a change to it is detected, and who receives that signal (column 10).**
   A lever with an owner and no detection is unowned in practice — the owner finds out from the
   invoice.
5. **Each lever is mapped to one of the four spend pools, spelled exactly as on
   `WS-07-spend-pool-budget-model`.** Every pool that carries a gate on that sheet has at least one
   lever mapped to it here; a gated pool with no lever means the gate has nothing to act on and one
   of the two sheets is wrong.
6. **No currency figure appears anywhere on the completed sheet.** If one has been written in, it
   belongs on the facing sheet, and the two now disagree about a number only one of them is
   entitled to hold.
7. **The sheet is signed and dated by the architecture owner**, and is filed physically facing
   `WS-07-spend-pool-budget-model`. Separated, the pair loses the one property that makes it
   useful: money and ownership readable in a single glance.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** Prose only. The three lever rows exist as a sentence; who-sets-it / today / target / guardrail / owner all need authoring.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Strong exec find: the chapter defers the "why engineer the bill centrally" argument to the leaders-block economics chapter but names the three levers here, so this is the architectural half of a decision the exec kit must make before breaking ground. DE-DUP RISK with whoever scanned the economics chapter -- that one likely owns the ROI/unit-cost calculator; this one is narrower and better (it is about WHO OWNS each lever, not what it costs). Supporting pattern detail: Cache-Aware Prefix at 103-107, Model Router and Gradient Workflow at 113-129, Tool Subset at 135-143. Prose only -- needs full authoring. CONFIRMED DE-DUP: Ch07 owns the economics with WS-07-spend-pool-budget-model, WS-07-cost-variance-baseline and WS-07-cost-vs-value-gate (all p1). This row is NOT a budget model and should not be merged into one -- it answers a different question (which ARCHITECTURAL lever sets the bill, and who owns each). Best shape: a half-page facing the Ch07 spend-pool worksheet, feeding it. Demote to priority 2 if the synthesizer finds Ch07 already covers lever ownership.
