# Skill Gap Map and the Revised Hiring Bar

`WS-06-skill-gap-and-hiring-bar` &middot; **Pack F - People and operating model** &middot; fill order **1** &middot; type `rubric` &middot; audience **eng-leader** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A prioritised capability gap map with a hire-train-accept decision per skill, plus a redlined interview loop (add a review exercise and a specification exercise, remove whiteboard algorithms and syntax trivia).

**Cluster.** `CL-SKILLS-STAFFING` - Skills, Ratios and the Enablement Plan

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch06-team-structures.qmd` |
| Chapter | Team Structures for AI-Augmented Delivery |
| Heading | Skill Matrix Evolution |
| Stable anchor | `#sec-team-skill-matrix` |
| Lines | L262-298 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch06-team-structures.html#sec-team-skill-matrix> |
| Locator quote | "The skills that differentiate engineers are shifting. This has hiring, retention, and development implications." |

Resolve at any time with `python docs/resolve.py ws WS-06-skill-gap-and-hiring-bar`.

## 3. Source extract - the scaffolding, verbatim

```text
  262 | The skills that differentiate engineers are shifting. This has hiring, retention, and development implications.
  263 | 
  264 | ::: {tbl-colwidths="[18,18,22,42]"}
  265 | 
  266 | | Skill | Pre-Agentic Value | Agentic Value | Direction |
  267 | |---|---|---|---|
  268 | | Syntax and language fluency | High — daily necessity | Low — agents handle this | Declining |
  269 | | Algorithm and data structure mastery | Medium — interviews, specific domains | Low to medium — agents implement known algorithms | Declining for implementation, stable for design |
  270 | | System design and architecture | High | Very high — the primary human differentiator | Increasing |
  271 | | Code review and evaluation | Medium — supporting skill | High — core daily activity | Increasing |
  272 | | Technical writing and specification | Low to medium — often neglected | High — specification quality drives agent output quality | Sharply increasing |
  273 | | Context engineering | Did not exist | High — new foundational skill | New |
  274 | | Debugging and root cause analysis | High | High — agent-generated bugs are subtler | Stable, but harder |
  275 | | Domain knowledge | High | Very high — agents cannot learn what is not documented | Increasing |
  276 | | Collaboration and communication | Medium | High — coordination with agents adds a new dimension | Increasing |
  277 | 
  278 | :::
  279 | 
  280 | ### Hiring Implications
  281 | 
  282 | The skill matrix changes what you screen for, what you stop requiring, and how you interview.
  283 | 
  284 | **Screen for:** Systems thinking, technical communication (can the candidate explain a design decision in writing, not just verbally?), evaluation skill (can they identify subtle flaws in code they didn't write?), comfort with ambiguity, and learning velocity.
  285 | 
  286 | **Stop requiring:** Whiteboard algorithm implementation, syntax trivia, memorized API knowledge. These were always imperfect proxies for engineering capability. They are now increasingly poor proxies, because agents eliminate the tasks they supposedly measure.
  287 | 
  288 | **Interview changes:** Include a review exercise — give candidates agent-generated code with subtle defects and evaluate how they identify and explain the problems. Include a specification exercise — give candidates an ambiguous requirement and evaluate how they decompose it into a clear, implementable specification. These exercises test the skills that matter now.
  289 | 
  290 | ### Retention Risks
  291 | 
  292 | Two retention risks emerge during the transition.
  293 | 
  294 | **Senior engineers who feel deskilled.** Engineers whose identity is tied to writing code may perceive agentic tools as devaluing their expertise. The reality is the opposite: their judgment is more valuable than ever, but the *form* of their contribution changes. Address this directly. Show them that context engineering and architectural guidance are expressions of the same expertise, applied differently.
  295 | 
  296 | **Junior engineers who feel replaceable.** The discourse around AI replacing developers lands hardest on the newest members of the profession. If your organization is not actively investing in junior development — using the models from the previous section — your junior engineers will correctly conclude that their growth path is unclear and leave. This is not just an empathy argument. The seniors of 2030 are the juniors you invest in today.
  297 | 
  298 | ---
```

## 4. What the user fills

Nine skill rows from the chapter table. Per row the leader scores current team strength 1-5, marks required level under agentic delivery, and picks one action: hire, train, or accept. Two attached blocks: a screen-for / stop-requiring list for the recruiting loop, and a retention-risk register naming the specific senior engineers at deskilling risk and the specific juniors at replaceability risk.

