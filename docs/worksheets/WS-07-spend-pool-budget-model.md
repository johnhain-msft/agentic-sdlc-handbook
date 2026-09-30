# The Four Spend Pools — Allocating and Metering the Agentic Budget

`WS-07-spend-pool-budget-model` &middot; **Pack C - The case and the money** &middot; fill order **8** &middot; type `calculator` &middot; audience **exec** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A funded, owned, metered agentic budget broken into four pools — the artifact a CFO signs and an engineering leader operates against.

**Cluster.** `CL-SPEND-GOVERNANCE` - The Agentic Budget: Pools, Tiers, Gates and Levers

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch07-the-agentic-sdlc-bill.qmd` |
| Chapter | The Agentic SDLC Bill |
| Heading | Pool the spend, gate the bets |
| Stable anchor | `#sec-bill-spend-pooling` |
| Lines | L100-107 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch07-the-agentic-sdlc-bill.html#sec-bill-spend-pooling> |
| Locator quote | "| Spend pool | Funding rule | Who draws on it | Metering |" |

Resolve at any time with `python docs/resolve.py ws WS-07-spend-pool-budget-model`.

## 3. Source extract - the scaffolding, verbatim

```text
  100 | | Spend pool | Funding rule | Who draws on it | Metering |
  101 | |---|---|---|---|
  102 | | **Frontier R&D** | Capped envelope · best models | Central AI / frontier team | By budget — the deliberate bet |
  103 | | **Per-workflow run** | Metered by outcome | Approved, governed use cases | Cost per outcome |
  104 | | **Everyday prompting** | Capped to cheaper models | Everyone — the floor | Open baseline access |
  105 | | **Local models** | Unmetered · owned GPUs | High-volume, low-risk loops | Free at the margin |
  106 | 
  107 | : The four spend pools, each funded and metered by a different rule. The cheaper pools run open; only the deliberate bets — frontier exploration and metered at-scale runs — carry a gate. {#tbl-spend-pools tbl-colwidths="[20,30,28,22]"}
```

## 4. What the user fills

Four pool rows already named by the chapter (Frontier R&D, Per-workflow run, Everyday prompting, Local models). Per pool the leader writes: the actual funded amount for the period, the named budget owner, the user segments that draw on it, the metering mechanism and where the number will be read, and the trigger that reopens the allocation.

## 5. Field-level schema

One row per spend pool. The four pool names, funding rules, drawer segments and metering
bases are **pre-printed from @tbl-spend-pools**; the organisation supplies money, people and
read-out locations. The sheet is landscape, one page, with a signature block at the foot.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Spend pool | `select` (fixed 4 rows) | Frontier R&D / Per-workflow run / Everyday prompting / Local models | — | ch07 L102-105 |
| 2 | Funding rule | `free text` | Capped envelope · best models / Metered by outcome / Capped to cheaper models / Unmetered · owned GPUs | Edit only if the org rejects the rule | ch07 L102-105 |
| 3 | Funded amount, this period | `currency` | — | The number the CFO signs | org |
| 4 | Period covered | `date` range | — | Quarter or FY the amount applies to | org |
| 5 | Budget owner | `owner (named person)` | — | A named person, never a function | ch07 L107 intent |
| 6 | Who draws on it | `free text` | Central AI / frontier team; approved governed use cases; everyone — the floor; high-volume low-risk loops | The org's actual segment names | ch07 L102-105 |
| 7 | Metering mechanism | `free text` | By budget; cost per outcome; open baseline access; free at the margin | The specific tool or report that meters it | ch07 L102-105 |
| 8 | Where the number is read | `free text` | — | Dashboard, report or meeting where this pool's spend is actually reviewed | org |
| 9 | Read cadence | `select` weekly / monthly / quarterly | — | — | org |
| 10 | Reopen trigger | `free text` | — | The condition that reopens this allocation before the period ends | org |
| 11 | Gate? | `checkbox` | Pre-ticked for Frontier R&D and Per-workflow run only | Confirm or override | ch07 L107 — "only the deliberate bets carry a gate" |
| — | Total allocated | `computed` | — | Sum of column 3; must reconcile to the agentic line in `WS-03-tco-calculator` | derived |
| — | Sponsor signature + date | `signature` | — | The CFO or budget-holding executive | org |

