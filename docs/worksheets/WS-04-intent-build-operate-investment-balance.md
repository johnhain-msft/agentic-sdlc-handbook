# Intent / Build / Operate Investment Balance Sheet

`WS-04-intent-build-operate-investment-balance` &middot; **Pack C - The case and the money** &middot; fill order **7** &middot; type `calculator` &middot; audience **exec** &middot; leadership priority **1**

> **Split back out in the re-opening pass.** Allocates along a different axis -- Intent / Build / Operate lifecycle buckets with accountable executives and planning cadences -- not across spend pools; already a declared prerequisite of WS-05-board-reporting-scorecard.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A one-page budget and accountability allocation across the three executive buckets, with an explicit re-balancing ask.

**Cluster.** `CL-IBO-BALANCE` - Intent / Build / Operate Investment Balance

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch04-the-reference-architecture.qmd` |
| Chapter | The Agentic SDLC Reference Architecture |
| Heading | Mapping the Layers Across the Lifecycle |
| Stable anchor | `#sec-ref-arch-lifecycle-mapping` |
| Lines | L91-99 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch04-the-reference-architecture.html#sec-ref-arch-lifecycle-mapping> |
| Locator quote | "Executives do not need to think in eight phases. They need three buckets" |

Resolve at any time with `python docs/resolve.py ws WS-04-intent-build-operate-investment-balance`.

## 3. Source extract - the scaffolding, verbatim

```text
   91 | Executives do not need to think in eight phases. They need three buckets that map to planning cadences, budget lines, and organizational accountability:
   92 | 
   93 | **Intent** (Ideate + Plan) answers "what are we building and why?" Agent assistance here is mostly emerging. Research agents that surface prior art, planning agents that draft architecture decision records and decompose epics into tasks. These exist in early forms, but no tool reliably automates the judgment calls that make planning valuable.
   94 | 
   95 | **Build** (Code + Build + Test + Review) answers "how do we turn intent into verified software?" This is where agent capabilities are most mature. Code generation, build diagnostics, test generation, and automated code review all have production-ready implementations across multiple vendors. This is also where most organizations start, and where the Vibe Coding Cliff from Chapter 1 hits hardest if context is not structured.
   96 | 
   97 | **Operate** (Release + Operate) answers "how do we get software to users and keep it running?" Agent assistance in release management is emerging; in incident response, it is directional. Correlating alerts to recent deployments, drafting incident timelines, suggesting rollback actions — these capabilities exist today as point solutions inside specialised observability and incident-management products, but not yet in workflows integrated end-to-end with the development lifecycle.
   98 | 
   99 | The practical implication: based on vendor maturity and published adoption patterns, most organizations appear to have concentrated investment in the Build bucket, with minimal coverage in Intent and almost none in Operate. This is not a failure. It reflects where the technology is mature. But it means the next high-value investments are in Plan, Test, and Review — where the work is expensive, the feedback loops are slow, and structured context makes the difference between useful automation and expensive noise.
```

## 4. What the user fills

Three rows (Intent, Build, Operate). Per row: current annual spend on tools and model consumption, FTE or headcount allocated, number of teams active, the named accountable executive, the planning cadence it sits on, and a target allocation for the next twelve months. A variance line shows the gap against the chapter observation that most organisations over-index on Build with near-zero Operate coverage.

## 5. Field-level schema