## 5. Field-level schema

An A3 booklet, four sides. **Side 1 — block A**, the nine-row skill gap map, the anchor.
**Side 2 — block B**, the redlined interview loop, and **block C**, the retention risk
register. **Side 3 — block D**, the junior development pathway, and **block E**, the team
composition target: the two blocks that carry printed figures, placed together so they can
share one disclaimer band down the outer margin. **Side 4 — block F**, the five enablement
tracks, and **block G**, the three attention levers.

**Block A — the skill gap map.** One row per skill; nine rows, fixed.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Skill | `select` (fixed 9) | Syntax and language fluency / algorithm and data structure mastery / system design and architecture / code review and evaluation / technical writing and specification / context engineering / debugging and root cause analysis / domain knowledge / collaboration and communication | — | ch06 L268-276 |
| 2 | Pre-agentic value | `free text` (pre-printed, read-only) | The chapter's assessment, verbatim | — | ch06 L268-276 |
| 3 | Agentic value | `free text` (pre-printed, read-only) | The chapter's assessment, verbatim | — | ch06 L268-276 |
| 4 | Direction | `free text` (pre-printed, read-only) | Declining / declining for implementation, stable for design / increasing / sharply increasing / new / stable, but harder | — | ch06 L268-276 |
| 5 | Our strength today | `1-5 scale`, anchors printed on the sheet | — | 1 nobody has it · 2 one person has it · 3 several have it, unevenly · 4 most of the team · 5 it is the team's routine standard | org |
| 6 | Required level under agentic delivery | `1-5 scale`, same anchors | — | The level this skill has to reach here, given our codebase and domain risk | org |
| 7 | Gap | `computed` | — | Displayed as a band — none / one step / two or more steps — never summed across rows | derived |
| 8 | Action | `select` — hire / train / accept | — | **Exactly one.** "Hire and train" is the answer that produces neither | ch06 L262 |
| 9 | Owner | `owner (named person)` | — | — | org |
| 10 | If `train`: which enablement track | `select` | — | Must resolve to a track in block F | derived |

**Block B — the redlined interview loop.**

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 11 | Screen for | `checkbox` per item + `free text` | Systems thinking / technical communication in writing, not just verbally / evaluation skill on code the candidate did not write / comfort with ambiguity / learning velocity | Which of these our loop actually tests today, and at which stage | ch06 L284 |
| 12 | Stop requiring | `checkbox` per item + `date` | Whiteboard algorithm implementation / syntax trivia / memorised API knowledge | Which are still in our loop, and the date each comes out | ch06 L286 |
| 13 | Review exercise | `free text` + `owner (named person)` + `date` | Give candidates agent-generated code with subtle defects; evaluate how they identify and explain the problems | Who builds it, which of our own real defects it is built from, and by when | ch06 L288 |
| 14 | Specification exercise | `free text` + `owner (named person)` + `date` | Give candidates an ambiguous requirement; evaluate how they decompose it into a clear, implementable specification | Who builds it, from which of our own ambiguous requirements, and by when | ch06 L288 |
| 15 | Loop sign-off | `signature` + `date` | — | The hiring manager **and** the recruiting partner. Without the second signature nothing changes in the pipeline | derived |

**Block C — the retention risk register.** Two rows pre-printed, extendable. Not for general
circulation: it names people.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 16 | Risk | `select` (2 pre-printed) | Senior engineers who feel deskilled / junior engineers who feel replaceable | Additional rows if the organisation has others | ch06 L294, L296 |
| 17 | Named individuals at risk | `owner (named person)` (list) | — | Actual names. A count is not a register | ch06 L294-296 |
| 18 | The conversation we owe them, and who has it | `free text` + `owner (named person)` | For seniors, the chapter's framing: their judgement is more valuable than ever, the *form* of the contribution changes, and context engineering and architectural guidance are expressions of the same expertise. For juniors: the growth path, evidenced by block D | Our words, and the named person who says them | ch06 L294-296 |
| 19 | By when | `date` | — | — | org |
| 20 | Signal we will watch | `free text` | — | What we would see if this were going wrong | org |

