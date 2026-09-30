# Scenario & Assumption Commitment

`WS-03-scenario-assumption-commitment` &middot; **Pack C - The case and the money** &middot; fill order **2** &middot; type `decision` &middot; audience **exec** &middot; leadership priority **1**

> **Split back out in the re-opening pass.** A signed, dated assumption set with a named optimism-owner and the gamble gate ('if it only works at aggressive, you have a gamble'); a signature artefact, and a declared prerequisite of the canonical.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A signed, dated set of modelling assumptions that every downstream number inherits - and an explicit record of who chose the optimism level.

**Cluster.** `CL-SCENARIO-COMMITMENT` - Scenario and Assumption Commitment (Signed)

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch03-the-business-case.qmd` |
| Chapter | The Business Case |
| Heading | Step 3: Model your value — three scenarios |
| Stable anchor | `#sec-business-case-value-scenarios` |
| Lines | L200-285 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch03-the-business-case.html#sec-business-case-value-scenarios> |
| Locator quote | "The conservative scenario represents where most organizations land if they adopt tools" |

Resolve at any time with `python docs/resolve.py ws WS-03-scenario-assumption-commitment`.

## 3. Source extract - the scaffolding, verbatim

```text
  200 | The conservative scenario represents where most organizations land if they adopt tools without investing in context engineering. The moderate scenario requires the sustained effort this book teaches. The aggressive scenario requires everything in the moderate scenario plus organizational commitment to structured context as a strategic asset.
  201 | 
  202 | Most organizations should plan for the conservative scenario and invest toward the moderate one. If your business case only works at the aggressive scenario, you don't have a business case — you have a gamble.
  203 | 
  204 | ### Step 4: Calculate the break-even
  205 | 
  206 | ```
  207 | Annual developer cost (fully loaded)         = $___________
  208 | × Team size                                  = $___________
  209 | = Total annual developer investment (A)
  210 | 
  211 | Cycle time improvement (%)                   = ___%
  212 |   (Use the blended scenario values from the table above.
  213 |    See clarification below the formula.)
  214 | Cycle time improvement (%) × A               = Annual value of time savings (B)
  215 | 
  216 | Defect reduction value:
  217 |   Current defect remediation cost per year    = $___________
  218 |   × Expected reduction (%)                   = Annual defect savings (C)
  219 | 
  220 | Knowledge retention value:
  221 |   Current onboarding cost per new hire        = $___________
  222 |   × Expected reduction in onboarding time (%) = Annual retention savings (D)
  223 | 
  224 | Total annual value (B + C + D)               = $___________
  225 | Total year-1 cost (from TCO table)           = $___________
  226 | 
  227 | Break-even: Year-1 cost ÷ Monthly value run-rate (at steady state, months 6+)
  228 | ```
  229 | 
  230 | Two cautions, and a clarification on the multiplier.
  231 | 
  232 | **On the cycle time multiplier.** The value drivers section above reports 30–50% cycle time reduction on *individual agent-suitable tasks* — measured across the full PR lifecycle (issue opened to code merged), not just the coding phase. The scenario table's lower percentages (10–50%) are the *team-wide blended average*: they already account for the fact that not all tasks are agent-suitable and that adoption depth varies by scenario. Use the scenario values directly. Applying a separate coding-phase multiplier on top would double-count the discount.
  233 | 
  234 | Two cautions. First, the "time savings" line is not headcount reduction. Developers whose routine implementation time decreases do not become surplus — they shift attention to higher-value work: architecture, code review, complex problem-solving. The value manifests as increased throughput and quality, not reduced payroll. If your business case depends on reducing headcount, you will either be disappointed or you will lose the engineers whose judgment makes the tools effective.
  235 | 
  236 | Second, knowledge retention savings are real but slow. Don't lean on them for a first-year business case. They are the compounding return that justifies sustained investment — the reason year 2 looks dramatically better than year 1.
  237 | 
  238 | ### Worked example: a 50-person team
  239 | 
  240 | The formula above is a template. Here is what it looks like with numbers.
  241 | 
  242 | **Assumptions** (moderate scenario):
  243 | - 50 engineers, fully loaded cost $200,000/year each (US market, senior engineers)
  244 | - Cycle time improvement: 25% (midpoint of moderate range)
  245 | - Current defect remediation: $500,000/year (rework, incident response, post-deploy fixes)
  246 | - Expected defect reduction: 20%
  247 | - Current onboarding cost: $15,000 per new hire; 10 hires/year; 30% reduction expected
  248 | 
  249 | ::: {tbl-colwidths="[40,35,25]"}
  250 | 
  251 | | Line item | Calculation | Value |
  252 | |---|---|---|
  253 | | Total annual developer investment (A) | 50 × $200,000 | $10,000,000 |
  254 | | Cycle time value (B) | 25% × $10,000,000 | $2,500,000 |
  255 | | Defect reduction (C) | $500,000 × 20% | $100,000 |
  256 | | Knowledge retention (D) | $15,000 × 10 hires × 30% | $45,000 |
  257 | | **Total annual value (B+C+D)** | — | **$2,645,000** |
  258 | | Year-1 cost (scaled from TCO) | ~$77K–$229K × 5 | $350,000–$1,150,000 |
  259 | | **Value-to-cost ratio** | — | **2.3–7.6×** |
  260 | 
  261 | :::
  262 | 
  263 | But value does not accrue evenly — months 1–4 are ramp-up (see The Adoption Timeline above). Accounting for the ramp, expect break-even at month 6–10 from project start, depending on cost position and adoption speed.
  264 | 
  265 | The time-savings value (B) dominates. This is typical — cycle time improvement is the largest and most defensible value driver. Note that the $2.5M does not mean the organization saves $2.5M in cash. It means the team delivers the equivalent of $2.5M more throughput at the same headcount. The value manifests as faster delivery, not smaller payroll.
  266 | 
  267 | At the conservative scenario (12% cycle time improvement, same cost assumptions), the break-even pushes to month 10–14. At the aggressive scenario (40%), it pulls in to month 4–6. If your numbers only work at the aggressive end, reread the earlier warning: you have a gamble, not a business case.
  268 | 
  269 | ### Sensitivity to rework rate
  270 | 
  271 | The 30–60% rework range (Chapter 1) directly affects the cycle time value. Higher rework rates consume the time agents save — a developer who spends 20 minutes correcting a function the agent produced in 30 seconds has a negative net gain on that task. The table below shows how the worked example's value changes when the rework rate varies, holding all other assumptions constant. The rework rate determines what fraction of agent-generated code requires non-trivial correction; a lower rate means more tasks deliver clean first-draft output that survives review.
  272 | 
  273 | ::: {tbl-colwidths="[20,30,25,25]"}
  274 | 
  275 | | Rework Rate | Effective Cycle Time Improvement † | Annual Team Value (50 devs) † | Value-to-Cost Ratio † |
  276 | |---|---|---|---|
  277 | | 20% (optimistic) | 35% | $3,600,000 | 3.1–10.3× |
  278 | | 40% (moderate) | 25% | $2,645,000 | 2.3–7.6× |
  279 | | 60% (conservative) | 15% | $1,600,000 | 1.4–4.6× |
  280 | 
  281 | :::
  282 | 
  283 | † Author estimates. The effective cycle time improvement is modeled as a function of the base scenario (25% at 40% rework); lower rework allows more tasks to deliver full time savings, higher rework erodes them. All three scenarios remain ROI-positive, but at 60% rework the margin is thin and the break-even extends past month 12.
  284 | 
  285 | The point is not the specific numbers — it is the shape. The business case holds across a wide range of rework assumptions. Even at the conservative end, the investment breaks even within a year. But the difference between 20% and 60% rework is a 2× spread in annual value. This is why context engineering — which directly reduces rework — is the highest-impact investment in the entire adoption plan.
```

