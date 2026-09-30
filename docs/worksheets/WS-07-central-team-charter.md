# Central AI Team Charter — Mandate, First Loop, and the Reuse Metric

`WS-07-central-team-charter` &middot; **Pack F - People and operating model** &middot; fill order **5** &middot; type `canvas` &middot; audience **eng-leader** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A signed central AI team charter with a named first loop and a reuse-based success metric — the staffing decision the chapter calls among the highest-leverage in the programme.

**Cluster.** `CL-CENTRAL-TEAM` - Central Function or Embedded? The Topology Decision and Team Charter

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch07-the-agentic-sdlc-bill.qmd` |
| Chapter | The Agentic SDLC Bill |
| Heading | Staff the factory |
| Stable anchor | `#sec-bill-staff-the-factory` |
| Lines | L115-121 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch07-the-agentic-sdlc-bill.html#sec-bill-staff-the-factory> |
| Locator quote | "The roles already exist in this book. The **Agentic Workflow Engineer**" |

Resolve at any time with `python docs/resolve.py ws WS-07-central-team-charter`.

## 3. Source extract - the scaffolding, verbatim

```text
  115 | The roles already exist in this book. The **Agentic Workflow Engineer** (@sec-agentic-workflow-engineer) researches and encodes the cost-effective loops; the **Agent Operations Specialist** (@sec-agent-operations-specialist) owns cost, traces, and eval drift once they run at scale. What the bill adds is a *mandate*: the central AI team's first deliverable is not a clever agent, it is a cheaper loop for a recurring, ROI-positive task. Your power users — the developers already pushing the frontier on their own — are the natural feeder into this function as it matures; this is a cost charter attached to a role this book already defined, not a new priesthood. Watch the one metric that keeps the team from becoming a bottleneck: its success is measured in **loops reused across the organization, not requests approved.** A central team that optimizes for gatekeeping has missed the point; a central team that optimizes for reuse compounds.
  116 | 
  117 | ::: {.callout-note title="Three-Tier Honesty: what these numbers are, and are not"}
  118 | The figures in this chapter — the 8.5× spread, the \$4.81 versus \$41.01 run, the model-price ranges — are **illustrative single runs and point-in-time prices**, not benchmarks. They are real, and they are not universal: the magnitude depends on the task, the models available the week you read this, and the harness. Treat them as existence proofs of *variance you can engineer*, not as a guaranteed return. The durable claim is the mechanism — model choice, token use, and harness govern the bill, and all three are in your control. The specific multiples will move. The lever will not.
  119 | :::
  120 | 
  121 | ---
```

## 4. What the user fills

A one-page charter: named members and their source teams, the mandate sentence, the first deliverable named as a specific recurring ROI-positive task (not a clever agent), the success metric written as loops reused across the organization rather than requests approved, the anti-bottleneck tripwire, and the feeder path from identified power users into the function.

## 5. Field-level schema

A3, printed as a **two-page spread and filled open**, both pages visible at once. The physical
layout is the argument. **Left page — what we refuse to build** (block A, the three working
patterns; block B, the three anti-patterns). **Right page — the charter** (blocks C to F), with
the six-stage lifecycle as a process strip across its foot. **Block G, the reconciliation, is
written in the gutter between them**, because it is the only cell on the sheet that answers the
question the two pages pose to each other.

**Block A — the three shapes that work.** Three rows, fixed.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Working pattern | `select` (fixed 3) | Stream-aligned teams with embedded context engineering / a platform team providing shared context infrastructure / a time-boxed enabling team for adoption support | — | ch06 L228-232 |
| 2 | Why the chapter says it works | `free text` (pre-printed, read-only) | Domain knowledge proximity — the people who understand the system encode it / shared assets maintained centrally rather than duplicated, delivered as primitives-as-code / a finite-lifespan team that coaches others through adoption | — | ch06 L228-232 |
| 3 | Status here | `select` — have it / building it / absent | — | — | org |
| 4 | The named team | `free text` + `owner (named person)` | — | The real team, as it is named internally | org |
| 5 | End date (enabling team row only) | `date` | The chapter is explicit that this team has a finite lifespan and folds into the platform team or dissolves once adoption is mature | Our date. A blank here is how an enabling team becomes permanent | ch06 L232 |