**Block D — the junior development pathway.** Three model rows, fixed, under a disclaimer band.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 21 | Model | `select` (fixed 3) | A: review-intensive apprenticeship / B: agent-assisted learning with scaffolded complexity / C: specification-first roles | — | ch06 L250-254 |
| 22 | The chapter's named risk for this model | `free text` (pre-printed, read-only) | A: can feel passive; requires disciplined senior oversight and deliberate hands-on assignments. B: without structure, juniors accept agent output uncritically — the scaffolding must actually exist. C: delays hands-on coding experience; some skills require building things, not just specifying them | — | ch06 L250-254 |
| 23 | Our mix, by quarter | `free text` (four cells, Q1-Q4) | — | The allocation across A, B and C and how the proportions shift as capability grows | ch06 L256 |
| 24 | Supervising senior | `owner (named person)` | — | Named, per selected model | org |
| 25 | Our mitigating control for column 22 | `free text` | — | The specific thing we will do so the named risk does not land | org |
| 26 | Competency measure we will report back | `free text` | — | **Mandatory on every selected model.** What we will measure, and to whom we report it | ch06 L248 |
| 27 | Disclaimer band | `free text` (pre-printed, read-only, printed across the head of block D) | *"Informed hypotheses, not proven patterns. No organisation has run any of these models for a full cycle — 12+ months — with measured outcomes on engineer competency development."* | — | ch06 L248 |

**Block E — the team composition target.** Four profile rows, fixed, plus the path-mix block.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 28 | Team profile | `select` (fixed 4) | Typical team size / senior-to-junior ratio / context engineering allocation / review time allocation | — | ch06 L308-311 |
| 29 | The book's pre-agentic figure | `free text` (pre-printed, read-only) | 6-10 engineers / 1:2 to 1:3 / 0% / 15-20% of team capacity | — | ch06 L308-311 |
| 30 | The book's agentic (mature) figure † | `free text` (pre-printed, read-only) | 4-7 engineers † / 1:1 to 2:1 † / 10-20% of team capacity † / 25-35% of team capacity † | — | ch06 L308-311 |
| 31 | Dagger footnote and caveats | `free text` (pre-printed, read-only, printed beneath column 30 on every row) | *"† Projected figures are based on early adopter reports and the author's observations, not longitudinal studies. Pre-agentic figures reflect established industry norms."* Plus the chapter's two caveats: these are directional, not prescriptive — a payments team under strict regulatory requirements needs a higher senior ratio than a team building internal tooling — and smaller does not mean fewer total engineers | — | ch06 L315, L319-321 |
| 32 | Our figure today | `free text` | — | Blank, in a cell physically separate from column 30 | org |
| 33 | Our 24-month target | `free text` | — | Ours, written by us | org |
| 34 | Gap | `free text` | — | — | derived |
| 35 | Path mix | `free text` (three cells) | A: hire senior, hold junior headcount / B: accelerate high-potential juniors / C: attrit and rebalance | Our allocation across the three; most organisations combine all three | ch06 L327-331 |
| 36 | Assumed attrition rate | `free text` | — | Ours. Paths B and C depend on attrition nobody controls, so the assumption is written down where it can later be checked | ch06 L327-331 |
| 37 | Assumed hiring pace | `free text` | — | Ours | ch06 L327-331 |
| 38 | Senior mentoring load accepted for path B | `free text` | The chapter's estimate, printed with its hedge: *typically around 10-15% of their time, based on early adopter estimates* | Our figure, in the adjacent cell | ch06 L329 |
| 39 | Ratio tracking cadence and owner | `free text` + `owner (named person)` | Quarterly | The named person who does the tracking | ch06 L333 |

**Block F — the enablement tracks.** Five rows, fixed.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 40 | Track | `select` (fixed 5) | Senior engineers and tech leads: context engineering and failure-mode recognition / mid-level developers: delegation scoping and calibrated trust / junior developers: review before generation / engineering managers: measurement and coaching / architects and staff engineers: making architecture agent-legible | — | ch08 L188-200 |
| 41 | Named people in it | `owner (named person)` (list) | — | Every engineer appears in exactly one track | org |
| 42 | Sequence relative to the phase roadmap | `free text` | The chapter fixes two points: the senior and tech-lead track is the highest-priority training investment, and the junior track's review-before-generation ordering is a safety measure, not a preference | Our ordering for the other three | ch08 L190, L194 |
| 43 | Delivery mechanism | `free text` | — | Workshop, pairing, cohort, external — named | org |
| 44 | Owner | `owner (named person)` | — | — | org |
| 45 | Budgeted hours | `free text` | — | Hours per participant, and whose budget they come from | org |

