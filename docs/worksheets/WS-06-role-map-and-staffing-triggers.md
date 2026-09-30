# The Role Map — Who Holds Each Hat, and When We Staff It

`WS-06-role-map-and-staffing-triggers` &middot; **Pack F - People and operating model** &middot; fill order **3** &middot; type `inventory` &middot; audience **eng-leader** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A staffed role map distinguishing roles we have today, hats someone will wear part-time, and roles we deliberately will not staff yet with the written trigger that would change that.

**Cluster.** `CL-ORG-DESIGN` - Role Map: Who Holds Each Hat, and When We Staff It

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch06-team-structures.qmd` |
| Chapter | Team Structures for AI-Augmented Delivery |
| Heading | Domain Specialist |
| Stable anchor | `#sec-domain-specialist` |
| Lines | L156-198 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch06-team-structures.html#sec-domain-specialist> |
| Locator quote | "The **Domain Specialist** is the role that owns *what a Skill encodes*." |

Resolve at any time with `python docs/resolve.py ws WS-06-role-map-and-staffing-triggers`.

## 3. Source extract - the scaffolding, verbatim

```text
  156 | The **Domain Specialist** is the role that owns *what a Skill encodes*. The person trained on a specific domain — what large enterprises call a Subject Matter Expert (SME) or Domain Owner. The Domain Specialist defines WHAT the procedure encodes; the Agentic Workflow Engineer encodes it; the Agent Operations Specialist runs it once it operates across Skills.
  157 | 
  158 | In a payments team, the Domain Specialist is the engineer (or compliance officer, or risk analyst) who knows what a refund flow must check before issuing money — the regulatory constraints, the fraud heuristics, the customer-experience guardrails. In a legal team, the Domain Specialist is the attorney who knows what a contract review must catch before sign-off. The role is industry-standard; agentic development gives it a new authoring surface — markdown primitives that the Agent Harness loads on every relevant invocation — but the underlying expertise has always existed under the SME label.
  159 | 
  160 | Two practical points:
  161 | 
  162 | **The Domain Specialist is not always an engineer.** Where the procedure encodes domain judgement that the engineer does not hold (regulatory review, M&A diligence, clinical decision support), the Domain Specialist is the domain expert and the Agentic Workflow Engineer pairs with them to turn the judgement into Skill structure. This is what makes the agentic SDLC carry non-engineering work without architectural change: non-developer roles get first-class authoring surfaces, not just consumption rights.
  163 | 
  164 | **SME and Domain Owner are recognised synonyms.** Different organizations use different vocabulary for the same role. The handbook standardises on Domain Specialist for clarity, but `SME` and `Domain Owner` appear in passing throughout — when they do, they refer to the same person.
  165 | 
  166 | ### Agentic Workflow Engineer {#sec-agentic-workflow-engineer}
  167 | 
  168 | The **Agentic Workflow Engineer** is the role that owns *how a Skill composes*. The engineer who turns the Domain Specialist's procedure into the actual `.skill.md` body, the dispatched Personas, the recursion bound, the eval scaffolding, and the plan-persistence discipline. Where the Domain Specialist names the WHAT, the Agentic Workflow Engineer encodes the HOW.
  169 | 
  170 | ::: {.callout-note title="A name collision worth naming once"}
  171 | Business Process Management (BPM) and workflow-orchestration tooling — Airflow, Camunda, Activiti, classical BPMN suites — have used the term *workflow engineer* for procedural and DAG work for two decades. Here we mean something different: the engineer who composes Skills and Personas into agentic workflows, not the engineer who builds DAGs in a BPM tool. The collision is real and we will not over-defend the name; once acknowledged, the context disambiguates. Where the rest of the handbook says Agentic Workflow Engineer, it means the agentic-workflow role.
  172 | :::
  173 | 
  174 | The Agentic Workflow Engineer's day-to-day artefacts are the `.skill.md` body, the PROSE-level composition that decides which Personas a Skill dispatches, the eval that bounds the recursion, and the plan that persists across the Skill's invocations. The role overlaps with senior engineering and platform engineering: in small teams the senior engineer wears the hat; at scale a dedicated role emerges, often inside the platform or developer-experience team.
  175 | 
  176 | ### Agent Operations Specialist {#sec-agent-operations-specialist}
  177 | 
  178 | The **Agent Operations Specialist** is the role that owns *operations once Skills run in production* — cost, traces, eval drift, rate limits, and the cross-Skill composition that emerges when more than one Skill begins dispatching another. Sidebar B of the Part III capstone (Chapter 22) references this role; the definitional home for it is here.
  179 | 
  180 | Per the maturity guidance in the staffing principles below: **the Agent Operations Specialist emerges only at scale.** In small teams the senior Agentic Workflow Engineer wears the hat. Do not staff the role before the work exists. The work exists when (a) more than one Skill is in production, (b) cost or eval drift has begun to require dedicated attention, and (c) the composition across Skills is no longer something a stream-aligned team can manage out of its own backlog. Most organizations will not need the role until they reach Phase 4 maturity as described in Chapter 2.
  181 | 
  182 | The day-to-day work centers on a small set of multi-agent composition patterns the field has converged on — *Panel*, *Wave*, *Scatter-Gather*, *Subagent* — operated, not invented. Part III treats these patterns in depth; Chapter 19 (@sec-composition-patterns) is the catalogue. The staffing point is that the role exists to *run* the patterns, not to design them.
  183 | 
  184 | ::: {.callout-tip title="The 3-concern authorship triplet"}
  185 | At the surface introduced in Chapter 4, the three roles separate cleanly along three concerns:
  186 | 
  187 | - **Domain Specialist** owns WHAT the Skill encodes (the procedure, the success criteria, the eval)
  188 | - **Agentic Workflow Engineer** owns HOW the Skill composes (the body, the PROSE-level composition, the eval scaffolding)
  189 | - **Agent Operations Specialist** owns the OPERATIONS once the Skill runs (cost, traces, eval drift, rate limits)
  190 | 
  191 | The same triplet recurs at the *Skill-authoring* level in Chapter 21 (@sec-primitives-as-code) — Ch20 carries the deep treatment of who does what when AUTHORING a single Skill bundle, complementary to the per-layer ownership table above.
  192 | :::
  193 | 
  194 | ::: {.callout-note title="From three roles to a central function"}
  195 | As usage-based billing makes run-cost a first-class concern, these three roles increasingly cluster into a small **central AI team** with a sharp charter: research and encode cost-effective agentic workflows that the rest of the organization reuses. The Agentic Workflow Engineer codes the cheaper loop; the Agent Operations Specialist owns its cost, traces, and eval drift at scale; the Domain Specialist keeps it correct. The team's first deliverable is not a clever agent — it is a cheaper, governed loop for a recurring, ROI-positive task. The chapter on the agentic SDLC bill describes the operating model this team runs (gated frontier-model access, model tiering, budget pockets, and a governed catalogue) and why a handful of engineers building reusable loops is among the highest-leverage staffing decisions in the programme.
  196 | :::
  197 | 
  198 | ---
```

