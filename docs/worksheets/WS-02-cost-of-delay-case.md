# Cost of Delay Case

`WS-02-cost-of-delay-case` &middot; **Pack C - The case and the money** &middot; fill order **10** &middot; type `assessment` &middot; audience **exec** &middot; leadership priority **1**

> **Split back out in the re-opening pass.** The board answer to 'what if we wait a year', which consumes the ROI model's output and runs it backwards; a downstream deliverable with its own risk panel, not an input block.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A single board-facing answer to "what if we wait a year?" carrying both a risk register and a number the CFO can interrogate.

**Cluster.** `CL-COST-OF-DELAY` - The Cost of Delay: What If We Wait a Year

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch02-the-ai-native-landscape.qmd` |
| Chapter | The AI-Native Landscape |
| Heading | Inaction Is a Decision |
| Stable anchor | `#sec-landscape-inaction` |
| Lines | L201-209 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch02-the-ai-native-landscape.html#sec-landscape-inaction> |
| Locator quote | "The most dangerous position in the current market is "wait and see."" |

Resolve at any time with `python docs/resolve.py ws WS-02-cost-of-delay-case`.

## 3. Source extract - the scaffolding, verbatim

```text
  201 | The most dangerous position in the current market is "wait and see." It feels like prudence. It is actually a decision — to let your developers self-select tools, to defer governance until a breach forces the conversation, and to fall behind organizations that are building the structured context that makes AI tools reliable. Here is what "wait and see" costs:
  202 | 
  203 | **Talent risk.** Developers increasingly expect AI tooling as a workplace standard. A 2023 GitHub-commissioned survey (Wakefield Research, n=500, U.S. enterprise developers at companies with 1,000+ employees) found that 92% report using AI coding tools at work or personally.[^ch2-github-survey] Offering no supported AI tools — or restricting them to basic autocomplete — makes your organization less attractive to the engineers you're competing to hire and retain.
  204 | 
  205 | **Shadow IT risk.** Every month without a sanctioned tool is a month where developers find their own solutions. Each unsanctioned tool introduces data residency questions, IP exposure, and compliance gaps that compound over time. The remediation cost of unwinding six months of shadow AI usage is nontrivial.
  206 | 
  207 | **Context accumulation risk.** This is the least obvious and most consequential cost. The organizations investing now in structured context — documented conventions, machine-readable architecture decisions, curated instruction sets — are building a compounding asset. Their AI tools get more reliable over time. Yours, when you eventually adopt, will start from zero. The gap between "adopted in 2025" and "adopted in 2027" is not two years of tool usage — it is two years of context that the early adopter's agents can use and yours cannot. Chapter 4 covers this in detail.
  208 | 
  209 | **Competitive risk.** If your competitors ship features faster because their developers can delegate routine implementation to agents while yours cannot, the productivity gap is not theoretical. It shows up in release cadence, in time-to-market, and in the quality of the problems your engineers spend their attention on.
```

## 4. What the user fills

A qualitative panel scoring the four delay risks (talent, shadow IT, context accumulation, competitive position) for this organisation with evidence and an accountable owner per risk; plus a quantitative panel running this organisation's own ROI model backwards to state the throughput forgone over a 12-month delay.

## 5. Field-level schema

Two panels on one page, side by side, and the board sees both or neither. **Panel A** is one row
per named delay risk — qualitative, evidenced, owned. **Panel B** is a single block running the
organisation's own ROI model backwards. One page, portrait, signed.

