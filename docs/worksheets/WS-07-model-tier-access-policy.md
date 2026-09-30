# Model Tier Access Policy — Who Gets the Frontier, and How

`WS-07-model-tier-access-policy` &middot; **Pack C - The case and the money** &middot; fill order **12** &middot; type `decision` &middot; audience **eng-leader** &middot; leadership priority **1**

> **Split back out in the re-opening pass.** A written two-tier access policy plus an escape-hatch design (approver, time box, budget cap, decision SLA, backlog landing) needing procurement and security in the room -- the gate is a queue, not a wall.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A written model-tier access policy with an escape-hatch process — the artifact that lets a leader give a thousand developers frontier-engineered loops without handing a thousand developers a frontier invoice.

**Cluster.** `CL-TIER-POLICY` - Model Tier Access Policy and Escape Hatch

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch07-the-agentic-sdlc-bill.qmd` |
| Chapter | The Agentic SDLC Bill |
| Heading | Tier the model access |
| Stable anchor | `#sec-bill-model-tiering` |
| Lines | L94-94 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch07-the-agentic-sdlc-bill.html#sec-bill-model-tiering> |
| Locator quote | "Give everyone open, baseline access to the most cost-effective, versatile models on the market" |

Resolve at any time with `python docs/resolve.py ws WS-07-model-tier-access-policy`.

## 3. Source extract - the scaffolding, verbatim

```text
   94 | Give everyone open, baseline access to the most cost-effective, versatile models on the market — the tier that delivers most of the value at a fraction of the frontier price.[^bill-skus] Gate the frontier tier to a small central AI team whose single mandate is to *code cost-effective loops for everyone else to reuse.* This sounds austere; it is the opposite. It is how you give a thousand developers the benefit of frontier-model engineering without handing a thousand developers a frontier-model invoice. The frontier model becomes a tool of production, used by the people who build the loops — not a default, billed to everyone who runs them. The one deliberate exception is a metered escape hatch: when the catalog has no loop for a task that genuinely needs frontier reasoning, a developer requests time-boxed, budget-capped frontier access rather than being blocked — and that gap becomes the next item on the central team's backlog. The gate is a queue, not a wall.
```

## 4. What the user fills

Define two tiers by capability class, not vendor SKU. For the baseline tier: which models, which user segments, what the open-access ceiling is. For the gated frontier tier: the named members of the central AI team, the charter sentence that justifies their access, and the cap. Then design the escape hatch: who approves a time-boxed frontier request, what the time box and budget cap are, the SLA on the decision, and where the unmet request lands on the central team backlog.

## 5. Field-level schema

Three blocks on **one physical page**: Block A the baseline tier, Block B the gated frontier tier,
Block C the escape hatch. The rows below are the policy's fields. Block C is not an annexe and must
not be printed on a second sheet — an annexed escape hatch is treated as optional, and a policy
without a working escape hatch is an austerity measure that developers route around. Three
signatures at the foot.

