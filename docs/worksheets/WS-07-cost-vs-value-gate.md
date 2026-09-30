# The Cost-vs-Value Gate — Approval Card for a Funded Workflow

`WS-07-cost-vs-value-gate` &middot; **Pack C - The case and the money** &middot; fill order **11** &middot; type `checklist` &middot; audience **mixed** &middot; leadership priority **1**

> **Split back out in the re-opening pass.** A per-workflow approval card -- owner, expected cost per run and per month, stop condition, off-switch -- completed at install time and re-checked at run time; a standing control, not a budget allocation.
>
> Ships as: `facing:WS-05-decision-rights-gate-matrix`

## 1. Purpose

**Output artifact.** A standing approval gate — a one-page card plus a routing rule — that distinguishes a governed spend from an ungoverned one, and produces an auditable record of every intentional bet.

**Cluster.** `CL-SPEND-GATE` - The Cost-vs-Value Gate: Approval Card for a Funded Workflow

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch07-the-agentic-sdlc-bill.qmd` |
| Chapter | The Agentic SDLC Bill |
| Heading | Pool the spend, gate the bets |
| Stable anchor | `#sec-bill-spend-pooling` |
| Lines | L98-98 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch07-the-agentic-sdlc-bill.html#sec-bill-spend-pooling> |
| Locator quote | "Split your token budget into intentional pockets and map them to user segments" |

Resolve at any time with `python docs/resolve.py ws WS-07-cost-vs-value-gate`.

## 3. Source extract - the scaffolding, verbatim

```text
   98 | Split your token budget into intentional pockets and map them to user segments: a generous pocket for the central team's exploration, bounded pockets for stream-aligned teams, a metered pocket for self-service. Then gate the spend the way you already gate any other risk. The governance chapter's Decision Matrix is the right home for this: a **cost-vs-value approval gate** that asks, at install time and at run time, *does the expected outcome justify the inferencing bill?* Workflows that run locally on local models, or whose cost gradient is low and well-evaluated, get a free pass. Workflows that spend frontier tokens at scale earn an owner, an expected cost, a stop condition, and an off-switch before they ship. **Any spend beyond the baseline playbook is an intentional bet — and a bet is only sound once your monitoring can tell you whether it paid off.**
```

## 4. What the user fills

One card per proposed workflow, completed at install time and re-checked at run time. Fields taken verbatim from the chapter: named owner, expected cost per run and per month, the stop condition, and the off-switch. Plus a fast-path tick for workflows that run on local models or have a low, well-evaluated cost gradient, which the chapter waves straight through.

## 5. Field-level schema

The physical artifact is **a one-page A4 card per workflow**, plus a one-line entry in a standing
register. The rows below are the card's fields, in fill order; field 19 is the register line the
card produces. The card is completed at install time and re-checked at run time, so every card
carries two dates and two signatures.