**Block B — the three shapes we refuse to build.** Three rows, fixed. This block is the reason
the left page exists.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 6 | Anti-pattern | `select` (fixed 3) | A centralised "AI team" that handles all agent interactions / splitting "human code" and "agent code" into separate workflows / replacing team roles with agents | — | ch06 L236-240 |
| 7 | Why the chapter says it fails | `free text` (pre-printed, read-only, verbatim) | Row 1: a specialised group becomes **the bottleneck for all agent work**; the result is a coordination tax that eliminates the speed advantage, and a knowledge gap because the AI team does not understand each product domain deeply enough to write good context. Row 2: the boundary between important and routine is not stable, agent code still requires human review and integration, and a two-class system undermines cohesion — all code is the team's code regardless of who or what produced it. Row 3: teams that lose senior engineers because "the AI can do that now" lose the judgement required to evaluate agent output and maintain architectural coherence, and produce more code and less working software | — | ch06 L236-240 |
| 8 | Status here | `select` — not present / at risk / already happening | — | — | org |
| 9 | Evidence for column 8 | `free text` | — | What we observed. "We would never do that" is not evidence | derived |
| 10 | What specifically prevents it | `free text` | — | A mechanism, not an intention. Required on every row whose column 8 is not `not present` | derived |

**Block C — the charter: members and mandate.** One row per member, plus the mandate fields.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 11 | Member | `owner (named person)` | — | Named individuals, one per row | ch07 L115 |
| 12 | Source team, and fraction of their time | `free text` | — | Which stream-aligned or platform team they come from, and how much of them this charter gets | ch07 L115 |
| 13 | Role held | `select` — Agentic Workflow Engineer / Agent Operations Specialist / Domain Specialist | The roles already exist in the book; the bill adds a *mandate*, not a new priesthood | Which each member holds | ch07 L115; ch06 L195 |
| 14 | Mandate sentence | `free text` (one sentence) | The chapter's: research and encode cost-effective agentic workflows that the rest of the organisation reuses | Ours, in one sentence, written on the sheet in the room | ch07 L115; ch06 L195 |
| 15 | Power-user feeder path | `free text` + `owner (named person)` | The developers already pushing the frontier on their own are the natural feeder into this function as it matures | Who they are here, by name, and how they join | ch07 L115 |
| 16 | Accountable executive | `owner (named person)` | — | — | org |

**Block D — the first loop.**

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 17 | The first deliverable | `free text` | The constraint prints in the cell: **not a clever agent** — a cheaper, governed loop for a recurring, ROI-positive task | The specific recurring task, named in our own vocabulary | ch07 L115; ch06 L195 |
| 18 | Why this task is recurring | `free text` | — | How often it runs, and who does it today | derived |
| 19 | Why it is ROI-positive | `free text` | — | **Our own** before-and-after for this task, measured by us | ch07 L115 |
| 20 | Delivery date | `date` | — | — | org |
| 21 | Distribution readiness | `checkbox` × 3 + `owner (named person)` | The chapter's distribution surface: release through the package manager with lockfile, integrity checks and version pinning; an IDP catalogue for discoverability; harness-managed settings for mass rollout | Which of the three exist, and who owns each gap. A loop nobody can find is a loop nobody reuses | ch07 L109-111 |

**Block E — the reuse metric.** One row. Mandatory. It does not print as optional and it cannot
be left blank.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 22 | The metric | `free text` (pre-printed, read-only) | **Loops reused across the organization — not requests approved.** | — | ch07 L115 |
| 23 | How we count a reuse | `free text` | — | The definition, written **before** the first loop ships | derived |
| 24 | Metric owner | `owner (named person)` | — | A named individual, not the central team collectively | ch07 L115 |
| 25 | Baseline and first reading date | `free text` + `date` | — | — | derived |
| 26 | Review date | `date` | — | — | derived |
| 27 | Tripwire | `free text` + `owner (named person)` | The chapter's diagnosis: a central team that optimises for gatekeeping has missed the point; a central team that optimises for reuse compounds | What we do, and who does it, if requests approved rises while loops reused does not | ch07 L115 |

