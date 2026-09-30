# The Three Levers Audit — Model, Tokens, Harness

`WS-07-three-variables-audit` &middot; **Pack C - The case and the money** &middot; fill order **9** &middot; type `inventory` &middot; audience **architect** &middot; leadership priority **1**

> **Split back out in the re-opening pass.** A per-workflow audit naming the specific misroutings and token taxes to fix and who decided each lever; it is the evidence that sets tier policy, and that policy's declared prerequisite.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A lever-by-lever audit of current agentic spend that identifies the specific misroutings and token taxes to fix first, with an owner named for each of the three variables.

**Cluster.** `CL-LEVER-AUDIT` - The Three Levers Audit: Model, Tokens, Harness

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch07-the-agentic-sdlc-bill.qmd` |
| Chapter | The Agentic SDLC Bill |
| Heading | Three Variables You Already Control |
| Stable anchor | `#sec-bill-three-variables` |
| Lines | L45-53 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch07-the-agentic-sdlc-bill.html#sec-bill-three-variables> |
| Locator quote | "The bill decomposes into three variables, and you control all three" |

Resolve at any time with `python docs/resolve.py ws WS-07-three-variables-audit`.

## 3. Source extract - the scaffolding, verbatim

```text
   45 | The bill decomposes into three variables, and you control all three:
   46 | 
   47 | - **Model choice** — the cost function. The spread between the cheapest capable model and the most expensive frontier model for the same step is, as of June 2026, large enough to dominate the other two cost inputs. Routing a mechanical edit to a frontier model is the single most common way teams overpay.[^bill-spread]
   48 | - **Token use** — how much context flows through that function on every call. Prompt bloat, redundant re-reads, oversized tool surfaces, and uncached prefixes all tax every invocation. The attention-economy chapter (@sec-attention-economy) shows why more context is not free and often not better; here the point is narrower — every wasted token is metered.
   49 | - **Harness choice** — the system prompts and orchestration that decide how many calls happen, on which model, with which context. This is the lever with the most reach, because it governs the other two: the harness is where you encode *which* model runs each step and *how much* context flows through it. Model choice sets the magnitude; the harness decides when you pay it.
   50 | 
   51 | None of these is a market condition you absorb. Each is a decision you can make once, encode, and reuse. That is the definition of an engineering problem.
   52 | 
   53 | ---
```

## 4. What the user fills

One row per significant agentic workflow already running or planned. Columns: model tier in use today, cheapest sufficient tier for that step, rough tokens per invocation and the obvious bloat sources (redundant re-reads, oversized tool surfaces, uncached prefixes), harness it runs on, and who decided each of the three. A final column flags mechanical work currently misrouted to a frontier model.

## 5. Field-level schema