**Block G — the three attention levers.** Three rows, fixed.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 46 | Lever | `select` (fixed 3) | Progressive disclosure / subagent isolation / plan-write-then-reload | — | ch15 L78-98 |
| 47 | Current state | `select` — absent / ad hoc / standardised / enforced by tooling | — | Scored by someone who runs agents daily | ch15 L78-98 |
| 48 | The practice that would evidence the next level | `free text` | — | Concrete and observable — a skill with an activation predicate, a child thread with its own brief, a re-read plan file | ch15 L78-98 |
| 49 | Enablement needed | `select` — training / template / harness feature | — | — | ch15 L78-98 |
| 50 | Owner and target date | `owner (named person)` + `date` | — | — | org |

**Absorbed detail.** All four absorbed members are carried, each as its own block, and none is
reduced to a line of prose. `WS-06-junior-pipeline-design` is block D: the three models are
column 21, the per-quarter mix is column 23, the supervising senior is column 24, the chapter's
named risk per model is column 22 pre-printed rather than left to be remembered, our mitigating
control is column 25, and the measurement commitment it insisted on is column 26 — mandatory,
because the chapter's own condition for using these models is that pilots measure and share.
`WS-06-staffing-ratio-target` is block E: its four profile rows are column 28, today / target /
gap are columns 32-34, and the path-selection block with its explicit assumed inputs is columns
35-38, with the quarterly tracking commitment at column 39.
`WS-08-skill-development-tracks` is block F: five tracks, named people, sequence, delivery
mechanism, owner and budgeted hours, columns 40-45.
`WS-15-attention-lever-adoption-plan` is block G: the three levers, the four-state current
score, the evidencing practice, the enablement needed and an owner with a date, columns 46-50 —
and its output, the enablement backlog, is the set of rows in block G whose column 49 is filled
plus the `train` rows in block A column 10.

**Deliberate omission — a ratio that belongs to a different sheet.** The book carries a 3:1
figure, but it is a **generation-to-review** ratio in ch08 L152 and L234, not a senior-to-junior
ratio, and it sits in that chapter's metrics section rather than in anything absorbed here. The
disclaimer that accompanies it there — *"these are starting benchmarks based on the author's
observation of early adopter teams, not industry-validated thresholds"* — attaches to that
ratio and not to block E's figures. It is therefore **not** printed on this sheet. Block E's
figures are the senior-to-junior ratio (1:2 to 1:3 moving to 1:1 to 2:1) and the time-allocation
split (context engineering 0% to 10-20%, review 15-20% to 25-35%), and the disclaimer that
belongs to them is ch06's dagger footnote at L315, which is what column 31 prints. Carrying
ch08's sentence here would attach a real disclaimer to the wrong number, which is a subtler
version of the failure this kit exists to avoid.

**Deliberate omission.** No composite score, no aggregate readiness percentage, no weighted
skill index. Column 7 is a band per row and is never summed: a two-step gap in context
engineering and a two-step surplus in syntax fluency are not cancelling quantities, and a
single number would let the room report the average and act on nothing.

## 6. Absorbed members (4)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-06-junior-pipeline-design` - Junior Development Pathway — Model Mix and Measurement