| # | Field | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | **A.** Baseline tier — capability class | `free text` | The chapter's definition: "the most cost-effective, versatile models on the market — the tier that delivers most of the value at a fraction of the frontier price" | Our own definition of the class, expressed as capability, never as a SKU | ch07 L94 |
| 2 | **A.** Models currently in that class | `free text` (in pencil) | — | Today's SKUs, recorded against the re-review date in field 22 because the chapter's footnote says model names date quickly | ch07 L191 |
| 3 | **A.** Who gets it | `select` everyone / named segments | The chapter: open, baseline access for everyone — the floor | Our own segment list | ch07 L94, L104 |
| 4 | **A.** Open-access ceiling | `free text` | — | The ceiling above which even baseline use is metered, if any, and where that number is read | ch07 L104 |
| 5 | **A.** Owner | `owner (named person)` | — | A named individual | org |
| 6 | **B.** Frontier tier — capability class | `free text` | The chapter: the frontier model is "a tool of production, used by the people who build the loops — not a default, billed to everyone who runs them" | Our own definition, as a class | ch07 L94 |
| 7 | **B.** Models currently in that class | `free text` (in pencil) | — | Today's SKUs, against the same re-review date | ch07 L191 |
| 8 | **B.** Named members of the central AI team | `owner (named person)` × n | The chapter gates the frontier tier to "a small central AI team" | The actual named people, not a team name | ch07 L94 |
| 9 | **B.** Charter sentence | `free text` | The chapter's mandate, printed: *"code cost-effective loops for everyone else to reuse"* | Our own one-sentence charter, or the chapter's adopted verbatim | ch07 L94 |
| 10 | **B.** Cap, and the pool it draws on | `currency` + `select` | — | The envelope, drawn on the Frontier R&D pool of `WS-07-spend-pool-budget-model` | ch07 L102 |
| 11 | **B.** Owner | `owner (named person)` | — | A named individual | org |
| 12 | **C.** Escape-hatch trigger | `free text` | The chapter's condition: "when the catalog has no loop for a task that genuinely needs frontier reasoning" | Our own wording of the trigger | ch07 L94 |
| 13 | **C.** How a developer requests it | `free text` | — | The actual channel — a form, a slash command, a queue. One step, not three | ch07 L94 |
| 14 | **C.** Approver, and deputy | `owner (named person)` × 2 | — | A named approver **and** a named deputy. An approver on leave is a wall | ch07 L94 |
| 15 | **C.** Decision SLA | `free text` (duration) | — | How fast a decision is owed. "A queue, not a wall" is an SLA claim; without a duration here the policy is a wall | ch07 L94 |
| 16 | **C.** Time box per grant | `free text` (duration) | The chapter: "time-boxed" | Our own duration | ch07 L94 |
| 17 | **C.** Budget cap per grant, and the pool | `currency` + `select` | The chapter: "budget-capped" | Our own cap, and which pool it draws on | ch07 L94 |
| 18 | **C.** What happens at expiry | `select` lapses / renewable once / must be re-requested | — | Tick one | derived |
| 19 | **C.** Where the unmet request lands | `free text` | The chapter: "that gap becomes the next item on the central team's backlog" | The named backlog, board or queue, and who triages it | ch07 L94 |
| 20 | **C.** Backlog triage SLA | `free text` (duration) | — | How long before the gap is triaged into the catalogue roadmap | derived |
| 21 | **C.** Denial route | `free text` | — | What a denied developer is told **and offered**: the nearest catalogue loop, a place in the backlog, or a date | ch07 L94 |
| 22 | Tier re-review cadence + owner | `select` + `owner (named person)` | The chapter's footnote: read these as tiers, not endorsements; the policy is tier-the-access whatever the SKUs are the week you deploy | Our cadence, and who runs the re-review | ch07 L191 |
| 23 | Escape-hatch health measure | `free text` | The adjacent passage: the central team's success is measured in "loops reused across the organization, not requests approved" | What we watch to know the hatch is a queue — grants requested, time to decision, gaps converted into catalogue loops | ch07 L94, L115 |
| 24 | Procurement acknowledgement | `signature` | — | Procurement confirms the tier definitions are purchasable and the caps are spendable instruments | org |
| 25 | Security acknowledgement | `signature` | — | Security confirms the escape-hatch route does not bypass data-residency or audit controls | org |
| 26 | Policy owner sign-off + date | `signature` + `date` | — | — | org |

**Printed verbatim on the sheet**, as the header above Block C:

> "The one deliberate exception is a metered escape hatch: when the catalog has no loop for a task
> that genuinely needs frontier reasoning, a developer requests time-boxed, budget-capped frontier
> access rather than being blocked — and that gap becomes the next item on the central team's
> backlog. **The gate is a queue, not a wall.**" (ch07 L94)

And as the header above Block B, because the room will need it: gating the frontier tier *"sounds
austere; it is the opposite. It is how you give a thousand developers the benefit of frontier-model
engineering without handing a thousand developers a frontier-model invoice."* (ch07 L94)

**Absorbed detail.** This sheet absorbed no other candidate. It consumes
`WS-07-three-variables-audit`: that sheet's columns 8 and 9 — tier in use today against cheapest
sufficient tier — are the evidence that sets Blocks A and B, because they show which segments
actually need which tier rather than which segments ask loudest. Fields 10 and 17 draw on pools
funded by `WS-07-spend-pool-budget-model`, and field 19's backlog is the demand signal that feeds
the central team's charter.

**Deliberate omission.** No per-token or per-seat prices, and no model name printed *as policy*.
Fields 2 and 7 record today's SKUs explicitly in pencil against field 22's re-review date, because
the chapter's own footnote states that specific model names date quickly and the durable policy is
tier-the-access whatever the SKUs are the week you deploy.

**Deliberate omission.** No headcount for the central AI team beyond the names in field 8. The
chapter says "small" and gives no number; printing one would fabricate a staffing benchmark, and a
staffing benchmark on a signed policy becomes a hiring constraint within two quarters.