**Panel A — the four delay risks.** One row per risk.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Delay risk | `select` (fixed 4 rows) | Talent / Shadow IT / Context accumulation / Competitive | — | ch02 L203-209 |
| 2 | What "wait and see" costs here | `free text` (read-only) | Developers increasingly expect AI tooling as a workplace standard / Every month without a sanctioned tool is a month developers find their own, compounding data-residency, IP and compliance gaps / Early adopters are building a compounding context asset; yours starts from zero / If competitors ship faster because their developers can delegate and yours cannot, the gap shows up in release cadence and time-to-market | — | ch02 L203-209 |
| 3 | The book's supporting evidence | `free text` (read-only) | Talent row only: a 2023 GitHub-commissioned survey (Wakefield Research, n=500, US enterprise developers at companies with 1,000+ employees) found 92% report using AI coding tools at work or personally — an externally cited survey with a stated sample, not an author estimate. The other three rows carry no figure and none is supplied | — | ch02 L203 |
| 4 | **Does this apply to us?** | `select` yes, evidenced / yes, suspected / no, evidenced / unknown | — | Tick one | org |
| 5 | Our evidence | `free text` | — | The attrition figure, the shadow-tool discovery, the competitor release observation — something with a date on it | org |
| 6 | Severity for us | `H/M/L` | — | Argued in the room, never computed from a formula | derived |
| 7 | Trend over the last two quarters | `select` worsening / flat / improving / unmeasured | — | Tick one | org |
| 8 | Accountable owner | `owner (named person)` | — | One named individual per risk | org |
| 9 | What we would do in the next 90 days if we delay | `free text` | — | The mitigation we would owe if the answer is "wait". Carried in from column 7 of `WS-01-model-upgrade-assumption-audit` | org |
| 10 | Reversibility | `select` reversible / recoverable at cost / irreversible | — | The context-accumulation row is the one leaders discount and the one the chapter argues is load-bearing | ch02 L207 |

**Panel B — the reverse run.** A single block, not a per-risk table.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| — | Scenario used | `free text` (carried) | The book runs the moderate scenario in reverse | The scenario committed on `WS-03-scenario-assumption-commitment`, carried verbatim | ch03 L315 |
| — | Delay period modelled | `select` 6 months / 12 months / other | The book models 12 months | Our own period | ch03 L315 |
| — | Annual value not realised, our figure | `computed` | The book's illustrative reverse run for a 50-person team delaying 12 months yields a figure in the range of $1.5–2.5M in throughput improvement not realised — stated in the text as illustrative, not predictive | Our own annual value from the signed `WS-03-roi-break-even-model`, run over our own delay period | ch03 L315 |
| — | Estimation-error caveat | `checkbox` + printed text | The caveat printed verbatim (below) | Tick to confirm it was read aloud, not merely printed | ch03 L315 |
| — | What the number omits | `free text` (read-only) | The chapter states the figure omits the unquantified but real costs of competitive position and hiring friction — which is why Panel A is not optional | — | ch03 L315 |
| — | Board answer, one sentence | `free text` | — | The single sentence the board hears in answer to "what if we wait a year?" | derived |
| — | Sponsor signature + date | `signature` | — | The executive who will deliver that sentence | org |

**Printed verbatim on the sheet**, immediately beneath Panel B's figure and in the same type size:

> "That figure is illustrative, not predictive: it compounds the model's existing estimation error
> by running the assumptions backward, and it omits the unquantified but real costs of competitive
> position and hiring friction. The value of this exercise is not the dollar amount; it is the
> framing." (ch03 L315)

**Absorbed detail.** This sheet absorbed no other candidate, but it is deliberately built across
two chapters because both passages answer the same board question. ch02 L201-209 supplies Panel A's
four risks in full; ch03 L307-315 supplies Panel B's reverse run, its caveat and the omission note.
Neither half ships alone. The context-accumulation row cross-links to
`WS-03-context-moat-asset-inventory`, which is where the asset it names is actually inventoried.

**Deliberate omission.** No composite delay score and no weighted index across the four risks. A
single number would make the risks tradeable against one another, letting a strong competitive
position cancel a live shadow-IT exposure. The chapter presents four independent risks and this
sheet reports four.