## 4. What the user fills

Two blocks. Block one, the three new roles (Domain Specialist, Agentic Workflow Engineer, Agent Operations Specialist): for each, name the person, mark hat-worn-by-existing-engineer vs dedicated, and tick the emergence triggers the chapter gives verbatim for Agent Operations Specialist (more than one Skill in production / cost or eval drift demands attention / cross-Skill composition exceeds a stream team backlog). Block two, the existing roles (senior engineer, junior engineer, tech lead): what shifts in emphasis, and what comes off the plate to make room.

## 5. Field-level schema

An A3 booklet, four sides. **Side 1 — blocks A and B**, the existing roles: A is the lifecycle
axis (what each role does in the SDLC), B is the seniority axis (what shifts in emphasis by
level). The same engineer appears on both, and that is intended: they answer different
questions. **Side 2 — block C**, the three new roles with their emergence triggers, and
**block D**, the extend-or-stand-up decision, printed alone on its half-page because it is
signed. **Side 3 — blocks E and F**, the per-team coverage map and the orchestrator charter.
**Side 4 — block G**, the per-Skill authoring triplet.

**Block A — lifecycle roles.** Five rows, fixed.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Human role | `select` (fixed 5) | Product Manager / Architect / Developer / QA Engineer / SRE and Ops | — | ch04 L169-173 |
| 2 | What stays human | `free text` (pre-printed, read-only) | The chapter's list per role | — | ch04 L169-173 |
| 3 | What agents handle | `free text` (pre-printed, read-only) | The chapter's list per role | — | ch04 L169-173 |
| 4 | What shifts | `free text` (pre-printed, read-only) | The chapter's one-line shift per role | — | ch04 L169-173 |
| 5 | Our real teams and the named people who hold it | `owner (named person)` (list) | — | Teams as they are actually named internally | org |
| 6 | Delegation verdict, per activity listed in column 3 | `select` — now / later / never | — | One verdict per listed activity, not one per role | ch04 L177 |
| 7 | Training or role-charter change implied | `free text` | — | What has to change in the job description, and who owns changing it | ch04 L177 |

