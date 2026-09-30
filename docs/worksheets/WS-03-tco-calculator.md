# Year-One Total Cost of Ownership Calculator

`WS-03-tco-calculator` &middot; **Pack C - The case and the money** &middot; fill order **3** &middot; type `calculator` &middot; audience **eng-leader** &middot; leadership priority **1**

> **Split back out in the re-opening pass.** The year-one cost build-up across six components, filled by finance and procurement at a different sitting; the canonical already declares it a prerequisite, which a merged row cannot satisfy.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A defensible year-1 investment number in which licences are visibly 20-25% of total spend - the cost input to the break-even model and the line that survives a CFO review.

**Cluster.** `CL-TCO` - Year-One Total Cost of Ownership

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch03-the-business-case.qmd` |
| Chapter | The Business Case |
| Heading | What It Actually Costs |
| Stable anchor | `#sec-business-case-costs` |
| Lines | L36-97 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch03-the-business-case.html#sec-business-case-costs> |
| Locator quote | "Every vendor pitch includes the license fee. None of them include the other" |

Resolve at any time with `python docs/resolve.py ws WS-03-tco-calculator`.

## 3. Source extract - the scaffolding, verbatim

```text
   36 | Every vendor pitch includes the license fee. None of them include the other 70–80% of your actual investment. A business case that accounts only for subscription costs is like a construction budget that covers materials but omits labor.
   37 | 
   38 | The total cost of ownership for agentic development has six components. The first is the only one your vendor will mention.
   39 | 
   40 | ### Tool licenses
   41 | 
   42 | The visible cost — and the only one vendors emphasize. Pricing models vary across tools and are evolving rapidly, but as of early 2025, representative price points for the major agentic coding platforms illustrate the range[^ch3-pricing]:
   43 | 
   44 | | Tool | Individual | Team / Business | Enterprise |
   45 | |---|---|---|---|
   46 | | GitHub Copilot | Free / $10 Pro / $39 Pro+ | $19/user/mo | $39/user/mo |
   47 | | Cursor | Free / $20 Pro / $60 Pro+ | $40/user/mo | Custom |
   48 | | Claude (Anthropic) | Free / $20 Pro / $100+ Max | $25/seat/mo | $20/seat + usage |
   49 | 
   50 | Enterprise tiers add SSO, audit logs, data residency, and admin controls. Note that most platforms are shifting toward **usage-based pricing** — GitHub Copilot Enterprise includes 1,000 premium requests per user per month (a single request to a frontier model like Claude Opus 4.6 consumes multiple premium requests), while others bill by token consumption. The actual license cost depends heavily on how aggressively your teams use agentic workflows with premium models. For a team of 10 on enterprise tiers, expect $2,400–5,000/year per developer in license costs alone — before token overages.
   51 | 
   52 | [^ch3-pricing]: Prices as of March 2025. See [GitHub Copilot plans](https://docs.github.com/en/copilot/about-github-copilot/plans-for-github-copilot), [Cursor pricing](https://cursor.com/pricing), [Anthropic pricing](https://anthropic.com/pricing). These change frequently; verify current rates before budgeting.
   53 | 
   54 | ### Context engineering investment
   55 | 
   56 | The largest hidden cost, and the one that determines whether the tool investment pays off. Context engineering — the practice of structuring your team's knowledge so AI agents can use it reliably — requires upfront work: documenting architectural decisions, writing machine-readable conventions, building instruction hierarchies, and curating the artifacts that make agents effective on your specific codebase.
   57 | 
   58 | For a team of 10–15 developers, in our experience with teams adopting this methodology, expect 2–4 weeks of engineering time for initial context architecture. This is not optional overhead. Without it, you've purchased tools that will generate plausible code that violates your conventions and requires extensive rework. With it, agent output improves over time as context compounds. Chapter 4 covers this investment in detail.
   59 | 
   60 | ### Token and compute costs
   61 | 
   62 | Usage-based pricing is increasingly common for agentic workflows. When an agent reads 50 files, plans an approach, generates code, runs tests, and iterates on failures, it consumes tokens at each step. For teams running frequent agentic sessions on premium models, token costs can reach $50–200 per developer per month — sometimes exceeding the tool subscription itself. This cost scales with usage, which means it scales with success. Budget for it to grow.
   63 | 
   64 | That monthly range describes *average* spend. The number that decides whether agentic delivery stays affordable at scale is not the average but the *variance*: the same task can cost several times more or less depending on which model runs it, how much context it consumes, and how the workflow is orchestrated. That variance is itself engineerable — and engineering it is the difference between a predictable bill and a runaway one. The chapter on the agentic SDLC bill builds the operating model that turns run-cost from a line item into a lever.
   65 | 
   66 | ### Training and change management
   67 | 
   68 | Developers don't become effective with agentic tools by reading a getting-started guide. The shift from "AI suggests a line of code" to "AI executes a multi-step task" requires new skills: prompt decomposition, context management, output verification, and knowing when to delegate versus when to write code directly. Expect 1–2 weeks of reduced productivity per developer during the learning curve, plus ongoing investment in shared practices and internal documentation.
   69 | 
   70 | ### Governance overhead
   71 | 
   72 | If your organization has compliance requirements — and most do — agent-generated code needs audit trails, review policies, and guardrails. Someone needs to define which agents can access which repositories, what approval workflow applies to agent-generated PRs, and how to handle data residency for code flowing through external APIs. This is a real cost in engineering and security team time, especially in the first quarter of adoption.
   73 | 
   74 | ### Opportunity cost of the adoption curve
   75 | 
   76 | During the first 60–90 days, your team will be slower, not faster. Context hasn't been built. Skills haven't been developed. The tools are being configured. The team is learning which tasks to delegate and which to keep manual. This is normal. This is also a cost that must be accounted for, especially if leadership expects immediate returns and loses confidence during the valley.
   77 | 
   78 | ### The honest TCO picture
   79 | 
   80 | ::: {tbl-colwidths="[25,35,40]"}
   81 | 
   82 | | Cost component | Illustrative range (team of 10, year 1) † | What's often missed |
   83 | |---|---|---|
   84 | | Tool licenses | $24,000–50,000 | Enterprise tier + premium model usage overages |
   85 | | Context engineering | $20,000–60,000 † | Measured in engineering time, not invoices |
   86 | | Token / compute | $6,000–24,000 † | Scales with adoption success |
   87 | | Training / change mgmt | $15,000–40,000 † | Productivity dip during learning curve |
   88 | | Governance setup | $10,000–25,000 † | Security review, policy definition, audit configuration |
   89 | | Adoption curve opportunity cost | $20,000–50,000 † | 60–90 days of reduced velocity |
   90 | | **Year 1 total** | **$95,000–249,000** † | Tool licenses are 20–25% of total |
   91 | 
   92 | :::
   93 | 
   94 | † Author estimates based on advisory work with early-adopter teams. Tool license costs reflect published pricing; all other ranges are projections that will vary by region, seniority, codebase complexity, and tooling maturity.
   95 | 
   96 | These ranges are estimates. Your numbers will vary based on team size, codebase complexity, compliance requirements, and how much undocumented knowledge currently lives in your team's heads. The point is not the specific figures; it's the ratio. If your business case shows only the first row, it is incomplete.
   97 | 
```