**Deliberate omission.** No probability field on Panel A. Asking a room to assign a likelihood to
"developers are already using unsanctioned tools" invites a guess where column 5 demands evidence;
the honest answer to an unmeasured risk is `unknown` in column 4, which is already available.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-03-roi-break-even-model` - Agentic ROI & Break-Even Model (Pack C - The case and the money, fill order 6)

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** WS-03-go-no-go-readiness-gate

## 8. Facilitation

| | |
|---|---|
| Who fills it | The executive sponsor who will take this to the board, the CFO or finance business partner, the CISO or whoever owns shadow-IT exposure, and the talent or HR lead. **Finance must be in the room for Panel B** — it is their model run backwards and they will be asked to defend the number, not to have been shown it. **Security and talent must be in the room for Panel A**, rows 1 and 2: consulting them afterwards produces a severity rating that nobody present actually owns. |
| When in the session | Fill order 10, late in the pack. `WS-03-roi-break-even-model` must be complete **and signed** — Panel B is that model run backwards and cannot be filled from an unsigned draft without inheriting a number the CFO has not yet stood behind. Running it after the money is agreed means the delay case inherits a figure the room has already argued over, rather than generating a second, competing one. |
| Duration | 60 minutes. Panel A takes about thirty-five of them, and the context-accumulation row takes the longest — it is the one the room will want to rate low and the one the book argues hardest is load-bearing. Panel B is arithmetic once the ROI model is in hand, plus ten minutes on the caveat, which is time well spent. |
| Data needed in advance | The signed `WS-03-roi-break-even-model`. Developer attrition and offer-decline data for the last two quarters. Any shadow-AI discovery evidence — expense-report entries, network logs, or an honest anonymous survey. Competitor release-cadence observations, however informal, with dates. The completed `WS-01-model-upgrade-assumption-audit`, whose "what we will do instead" column is the direct input to column 9. |
| Room format | One page, two panels, projected and filled live, then printed and signed. This is the board-facing artifact of Pack C, so it must be legible as a single page. If Panel B needs supporting arithmetic, the appendix is `WS-03-roi-break-even-model` attached behind it — not a third panel. |

**Facilitation note.** The caveat is not optional decoration and must be printed on the sheet at
the same type size as the figure: the reverse-run number is illustrative rather than predictive,
because it compounds the model's estimation error by running the assumptions backward, and it omits
competitive position and hiring friction entirely. Those two omissions are exactly what Panel A
exists to carry, which is why neither panel ships alone. The context-accumulation risk is the one
leaders discount and the one the Context Moat argues is load-bearing — cross-link it to
`WS-03-context-moat-asset-inventory` and do not let it be scored from instinct in thirty seconds.
Open with the chapter's framing sentence: "wait and see" feels like prudence and is actually a
decision. Close by reading the book's own instruction on what this exercise is for — the answer to
"what if we wait a year?" is *this methodology applied to your own numbers, not someone else's
estimate.*

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All four delay risks carry a tick in column 4 and a severity in column 6.** `unknown` is a
   permitted and honest answer in column 4 — a blank is not, because a blank cannot be
   distinguished from an omission.
2. **Every risk rated "yes" carries a locatable piece of the organisation's own evidence in column
   5**, with a date. A severity rating with nothing beside it is an opinion and is struck; the
   92% survey figure in column 3 is the book's evidence for its argument, not ours for our risk.
3. **Each risk names one accountable owner and a stated 90-day mitigation** that would be owed if
   the organisation chose to wait. A delay case that describes risks nobody would act on is a
   description, not a case.
4. **Panel B uses the scenario committed on `WS-03-scenario-assumption-commitment` and the annual
   value from the signed `WS-03-roi-break-even-model`, both carried verbatim.** Any figure that
   cannot be traced back to those two sheets is rejected outright.
5. **The estimation-error caveat is printed verbatim at the same type size as the figure, and the
   tick confirms it was read aloud.** The number is labelled illustrative everywhere it appears,
   and the book's $1.5–2.5M reverse run appears only as the reference prior — never as this
   organisation's number.
6. **Both panels are complete.** A board-facing delay case with a number and no risk panel, or a
   risk panel and no number, is half a case and does not leave the room. The two panels exist
   precisely because each covers what the other omits.
7. **The one-sentence board answer is written, fits on one line, and does not lead with the dollar
   figure.** The chapter is explicit that the value of this exercise is the framing rather than the
   amount, and a sentence that opens with a currency symbol has already lost the argument it was
   built to win.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** Four named delay risks in prose plus a reverse-run invitation; both the scoring panel and the quantitative panel need designing.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> MERGED ACROSS TWO CHAPTERS - deliberately one sheet, because both passages answer the same board question. Qualitative half: ch02 lines 201-209, four named risks in prose, needs authoring. Quantitative half: ch03 "The Cost of Doing Nothing" (handbook\ch03-the-business-case.qmd lines 307-317), which explicitly invites the reader to run the model in reverse - "The answer is this methodology applied to your own numbers, not someone else's estimate" - and gives an illustrative $1.5-2.5M forgone throughput for a 50-person team delaying 12 months. Caveat that MUST be printed on the sheet: the book flags that reverse-run figure as illustrative, not predictive, because it compounds the model's estimation error by running assumptions backward. The context-accumulation risk is the one leaders discount and the one ch03 "The Context Moat" argues is load-bearing - cross-link to WS-03-context-moat-asset-inventory.
