# Our Own Cost Spread — Measuring the Variance Before We Budget

`WS-07-cost-variance-baseline` &middot; **Pack C - The case and the money** &middot; fill order **4** &middot; type `calculator` &middot; audience **mixed** &middot; leadership priority **1**

> **Split back out in the re-opening pass.** A measurement exercise producing the organisation's own spread exhibit in its own numbers; it is the declared prerequisite of WS-07-spend-pool-budget-model, a different canonical.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A one-page variance exhibit in the organization's own numbers — the CFO-facing artifact that reframes the agentic bill from a price negotiation into an engineering-design decision.

**Cluster.** `CL-COST-VARIANCE` - Our Own Cost Spread: Measuring Variance Before We Budget

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch07-the-agentic-sdlc-bill.qmd` |
| Chapter | The Agentic SDLC Bill |
| Heading | The Same Task, an 8.5× Bill |
| Stable anchor | `#sec-bill-cost-variance` |
| Lines | L13-41 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch07-the-agentic-sdlc-bill.html#sec-bill-cost-variance> |
| Locator quote | "Take a single, ordinary task: refactor nineteen files to adopt a new error-handling convention." |

Resolve at any time with `python docs/resolve.py ws WS-07-cost-variance-baseline`.

## 3. Source extract - the scaffolding, verbatim

```text
   13 | Take a single, ordinary task: refactor nineteen files to adopt a new error-handling convention. Hand it to an agent two ways. In the first, the agent loops file-by-file on a frontier model, re-reading context, re-planning, retrying on each failure. In the second, a *designed* workflow plans once, batches the edits, routes the mechanical work to a cheaper model, and verifies deterministically at the end. Same nineteen files. Same passing tests. In one illustrative run, the first path cost **\$41.01** and the second **\$4.81** — an **8.5× spread** on identical output.[^bill-variance]
   14 | 
   15 | ```{mermaid}
   16 | %%| label: fig-bill-variance
   17 | %%| fig-cap: "The same task, two ways. Identical input and identical output; the cost diverges by 8.5× depending only on how the work is organized. The bill is a property of the design, not the task."
   18 | %%| fig-alt: "A left-to-right flowchart. A single start node, Refactor nineteen files, splits into two paths. The upper path, labelled Undesigned, reads: file-by-file on a frontier model, re-read, re-plan, retry, and arrives at a cost node of forty-one dollars and one cent. The lower path, labelled Designed, reads: plan once, batch the edits, route mechanical work to a cheaper model, verify deterministically, and arrives at a cost node of four dollars and eighty-one cents. Both cost nodes converge on a single end node, Identical output: same files, same passing tests."
   19 | %%| fig-width: 6.5
   20 | %%| fig-height: 3.4
   21 | flowchart LR
   22 |     T["<b>Refactor 19 files</b>"]:::task
   23 |     T --> A["<b>UNDESIGNED</b><br/>file-by-file · frontier model<br/>re-read · re-plan · retry"]:::waste
   24 |     T --> B["<b>DESIGNED</b><br/>plan once · batch edits<br/>route to cheaper model · verify"]:::lean
   25 |     A --> AC["<b>$41.01</b>"]:::wastecost
   26 |     B --> BC["<b>$4.81</b>"]:::leancost
   27 |     AC --> O["<b>Identical output</b><br/>same files · same passing tests"]:::out
   28 |     BC --> O
   29 |     classDef task fill:#26261f,stroke:#26261f,color:#f9f7f5,font-weight:bold
   30 |     classDef waste fill:#f6e0d3,stroke:#c26b3f,color:#7c2d12,stroke-width:2px
   31 |     classDef lean fill:#eef0e0,stroke:#6c7931,color:#33401a,stroke-width:2px
   32 |     classDef wastecost fill:#c26b3f,stroke:#9a4f2a,color:#ffffff,font-weight:bold
   33 |     classDef leancost fill:#6c7931,stroke:#55611f,color:#ffffff,font-weight:bold
   34 |     classDef out fill:#f9f7f5,stroke:#26261f,color:#26261f,stroke-width:1.5px
   35 | ```
   36 | 
   37 | Hold onto that number, because it reframes the whole problem. Your agentic bill is not primarily a *price* problem — the per-token rate you negotiate. It is a *variance* problem — how widely the cost of the same outcome swings depending on how the work is organized. And variance is the thing finance teams already know how to think about: you do not manage a portfolio by its average return, you manage it by its tail risk. A *designed* workflow bounds your worst case to the worst *planned* step. An undesigned one bounds it to nothing.
   38 | 
   39 | This is why cost has become the strongest case yet for the argument this book has made since its first page: **engineer your agentic workflows centrally, deliberately, as artifacts you own.** Every prior chapter argued it on the grounds of reliability and governance. Cost makes the same argument in the language a CFO signs off on.
   40 | 
   41 | ---
```