One row per significant agentic workflow, running or planned. The three lever bands are printed as
visually separated groups, and **the HARNESS band comes first and widest** — the chapter names it
the lever with the most reach because it governs the other two, and a sheet that lists the three
levers as equal columns quietly contradicts its own source. A3 landscape, one page, with a
MEASURED / PROSPECTIVE flag printed across the header.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Workflow | `free text` | — | Name of a significant agentic workflow, running or planned | org |
| 2 | Mode | `select` running today / planned | — | Tick one per row | derived |
| 3 | What the step actually does | `free text` | — | One sentence: mechanical edit, planning, review, triage, classification | org |
| 4 | **HARNESS** — which harness it runs on | `free text` | — | The named runtime | ch07 L49 |
| 5 | **HARNESS** — does it encode which model runs each step? | `select` yes, statically / partly / no, the operator chooses | The chapter: the harness is where you encode *which* model runs each step and *how much* context flows through it | Tick one | ch07 L49 |
| 6 | **HARNESS** — model calls per run | `free text` (count) | — | Count, or "unmeasured" written plainly | ch07 L49 |
| 7 | **HARNESS** — who decided this | `owner (named person)` or `nobody / vendor default` | — | A name, or the explicit honest answer | ch07 L51 |
| 8 | **MODEL** — tier in use today | `select` baseline / frontier / local / vendor default (unknown) | — | A tier, never a SKU | ch07 L47, footnote at L191 |
| 9 | **MODEL** — cheapest sufficient tier for this step | `select` baseline / frontier / local | — | The honest answer, argued in the room | ch07 L47 |
| 10 | **MODEL** — misrouted? | `checkbox` | The chapter names routing a mechanical edit to a frontier model as "the single most common way teams overpay" | Tick where columns 8 and 9 differ and column 3 describes mechanical work | ch07 L47 |
| 11 | **MODEL** — who decided this | `owner (named person)` or `nobody / vendor default` | — | A name, or the explicit honest answer | ch07 L51 |
| 12 | **TOKENS** — rough tokens per invocation | `free text` | — | Order of magnitude is enough; write "unmeasured" if it is | ch07 L48 |
| 13 | **TOKENS** — bloat sources present | `checkbox` set: prompt bloat / redundant re-reads / oversized tool surface / uncached prefix | The four the chapter names | Tick each that applies | ch07 L48 |
| 14 | **TOKENS** — who decided this | `owner (named person)` or `nobody / vendor default` | — | A name, or the explicit honest answer | ch07 L51 |
| 15 | Reach | `H/M/L` | — | How much of the bill this row's harness decision governs | derived |
| 16 | Fix first? | `checkbox` | — | Tick the rows to fix first. The chapter's own weighting puts a harness fix ahead of a model swap, because the harness governs the other two | ch07 L49 |
| — | **Sheet mode** | `select` MEASURED / PROSPECTIVE | — | PROSPECTIVE when every row in column 2 reads "planned"; printed across the header | derived |
| — | Rows misrouted | `computed` | — | Count of column 10 ticks — the fastest money on the sheet | derived |
| — | Harness rows with no named decider | `computed` | — | Count of column 7 entries reading `nobody / vendor default` | derived |
| — | Organisation-wide owner: model choice | `owner (named person)` | — | One name, across all workflows | ch07 L45-51 |
| — | Organisation-wide owner: token use | `owner (named person)` | — | One name, across all workflows | ch07 L45-51 |
| — | Organisation-wide owner: harness choice | `owner (named person)` | — | One name, across all workflows — and the chapter's weighting says this seat should be the most central of the three | ch07 L49 |
| — | Highest-spread task carried in | `free text` | — | The circled row from `WS-07-cost-variance-baseline`, which must appear as a row on this sheet | `WS-07-cost-variance-baseline` |

**Absorbed detail.** This sheet absorbed no other candidate. It does consume one: the circled
highest-spread task from `WS-07-cost-variance-baseline` is a mandatory row here, because that sheet
identifies *where* the money is and this one identifies *which of the three levers* is causing it.
An audit that omits the highest-spread task has audited the workflows the room could remember
rather than the ones that cost.

**Deliberate omission.** No cost-per-run column. Run cost lives on
`WS-07-cost-variance-baseline`, this sheet's prerequisite, and duplicating it here creates two
numbers for one thing that will diverge by the second session. This sheet audits *decisions and
their owners*, not amounts.

**Deliberate omission.** No model names, SKUs or prices. Columns 8 and 9 take a tier. The chapter's
own footnote is explicit that specific model names date quickly and the durable policy is
tier-the-access whatever the SKUs are the week you deploy.