## 4. What the user fills

A dollar figure for each of the six cost components (tool licences, context engineering, token and compute, training and change management, governance setup, adoption-curve opportunity cost) scaled to actual team size and seniority, with the assumption written beside each figure and a year-1 total.

## 5. Field-level schema

One row per cost component. The six component names and the chapter's "what's often missed" notes
are **pre-printed from ch03 L84-89**; the book's illustrative team-of-ten ranges sit in a read-only
column, daggers intact, immediately to the left of the blank column the organisation fills. Two
pages: the build-up below, plus a licence sub-table that is entirely blank by design.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Cost component | `select` (fixed 6 rows) | Tool licences / Context engineering / Token & compute / Training & change management / Governance setup / Adoption-curve opportunity cost | — | ch03 L84-89 |
| 2 | What's often missed | `free text` (read-only) | Enterprise tier + premium model usage overages / Measured in engineering time, not invoices / Scales with adoption success / Productivity dip during learning curve / Security review, policy definition, audit configuration / 60–90 days of reduced velocity | — | ch03 L84-89 |
| 3 | Illustrative range, team of 10, year 1 † | `free text` (read-only) | $24,000–50,000 / $20,000–60,000 † / $6,000–24,000 † / $15,000–40,000 † / $10,000–25,000 † / $20,000–50,000 † | Not editable — the book's prior, carried with its dagger | ch03 L84-89 |
| 4 | **Our figure, year 1** | `currency` | — | The organisation's own number, for the organisation's own team size | org |
| 5 | Our assumption behind it | `free text` | — | One sentence: seat count, headcount, day rate, weeks. The sentence a CFO will test | org |
| 6 | Basis | `select` quoted / invoiced / estimated internally / scaled from the book's range | — | Tick one | derived |
| 7 | Owner of this line | `owner (named person)` | — | Who defends this figure in a CFO review | org |
| 8 | Confidence | `H/M/L` | — | Argued, not computed | derived |
| — | Team size this build-up is for | `free text` (count) | The book's illustrative table is built for a team of 10 | Our actual engineer count | ch03 L82 |
| — | **Year-1 total, our figure** | `computed` | Book's illustrative total: $95,000–249,000 † | Sum of column 4 | ch03 L90 |
| — | Licence share of our total | `computed` | The book observes tool licences are 20–25% of total † | Our own computed percentage, plus one sentence if it diverges | ch03 L90 |
| — | Divergence note | `free text` | — | Why our licence share differs from the book's observation, if it does | derived |
| — | Finance sign-off | `signature` + `date` | — | The CFO or finance business partner | org |