## 4. What the user fills

The organisation picks one of the three scenarios (conservative / moderate / aggressive), writes the evidence justifying that pick across all six rows, commits to a rework-rate assumption (20 / 40 / 60%), and signs the gate: if the case only works at aggressive, it is recorded as a gamble, not a business case.

## 5. Field-level schema

One row per assumption line of the scenario table, followed by a sheet-level commitment block.
The book's three scenario columns are printed **read-only, daggers intact**, immediately to the
left of a blank "our number" column — the organisation writes its own value beside the prior and
never into it. One page, portrait, physically signed in the room.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Assumption line | `select` (fixed 6 rows) | Cycle time improvement / Defect reduction / Context engineering maturity / Adoption depth / Time to positive ROI / Assumption | — | ch03 L189-194 |
| 2 | Book's conservative † | `free text` (read-only) | 10–15% † / 5–10% † / Basic conventions documented / Code phase only / 9–12 months † / Minimal context investment, cautious delegation | Not editable | ch03 L189-194 |
| 3 | Book's moderate † | `free text` (read-only) | 20–30% † / 15–25% † / Full instruction hierarchy / Code + Test + Review / 6–9 months † / Sustained context engineering, skilled practitioners | Not editable | ch03 L189-194 |
| 4 | Book's aggressive † | `free text` (read-only) | 35–50% † / 25–35% † / Comprehensive context architecture / Multi-phase SDLC coverage / 4–6 months † / Significant upfront investment, mature practices | Not editable | ch03 L189-194 |
| 5 | **Our number / our state** | `free text` | — | The organisation's own committed value for this line | org |
| 6 | Evidence for our number | `free text` | — | The measurement, the baseline, or the named precedent it rests on | org |
| 7 | Basis | `select` measured / estimated / borrowed from the book | — | Tick one | derived |
| 8 | If borrowed — replace by | `date` + `owner (named person)` | — | When a measured number replaces it, and who owes it | derived |
| 9 | Scenario this line implies | `computed` | — | Which of columns 2–4 our number sits nearest | derived |
| — | **Scenario committed to** | `select` conservative / moderate / aggressive | — | Exactly one tick, for the whole sheet | ch03 L200-202 |
| — | Rework rate committed to | `select` 20% † / 40% † / 60% † / our measured rate | The book's three modelled poles, carried with their daggers | Our own measured rework rate if we have one | ch03 L275-279 |
| — | Effective cycle-time improvement at that rework rate † | `free text` (read-only) | 35% † / 25% † / 15% † | — | ch03 L277-279 |
| — | Value-to-cost ratio at that rework rate † | `free text` (read-only) | 3.1–10.3× † / 2.3–7.6× † / 1.4–4.6× † | Our own ratio, computed later on `WS-03-roi-break-even-model` and written back here | ch03 L277-279 |
| — | Optimism owner | `owner (named person)` + `signature` | — | The single named individual who chose the scenario. Not a committee | ch03 L202 intent |
| — | Gamble declaration | `checkbox` + `signature` | Gate sentence printed verbatim | Tick only if the case does **not** depend on the aggressive column; otherwise write "gamble" and sign beside it | ch03 L202 |
| — | Double-counting attestation | `checkbox` | Warning printed verbatim | Tick to confirm no separate coding-phase multiplier has been applied on top of the scenario value | ch03 L230-232 |
| — | Date + countersignature | `signature` | — | The executive sponsor | org |

