# Agentic ROI & Break-Even Model

`WS-03-roi-break-even-model` &middot; **Pack C - The case and the money** &middot; fill order **6** &middot; type `calculator` &middot; audience **exec** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A CFO-legible ROI model with stated assumptions and a break-even month, plus a value-to-cost ratio the board can stress-test.

**Cluster.** `CL-COST-MODEL` - Investment, Break-Even and the Cost of Waiting

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch03-the-business-case.qmd` |
| Chapter | The Business Case |
| Heading | Building Your Business Case |
| Stable anchor | `#sec-business-case-building` |
| Lines | L168-267 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch03-the-business-case.html#sec-business-case-building> |
| Locator quote | "The ROI calculation template below is designed for a CFO audience." |

Resolve at any time with `python docs/resolve.py ws WS-03-roi-break-even-model`.

## 3. Source extract - the scaffolding, verbatim

```text
  168 | The ROI calculation template below is designed for a CFO audience. It uses ranges, not point estimates. It requires you to state assumptions explicitly. It does not promise a specific outcome — it gives you a structured way to model scenarios for your organization.
  169 | 
  170 | ### Step 1: Establish your baseline
  171 | 
  172 | Before adopting agentic development, measure these four metrics for at least one quarter. Without a baseline, you have no way to evaluate impact.
  173 | 
  174 | - **Median PR cycle time** — from issue assignment to code merged. Use your existing data from GitHub, GitLab, or your project management tool.
  175 | - **Review rejection rate** — percentage of PRs that require changes after initial review.
  176 | - **Post-deploy defect rate** — bugs traced to code changes, per release.
  177 | - **Developer time allocation** — survey your team: what percentage of time is spent on implementation, review, debugging, design, and communication?
  178 | 
  179 | ### Step 2: Model your costs
  180 | 
  181 | Use the TCO table above. Adjust ranges for your team size, compliance requirements, and codebase complexity. Be honest about context engineering — if your codebase has significant undocumented conventions, budget toward the higher end.
  182 | 
  183 | ### Step 3: Model your value — three scenarios {#sec-business-case-value-scenarios}
  184 | 
  185 | ::: {tbl-colwidths="[30,23,23,24]"}
  186 | 
  187 | | | Conservative | Moderate | Aggressive |
  188 | |---|---|---|---|
  189 | | **Cycle time improvement** | 10–15% † | 20–30% † | 35–50% † |
  190 | | **Defect reduction** | 5–10% † | 15–25% † | 25–35% † |
  191 | | **Context engineering maturity** | Basic conventions documented | Full instruction hierarchy | Comprehensive context architecture |
  192 | | **Adoption depth** | Code phase only | Code + Test + Review | Multi-phase SDLC coverage |
  193 | | **Time to positive ROI** | 9–12 months † | 6–9 months † | 4–6 months † |
  194 | | **Assumption** | Minimal context investment, cautious delegation | Sustained context engineering, skilled practitioners | Significant upfront investment, mature practices |
  195 | 
  196 | :::
  197 | 
  198 | † Author projections based on early-adopter patterns and the author's advisory work. Not derived from controlled studies. Your results will depend on codebase complexity, team seniority, and context engineering investment.
  199 | 
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
```

*(10 further lines in range; read the file for the remainder.)*

## 4. What the user fills

The five blanks of the printed formula: fully loaded annual developer cost, team size, cycle time improvement percent, current defect remediation cost and expected reduction, current onboarding cost per hire and expected reduction - producing annual value (B+C+D), year-1 cost, and a break-even month.

## 5. Field-level schema

**Two pages, and both are mandatory.** Page 1 is the chapter's own fill-in-the-blank formula turned
into rows, with the 50-person worked example printed read-only in the column immediately left of
the blank the organisation fills. Page 2 is the sensitivity page — the productivity-gain assumption
expressed as a **range**, never a point. A completed page 1 with a blank page 2 is a point-estimate
business case and is not a completed sheet.