**Licence sub-table (entirely blank by design).** The chapter's March 2025 vendor price table is
**not reproduced**. In its place the sheet carries an empty grid the organisation prices itself:
one row per tool, with columns *Tool* (`free text`), *Tier being bought* (`select` individual /
team-business / enterprise), *Licence model* (`select` per-seat subscription / usage-based /
platform-bundled — the three models ch02 L142 names), *Seats* (`free text`), *Quoted unit price*
(`currency`), *Enterprise premium over individual* (`computed`, with ch02's observation that
enterprise tiers typically run 2–4× the individual price printed beside it as a read-only prior),
*Included usage allowance* (`free text`), *Expected overage basis* (`free text`), and ***Quote
date*** (`date`). The quote date is mandatory; without it the sheet cannot be dated and cannot be
trusted downstream. Source for the licence-model taxonomy and the enterprise-premium prior:
ch02 L142-146.

**Context-engineering sub-calculator.** Row 2 is the largest hidden cost and the chapter says so
explicitly, so column 4 for that row is computed rather than typed: *engineers assigned* ×
*weeks of effort* × *fully loaded weekly cost as finance defines it*. The book's observation —
2–4 weeks of engineering time for initial context architecture on a team of 10–15 — is printed
beside the weeks field as a read-only prior with its own note that it is drawn from the author's
experience with adopting teams, never as a default value in the field.

**Carried from the source scan (ch02 pricing, kept here rather than shipped as its own sheet).**
The three pricing models and the enterprise-tier premium from ch02 L142-146 land in the licence
sub-table as the *Licence model* selector and the *Enterprise premium* column. The chapter's own
framing — that the budget question is not "what does the tool cost?" but what it costs relative to
the developer time it displaces, and whether the governance premium beats the shadow-IT
remediation cost — is printed above that sub-table as its heading sentence, because it is the
question rows 2 to 6 exist to answer.

**Deliberate omission.** No vendor prices and no per-developer licence figure are printed anywhere
on the sheet — not the March 2025 table, not the $2,400–5,000 per developer range. The named rule
for this sheet is that the price table is a fill-in, never a printed constant, and a dated price
reproduced on a worksheet is read as current by every reader who does not check the footnote.

**Deliberate omission.** No year-2 or three-year column. The chapter models year 1 and says
explicitly that knowledge-retention returns are slow; a multi-year column here would let the room
solve a thin year-1 ratio by extending the horizon instead of examining the assumption.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- None. This sheet can be filled cold.

**Consumed by:**

- `WS-03-roi-break-even-model` - Agentic ROI & Break-Even Model (Pack C - The case and the money, fill order 6)

**Feeds into (prose, from the source scan).** WS-03-roi-break-even-model

## 8. Facilitation

| | |
|---|---|
| Who fills it | The engineering leader who owns the delivery plan, **with a finance business partner and someone from procurement, both physically present.** This is the one sheet in Pack C the room cannot complete on its own: the licence sub-table needs a real dated quote that only procurement can produce, and rows 2 to 6 need a fully loaded internal cost rate that only finance can authorise. A TCO built from remembered rates and last year's quote is exactly the incomplete business case the chapter opens by describing. |
| When in the session | Fill order 3 — after `WS-03-scenario-assumption-commitment`, which sets the assumptions this cost build-up will be tested against, and before `WS-03-roi-break-even-model`, which declares it a prerequisite and reads its year-1 total verbatim. It has no prerequisites of its own. In practice, run the build-up as a **pre-session desk exercise with finance and procurement**, bring it into the room already populated, and spend the session validating and challenging it rather than sourcing it. |
| Duration | 60–90 minutes in the room if the dated quote and the loaded rate are already in hand; a half-day if they are not. Row 1 is fast because it has an invoice behind it. Rows 2, 4 and 6 — context engineering, training, adoption-curve opportunity cost — take most of the time, because they are engineering time rather than invoices and the room must first agree a loaded day rate it is willing to be held to. |
| Data needed in advance | A current vendor quote **with a date on it**, per tool and per tier. The fully loaded annual cost of an engineer as finance defines it, not as engineering estimates it. Actual engineer headcount by seniority. The organisation's compliance and audit obligations, since row 5 is priced from them. Any prior or shadow spend on AI tooling already running through expenses. If the codebase has significant undocumented conventions, say so before the session — the chapter is explicit that row 2 should then be budgeted toward the higher end. |
| Room format | A live spreadsheet on the projector, not paper. The year-1 total and the licence share are computed, and the room will want to re-run them two or three times as the day rate is argued. Print and sign the final page at the end. The licence sub-table is printed blank and filled from the quote in front of everyone, so nobody later asks where the number came from. |