## 4. What the user fills

Pick two or three recurring, high-frequency engineering tasks. For each, record: runs per month, measured cost of the undesigned path today, estimated cost of a designed path (plan once, batch, route mechanical work to a cheaper tier, verify deterministically), the resulting spread multiple, and annualised exposure. Explicitly record which numbers are measured and which are estimated.

## 5. Field-level schema

One row per recurring engineering task the organisation chooses to measure — two or three rows, no
more. Every figure on the sheet is the organisation's own; the chapter's illustrative run appears
only in a boxed sidebar, physically separated from the table. A3 landscape, one page. This is an
exhibit, not a form: it is designed to be shown to a CFO.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Task | `free text` | — | A recurring, high-frequency engineering task in our own codebase | org |
| 2 | Why this task | `select` high frequency / high unit cost / both | — | Tick one | derived |
| 3 | Runs per month | `free text` (count) | — | Measured from our own logs, or the team's honest estimate | org |
| 4 | Undesigned path — what it does today | `free text` | The chapter's example: file-by-file on a frontier model, re-reading context, re-planning, retrying on each failure | Our own description of today's loop | ch07 L13 |
| 5 | Undesigned cost per run | `currency` | — | Our figure | org |
| 6 | Designed path — what it would do | `free text` | The chapter's example: plan once, batch the edits, route the mechanical work to a cheaper model, verify deterministically at the end | Our own designed loop | ch07 L13 |
| 7 | Designed cost per run | `currency` | — | Our figure | org |
| 8 | Basis, column 5 | `select` metered from invoices / instrumented run / estimated | — | Tick one | derived |
| 9 | Basis, column 7 | `select` metered from invoices / instrumented run / estimated | — | Tick one, separately from column 8 | derived |
| 10 | Output identical? | `checkbox` | The chapter holds output constant — same nineteen files, same passing tests | Tick only if both paths produce the same verified output; otherwise state what differs | ch07 L13 |
| 11 | **Our spread multiple** | `computed` | — | Column 5 ÷ column 7 | derived |
| 12 | Monthly exposure | `computed` | — | (column 5 − column 7) × column 3 | derived |
| 13 | Annualised exposure | `computed` | — | Column 12 × 12 | derived |
| 14 | Who would own designing the designed path | `owner (named person)` | — | A named individual | org |
| — | **Total annualised exposure** | `computed` | — | Sum of column 13 — the figure that sizes the pools on `WS-07-spend-pool-budget-model` | derived |
| — | Highest-spread task | `computed` | — | The row with the largest column 11; circled, and carried into `WS-07-three-variables-audit` | derived |
| — | Measurement window | `date` range | — | The period columns 3, 5 and 7 were measured over. Undated, the exhibit is not auditable | org |
| — | Sheet mode | `select` MEASURED / PROSPECTIVE | — | PROSPECTIVE if every basis tick on the sheet reads "estimated"; printed across the header | derived |