**Block B — seniority roles.** Three rows, fixed.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 8 | Role | `select` (fixed 3) | Senior engineer / junior engineer / tech lead | — | ch06 L86, L97, L110 |
| 9 | What shifts in emphasis | `free text` (pre-printed, read-only) | Seniors: architecture and design, context engineering, review and escalation, mentoring. Juniors: reviewing agent output, writing specifications for agent tasks, diagnosing agent failures, building and maintaining context artefacts. Tech leads: orchestrating work across humans and agents, deciding which tasks suit agent execution, owning the feedback loop on context gaps | — | ch06 L86-95, L97-108, L110-114 |
| 10 | What comes off the plate to make room | `free text` | — | The explicit subtraction. A role with only additions has been overloaded, not restaffed | derived |
| 11 | Named people | `owner (named person)` (list) | — | — | org |
| 12 | The bottleneck risk, named | `free text` | The chapter's warning: seniors who resist the shift and insist on writing everything themselves become the bottleneck | Who, here, is at that risk and what we do about it | ch06 L95 |

**Block C — the three new roles.** Three rows, fixed.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 13 | Role | `select` (fixed 3) | Domain Specialist (SME / Domain Owner) / Agentic Workflow Engineer / Agent Operations Specialist | — | ch06 L156, L166, L176 |
| 14 | What it owns | `free text` (pre-printed, read-only) | WHAT the Skill encodes / HOW the Skill composes / OPERATIONS once the Skill runs | — | ch06 L187-189 |
| 15 | Who holds it here | `owner (named person)` | — | — | org |
| 16 | Dedicated role, hat, or gap | `select` — dedicated role / hat worn by an existing engineer / gap | — | `hat` is a first-class answer, not a deferral | ch06 L174, L180 |
| 17 | If `gap`: hire, promote or contract, and by when | `select` + `date` | — | — | ch04 L179 |
| 18 | Not always an engineer | `checkbox` + `free text` | Pre-printed on the Domain Specialist row: where the procedure encodes domain judgement the engineer does not hold — regulatory review, M&A diligence, clinical decision support — the Domain Specialist **is** the domain expert and the Agentic Workflow Engineer pairs with them | Who, and from which function | ch06 L162 |
| 19 | Emergence triggers | `checkbox` × 3 | Pre-printed on the Agent Operations Specialist row: (a) more than one Skill is in production; (b) cost or eval drift has begun to require dedicated attention; (c) cross-Skill composition is no longer something a stream-aligned team can manage out of its own backlog | Tick only what is true today | ch06 L180 |
| 20 | Staffing verdict | `select` — staff now / do not staff yet | The rule prints beside the column: **do not staff the role before the work exists**; most organisations will not need it until Phase 4 maturity | — | ch06 L180 |
| 21 | What would have to become true | `free text` | — | Mandatory wherever column 20 reads `do not staff yet`. This is the trigger the sheet exists to force | ch06 L180 |