| # | Field | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Workflow name | `free text` | — | — | org |
| 2 | Gate stage | `select` install time / run time | The chapter gates at both | Tick the stage this completion covers | ch07 L98 |
| 3 | Spend pool it draws on | `select` (4 fixed) | Frontier R&D / Per-workflow run / Everyday prompting / Local models | The pool, spelled exactly as on `WS-07-spend-pool-budget-model` | ch07 L102-105 |
| 4 | Fast path? | `checkbox` | The chapter waves through workflows that run locally on local models, or whose cost gradient is low and well-evaluated | Tick only if **both** tests are met — local or low-gradient, **and** evaluated | ch07 L98 |
| 5 | Evaluation evidence for the fast path | `free text` | — | What "well-evaluated" means for this workflow, and where that evaluation lives | ch07 L98 |
| 6 | Expected outcome | `free text` | — | What the workflow is for, in outcome terms, not activity terms | ch07 L98 |
| 7 | Does the expected outcome justify the inferencing bill? | `select` yes / no / not yet evidenced | The chapter's gate question, printed verbatim above the field | Tick one | ch07 L98 |
| 8 | Named owner | `owner (named person)` | The chapter requires an owner before it ships | A named individual | ch07 L98 |
| 9 | Expected cost per run | `currency` | — | — | ch07 L98 |
| 10 | Expected runs per month | `free text` (count) | — | — | derived |
| 11 | **Expected cost per month** | `computed` | — | Field 9 × field 10 | ch07 L98 |
| 12 | Stop condition | `free text` | The chapter requires one before it ships | The specific, observable condition at which this workflow stops | ch07 L98 |
| 13 | Off-switch | `free text` | The chapter requires one before it ships | The named mechanism, who can pull it, and how quickly it takes effect | ch07 L98 |
| 14 | Monitoring that tells us whether the bet paid off | `free text` | Printed verbatim: "a bet is only sound once your monitoring can tell you whether it paid off" | The specific dashboard, report or trace — one that exists | ch07 L98 |
| 15 | Reversibility | `select` reversible / recoverable at cost / irreversible | — | Use the vocabulary of `WS-05-decision-rights-gate-matrix` unchanged | `WS-05-decision-rights-gate-matrix` |
| 16 | Approver | `owner (named person)` + `signature` | — | Who approved at install; re-signed at the run-time re-check | ch07 L98 |
| 17 | Install-time approval date | `date` | — | — | org |
| 18 | Next run-time re-check date | `date` | — | Mandatory. A card with no re-check date is a one-time approval, not a gate | ch07 L98 |
| 19 | Register line | `computed` | — | Workflow / pool / owner / expected monthly cost / next re-check date — filed with the organisation's decision record | derived |

**Absorbed detail.** This card absorbed no other candidate. It is, by the chapter's own routing,
**the cost row of `WS-05-decision-rights-gate-matrix` rather than a second competing gate** — field
15 therefore borrows that sheet's reversibility vocabulary unchanged, and field 19 is filed
alongside its evidence column. It is also the run-time half of a pair with
`WS-07-spend-pool-budget-model`: that sheet allocates the budget, this card approves an individual
spend against it, and field 3 is the join.

**Printed at the foot of every card.** The chapter's own sentence, in full: *"Any spend beyond the
baseline playbook is an intentional bet — and a bet is only sound once your monitoring can tell you
whether it paid off."* (ch07 L98)

**Deliberate omission.** No currency threshold above which the gate applies. The chapter's test is
qualitative — local models and low, well-evaluated cost gradients take the free pass; frontier
tokens at scale earn the card — and printing a threshold here would invent a boundary the book does
not set, one that is immediately gamed by splitting a workflow in two. If the organisation wants a
threshold, it sets one itself, records it on `WS-07-spend-pool-budget-model` beside the pool it
applies to, and dates it there.