**Printed verbatim on the sheet.** Both gate sentences appear in full, in the chapter's own words,
boxed and unabbreviated:

> "Most organizations should plan for the conservative scenario and invest toward the moderate one.
> If your business case only works at the aggressive scenario, you don't have a business case — you
> have a gamble." (ch03 L202)

> "The scenario table's lower percentages (10–50%) are the *team-wide blended average*: they
> already account for the fact that not all tasks are agent-suitable and that adoption depth varies
> by scenario. Use the scenario values directly. Applying a separate coding-phase multiplier on top
> would double-count the discount." (ch03 L232)

**Deliberate omission.** The 60% review-rejection prior and the ~12% escalation prior are **not**
printed on this sheet. Both are author-observed starting hypotheses belonging to the operating
chapters, and importing them into a sheet whose purpose is committing to assumptions would hand the
room two more inherited numbers at exactly the moment it is meant to be producing its own.

**Deliberate omission.** No probability, weighting or expected-value column across the three
scenarios. The chapter's instrument is a *commitment to one scenario*, and a probability-weighted
blend lets a room avoid choosing — which is the failure the gamble gate exists to catch.

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
| Who fills it | The executive sponsor who will sign as optimism owner, the CTO or VP Engineering, and a finance business partner. **Finance must be in the room, not sent the result.** Every number in Pack C inherits the scenario ticked here, and it is far cheaper to have finance watch the choice being made than to have them reject the ROI model in Pack G because they never saw the optimism enter the model. Procurement is not needed — no purchase decision is taken on this sheet. The named optimism owner must be physically present: a signature cannot be delegated. |
| When in the session | Fill order 2, immediately after `WS-01-model-upgrade-assumption-audit`. It has no prerequisites and can be filled cold, but it must precede `WS-03-tco-calculator` and `WS-03-roi-break-even-model`, both of which inherit the scenario. Filling it late, after the cost build-up, produces a scenario reverse-engineered to make the ratio work — which is the gamble the gate is designed to catch, arriving through the back door. |
| Duration | 45–60 minutes. The six assumption lines take about twenty; the rest goes on the rework selection and on the gamble gate. Expect the room to slow down sharply at the signature block, which is the instrument working as intended. |
| Data needed in advance | The four baseline metrics the chapter's Step 1 names — median PR cycle time, review rejection rate, post-deploy defect rate, developer time allocation — at whatever fidelity exists, even one quarter's rough figures. Plus an honest read of the current context-engineering state (are conventions documented? is there an instruction hierarchy?), any existing adoption plan with a stated timeline, and a measured rework rate if the organisation has one. |
| Room format | One page projected and filled live, then **printed and physically signed before the room breaks**. Do not circulate for e-signature afterwards: the signature is the artifact, and a signature given alone at a desk is a different act from one given in front of the people who will inherit the number. |