**Block D — extend or stand up.** One decision. Signed.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 22 | The decision | `select` — extend the existing platform team / stand up a new function | — | One of two | ch04 L181 |
| 23 | Rationale | `free text` | The chapter's defensible default for most organisations is **extend**: layers one, three and most of four describe work the platform team is already qualified for, and layer two is where net-new authoring talent joins | Our rationale, and where we differ from the default | ch04 L181 |
| 24 | Named accountable leader | `owner (named person)` | — | — | ch04 L181 |
| 25 | Signed | `signature` + `date` | — | — | derived |

**Block E — the three-role coverage map.** One row per team or service.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 26 | Team or service | `free text` | — | — | org |
| 27 | Architect | `owner (named person)` | Decomposes the work, sequences dependencies, defines constraints and granularity | Named | ch10 L62-66 |
| 28 | Reviewer | `owner (named person)` | Evaluates whether the agent stayed inside the constraints, and whether the constraints were right | Named | ch10 L68-72 |
| 29 | Escalation handler | `owner (named person)` | Resolves ambiguity the specification did not settle, and the calls that are genuinely the human's | Named | ch10 L74-76 |
| 30 | Today's split of engineer time across the three | `free text` | — | Three rough proportions | ch10 L78 |
| 31 | Target split | `free text` | The chapter's direction: as specifications and decomposition improve, review burden decreases and the architect role dominates; the escalation handler role stays roughly constant | Our target | ch10 L78 |
| 32 | Escalation path — who is reachable, within what response time | `owner (named person)` + `free text` | — | Must match the on-call arrangement that actually exists | ch10 L74-76 |

**Block F — the orchestrator charter.** Three rows, fixed.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 33 | Phase | `select` (fixed 3) | Before execution / during execution / after execution | — | ch17 L334-338 |
| 34 | What the orchestrator decides | `free text` (pre-printed, read-only) | Before: the plan — which concerns to address, which to defer, how to partition work across agents and waves, and what principles govern trade-offs. During: monitors progress and handles escalations; diagnoses whether a stall is a prompt problem, a scope problem or a tooling problem; resolves conflicting output by the plan's principles or by an explicit design decision. After: spot-checks critical changes, verifies test results, decides whether output meets the acceptance criteria | — | ch17 L334-338 |
| 35 | Who holds it here | `owner (named person)` or level | — | By name, or by level where it is a whole cohort | ch17 L328 |
| 36 | What they stop doing to make room | `free text` | — | The subtraction again, this time for the orchestrator specifically | ch17 L328; ch06 L95 |
| 37 | Skills they need and do not have today | `free text` | — | Resolves into the gap map of `WS-06-skill-gap-and-hiring-bar` rather than being re-derived here | derived |
| 38 | Review depth proportional to risk, not diff volume | `free text` | The chapter's worked example: a 2,000-line diff of which 1,800 lines are mechanical migration does not require reading 2,000 lines — it requires verifying the migration pattern, the 200 non-mechanical lines, and the test coverage | Our rule, in our own terms | ch17 L338 |

**Block G — the Skill-authoring triplet.** One row per Skill or candidate Skill.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 39 | Skill or candidate Skill | `free text` | — | — | org |
| 40 | WHAT — Domain Specialist | `owner (named person)` | — | Named | ch21 L177 |
| 41 | WHAT artefacts | `free text` (pre-printed, read-only) | The procedure, the success criteria, the ground-truth references the Skill cites, the eval set | — | ch21 L177 |
| 42 | HOW — Agentic Workflow Engineer | `owner (named person)` | — | Named | ch21 L178 |
| 43 | HOW artefacts | `free text` (pre-printed, read-only) | The `.skill.md` body, the PROSE-level composition, the dispatched Personas, the recursion bound, the plan-persistence discipline | — | ch21 L178 |
| 44 | OPERATIONS — Agent Operations Specialist | `owner (named person)` | — | Named | ch21 L179 |
| 45 | OPERATIONS artefacts | `free text` (pre-printed, read-only) | The cost ceiling, the trace expectations, the eval-drift threshold, the rate-limit policy, the rollback procedure | — | ch21 L179 |
| 46 | Per concern: real role today, hat already worn, or gap to hire | `select` × 3 | The chapter's framing: the roles are concerns, not headcount — in a small team one engineer wears all three | Three verdicts, one per concern | ch21 L183 |