**Block F — the escape hatch.**

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 28 | Escape-hatch route | `free text` | When the catalogue has no loop for a task that genuinely needs frontier reasoning, a developer requests time-boxed, budget-capped frontier access **rather than being blocked** | Our request route, named | ch07 L94 |
| 29 | SLA — response time on a request | `free text` | The test prints beside it: *the gate is a queue, not a wall* | Ours. This is the number that decides which of the two we have built | ch07 L94 |
| 30 | Time-box and budget cap per grant | `free text` + `currency` | — | Ours | ch07 L94 |
| 31 | Who approves | `owner (named person)` | — | — | ch07 L94 |
| 32 | Where the gap goes | `free text` | The chapter's rule: the gap becomes the next item on the central team's backlog | The named backlog, and how the request reaches it automatically | ch07 L94 |

**Block G — the reconciliation.** Written in the gutter, between the two pages. Signed.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 33 | Which are we? | `free text` (one paragraph, handwritten) | The question prints in full: *is this charter the anti-pattern in block B row 1, or not — and what specifically makes the difference?* | The room's own answer, in its own words | ch06 L236 against ch07 L115 |
| 34 | The three commitments that stop this charter becoming that anti-pattern | `free text` × 3 | One line per failure mode ch06 names: the bottleneck, the coordination tax, the domain-knowledge gap | One commitment against each, each with a mechanism | ch06 L236 |
| 35 | Signed | `signature` × 2 + `date` | — | The accountable executive **and** whoever would become the bottleneck if this went wrong | derived |

**Lifecycle strip — the process the team instantiates.** Six cells across the foot of the right
page.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 36 | Stage | `select` (fixed 6) | EXPLORE — spend to learn, frontier model, capped / CODIFY — persist as a reusable skill / PUBLISH — portal skill, policy-gated / CONSUME — pull by manifest / RUN AND MONITOR — cost per outcome / DISCOVER — usage reveals the next gap | — | ch07 L149-171 |
| 37 | Who owns this stage here | `owner (named person)` | — | — | org |
| 38 | What it produces | `free text` | — | The artefact that moves to the next stage | ch07 L149-171 |

**Absorbed detail.** `WS-06-topology-antipattern-check` is the entire left page. Its left column
is block A — three working patterns, a have-it / building-it / absent tick, and the named team —
and its right column is block B, with the chapter's reasoning printed rather than summarised so
the room argues with the text and not with the facilitator. Its output, *a one-page target
topology statement plus a written commitment naming the anti-patterns the organisation is
explicitly refusing*, is blocks A, B and G together. It is not a preamble to the charter. It is
the half of the sheet that makes the charter defensible to the exec who asks why we are not
simply standing up an AI centre of excellence.

**The contradiction this sheet is built on — do not resolve it.** Chapter 6 lists *a centralised
"AI team" that handles all agent interactions* as an anti-pattern that becomes the bottleneck
for all agent work (ch06 L236). Chapter 7 charters a small central AI team and calls a handful of
engineers building reusable loops among the highest-leverage staffing decisions in the programme
(ch07 L115; ch06 L195). The book never reconciles them, and read cold they contradict. This
sheet is therefore **deliberately two-sided**, and the build must not smooth it: the refusals
and the charter face each other, and the fill is the reconciliation at block G. The
discriminator is the one ch07 supplies and is printed on both pages — success is measured in
*loops reused across the organization, not requests approved*, and the gate is *a queue, not a
wall*. That is why block E is mandatory with a named owner and a review date, and why block F
carries an SLA: those two blocks are the instruments that decide which of the two things the
organisation has actually built, and a charter that leaves either blank has answered the
question by default.