**Page 1 — the model.** One row per line of the printed formula.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Formula line | `select` (fixed) | Annual developer cost (fully loaded) / Team size / Total annual developer investment (A) / Cycle time improvement % / Cycle time value (B) / Current defect remediation cost per year / Expected defect reduction % / Annual defect savings (C) / Current onboarding cost per new hire / Hires per year / Expected reduction in onboarding time % / Annual retention savings (D) / Total annual value (B+C+D) / Total year-1 cost / Break-even month | — | ch03 L206-228 |
| 2 | Symbol | `free text` (read-only) | A / B / C / D where the formula assigns one | — | ch03 L209-224 |
| 3 | Worked example, 50-person team † | `free text` (read-only) | $200,000 / 50 / $10,000,000 / 25% / $2,500,000 / $500,000 / 20% / $100,000 / $15,000 / 10 hires / 30% / $45,000 / $2,645,000 / $350,000–1,150,000 / month 6–10 † | Not editable — the book's reference case, daggers intact | ch03 L242-263 |
| 4 | **Our number** | `currency`, percentage or `computed` per line | — | The organisation's own figure | org |
| 5 | Where our number came from | `free text` | — | The system, report or person. For the cycle-time line: the scenario ticked on `WS-03-scenario-assumption-commitment` | org |
| 6 | Basis | `select` measured / finance-authorised rate / scenario commitment / estimated | — | Tick one | derived |
| 7 | Owner of this line | `owner (named person)` | — | Who defends it under questioning | org |
| — | **Total annual value (B+C+D), our figure** | `computed` | Worked example: $2,645,000 † | Sum of B, C and D from column 4 | ch03 L257 |
| — | **Year-1 cost, our figure** | `currency` (carried, not re-entered) | Worked example: $350,000–1,150,000 †, scaled 5× from a team-of-ten TCO | The year-1 total from `WS-03-tco-calculator`, carried verbatim | ch03 L258 |
| — | **Value-to-cost ratio, our figure** | `computed` | Worked example: 2.3–7.6× † | Derived from the two lines above | ch03 L259 |
| — | **Break-even month, our figure** | `computed` | Worked example: month 6–10 †; conservative pushes to month 10–14 †, aggressive pulls in to month 4–6 † | Derived, with the ramp stated: months 1–4 are ramp-up | ch03 L263, L267 |
| — | Agentic run-cost exposure | `currency` | ch07's illustrative single run showed an 8.5× spread — $41.01 against $4.81 on identical output — described there as an illustrative single run at point-in-time prices, not a benchmark | Our own total annualised exposure, carried verbatim from `WS-07-cost-variance-baseline`, or marked NOT YET MEASURED with a date | ch07 L13; `WS-07-cost-variance-baseline` |
| — | Headcount attestation | `checkbox` | Caution printed verbatim | Tick to confirm the time-savings line is **not** modelled as headcount reduction | ch03 L234 |
| — | Knowledge-retention attestation | `checkbox` | Caution printed verbatim | Tick to confirm (D) is not load-bearing in year 1 | ch03 L236 |
| — | Double-counting attestation | `checkbox` | Caution printed verbatim | Tick to confirm no separate coding-phase multiplier was applied on top of the blended scenario value | ch03 L232 |
| — | CFO signature + date | `signature` | — | The finance signatory who will be asked to defend it | org |