**Deliberate omission.** No pattern-design fields. Model Router, Gradient Workflow, Cache-Aware
Prefix and Tool Subset are named in the practitioner block; leadership funds those patterns and
does not specify them on this sheet.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-07-cost-variance-baseline` - Our Own Cost Spread — Measuring the Variance Before We Budget (Pack C - The case and the money, fill order 4)

**Consumed by:**

- `WS-07-model-tier-access-policy` - Model Tier Access Policy — Who Gets the Frontier, and How (Pack C - The case and the money, fill order 12)

**Feeds into (prose, from the source scan).** WS-07-spend-pool-budget-model and WS-07-model-tier-access-policy (the audit reveals which segments actually need which tier).

## 8. Facilitation

| | |
|---|---|
| Who fills it | The principal engineer or platform architect who owns the runtime, one engineer per workflow row who actually runs it, and whoever holds the token or cost telemetry. **Finance and procurement are not needed in the room** — this is a technical audit with no currency column, and their seats are at `WS-03-tco-calculator` and `WS-07-spend-pool-budget-model`. The architect who will own the harness lever must be present: column 7 records a decision the room usually discovers was nobody's, and that discovery needs a witness who can act on it. |
| When in the session | Fill order 9, after `WS-07-cost-variance-baseline`, which it declares a prerequisite and whose circled highest-spread task must appear here as a row. It must precede `WS-07-model-tier-access-policy`, which is built directly from columns 8 and 9 — the audit is what reveals which segments actually need which tier, and a tier policy written without it is a guess dressed as a decision. |
| Duration | 60–90 minutes for four to six workflow rows. The harness band is fast if one harness is in use and slow if three are. Columns 7, 11 and 14 — *who decided this* — take the longest, because the honest answer is frequently "nobody, it is the vendor default", and the room needs a moment with that before it moves on. |
| Data needed in advance | A list of the agentic workflows running or planned, each with an owner. Which harness each runs on. The model-selection settings as currently configured, exported rather than remembered. Any token or cost telemetry broken down by workflow. The completed `WS-07-cost-variance-baseline`, with its highest-spread row identified. |
| Room format | A3 landscape, one page, with the three lever bands visually separated and the HARNESS band printed first and widest. Filled live with the engineers present — this is not a sheet the architect can complete alone, because columns 12 and 13 need somebody who has actually read a trace rather than somebody who has read the configuration. |

**Facilitation note.** Most organisations arriving at a pre-groundbreaking workshop have little or
no agentic spend to audit yet. Run the sheet **prospectively against planned workflows** in that
case and mark PROSPECTIVE across the header; a prospective audit is a legitimate output and the
room must not stall on empty cells. Weight the harness deliberately: the chapter names it the lever
with the most reach *because it governs the other two*, so a harness row with no named decider is a
more consequential finding than a single misrouted model, and the fix-first ordering in column 16
should reflect that. Open with the chapter's closing line, which is the framing that makes the
sheet worth filling: **none of these is a market condition you absorb — each is a decision you can
make once, encode, and reuse.** That sentence converts three columns of "vendor default" from an
embarrassment into a backlog.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **Every significant agentic workflow running or planned has a row, and the circled highest-spread
   task from `WS-07-cost-variance-baseline` is one of them.** A sheet that omits it has audited the
   memorable workflows rather than the expensive ones.
2. **Every row carries a mode tick, and if every row reads "planned" the header is marked
   PROSPECTIVE.** A prospective sheet is valid output; a sheet that silently mixes measured and
   planned rows under a MEASURED header is not.
3. **All three "who decided this" columns (7, 11, 14) are filled on every row**, using either a
   named individual or the explicit answer `nobody / vendor default`. Blank is not permitted — the
   sheet exists to convert an absorbed market condition into an owned decision, and a blank records
   neither.
4. **Columns 8 and 9 record a tier, never a vendor SKU.** A model name written into either column
   is struck and replaced with its tier, because the sheet will outlive the model.
5. **Every row where columns 8 and 9 differ and column 3 describes mechanical work is ticked in
   column 10**, and the misrouting count is written in the footer. That count is the cheapest money
   identified anywhere in Pack C.
6. **Three named individuals are recorded as organisation-wide owners of the three levers**, and
   the harness owner holds a more central or more senior seat than the other two — or the room has
   written down why it is inverting the chapter's weighting.
7. **At least one row is ticked "fix first", and the ticked set is ordered with harness fixes ahead
   of model swaps**, or the room records its reason for departing from the chapter's own weighting.
   An unordered fix list is a wish list.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** Three prose bullets; the per-workflow tabular form and the misrouting flag are net-new, though the taxonomy maps cleanly to columns.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> The chapter names the harness as the lever with the most reach because it governs the other two — the worksheet should weight it accordingly rather than treating the three as equal. Pure prose today (three bullets, lines 47-51), so the tabular form is net-new authoring, but the taxonomy is crisp and maps cleanly to columns. Practical caveat for facilitation: most organizations arriving at a pre-groundbreaking workshop will have little or no agentic spend to audit yet, so this worksheet runs prospectively against PLANNED workflows in that case. Mark that mode on the instrument or the room will stall on empty cells. Downstream mechanics (Model Router, Gradient Workflow, Cache-Aware Prefix, Tool Subset) live in Part III per lines 125-133 — leadership does not fill those in, it funds them.