**Boxed sidebar — the book's run, for reference only.** Printed to the right of the table, in a
box, with no adjacent blank cell and no row in the table: *one illustrative run on a nineteen-file
refactor cost $41.01 undesigned and $4.81 designed — an 8.5× spread on identical output* (ch07
L13). The sidebar carries the chapter's own fence immediately beneath it (see below). There is
nothing for the organisation to write in the sidebar, which is the point: a blank cell beside a
printed number is read as a target, so there is no blank cell beside this one.

**Printed verbatim on the sheet.** The chapter's Three-Tier Honesty callout, reproduced in full
under the sidebar:

> "The figures in this chapter — the 8.5× spread, the \$4.81 versus \$41.01 run, the model-price
> ranges — are **illustrative single runs and point-in-time prices**, not benchmarks. They are
> real, and they are not universal: the magnitude depends on the task, the models available the
> week you read this, and the harness. Treat them as existence proofs of *variance you can
> engineer*, not as a guaranteed return. The durable claim is the mechanism — model choice, token
> use, and harness govern the bill, and all three are in your control. The specific multiples will
> move. The lever will not." (ch07 L118)

The header strip carries the durable claim on its own, in large type, because that is what the
exhibit is actually arguing: **model choice, token use and harness govern the bill, and all three
are in our control.**

**Deliberate omission.** No "target spread" and no "expected saving" column. The sheet measures a
spread that already exists; a target column invites the room to plan against a multiple it has not
yet engineered, and the saving is not banked until `WS-07-three-variables-audit` names the lever
and someone owns the fix.

**Deliberate omission.** No model names and no per-token prices. The chapter's own footnote says
the price spread moves frequently and must be verified before budgeting; a price printed on a
laminated exhibit outlives its accuracy by about a quarter.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- None. This sheet can be filled cold.

**Consumed by:**

- `WS-07-spend-pool-budget-model` - The Four Spend Pools — Allocating and Metering the Agentic Budget (Pack C - The case and the money, fill order 8)
- `WS-07-three-variables-audit` - The Three Levers Audit — Model, Tokens, Harness (Pack C - The case and the money, fill order 9)