One row per executive bucket. The three bucket names, the lifecycle phases each covers, the
question each answers and the chapter's maturity read are **pre-printed from ch04 L93-97**; the
organisation supplies money, people, accountability and a target. One page, landscape, signed. The
three rows are fixed: the chapter's argument is that executives need *three* buckets, and a fourth
row re-imports the eight phases this sheet exists to collapse.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Bucket | `select` (fixed 3 rows) | Intent / Build / Operate | — | ch04 L93-97 |
| 2 | Lifecycle phases it covers | `free text` (read-only) | Ideate + Plan / Code + Build + Test + Review / Release + Operate | — | ch04 L93-97 |
| 3 | Question it answers | `free text` (read-only) | "What are we building and why?" / "How do we turn intent into verified software?" / "How do we get software to users and keep it running?" | — | ch04 L93-97 |
| 4 | Agent maturity, per the chapter | `free text` (read-only) | Intent: mostly emerging — no tool reliably automates the judgement calls / Build: most mature, production-ready across multiple vendors / Operate: release management emerging, incident response directional, point solutions not integrated end-to-end | — | ch04 L93-97 |
| 5 | Current annual spend — tools and model consumption | `currency` | — | Our own figure for this bucket | org |
| 6 | FTE or headcount allocated | `free text` (count) | — | Our own | org |
| 7 | Teams active in this bucket | `free text` (count) | — | Our own, carried up from `WS-04-lifecycle-layer-coverage-canvas` | org |
| 8 | Accountable executive | `owner (named person)` | — | One named executive per bucket. Not a function, not a committee | ch04 L91 |
| 9 | Planning cadence it sits on | `select` annual / quarterly / monthly / sprint / none, and the forum | — | The cadence **and** the named forum that owns it | ch04 L91 |
| 10 | Budget line it is drawn from | `select` / `free text` | — | The actual cost centre or budget line. "To be determined" means the bucket has no money | ch04 L91 |
| 11 | Current share of total | `computed` | — | Column 5 ÷ footer total | derived |
| 12 | Target share, next twelve months | `free text` | — | Our own target, argued in the room | org |
| 13 | Re-balancing ask | `free text` | — | The specific money or headcount move, and the named person who must approve it | derived |
| — | **Total across the three buckets** | `computed` | — | Sum of column 5; reconciles to the tooling and model-consumption lines of `WS-03-tco-calculator` | derived |
| — | Concentration check | `free text` | The chapter observes that, based on vendor maturity and published adoption patterns, most organisations *appear* to have concentrated investment in Build, with minimal coverage in Intent and almost none in Operate — a directional observation, not a measured distribution | Our own three computed shares, and one sentence on whether we match the pattern | ch04 L99 |
| — | Next high-value investment, per the chapter | `free text` (read-only) | Plan, Test and Review — where the work is expensive, the feedback loops are slow, and structured context makes the difference between useful automation and expensive noise | Our own ranked next investment, with a reason if it differs | ch04 L99 |
| — | Sponsor signature + date | `signature` | — | The executive sponsor | org |

**Absorbed detail.** This sheet absorbed no other candidate. It does, however, *consume* one:
columns 6 and 7 are aggregated up from `WS-04-lifecycle-layer-coverage-canvas`, which establishes
who, which agent and which platform per phase. Filling this sheet without that canvas means columns
6 and 7 are recollections, and the concentration check then compares a guess against an
observation.

**Deliberate omission.** **No recommended split.** The chapter names a *direction* — under-weight
in Intent, close to nothing in Operate — and gives no distribution at all. Printing a target split
such as 30/50/20 would fabricate a benchmark the book does not contain, and a fabricated split on a
signed exec sheet becomes a governance target within one quarter. Column 12 is therefore the
organisation's own target, argued in the room, with the chapter's directional observation printed
beside it as a prompt rather than a number.