**Absorbed detail.** This sheet absorbed no other candidate, but it is the *allocation* half of a
pair: `WS-07-cost-vs-value-gate` approves an individual spend **against** these pools, and
`WS-19-where-the-bill-gets-decided` names who owns each architectural lever that moves them.
Columns 11 and 10 are the hand-off points to those two sheets and must use identical vocabulary.

**Deliberate omission.** No "forecast" or "expected spend" column. The chapter's instrument is an
*allocation*, and adding a forecast column invites the room to budget from a prediction rather than
from a decision.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-07-cost-variance-baseline` - Our Own Cost Spread — Measuring the Variance Before We Budget (Pack C - The case and the money, fill order 4)

**Consumed by:**

- `WS-07-cost-vs-value-gate` - The Cost-vs-Value Gate — Approval Card for a Funded Workflow (Pack C - The case and the money, fill order 11)

**Feeds into (prose, from the source scan).** WS-07-cost-vs-value-gate (individual spends draw against these pools) and the cost line of the overall transformation business case.

## 8. Facilitation

| | |
|---|---|
| Who fills it | The budget-holding executive, with the engineering leader and whoever owns the current cloud/tooling spend line. Finance must be in the room, not consulted afterwards — column 3 is a commitment, not an estimate. |
| When in the session | Pack C, immediately after `WS-07-cost-variance-baseline`. The variance exhibit sizes the pools; this table governs them. Running it before the variance exhibit produces four numbers pulled from the air. |
| Duration | 45–60 minutes. The four rows are fast; naming a person in column 5 and a read-out location in column 8 is where the time goes, and where the honest answer is usually "nobody" and "nowhere". |
| Data needed in advance | Current annual spend on AI tooling and model consumption (any granularity); the existing cost-centre structure; who currently approves cloud spend; the output of `WS-07-cost-variance-baseline`. |
| Room format | Projected table filled live, or A3 printed landscape. Do not distribute as pre-work — the disagreement about who owns the frontier pool is the point of running it together. |

**Facilitation note carried from ch07.** The tier gate must be designed as *a queue, not a wall*.
If the room designs a gate with no escape hatch, the pool structure reads as austerity and
developers route around it. If `WS-07-model-tier-access-policy` has not yet been filled, record
the escape-hatch owner here and forward it.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All four pools carry a funded amount and a period.** A pool with a blank in column 3 is not a
   pool, it is an intention. If the organisation genuinely will not fund one (commonly Local
   models), it is recorded as `0` with a reopen trigger in column 10 — never left blank.
2. **Every budget owner in column 5 is a named individual**, not a function, a team or a role
   label. The register is unowned otherwise, which is the failure mode the chapter's whole
   pooling argument exists to prevent.
3. **Every pool names where its number is actually read (column 8) and how often (column 9).**
   A metering mechanism nobody reads is not metering.
4. **The computed total reconciles** to the agentic line in `WS-03-tco-calculator`. A discrepancy
   is either an unfunded pool or a cost the TCO missed; both must be resolved before Pack C closes.
5. **Exactly the two deliberate-bet pools carry a gate (column 11)**, or the room has written down
   why it is overriding the chapter, and `WS-07-cost-vs-value-gate` is updated to match.
6. **The sponsor has signed and dated it.** This is the artifact a CFO signs; an unsigned copy is a
   draft and must not be carried into Pack G as a funded input.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Carried unchanged from _section-clusters.md section 7 for CL-SPEND-GOVERNANCE.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Already a four-row table with funding rule, drawer, and metering columns, so structure is close to ready — the missing columns are the money, the owner, and the read-out location. This is the strongest exec-facing instrument in Chapter 7 because it is the one artifact that translates the whole agentic argument into a budget a finance function recognises. Pair it in the room with WS-07-cost-variance-baseline: the variance exhibit sizes the pools, the pool table governs them. The Local models pool connects forward to WS-07-local-inference-watchlist; the chapter notes local execution is waved straight through the cost gate, which makes that pool the cheapest place to run high-volume low-risk loops.