**Page 2 — the mandatory sensitivity page.** One row per sensitivity input. Note the **two**
our-number columns: the productivity-gain assumption is entered as a range spanning both poles, and
the page computes a break-even at each end.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Sensitivity input | `select` (fixed) | Engineer count / Fully loaded cost per engineer / Hours to author the initial primitive set / Ongoing maintenance hours per month / Sustained productivity gain | — | ch27 L207 |
| 2 | Sceptical pole † | `free text` (read-only) | 15–20% sustained gain — the low pole the closing chapter names when asking whether the documentation burden pays for itself | Not editable | ch27 L207 |
| 3 | Optimistic pole † | `free text` (read-only) | 2–3× — the high pole the same passage names as what "some claim" | Not editable | ch27 L207 |
| 4 | **Our low** | `currency` / percentage / hours | — | Our own low end | org |
| 5 | **Our high** | `currency` / percentage / hours | — | Our own high end | org |
| 6 | Months to break even at our low | `computed` | — | — | derived |
| 7 | Months to break even at our high | `computed` | — | — | derived |
| 8 | Minimum sustained gain at which the investment clears zero | `computed` | — | Solved from columns 4 and 5 — the single number a sceptical CFO will ask for | derived |
| — | Rework rate carried in | `free text` (carried) | The book's three modelled poles: 20% → 35% effective, 40% → 25%, 60% → 15%, all daggered | The rate committed on `WS-03-scenario-assumption-commitment`, carried verbatim | ch03 L275-279 |
| — | Range discipline attestation | `checkbox` | — | Tick to confirm the gain assumption is entered as a range and no point estimate is presented anywhere | ch27 L207 |

**Absorbed detail.** `WS-27-instrumentation-breakeven` is absorbed **in full as page 2**, and
nothing of it is dropped. Its engineer count and fully loaded cost are page-2 rows 1 and 2,
columns 4 and 5. Its hours to author the initial primitive set and its ongoing maintenance hours
per month are page-2 rows 3 and 4. Its mandatory range-not-point discipline is the reason page 2
carries **two** our-number columns rather than one, and is enforced by the attestation in the
footer. Its 15–20% and 2–3× poles are printed read-only in page-2 columns 2 and 3, adjacent to the
blank our-number columns and never inside them. Its declared output — months to break even at each
end of the range, plus the minimum sustained gain at which the investment clears zero — is page-2
columns 6, 7 and 8.

**Printed verbatim on the sheet.** ch07's Three-Tier Honesty callout is reproduced in full beside
the agentic run-cost exposure line, because that line is the only place a ch07 figure touches this
model:

> "The figures in this chapter — the 8.5× spread, the \$4.81 versus \$41.01 run, the model-price
> ranges — are **illustrative single runs and point-in-time prices**, not benchmarks. […] The
> durable claim is the mechanism — model choice, token use, and harness govern the bill, and all
> three are in your control. The specific multiples will move. The lever will not." (ch07 L118)

The two cautions are printed in full on page 1, in the chapter's words: that the time-savings line
is not headcount reduction but throughput at the same payroll, and that knowledge-retention savings
are real but slow and must not be leaned on in a first-year case (ch03 L234-236).

**Deliberate omission — an open question the source scan raised, now decided.** The book's worked
example scales year-1 cost from a team-of-ten TCO by 5× (ch03 L258). **This sheet does not scale.**
The year-1 cost line is carried verbatim from `WS-03-tco-calculator`'s own build-up at the
organisation's actual headcount, and linear scaling appears only inside column 3 as part of the
book's reference case, labelled as such. Licence cost scales close to linearly; context
engineering, governance setup and the adoption-curve opportunity cost do not, and multiplying them
out is how a plausible total conceals three wrong components.

**Deliberate omission.** No net-present-value, discount-rate or multi-year column. The chapter
models year 1 and a break-even month; a discounted multi-year view would let a thin year-1 ratio be
solved by extending the horizon rather than by revisiting the assumption — which is what the gamble
gate on `WS-03-scenario-assumption-commitment` exists to prevent.

## 6. Absorbed members (1)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-27-instrumentation-breakeven` - Instrumentation Break-Even Calculator