**Deliberate omission.** No maturity score, index or 1–5 rating for the three buckets. Column 4
carries the chapter's qualitative read and stops there; converting "mostly emerging" and
"directional" into numbers would make them summable and comparable, which is exactly what they are
not.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-04-lifecycle-layer-coverage-canvas` - Lifecycle Layer Coverage Canvas: Who, Which Agent, Which Platform, Per Phase (Pack B - Where we actually are, fill order 2)

**Consumed by:**

- `WS-05-board-reporting-scorecard` - Quarterly Board Scorecard: Adoption, Value, Cost, Risk (Pack G - The plan we leave with, fill order 7)

**Feeds into (prose, from the source scan).** WS-08-pilot-selection-and-scope; the Cost rows of WS-05-board-reporting-scorecard

## 8. Facilitation

| | |
|---|---|
| Who fills it | The executive sponsor and the three people who will be named in column 8 — one per bucket — in the room together. **A finance business partner should attend**, because columns 5 and 10 must tie to real cost-centre lines rather than to an engineering estimate of what the organisation probably spends; procurement is not needed. Do **not** run this with one executive naming the other two in their absence. The naming is the deliverable, and a name assigned to an empty chair is the Operate row's usual fate. |
| When in the session | Fill order 7. Its prerequisite `WS-04-lifecycle-layer-coverage-canvas` from Pack B must be complete — it supplies the per-phase coverage that columns 6 and 7 aggregate. Run it after `WS-03-tco-calculator` so the footer total has something real to reconcile against, and before `WS-07-spend-pool-budget-model`, which allocates the same money along a different axis and will otherwise be the first place anyone notices the two do not add up. |
| Duration | 45–60 minutes. Three rows, but columns 8 and 10 take most of it. Expect the Operate row to be the slow one: it is where the room routinely discovers there is no owner, no budget line, and no cadence — which is the chapter's observation arriving as a lived experience rather than as a claim. |
| Data needed in advance | The completed lifecycle layer coverage canvas. The current cost-centre structure and which lines actually carry tooling and model consumption. Headcount by lifecycle phase, however approximate. The existing planning cadences and the forums that own them, so column 9 records a real meeting rather than an aspiration. Any spend currently sitting in expenses rather than in a budget line. |
| Room format | One projected table filled live, with the three bucket names written large on the wall. A3 printed works equally well. Do **not** distribute as pre-work: the argument about who owns Operate is the entire point of running it together, and it is precisely the row that gets quietly left blank when the sheet is filled alone at a desk. |

**Facilitation note.** The chapter's framing is what makes this an executive instrument rather than
an architectural one: the three buckets map to "planning cadences, budget lines, and organizational
accountability", which is why columns 8, 9 and 10 are load-bearing rather than administrative. Say
the chapter's other sentence out loud before the room fills column 11: the concentration in Build
**"is not a failure. It reflects where the technology is mature."** Without it, the sheet turns
into a self-criticism exercise and the room starts defending its history instead of re-balancing
its next twelve months. And hold the line on the target column: the chapter gives a direction, not
a split, so the number in column 12 must be the room's own argued figure — if someone asks what the
recommended allocation is, the honest answer is that the book does not give one.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All three buckets carry a spend figure, a headcount and a team count (columns 5, 6, 7).** A
   bucket the organisation genuinely does not fund is recorded as `0`, never left blank — a blank
   Operate row is indistinguishable from a question nobody asked.
2. **Each bucket names one accountable executive as a named individual (column 8)**, and that
   person either was in the room or was notified before the session closed.
3. **Each bucket names the planning cadence and forum it sits on (column 9) and the real budget
   line it is drawn from (column 10).** "To be determined" in column 10 is permitted only if the
   sheet states plainly that the bucket currently has no money.
4. **The computed total reconciles to the tooling and model-consumption lines of
   `WS-03-tco-calculator`.** A gap is either spend nobody has booked or a cost the TCO missed; both
   are resolved before Pack C closes, not annotated and carried.
5. **Every bucket has a target share, and every bucket whose target differs from its current share
   carries a re-balancing ask naming the money or headcount move and the person who must approve
   it.** A target with no ask is an aspiration and will not survive the next planning round.
6. **No recommended split is printed anywhere on the completed sheet.** The concentration check
   records the organisation's own computed shares against the chapter's directional observation. If
   a percentage split has appeared that nobody in the room argued for, it has been invented and is
   struck.
7. **Signed and dated.** These three rows become the Cost rows of `WS-05-board-reporting-scorecard`
   in Pack G; an unsigned copy must not be carried forward into a board-facing scorecard.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** The book names the three buckets and the over-indexing claim but offers no fillable structure at all.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Implicit find: the book gives the three buckets and the claim that investment concentrates in Build, but offers no fillable structure at all, so this needs authoring. The chapter frames these buckets as mapping to "planning cadences, budget lines, and organizational accountability" (line 91), which is what makes this an exec instrument rather than an architect one. Overlaps the dedicated cost chapter ("the agentic SDLC bill") referenced at ch04 line 157 and ch05 line 309 - synthesizer should check whether that chapter already carries a fuller calculator and keep this one as the pre-groundbreaking coarse allocation only.