**Deliberate omission.** No approval-rate target for the escape hatch. The adjacent passage is
explicit that the central team's success is measured in loops reused, not requests approved — a
target expressed as an approval percentage would optimise the exact metric the chapter names as the
route to becoming a gatekeeper.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-07-three-variables-audit` - The Three Levers Audit — Model, Tokens, Harness (Pack C - The case and the money, fill order 9)

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** WS-07-spend-pool-budget-model (tiers determine pool membership) and WS-07-central-team-charter (the escape-hatch backlog is the central team's demand signal).

## 8. Facilitation

| | |
|---|---|
| Who fills it | The engineering leader who will own the policy, the named lead of the central AI team, and — **physically in the room, not consulted afterwards — procurement and security.** Procurement, because fields 2, 7 and 17 commit the organisation to tiers that must actually be purchasable and caps that must be spendable instruments. Security, because field 13's request channel and field 19's backlog must not route around data-residency or audit controls. Finance's seat is optional provided it has already signed `WS-07-spend-pool-budget-model`, from which fields 10 and 17 draw. **The named escape-hatch approver in field 14 must be in the room**: a hatch whose approver first learns of the role by email is a wall with a name on it. |
| When in the session | Fill order 12, last in Pack C. `WS-07-three-variables-audit` must be complete — its tier-in-use and cheapest-sufficient-tier columns are the evidence that sets Blocks A and B, and a tier policy written without that audit is a guess about which segments need which tier. Fill it after `WS-07-spend-pool-budget-model` as well, so that fields 10 and 17 draw on a pool that already has money in it. |
| Duration | 60–75 minutes. Blocks A and B take about twenty of them. **Block C takes the rest and must not be compressed.** If the session is running short, cut the open-access ceiling discussion in Block A — never the escape hatch. |
| Data needed in advance | The completed `WS-07-three-variables-audit`. The funded Frontier R&D pool amount. Current vendor contracts and which tiers they actually entitle. Who holds admin rights over model selection in each harness today. The organisation's existing approval SLAs for comparable requests — a firewall exception, a production access grant — so that field 15 is calibrated against something real rather than invented. Security's current data-residency constraints per model provider. |
| Room format | One page, three blocks, filled live and signed in the room by three signatories. **Print Block C on the same physical page as Blocks A and B.** If the escape hatch appears on a second sheet it will be read as an annexe, and an annexed escape hatch is not one. |

**Facilitation note — the named rule for this sheet.** The chapter's own words are the facilitation
rule: **the gate is a queue, not a wall.** Do not let the room leave Block C partly filled. Fields
14 to 21 are the entire difference between a policy and an austerity measure — an approver *with a
deputy*, a decision SLA, a time box, a budget cap, a named backlog the unmet request lands on, a
triage SLA, and something better than "no" to tell a developer who is denied. Without those,
developers route around the policy, which is the failure mode, and the organisation loses both the
saving and the visibility it was buying. Read the Block B header aloud before the room fills it:
gating the frontier tier sounds austere and is the opposite, because it is how a thousand
developers get the benefit of frontier-model engineering without a thousand frontier invoices. And
watch field 23 closely — the adjacent passage is explicit that the central team's success is *loops
reused across the organization, not requests approved*, so a policy measured on approval throughput
will reliably manufacture a gatekeeper.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **Both tiers are defined as capability classes (fields 1 and 6), and every SKU written on the
   sheet (fields 2 and 7) sits against the re-review cadence and named owner in field 22.** A
   policy whose tier definition *is* a vendor model name fails and is rewritten — it will be wrong
   within two quarters and nobody will notice.
2. **Block B names the members of the central AI team as individuals (field 8)**, carries a charter
   sentence (field 9), and carries a cap (field 10) drawn on a pool that
   `WS-07-spend-pool-budget-model` has actually funded.
3. **Block C is complete in full — fields 12 to 21, with no blanks.** Every item the chapter
   specifies is present and specific: an approver with a deputy, a time box, a budget cap, a
   decision SLA, and a named backlog the unmet request lands on. **A blank anywhere in fields 14 to
   19 fails the sheet outright**, however well the other two blocks are filled.
4. **The decision SLA in field 15 is a duration the named approver has agreed out loud**, and is
   calibrated against an existing comparable approval in the organisation. "As soon as possible" is
   struck and replaced.
5. **Field 21 offers a denied developer something other than a refusal** — the nearest catalogue
   loop, a place in the backlog, or a date. The queue-not-a-wall test is failed by any denial route
   that ends in "no".
6. **Field 23 names a health measure that is not "requests approved".** A policy scored on
   approvals produces a gatekeeper, which the chapter names explicitly as having missed the point.
7. **Three signatures are on the page — policy owner, procurement, security — and all three signed
   in the room.** Procurement's signature confirms the tiers are purchasable and the caps
   spendable; security's confirms the escape-hatch route does not bypass data-residency or audit
   controls. A policy signed by engineering alone will be discovered to be unpurchasable or
   non-compliant at the moment the first developer uses it.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** A single dense paragraph. The two-tier structure and the escape-hatch fields are net-new, though every decision is specified in the prose.
- **Fill (the organisation completing it): `S`.** S - one sitting, data already in the room

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Single dense paragraph today; the policy structure is net-new but the decisions are fully specified in the prose. CRITICAL FACILITATION POINT: the chapter's own words are the gate is a queue, not a wall — if the escape hatch is not designed into the worksheet, tiering reads as austerity and developers route around it, which is the failure mode. Vendor caveat is authorially explicit (footnote bill-skus): specific model names date quickly, so the worksheet must capture TIERS and a re-review cadence, never SKUs. Expect procurement and security to want a seat when this one is filled.