**Deliberate omission.** No scoring, no weighting, no approval rubric. Field 7 is a judgement with
a named approver's signature beside it. A scored gate produces an arithmetic defence of a decision
nobody owns, which is the opposite of what field 16 is for.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-07-spend-pool-budget-model` - The Four Spend Pools — Allocating and Metering the Agentic Budget (Pack C - The case and the money, fill order 8)

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** WS-08-phase-gate-exit-rollback (this gate becomes an operating control that must exist before Phase 2) and the governance Decision Matrix in Chapter 5.

## 8. Facilitation

| | |
|---|---|
| Who fills it | The workflow's proposed owner drafts the card; the approver named in field 16 signs it. **Whoever holds the pool named in field 3 must be present at install-time approval** — the card draws on their budget, and an approval given without the pool owner in the room is how a pool is overspent by three cards that each looked reasonable alone. Finance does not attend every card; it needs only to have signed `WS-07-spend-pool-budget-model`, which this card draws against. Security attends only where the workflow touches a system of record. |
| When in the session | Fill order 11. `WS-07-spend-pool-budget-model` must be complete: field 3 selects from its four pools and field 11 draws against its allocation. In the workshop itself, **fill one card live as a worked example** for the workflow the room cares most about, agree the routing rule, and leave the blank stack behind. This is a standing control, not a one-off exercise — its real fill happens every time a workflow is proposed, months after the session. |
| Duration | 20–30 minutes for the first card, about 10 for each one after. Fields 1 to 11 are quick. The stop condition (12) and the monitoring line (14) take almost all of the time and are the two fields that decide whether the card is a control or a formality. Budget a further 15 minutes in the workshop to agree the routing rule: which cards need an approver and which take the fast path. |
| Data needed in advance | The completed `WS-07-spend-pool-budget-model` with pool owners named. The candidate workflow list from `WS-07-three-variables-audit`. Whatever cost telemetry exists, so that field 9 is a figure rather than a guess. The existing `WS-05-decision-rights-gate-matrix`, so field 15 uses its reversibility vocabulary unchanged rather than inventing a parallel one. |
| Room format | A single-sided A4 card, one per workflow, plus a one-line register held wherever the organisation already keeps its decision record. **Print a stack of blanks and hand them out.** The card only works if it is cheap enough to fill at the moment a workflow is proposed; a card that must be requested will be filled retrospectively, which is not a gate. |

**Facilitation note.** The chapter routes this explicitly into the governance chapter's Decision
Matrix, so build it as the **cost row of `WS-05-decision-rights-gate-matrix`**, not as a second,
competing gate with its own vocabulary and its own filing. Two governance gates with different
words for the same idea is how a control quietly stops being applied. The sentence to print at the
foot of the card is the chapter's own — any spend beyond the baseline playbook is an intentional
bet, and a bet is only sound once your monitoring can tell you whether it paid off. Use it as the
test when reviewing a draft card: fields 1 to 13 complete with field 14 blank means the room has
approved a bet it has no way to score, which is exactly the failure that sentence names. Finally,
be strict about the fast path. It is a genuine and deliberate feature of the chapter's design, not
a loophole, and it stays genuine only while field 5 is actually filled in.

## 9. Acceptance criteria

A well-completed card satisfies all of:

1. **It names an individual owner (8), an expected cost per run and per month (9 and 11), a stop
   condition (12) and an off-switch (13).** The chapter names exactly these four as what a
   frontier-spending workflow earns before it ships; a card missing any one of them is not an
   approval, whatever else it carries.
2. **The stop condition is observable.** Someone reading the monitoring named in field 14 can tell
   whether it has been met without exercising judgement. "If it gets too expensive" is struck and
   re-written with a number the organisation itself chose.
3. **The off-switch names the mechanism, the person who can pull it, and how fast it takes
   effect.** An off-switch that requires a change request, a release, or a ticket queue is not an
   off-switch and the card is not approvable.
4. **Field 14 names a monitoring artefact that already exists**, or the card is marked NOT YET
   APPROVABLE with the monitoring work recorded as its blocker and an owner against it.
5. **Every fast-path tick carries evaluation evidence in field 5.** A fast path claimed on "it's
   cheap" with field 5 blank is struck, and the card goes through the full gate.
6. **Field 3's pool is one of the four on `WS-07-spend-pool-budget-model`, spelled identically, and
   the sum of field 11 across all live cards drawing on a pool does not exceed that pool's funded
   amount** — or the excess is recorded and routed to that pool's reopen trigger rather than
   absorbed silently.
7. **Field 15 uses the reversibility vocabulary of `WS-05-decision-rights-gate-matrix` unchanged,
   and the register line carries a next re-check date.** The chapter gates at install time *and* at
   run time; a card with an install date and no re-check date is a one-time approval wearing the
   costume of a standing control.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Derived from one sentence that is itself a complete form specification: owner, expected cost, stop condition, off-switch.
- **Fill (the organisation completing it): `S`.** S - one sitting, data already in the room

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Derived from one sentence: workflows that spend frontier tokens at scale earn an owner, an expected cost, a stop condition, and an off-switch before they ship. That sentence is a complete form specification — unusually high yield for its length, and one of the cleanest leadership instruments in Part II. DEDUPE: the chapter routes this explicitly into Chapter 5's Decision Matrix, so a ch05 scanner has probably proposed an overlapping governance gate; the synthesizer should make this a COST ROW on the existing decision matrix rather than a second standalone gate. Distinct from WS-07-spend-pool-budget-model despite sharing the source paragraph: that one allocates the budget, this one approves an individual spend against it.