**Absorbed detail.** All four absorbed members are carried and each keeps its own block.
`WS-04-agentic-operating-model-and-role-map` is split across three of them exactly as it was
structured: its Part A is block A (five lifecycle roles, named people, a now/later/never
delegation verdict per listed activity, and the implied training or charter change), its Part B
is block C columns 15-17 (who holds each new role, hire/promote/contract, by when), and its
Part C is block D — the single extend-versus-stand-up decision with a rationale and a named
accountable leader, signed.
`WS-10-three-roles-org-map` is block E: architect, reviewer and escalation handler per team, the
today-and-target time splits, and the named escalation path with a response time.
`WS-17-human-orchestrator-role-charter` is block F: the three phases as columns 33-34, who holds
it, what they stop doing, the skills gap, and the review-depth-by-risk rule at column 38.
`WS-21-skill-authoring-triplet-raci` is block G: a named human behind WHAT, HOW and OPERATIONS
for every Skill, each concern's authoring artefacts pre-printed so the named person knows what
they have signed up to produce, and the role / hat / gap verdict per concern at column 46.

**Deliberate omission — the legacy role framing.** Chapter 6 carries a second description of
these same roles under older names (context engineer, agent operations specialist) at L210-220,
which the chapter itself marks as preserved for continuity. This sheet builds only from the
current framing and prints no second role list. Two lists of the same three roles on one
worksheet would be read as six roles, and someone would staff the difference.

**Deliberate omission.** No headcount number and no FTE allocation per role anywhere on the
sheet. The chapter's staffing argument is that a role is created by a **trigger**, not by a
plan — *do not staff the role before the work exists* (ch06 L180) — so column 20 is a verdict
derived from column 19's ticks, column 16 admits `hat` as a first-class answer, and column 21
records the condition rather than a date by which somebody hopes to hire.

## 6. Absorbed members (4)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-04-agentic-operating-model-and-role-map` - Agentic Operating Model and Role Map