- **Address.** `handbook\ch27-what-comes-next.qmd` L207-207, What the Author Probably Got Wrong (`#sec-next-author-caveats`)
- **Why folded.** The same output as the canonical (months to break even); contributes the mandatory range-not-point discipline and the 15-20% / 2-3x sensitivity poles as a required sensitivity page.
- **Fill detail to absorb.** Inputs: engineer count and loaded cost, estimated hours to author the initial primitive set, ongoing maintenance hours per month, and a productivity-gain assumption entered as a RANGE spanning the passage's two poles (15-20% at the low end, 2-3x at the high end). Output: months to break even at each end of the range, and the minimum sustained gain at which the investment clears zero.
- **Its output was.** A break-even model with an explicit sensitivity range, so the business case survives contact with a sceptical CFO.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-03-tco-calculator` - Year-One Total Cost of Ownership Calculator (Pack C - The case and the money, fill order 3)
- `WS-03-scenario-assumption-commitment` - Scenario & Assumption Commitment (Pack C - The case and the money, fill order 2)

**Consumed by:**

- `WS-02-cost-of-delay-case` - Cost of Delay Case (Pack C - The case and the money, fill order 10)
- `WS-03-go-no-go-readiness-gate` - Go / No-Go Readiness Gate (Pack G - The plan we leave with, fill order 6)

**Feeds into (prose, from the source scan).** WS-02-cost-of-delay-case

## 8. Facilitation

| | |
|---|---|
| Who fills it | The CFO or the finance business partner who will sign, the engineering leader, and the individual who signed `WS-03-scenario-assumption-commitment` as optimism owner. **Finance must be in the room and must be the one entering column 4.** This is the sheet that gets interrogated, and a CFO who first meets it as a PDF will interrogate it from the outside; a CFO who watched the defect-remediation figure be argued over will defend it. Procurement is not needed — its contribution already landed in `WS-03-tco-calculator`. |
| When in the session | Fill order 6, and **both prerequisites must be complete, signed and physically on the table**: `WS-03-tco-calculator` supplies the year-1 cost line verbatim, and `WS-03-scenario-assumption-commitment` supplies the cycle-time percentage. Do not run this from either being "nearly done". Every figure downstream — the delay case in this pack, the readiness gate in Pack G — inherits what is decided here, and a model built on a draft input propagates the draft silently. |
| Duration | 75–90 minutes. Page 1 is arithmetic and moves quickly once both prerequisites are in hand. Page 2 is the longer half and the one rooms try to skip; do not let them — it is the half that survives contact with a sceptical CFO. The three attestations take roughly ten minutes of genuine argument each time they are run, and they are the most valuable thirty minutes on the sheet. |
| Data needed in advance | The completed and signed `WS-03-tco-calculator` and `WS-03-scenario-assumption-commitment`. The fully loaded annual engineer cost as finance defines it. Current annual defect-remediation spend — rework, incident response, post-deploy fixes — however crudely booked. Current onboarding cost per hire and hires per year. The total annualised exposure from `WS-07-cost-variance-baseline` if that sheet has been filled; if not, the exposure line is marked NOT YET MEASURED with a date rather than estimated on the spot. |
| Room format | A live spreadsheet projected, not paper. The room will re-run page 2 three or four times as the range is argued, and that re-running *is* the exercise — watching the break-even month move as the gain assumption moves is what converts a number into an understood number. Print both pages and sign page 1 before the room breaks. |

**Facilitation note.** Reproduce and read aloud both of the chapter's cautions. First: the
time-savings line is **not** headcount reduction — it is throughput at the same payroll, and a case
that depends on cutting heads will either disappoint or lose the engineers whose judgement makes
the tools effective. Second: knowledge-retention savings are real but slow, and must not be
load-bearing in a first-year case; they are the reason year 2 looks better, not the reason year 1
clears. Watch for the room reaching for the aggressive column when page 1's ratio disappoints. That
is the gamble gate re-opening, and it is re-opened **on the signed
`WS-03-scenario-assumption-commitment` sheet, in front of the person who signed it** — never
quietly, here, by editing column 4. The other thing to watch is page 2 being treated as optional.
The closing chapter's own doubt is that the documentation burden may not pay for itself if gains
land at the low pole rather than the high one; page 2 is where that doubt is answered with the
organisation's own arithmetic instead of with confidence.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **Every formula line on page 1 has a figure in column 4 and a stated source in column 5.** No
   line is left to the worked example in column 3. A blank line means the formula was admired
   rather than completed.
2. **The cycle-time percentage in column 4 is the value committed on
   `WS-03-scenario-assumption-commitment`, unchanged.** A different number here means one of the
   two sheets is stale; the model is rebuilt from the signed commitment, not patched to match.
3. **The year-1 cost line is carried verbatim from `WS-03-tco-calculator`'s own build-up at the
   organisation's actual headcount** — not scaled from the book's team-of-ten range. A figure that
   is a round multiple of $95,000–249,000 is a scaled figure and is rejected.
4. **All three attestations are ticked, and the cautions are printed verbatim on the sheet.** A
   model that books time savings as headcount reduction, or that leans on (D) in year 1, fails
   regardless of how good its ratio looks.
5. **Page 2 is complete, with both our-number columns filled and the minimum sustained gain at
   which the investment clears zero computed and written down.** A point estimate anywhere on the
   sheet, or a blank page 2, fails — the absorbed range discipline is not decorative, it is the
   half of the model that survives a sceptic.
6. **The agentic run-cost exposure line carries the organisation's own annualised figure from
   `WS-07-cost-variance-baseline`, or is explicitly marked NOT YET MEASURED with a date.** The
   book's 8.5× appears only in the reference column, and the Three-Tier Honesty text is reproduced
   beside it. An 8.5× multiple appearing in an our-number cell voids the line.
7. **The CFO has signed page 1.** This signed total is what `WS-02-cost-of-delay-case` runs
   backwards and what `WS-03-go-no-go-readiness-gate` reads in Pack G. An unsigned copy is a
   working draft and must not be carried forward — a draft quoted in a board pack becomes a
   commitment nobody made.

## 10. Integrity constraint

**Named rule for this sheet.** ch03's TCO table and the 8.5x variance enter as worked-example columns adjacent to blank 'our number' columns; ch07's own Three-Tier Honesty callout text is reproduced on the sheet.

**Hedged figures reachable from this source range.** Each is listed with the book's own hedge, verbatim, and where that hedge lives. Present the figure as a pre-filled prior the organisation overwrites, or as a facilitation prompt - never as a benchmark, target or acceptance threshold. **Carry the hedge onto the sheet with the number; do not restate it in your own words.**

- **The conservative / moderate / aggressive scenario table and its time-to-positive-ROI rows.**
  - *Appears at* `handbook\ch03-the-business-case.qmd` L183-199
  - *The book's hedge (ch03 L198):* † Author projections based on early-adopter patterns and the author's advisory work. Not derived from controlled studies.
- **The two productivity poles the passage sets against each other, 15-20% and 2-3x.**
  - *Appears at* `handbook\ch27-what-comes-next.qmd` L203-213
  - *The book's hedge (ch27 L207):* The book states the problem and explicitly declines to resolve it: the break-even is 'less obviously favorable than the book implies' and the author has not seen enough longitudinal data. Any sheet using these must output a RANGE, never a single figure.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Carried unchanged from _section-clusters.md section 7 for CL-COST-MODEL.
- **Fill (the organisation completing it): `L`.** L - needs the real repository, finance input or cross-team agreement

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> HIGHEST-FIDELITY SOURCE IN THE BOOK - the formula at lines 206-236 is literally already a fill-in-the-blank template with dollar blanks, and the 50-person worked example at lines 238-267 supplies a fully calculated reference case. Authoring effort is formatting, not invention. Two cautions the book insists on and the sheet must reproduce verbatim: (1) the time-savings line is NOT headcount reduction - it is throughput at the same payroll, and a case that depends on cutting heads will lose the engineers who make the tools work (lines 234-236); (2) knowledge-retention savings are real but slow, so do not lean on them in year 1. Step 2 (line 179-181) points back to the TCO table, hence the prereq. Note the worked example scales year-1 cost from a team-of-10 TCO by 5x - the synthesizer should decide whether the kit scales linearly or asks for a direct build-up.