**Deliberate omission.** No cost multiple and no target saving anywhere on the artefact. The
chapter's figures are fenced by its own Three-Tier Honesty callout as illustrative single runs
at point-in-time prices rather than benchmarks (ch07 L117-119), so column 19 asks for **our**
before-and-after on **our** named task and nothing from the chapter is printed as a target or an
acceptance threshold. There is also no headcount number for the central team: the chapter says a
handful of engineers, a printed figure would be read as an establishment, and block C's rows are
named people drawn from named source teams precisely so the team's size is an outcome of who is
in it.

## 6. Absorbed members (1)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-06-topology-antipattern-check` - Our Target Topology — and the Three Shapes We Refuse to Build

- **Address.** `handbook\ch06-team-structures.qmd` L224-242, Team Topologies That Work — and Don't (`#sec-team-topologies`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Left column, three working patterns (stream-aligned teams with embedded context engineering / platform team owning shared context infrastructure / time-boxed enabling team): tick have it, building it, or absent, and name the team. Right column, three anti-patterns (centralised AI team as the funnel / split human-code vs agent-code tracks / replace roles with agents): tick not present, at risk, or already happening, with the evidence.
- **Its output was.** A one-page target topology statement plus a written commitment that names the anti-patterns the organization is explicitly refusing — the artifact to show an exec who asks why we are not just standing up an AI centre of excellence.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-06-role-map-and-staffing-triggers` - The Role Map — Who Holds Each Hat, and When We Staff It (Pack F - People and operating model, fill order 3)

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** WS-08-transition-roadmap (the charter must be dated onto the phase timeline) and WS-07-model-tier-access-policy (this team is the frontier-tier population).

## 8. Facilitation

| | |
|---|---|
| Who fills it | The accountable executive who will sign block G, the platform lead, and — this is the one that matters — **at least two stream-aligned team leads who do not want a central team.** Block B cannot be filled honestly without someone in the room whose work would be intermediated by the thing being chartered. The named candidate members attend for block C. Finance is not needed: the money for this team sits on `WS-07-spend-pool-budget-model`, and bringing the budget conversation in here turns a design argument into a bid. Security, legal, compliance and HR are not needed. |
| When in the session | Pack F, fifth and last, after `WS-06-role-map-and-staffing-triggers`, which is a hard prerequisite — block C column 13 draws on the three roles that sheet staffed, and an Agent Operations Specialist chartered here whose emergence triggers were unticked there is exactly the fiat that sheet exists to prevent. Within the session: **left page before right page, without exception.** A room that opens the charter first charters a team and then rationalises the anti-patterns around it. The order is the method. |
| Duration | Left page 45 minutes, right page 60, block G 20. Two hours in total. Block G is the only part that cannot be delegated, shortened or taken away as an action, so do not schedule this sheet as the last forty-five minutes of a long day — that is precisely when a room signs a charter and skips the reconciliation. |
| Data needed in advance | The completed role map; the list of developers already running agents heavily on their own initiative — the power users, a list that is usually shorter and far more specific than leaders expect; three or four candidate recurring tasks for the first loop, each with a frequency and a current owner; whether a package manager, an IDP catalogue and harness-managed settings exist today; and `WS-07-spend-pool-budget-model` if it is filled, since the frontier pool is what funds this team. |
| Room format | A3, printed as a two-page spread and **filled open**, with both pages visible throughout. Do not print or circulate the charter side on its own — the refusals are not an appendix to it, they are the other half of the same decision, and a charter that travels without them is the artefact this sheet was designed to make impossible. Block G is handwritten in the gutter, in the room. |

**Facilitation note — the tension is the point.** The book does not reconcile these two passages
and this sheet does not either. Chapter 6 names a centralised AI team that handles all agent
interactions as an anti-pattern that becomes the bottleneck for all agent work; chapter 7
charters a small central AI team and calls it among the highest-leverage staffing decisions in
the programme. Read cold, that is a contradiction — and a facilitator who papers over it loses
the room at exactly the moment they need it, because the two team leads you invited will have
spotted it already.

Name it out loud instead, and then hand the room the discriminator the book itself supplies:
success is measured in **loops reused across the organization, not requests approved**, and the
tier gate is **a queue, not a wall**. A central team that optimises for gatekeeping has become
chapter 6's anti-pattern whatever its charter says; a central team that optimises for reuse
compounds. That is the whole reason block E is mandatory and block F carries an SLA.

The knowledge-gap half of chapter 6's objection — that a central team does not understand each
product domain deeply enough to write good context — has its own answer, and it is structural
rather than rhetorical: block C column 12 requires every member to come from a named source team
and to keep a fraction of their time in it, and the Domain Specialist role exists so the loop
stays correct in a domain the central engineers do not own. If the room cannot fill column 12
without inventing a full-time standalone team, it has just discovered which of the two things it
is actually building, and block G should say so.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **Both pages are filled.** A charter with an empty left page is the anti-pattern being built
   with the evidence torn off. All three block A rows carry a status and a named team, and the
   enabling-team row carries an end date — a blank there is how a time-boxed team becomes
   permanent.
2. **All three anti-pattern rows carry a status and evidence, and every row that is not `not
   present` names a mechanism in column 10.** "We would never do that" is not evidence, and
   "we'll be careful" is not a mechanism. The centralised-AI-team row in particular must be
   answered by a room that has just chartered one.
3. **The first deliverable is a specific recurring task, in our vocabulary, with a frequency and
   a current owner.** "A code review agent" is a clever agent and fails this criterion; "the
   monthly dependency upgrade sweep across the twelve services in payments" is a loop. Column 19
   carries our own before-and-after, not a figure from the chapter.
4. **Block E is complete: a written definition of what counts as a reuse, a named individual
   owner, a first reading date, a review date and a tripwire action with a named owner.** This
   is the metric the book supplies precisely to keep the team from becoming a bottleneck; a
   charter that leaves it blank has no defence against the failure mode that turns it into the
   anti-pattern on the facing page.
5. **The escape hatch carries a response-time SLA, a time-box, a budget cap, a named approver
   and a named backlog destination.** An escape hatch with no SLA is a wall with a form attached,
   and the chapter's test — queue, not wall — is failed by omission rather than by argument.
6. **Block G is written by the room in its own words and signed by two people, one of whom is
   whoever would become the bottleneck if this went wrong.** Column 33 is a paragraph, not a
   tick, and column 34 carries one commitment with a mechanism against each of the three failure
   modes chapter 6 names. A signature above an empty column 33 signs off a decision nobody made.
7. **Reconciliation with `WS-06-role-map-and-staffing-triggers`.** Every member in block C holds
   a role staffed on that sheet, and an Agent Operations Specialist appears here only if its
   emergence triggers were ticked there. Chartering a role the prerequisite sheet says should not
   yet be staffed is the creation-by-fiat that sheet exists to prevent, and it would be done here
   under the cover of a charter.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** Carried unchanged from _section-clusters.md section 7 for CL-CENTRAL-TEAM.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> THE STRONGEST SINGLE STAFFING DECISION IN PART II, and the chapter says so. Cross-chapter: Chapter 6's callout From three roles to a central function (ch06 lines ~194-198) is the same decision seen from the org-design side — the synthesizer should build ONE charter worksheet and cite both locations, not two. The operating-model diagram at ch07 lines 69-90 (fig-loop-factory) is the ready-made visual for the worksheet, and the six-stage workflow lifecycle at lines 149-171 (EXPLORE, CODIFY, PUBLISH, CONSUME, RUN AND MONITOR, DISCOVER; anchor what-this-compounds-into) is a ready-made back-page process the team instantiates. Distribute through the catalog (109-111, anchor distribute-through-the-catalog) adds a thin distribution-readiness question — APM lockfile, IDP catalog, harness-managed rollout — fold it in as a charter prerequisite rather than a separate worksheet.