- **Address.** `handbook\ch04-the-reference-architecture.qmd` L163-181, What Changes About Roles (`#sec-ref-arch-roles`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Part A: for each of the five existing roles (Product Manager, Architect, Developer, QA Engineer, SRE/Ops), name the real teams and people who hold it, tick which listed activities we will delegate to agents now / later / never, and note the training or role-charter change implied. Part B: for the three roles the Five-Layer landscape implies (Domain Specialist, Agentic Workflow Engineer, Agent Operations Specialist), record who will hold it, whether it is hire / promote / contract, and by when. Part C: the single decision - extend the existing platform team or stand up a new function - with rationale and the named accountable leader recorded.
- **Its output was.** An operating-model page showing the agentic SDLC mapped onto the real org chart, with staffing commitments for the three new roles and a signed extend-vs-new-function decision.

### `WS-10-three-roles-org-map` - Architect / Reviewer / Escalation Handler Coverage Map

- **Address.** `handbook\ch10-the-practitioners-mindset.qmd` L62-82, Your Three Roles (`#sec-mindset-three-roles`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** For each team or service: who holds each of the three roles, today's split of engineer time across them, the target split, and the named escalation path — who is reachable, within what response time — when an agent stalls or surfaces a judgment call.
- **Its output was.** A role-coverage map with named owners and an escalation rota; the input to any job-ladder, on-call or headcount change the transformation requires.

### `WS-17-human-orchestrator-role-charter` - The Orchestrator Role Charter: What the Engineer's Job Becomes

- **Address.** `handbook\ch17-multi-agent-orchestration.qmd` L326-336, The Human as Orchestrator (`#sec-multi-agent-human-orchestrator`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Three columns - before execution, during execution, after execution - filled with what the orchestrator decides in each phase, who in the real org holds that role (by name or by level), what they stop doing to make room for it, what skills they need that they do not have today, and what review depth is proportional to risk rather than to diff volume.
- **Its output was.** A role charter for the orchestrator - a job-description delta plus a named skills gap, directly usable in role definitions, levelling guidance and the enablement plan.

### `WS-21-skill-authoring-triplet-raci` - Who Owns WHAT, HOW and OPERATIONS: Mapping Three Concerns onto Real People

- **Address.** `handbook\ch21-primitives-as-code.qmd` L173-189, Three concerns when authoring a Skill (`#sec-skill-authoring-triplet`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** For each Skill (or candidate Skill), the named human behind each of the three concerns: Domain Specialist owning WHAT (the procedure, success criteria, ground-truth references, the eval set), Agentic Workflow Engineer owning HOW (the body, the composition, the dispatched Personas, the recursion bound, plan-persistence discipline), Agent Operations Specialist owning OPERATIONS (cost ceiling, trace expectations, eval-drift threshold, rate-limit policy, rollback procedure) -- plus whether that is a real role today, a hat someone already wears, or a gap to hire.
- **Its output was.** A staffing and ownership map converting three abstract concerns into named people, explicit hat-wearing notes, and a justified hiring gap list.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-04-five-layer-supply-chain-canvas` - Five-Layer Supply Chain Instantiation Canvas (Pack D - Architecture and ownership, fill order 2)

**Consumed by:**

- `WS-05-decision-rights-gate-matrix` - Decision Rights and Gate Matrix: Who Decides What, With Which Evidence (Pack F - People and operating model, fill order 4)
- `WS-07-central-team-charter` - Central AI Team Charter — Mandate, First Loop, and the Reuse Metric (Pack F - People and operating model, fill order 5)

**Feeds into (prose, from the source scan).** WS-07-central-team-charter (the three roles cluster into the central AI function) and WS-06-skill-gap-and-hiring-bar (each mapped person needs a training track).

## 8. Facilitation

| | |
|---|---|
| Who fills it | The engineering leader who will sign block D, with the platform lead and the tech leads who wear the hats today. Bring at least one candidate **non-engineering** Domain Specialist if the organisation intends to carry non-engineering work through the same architecture — column 18 is the row that proves the model, and it cannot be filled by proxy. **HR is needed** for blocks A, B and C, where a shift in emphasis becomes a job description and a levelling change; the chapter's rule that no role is created by fiat is easier to hold with HR in the room, not harder. Security, legal and compliance are not needed on this sheet. |
| When in the session | Pack F, third sheet, after `WS-04-five-layer-supply-chain-canvas`, which is a hard prerequisite — blocks C and D map roles onto layers that canvas defines, and block D is unanswerable without it. It must precede `WS-05-decision-rights-gate-matrix` and `WS-07-central-team-charter`, both of which consume it. Run it after `WS-06-skill-gap-and-hiring-bar` so that column 37 can point into that sheet's gap map instead of re-deriving the same list a second time. |
| Duration | Blocks A and B, 45 minutes. Blocks C and D, 45 — and block D will run long, because it is a genuine organisational decision and not a form. Block E is roughly 30 minutes per team: scope it to two or three teams live and delegate the rest to those teams with a return date. Block F, 30. Block G, 20 per Skill. Budget half a day, split if necessary after block D. |
| Data needed in advance | The current org chart with names; the completed five-layer canvas; the list of Skills in production or in flight, if any; the current on-call and escalation arrangements with their real response times; existing job descriptions and levelling guidance for the roles in blocks A and B; and the output of `WS-06-skill-gap-and-hiring-bar`. |
| Room format | A3 booklet, four sides. Block D is printed alone on its half-page and signed in the room — it is the artefact an exec will ask for. Block E is distributed to teams to fill and reconciled centrally; attempting more than three teams live produces three good rows and a page of guesses. Block G is filled per Skill by the people who would actually author it. |

**Facilitation note carried from ch06.** The rule this sheet exists to enforce is that **no role
is created by fiat.** For the Agent Operations Specialist, column 20 is decided by the three
triggers ticked in column 19 and by nothing else, and the chapter's sentence — *do not staff the
role before the work exists* — prints beside it. Expect the room to want to hire it early
because it sounds like the future; the chapter's position is that most organisations will not
need it until Phase 4 maturity and that in small teams the senior Agentic Workflow Engineer
wears the hat. If the room overrides that, the override is written into column 21 as a decision
rather than allowed to happen by enthusiasm.

Two smaller notes save time. First, L162 is what unlocks non-engineering work and is worth
reading aloud: the Domain Specialist is not always an engineer, and where the procedure encodes
judgement the engineer does not hold, the domain expert **is** the Domain Specialist and the
Agentic Workflow Engineer pairs with them. Second, name the collision at L170-172 once and move
on — *Agentic Workflow Engineer* does not mean the BPM or Airflow workflow engineer of the last
two decades. Left unspoken, the room re-litigates it three times across the booklet.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **Each of the three new roles carries a verdict in column 16 — dedicated role, hat, or gap —
   and every `gap` carries hire, promote or contract with a date.** A role with a name and no
   verdict is an aspiration, and it will be quoted back as a commitment.
2. **The Agent Operations Specialist row is decided by its triggers, not by appetite.** With
   fewer than all three ticks in column 19, column 20 reads `do not staff yet` and column 21
   names what would have to become true. Staffing it against unticked triggers contradicts
   ch06 L180 and is only acceptable as a written override with a reason and a signature.
3. **Block D is answered, rationalised, signed and carries a named accountable leader.** This is
   the single decision the operating-model half of the booklet exists to produce. An unsigned
   block D means extend-versus-new-function is still open, however complete everything else is.
4. **Blocks A and B name real people, and block B names what comes off the plate.** Column 10
   is the criterion most often failed: a role description that only adds responsibilities has
   been overloaded rather than restaffed, and the chapter's bottleneck warning at L95 is what
   happens next.
5. **Block E covers every in-scope team, with all three roles held by a named individual and an
   escalation path that names a reachable person and a response time.** It reconciles with
   `WS-17-escalation-autonomy-ladder`: the person in column 32 is the person that ladder pages
   at L3. A mismatch means one of the two sheets is describing a rota that does not exist.
6. **Block F names the orchestrator's subtraction and writes a review-depth rule in our own
   terms.** A charter with no subtraction in column 36 and no rule in column 38 is a job title,
   and the review rule in particular is what stops depth being set by diff size.
7. **Block G names an individual behind all three concerns for every Skill, each marked role,
   hat or gap.** Where the organisation has no Skills yet, one candidate Skill is filled as a
   rehearsal and marked as such — a blank block G is indistinguishable from a question nobody
   asked, and the triplet is exactly what a first Skill review will be judged against.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** Carried unchanged from _section-clusters.md section 7 for CL-ORG-DESIGN.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Spans three sub-sections with explicit anchors: sec-domain-specialist (156), sec-agentic-workflow-engineer (166), sec-agent-operations-specialist (176), plus the 3-concern authorship triplet callout at ~190-198. The existing-role half comes from How Roles Evolve, lines 84-116, anchor how-roles-evolve. DEDUPE WARNING: New Roles (legacy framing) at lines 210-220, anchor new-roles-legacy-framing, describes the SAME roles under older names (context engineer, agent operations specialist) and the chapter itself marks it as preserved for continuity — do NOT build a second worksheet from it. Strong facilitation hook: the chapter insists no role should be created by fiat, so the worksheet must force a trigger, not a hire.