**Facilitation note.** Read both gate sentences aloud; do not rely on them being printed. The
double-counting warning is the more often violated of the two — rooms that know the book's 30–50%
per-task figure will instinctively apply it on top of the blended scenario percentage, and the
resulting case is wrong by a multiple rather than a margin. On the gamble gate, the facilitator's
job is **not** to argue a room down from the aggressive column. It is to make them write the word
"gamble" on the sheet and sign beside it. A signed, knowing gamble is a legitimate output of this
instrument; an unsigned, unexamined one is what the chapter is warning about. Every line whose
basis reads "borrowed from the book" needs a name and a date in column 8 before the room moves on,
or the daggered priors quietly become the organisation's own figures by the time Pack G opens.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All six assumption lines carry a value in column 5 and a basis tick in column 7.** No line
   inherits a book figure silently; a line left blank means the scenario was ticked without the
   assumptions that constitute it.
2. **Every line whose basis reads "borrowed from the book" carries a named owner and a replacement
   date in column 8.** Borrowing is permitted; borrowing indefinitely is not, and a daggered
   projection with no expiry becomes the organisation's own number by attrition.
3. **Exactly one scenario is ticked, and it is consistent with the six per-line values.** A
   moderate tick sitting above six values that all fall in the aggressive column is an unresolved
   sheet, not a conservative one — reconcile the lines or change the tick.
4. **Both gate sentences appear on the printed sheet verbatim**, and the gamble declaration is
   resolved: either ticked, or the word "gamble" is written on the sheet with the sponsor's
   signature beside it. An unresolved gate means the sheet does not leave the room.
5. **The double-counting attestation is ticked, and the person who ticked it can state unprompted
   that the scenario percentages are already blended.** If they cannot, the attestation is
   untested and the model downstream will be wrong by a multiple.
6. **One named individual is recorded as optimism owner and has signed.** Not a function, not a
   committee, not "the steering group". The whole point of the instrument is that somebody chose.
7. **The scenario and rework selections here are the only scenario inputs used by
   `WS-03-roi-break-even-model`.** A different cycle-time percentage appearing on that sheet means
   one of the two is stale; the model is rebuilt from this sheet, not reconciled by hand.

## 10. Integrity constraint

**Named rule for this sheet.** Print both gate sentences verbatim: 'If your business case only works at the aggressive scenario, you don't have a business case - you have a gamble', and the double-counting warning.

**Hedged figures reachable from this source range.** Each is listed with the book's own hedge, verbatim, and where that hedge lives. Present the figure as a pre-filled prior the organisation overwrites, or as a facilitation prompt - never as a benchmark, target or acceptance threshold. **Carry the hedge onto the sheet with the number; do not restate it in your own words.**

- **The 20/40/60% rework sensitivity table and its value-to-cost ratios.**
  - *Appears at* `handbook\ch03-the-business-case.qmd` L269-286
  - *The book's hedge (ch03 L283):* † Author estimates. The effective cycle time improvement is modeled as a function of the base scenario (25% at 40% rework).

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Two structured tables (scenario, rework sensitivity); authoring is a selection column and a signature block.
- **Fill (the organisation completing it): `S`.** S - one sitting, data already in the room

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> MERGED: two tables want one decision sheet. Scenario table at lines 185-194 (cycle time, defect reduction, context maturity, adoption depth, time to positive ROI, assumption). Rework sensitivity table at lines 273-279 (20/40/60% rework mapped to 35/25/15% effective cycle time and 3.1-10.3x / 2.3-7.6x / 1.4-4.6x value-to-cost). Both are already structured - authoring is mostly adding a selection column and a signature block. PRINT THE TWO GATE SENTENCES ON THE SHEET: "If your business case only works at the aggressive scenario, you don't have a business case - you have a gamble" (line 202), and the double-counting warning at lines 230-232 (do not apply a separate coding-phase multiplier on top of the scenario percentages - they are already blended). All figures dagger-marked as author projections, so the sheet must force the organisation to overwrite them, not adopt them.