**Feeds into (prose, from the source scan).** WS-07-spend-pool-budget-model (annualised exposure sizes the pools) and WS-07-central-team-charter (the highest-spread task becomes the central team's first loop).

## 8. Facilitation

| | |
|---|---|
| Who fills it | The engineering leader, one engineer per task row who actually runs that task, and whoever can read the token or invoice meter. **Finance does not need to be in the room.** The numbers here come from engineering telemetry, and finance's seat is at `WS-07-spend-pool-budget-model`, which this exhibit sizes — arriving there with a measured exposure figure is worth more than having them watch it be produced. The engineer who runs the task must be present: columns 4 and 6 cannot be written by someone who has not seen a trace. |
| When in the session | Fill order 4. It has no prerequisites and is the first ch07 instrument. It must precede both `WS-07-spend-pool-budget-model` and `WS-07-three-variables-audit`, which declare it a prerequisite. Running the pool table first produces four numbers pulled from the air; running the lever audit first audits whichever workflows happen to be top of mind rather than the ones actually costing money. |
| Duration | 60–75 minutes for two or three task rows, **provided the cost data was pulled in advance**. The sheet cannot be filled cold: columns 5 and 7 need either an invoice broken down by workflow or an instrumented run, and neither is available in the room on the day. |
| Data needed in advance | A month of agentic spend broken down by workflow or repository, if any exists. A shortlist of the three highest-frequency engineering tasks with run counts. Ideally **one instrumented before-and-after pair on a single task, commissioned a week ahead** — one real pair of numbers is worth more than three estimated rows. If the organisation is not yet spending, say so before the session and plan for PROSPECTIVE mode. |
| Room format | A3 landscape, one page, filled live, with the book's illustrative run printed in a boxed sidebar to the side of the table — never as a row in it. Keep the sheet; it is the exhibit that goes in front of the CFO, and it is the only artifact in Pack C that reframes the bill from a price negotiation into an engineering-design decision. |

**Facilitation note.** The named rule for this sheet is the one to hold hardest: **the organisation
must produce its own spread.** The chapter fences $41.01, $4.81 and 8.5× as illustrative single
runs at point-in-time prices, and adopting them as a planning assumption is precisely the misuse it
warns against. If the room has no measured numbers and starts reaching for the book's, stop the
sheet and commission an instrumented run instead — a blank exhibit with a date on it is more useful
than a borrowed multiple, because it can be filled next month, whereas a borrowed multiple will be
quoted in a board pack next quarter. Open the session on the mechanism rather than the number:
model choice, token use and harness govern the bill, all three are controllable, and the sheet
exists to find out by how much *here*. Where the room's two figures come out close together, that
is a real and useful finding — it says the loop is already reasonably designed, and the money is
somewhere else.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **Every task row carries the organisation's own figures in columns 5 and 7.** A row reproducing
   $41.01 and $4.81, or any multiple copied from the chapter, is void and is struck from the sheet.
   The exhibit's entire value is that the numbers are ours.
2. **Both basis ticks (columns 8 and 9) are filled for every row, and at least one figure somewhere
   on the sheet is metered or instrumented rather than estimated.** A sheet of pure estimates is
   valid output, but it is marked PROSPECTIVE across the header and is not quoted as measurement.
3. **Column 10 is ticked for every row, or the row states what differs between the two paths.** A
   spread between two paths that do not produce the same verified output is not a spread — it is a
   comparison of two different jobs, and it will not survive a CFO's first question.
4. **Each row names an individual who would own designing the designed path.** Not a team. The
   highest-spread row's owner is the one who will be asked for a date.
5. **The total annualised exposure is computed and the measurement window is dated.** That figure,
   and no other, is what sizes the four pools on `WS-07-spend-pool-budget-model`; if the pool table
   totals something unrelated to it, one of the two sheets has not been filled honestly and the
   discrepancy is resolved before Pack C closes.
6. **The highest-spread row is circled and named** as the candidate first loop for the central
   team, and is carried into `WS-07-three-variables-audit` as a row on that sheet.
7. **The Three-Tier Honesty text appears on the completed sheet, and the book's illustrative run
   appears only in the sidebar.** If it has migrated into the table as a row, or if a column-11
   multiple matches 8.5× because it was assumed rather than divided, the sheet is rejected.

## 10. Integrity constraint

**Named rule for this sheet.** The worksheet must make the org produce its OWN spread. Using the book's 8.5x as a planning assumption is precisely the misuse the chapter warns against.

**Hedged figures reachable from this source range.** Each is listed with the book's own hedge, verbatim, and where that hedge lives. Present the figure as a pre-filled prior the organisation overwrites, or as a facilitation prompt - never as a benchmark, target or acceptance threshold. **Carry the hedge onto the sheet with the number; do not restate it in your own words.**

- **The 8.5x cost spread and the $4.81 versus $41.01 run on a nineteen-file refactor.**
  - *Appears at* `handbook\ch07-the-agentic-sdlc-bill.qmd` L11-41
  - *The book's hedge (ch07 L118):* The figures in this chapter -- the 8.5x spread, the $4.81 versus $41.01 run, the model-price ranges -- are **illustrative single runs and point-in-time prices**, not benchmarks.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** A narrative plus a mermaid. The fillable structure - task rows, measured-versus-estimated flags, annualised exposure - is net-new.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> The chapter supplies an illustrative single run ($41.01 vs $4.81, 8.5x) and immediately fences it in a Three-Tier Honesty callout (lines 119-121) stating these are illustrative single runs and point-in-time prices, not benchmarks. FACILITATION RULE: the worksheet must make the org produce its OWN spread; using the book's 8.5x as a planning assumption is precisely the misuse the chapter warns against. The durable claim to print on the worksheet header is the mechanism — model choice, token use, and harness govern the bill and all three are controllable. Book content is a narrative with a mermaid (16-40); the fillable structure is net-new authoring, but the framing is strong and ready.