**Facilitation note.** The chapter's own sentence belongs on the sheet and should be read aloud
before the room starts: *"If your business case shows only the first row, it is incomplete."*
(ch03 L96). Row 1 is the only line with an invoice behind it; the other five are engineering time,
and a room under time pressure will price row 1 properly and wave at the rest. If that happens the
sheet has faithfully reproduced the vendor's version of the business case. Watch the quote date in
particular — the book's own pricing footnote says these change frequently and must be verified
before budgeting, and a sheet carrying an undated quote is not auditable three months later when
the CFO asks what the number was based on. Finally, the ranges in column 3 are dagger-marked author
estimates for a team of ten; they exist on the sheet to show the *ratio between the six rows*, not
to be scaled. If the room reaches for them as defaults, ask for the day rate instead.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All six components carry a figure in column 4 and a one-sentence assumption in column 5.** A
   blank or "TBD" on any of rows 2 to 6 fails the sheet — those five rows are the entire reason the
   instrument exists, and a completed row 1 beside five blanks is a vendor quote, not a TCO.
2. **No figure in column 4 is the book's range copied across.** Any line whose basis reads "scaled
   from the book's range" carries a named owner and a date by which a real quote or a
   finance-authorised internal rate replaces it.
3. **The licence sub-table records a quote date**, and that quote is within the organisation's own
   procurement validity window. An out-of-window quote makes the sheet stale, and it must be
   re-priced before it feeds `WS-03-roi-break-even-model`.
4. **The team size in the footer is the organisation's actual engineer count, and every column-4
   figure is built up to that number** — not multiplied out from the book's team of ten. Licence
   cost scales close to linearly; context engineering and governance setup do not.
5. **Every component line has a named individual owner** who can defend the figure in a CFO review
   without going away to check.
6. **The computed licence share is recorded**, with the book's 20–25% observation beside it as a
   prior. A divergence is not an error, but the room writes one sentence saying why — typically a
   high internal day rate, an unusually clean codebase, or a compliance burden above the norm.
7. **Finance has signed.** The year-1 total on this signed sheet is the only cost figure
   `WS-03-roi-break-even-model` may use. If the two disagree, the ROI model is rebuilt from this
   sheet rather than reconciled by hand, because a hand-reconciled total loses its audit trail.

## 10. Integrity constraint

**Named rule for this sheet.** The vendor price table is dated and must be a fill-in with a quote date, never a printed constant. All TCO figures are dagger-marked author estimates.

**Hedged figures reachable from this source range.** Each is listed with the book's own hedge, verbatim, and where that hedge lives. Present the figure as a pre-filled prior the organisation overwrites, or as a facilitation prompt - never as a benchmark, target or acceptance threshold. **Carry the hedge onto the sheet with the number; do not restate it in your own words.**

- **Year-one TCO component ranges and the $95,000-249,000 total, for a team of 10.**
  - *Appears at* `handbook\ch03-the-business-case.qmd` L80-97
  - *The book's hedge (ch03 L94):* † Author estimates based on advisory work with early-adopter teams. Tool license costs reflect published pricing; all other ranges are projections that will vary by organisation.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Six named cost subsections plus a summary TCO table already ranged for a team of ten; the work is adding 'our figure' and 'our assumption' columns.
- **Fill (the organisation completing it): `L`.** L - needs the real repository, finance input or cross-team agreement

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Strongest cost source in the book: six named cost subsections (lines 40-77) and a summary TCO table already ranged for a team of 10 (lines 82-90, all dagger-marked as author estimates). ABSORB ch02's pricing section here (handbook\ch02-the-ai-native-landscape.qmd lines 142-146: per-seat vs usage-based vs platform-bundled, enterprise tiers at 2-4x individual) as the licence-model selector - do NOT ship it as a separate worksheet. The vendor price table at lines 44-48 is dated March 2025 and must be a fill-in, never a printed constant. Context engineering is called the largest hidden cost (2-4 weeks engineering time for a team of 10-15) and needs its own sub-calculator. Effort L because it requires finance and procurement input, not just the room.