- **Address.** `handbook\ch06-team-structures.qmd` L246-258, The Junior Pipeline (`#sec-team-junior-pipeline`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** A first-year plan per junior cohort: allocate a percentage across Model A review-intensive apprenticeship, Model B agent-assisted learning with scaffolded complexity, and Model C specification-first roles, with the mix shifting by quarter. For each selected model, name the supervising senior, write the named risk the chapter attaches to it, and define the mitigating control and the competency measure that will be reported back.
- **Its output was.** A written junior development pathway with a stated model mix, named supervisors, and an explicit measurement commitment — plus the growth-path narrative managers can give juniors who are asking whether they are replaceable.

### `WS-06-staffing-ratio-target` - Team Composition Target and the Path to Get There

- **Address.** `handbook\ch06-team-structures.qmd` L302-335, Staffing Models (`#sec-team-staffing-models`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Four rows from the chapter table (typical team size, senior-to-junior ratio, context engineering allocation, review time allocation). Per row: our number today, our 24-month target, and the gap. Then a path selection block — allocate a percentage across Path A hire senior, Path B accelerate high-potential juniors, Path C attrit and rebalance — with the assumed attrition rate, hiring pace, and the senior mentoring load (the chapter estimates 10-15% of senior time for Path B) written down as explicit inputs.
- **Its output was.** A defensible headcount and seniority-mix plan with a named path mix, a 12-24 month horizon, and a quarterly ratio-tracking commitment — the artifact that goes to Finance and HR.

### `WS-08-skill-development-tracks` - Role-Based Enablement Plan — Five Tracks, Named People

- **Address.** `handbook\ch08-planning-the-transition.qmd` L188-200, Skill Development Paths (`#sec-transition-skill-paths`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Five track rows (senior engineers and tech leads: context engineering and failure-mode recognition; mid-level developers: delegation scoping and calibrated trust; junior developers: review before generation; engineering managers: measurement and coaching; architects and staff engineers: making architecture agent-legible). Per track: the named people in it, the sequence relative to the phase roadmap, the delivery mechanism, the owner, and the budgeted hours.
- **Its output was.** A role-based enablement plan with named participants and dated delivery, sized and budgeted — the answer to the mandate-without-infrastructure pitfall.

### `WS-15-attention-lever-adoption-plan` - Three Levers: Team Capability Assessment and Enablement Plan

- **Address.** `handbook\ch15-attention-and-context-economy.qmd` L78-98, Three levers of the attention economy (`#sec-attention-three-levers`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** For each of the three levers - progressive disclosure, subagent isolation, plan-write-then-reload - the team scores current state (Absent / Ad hoc / Standardised / Enforced by tooling), names the concrete practice that would evidence the next level, identifies the enablement needed (training, template, harness feature), and assigns an owner and a target date.
- **Its output was.** A three-lever capability baseline plus an enablement backlog - the training and tooling line items of the transformation plan.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- None. This sheet can be filled cold.

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** WS-06-skill-gap-and-hiring-bar (the train rows become curriculum) and the hiring-plan line of WS-06-staffing-ratio-target.

## 8. Facilitation

| | |
|---|---|
| Who fills it | The engineering leader with their line managers. **HR must be physically in the room** for blocks B, C and E: block B redlines a live interview loop, block C names individuals at retention risk, and block E is a headcount and seniority plan that goes to HR and Finance whether or not they were consulted. Bring the recruiting partner for block B — without their signature at column 15 nothing changes in the actual pipeline. Block G needs one practitioner who runs agents daily; a leadership-only room scores all three levers a grade too high. Security, legal and compliance are not needed on this sheet. |
| When in the session | Pack F, first sheet. It has no hard prerequisites and can be filled cold, but blocks D and E read better after `WS-06-role-map-and-staffing-triggers` where that is already done. Run the blocks strictly in order A → B → C → D → E → F → G: block A column 10 pushes into block F, and a room that opens block F first will build a training plan for skills it has not yet decided to train. |
| Duration | Block A 45 minutes; B 30; C 30; D 45; E 45-60 and it usually needs a follow-up with Finance; F 30; G 20. Roughly four hours in total, which is two sittings, not one. Split A + B + G into the first and C + D + E + F into the second, so the confidential material sits together. |
| Data needed in advance | Current headcount by level; the last twelve months of attrition by level; the live interview loop written out stage by stage; the current enablement or training budget and whose line it sits on; an honest answer to "is anyone doing context engineering today, and who"; two or three real examples of subtly defective agent-generated code from our own repository, for column 13; and a practitioner's candid read on block G. |
| Room format | A3 booklet, four sides. **Block C is not printed for general distribution, not projected and not photographed** — it names people, and a retention register that leaks is a retention event. Blocks A and G can be pre-filled individually and reconciled in the room; blocks B, D and E cannot, because the disagreement is the work. |

**Facilitation note carried from ch06 and ch08.** The disclaimers on this sheet are not ornament;
they are the reason it is safe to print at all. Before block E opens, say plainly that the
figures in column 30 are projections from early-adopter reports and the author's observations
rather than longitudinal studies, that the chapter calls them directional and not prescriptive,
and that a payments team under strict regulatory requirements will land on a different ratio
from a team building internal tooling. Then keep our numbers in columns 32-33 and the book's in
column 30, visibly apart, because the failure mode is not disagreement — it is transcription.

Block D carries the stronger disclaimer, and it should be read aloud: no organisation has run
any of the three junior-pathway models for a full twelve-month cycle with measured outcomes on
competency development. That is exactly why column 26 is mandatory rather than optional; the
chapter asks pilots to measure and share, and a pathway chosen without a measurement commitment
is an untested hypothesis with juniors' careers inside it.

Finally, do not let block C be treated as the soft block. The chapter's argument is not
sentiment — *the seniors of 2030 are the juniors you invest in today* (ch06 L296) — and of all
seven blocks on this booklet, block C has the longest payback and the shortest window.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All nine skill rows carry a current strength, a required level and exactly one action.**
   One of hire, train or accept — never two. A row marked "hire and train" is a row where the
   decision was avoided, and it reliably produces neither.
2. **Every `train` row resolves to a named track in block F, and every block F track has named
   people and budgeted hours.** A track with a delivery mechanism and no hours is the
   mandate-without-infrastructure pitfall in printed form; a `train` action with no track behind
   it is the same failure one column earlier.
3. **Block B is redlined in both directions.** At least one of the two exercises is built, owned
   and dated, **and** every "stop requiring" item is either confirmed absent from our loop or
   carries the date it comes out. A loop that only adds is a longer loop, not a revised one, and
   column 15 needs the recruiting partner's signature as well as the hiring manager's.
4. **Block C names individuals, not counts.** Both printed risks are populated with real names,
   a named person to hold each conversation and a date — or explicitly assessed as not present,
   with the evidence for that assessment written down. "We don't think that's an issue here" is
   not evidence.
5. **Every figure printed from the book in blocks D and E appears with its disclaimer attached
   on the artefact** — the dagger footnote and both caveats beneath column 30, the
   no-full-cycle disclaimer across the head of block D — and our own numbers appear only in
   columns 32, 33, 36, 37 and 38, in cells physically separate from the book's. A copy
   circulated with the figures and without the bands is not this sheet.
6. **Block D's mix accounts for the whole of each quarter, names a supervising senior for every
   selected model, and has column 26 filled.** The chapter's condition for using these models at
   all is that the organisation measures the outcome; a pathway with no competency measure fails
   this criterion even if every other cell is complete.
7. **Block E states its assumptions.** A path mix, an assumed attrition rate and an assumed
   hiring pace, all written down, plus a named owner and cadence at column 39. A 24-month target
   with no stated attrition assumption cannot be reviewed against reality later — which is the
   only mechanism by which anyone would ever discover it was wrong.

## 10. Integrity constraint

**Named rule for this sheet.** The senior-to-junior ratio and the time-allocation split print with their dagger footnote text attached, plus ch06's disclaimer that no org has run the junior-pathway models for a full 12-month cycle.

**Hedged figures reachable from this source range.** Each is listed with the book's own hedge, verbatim, and where that hedge lives. Present the figure as a pre-filled prior the organisation overwrites, or as a facilitation prompt - never as a benchmark, target or acceptance threshold. **Carry the hedge onto the sheet with the number; do not restate it in your own words.**

- **Team size 6-10 -> 4-7; senior-to-junior 1:2-1:3 -> 1:1-2:1; context allocation 0 -> 10-20%; review 15-20% -> 25-35%. NOTE: there is no 3:1 senior-to-junior ratio in this book -- 3:1 is the generation-to-review ratio in ch08, a different metric in a different chapter.**
  - *Appears at* `handbook\ch06-team-structures.qmd` L304-318
  - *The book's hedge (ch06 L315):* † Projected figures are based on early adopter reports and the author's observations, not longitudinal studies.
- **The senior-mentorship load for Path B (around 10-15% of senior time).**
  - *Appears at* `handbook\ch06-team-structures.qmd` L323-335
  - *The book's hedge (ch06 L329):* 'based on early adopter estimates'. The book also states no organisation has run these junior-pathway models for a full 12-month cycle.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** Carried unchanged from _section-clusters.md section 7 for CL-SKILLS-STAFFING.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Already a structured 9-row table (266-276) so authoring load is low. Hiring Implications (280-288, anchor hiring-implications) and Retention Risks (290-298, anchor retention-risks) supply the two attached blocks — they are prose and need converting into fillable form. Retention risk is the genuinely underserved half: the chapter names two named risks but gives no instrument, so that block is close to net-new authoring. Note for the synthesizer: two retention risks map straight onto the Cultural readiness dimension in WS-08-team-readiness-matrix.
