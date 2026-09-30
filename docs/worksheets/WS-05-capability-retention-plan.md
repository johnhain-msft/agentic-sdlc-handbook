# Capability Retention and Fallback Plan

`WS-05-capability-retention-plan` &middot; **Pack F - People and operating model** &middot; fill order **2** &middot; type `diagnostic` &middot; audience **eng-leader** &middot; leadership priority **2**

> **Split back out in the re-opening pass.** Not a register at all: a deliberate-practice programme plus a dated 48-hour agent-unavailability drill with scope and success criteria, which sets hiring and training budget.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A named deliberate-practice and fallback-drill plan with owners and a cadence - the mitigation the chapter says must be designed in rather than avoided.

**Cluster.** `CL-CAPABILITY-RETENTION` - Capability Retention, Deliberate Practice and the 48-Hour Drill

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch05-governance-for-ai-assisted-delivery.qmd` |
| Chapter | Governance for AI-Assisted Delivery |
| Heading | Knowledge atrophy: the aviation parallel |
| Stable anchor | `#sec-governance-knowledge-atrophy` |
| Lines | L131-141 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch05-governance-for-ai-assisted-delivery.html#sec-governance-knowledge-atrophy> |
| Locator quote | "This is the least discussed and most consequential long-term risk" |

Resolve at any time with `python docs/resolve.py ws WS-05-capability-retention-plan`.

## 3. Source extract - the scaffolding, verbatim

```text
  131 | This is the least discussed and most consequential long-term risk. When agents handle tasks that humans used to perform, humans get less practice at those tasks. Over months and years, the team's collective ability to perform those tasks without agent assistance erodes.
  132 | 
  133 | Knowledge atrophy is not hypothetical. It follows patterns well-documented in aviation and financial analysis. Airline pilots who rely on autopilot for routine flying are measurably less proficient at manual flying — a fact the industry addresses with mandatory manual-flying requirements. Financial analysts who rely on automated models are less able to identify model failures, which is why regulatory frameworks require human understanding, not just human approval.
  134 | 
  135 | In software development, the specific atrophy risks are:
  136 | 
  137 | - **Debugging skills.** If agents write the code and agents fix the bugs, junior engineers never develop the debugging intuition that comes from struggling with code they wrote themselves.
  138 | - **Architectural reasoning.** If agents make implementation decisions within provided constraints, engineers get less practice reasoning about trade-offs outside those constraints, the kind of reasoning required when the constraints themselves need to change.
  139 | - **Review depth.** If reviewers habitually approve agent-generated code that passes tests, the skill of deep code review (reading for intent, not just correctness) atrophies.
  140 | 
  141 | Knowledge atrophy does not produce failures in the short term. It produces an organization that cannot recover when agent assistance is unavailable, cannot evaluate whether agent output is correct in novel situations, and cannot train the next generation of engineers. The mitigation is not to avoid agents — it is to design deliberate practice into your development process, the way aviation designs manual-flying requirements into pilot training.
```

## 4. What the user fills

Three named atrophy risks (debugging skills, architectural reasoning, review depth). Per risk: which cohorts are exposed (juniors, a specific team, everyone), how we would detect the erosion today, the deliberate-practice mechanism we commit to (unassisted development exercises, architecture review rotation, constraint-design tasks in sprint work), who owns it, and the cadence. A separate block plans the 48-hour agent-unavailability drill: date, scope, success criteria and findings.

## 5. Field-level schema

A3 landscape, two sides. **Front — block A**, the atrophy register and the deliberate-practice
programme. **Back — block B**, the 48-hour drill: the plan above the fold, the findings below
it, printed blank and filled after the drill has actually happened. The aviation parallel from
ch05 L133 prints across the head of the front page, because it is the framing that lets the
room discuss erosion without anyone present feeling accused of it.

**Block A — atrophy risks and the practice programme.** One row per atrophy mode; three rows
pre-printed, extendable.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Atrophy risk | `select` (3 pre-printed, extendable) | Debugging skills / architectural reasoning / review depth | Additional modes if the organisation has them | ch05 L137-139 |
| 2 | The chapter's mechanism | `free text` (pre-printed, read-only) | The chapter's one-sentence account of how each erodes — agents write the code and fix the bugs; agents decide inside provided constraints; reviewers habitually approve output that passes tests | — | ch05 L137-139 |
| 3 | Cohorts exposed | `free text` | — | Juniors, a named team, or everyone — named, not categorised | ch05 L137-139 |
| 4 | How we would detect the erosion today | `free text` | — | The signal, and where it would surface. If the honest answer is "we would not", that is the entry | ch05 L141 |
| 5 | Detection status | `select` — we would detect it / we would not / not sure | — | `we would not` is a legitimate and common answer, and triggers an action in column 9 | ch05 L141 |
| 6 | Deliberate practice mechanism | `select` + `free text` | Regular unassisted development exercises / pair juniors with agent output for review practice / rotate architecture review responsibilities / include constraint-design tasks in sprint work | Our concrete instantiation: what the exercise is, on what code, run by whom | ch05 L114-115, L141 |
| 7 | Cadence | `free text` | — | A recurring commitment with a period. "Periodically" and "when we can" both fail this column | ch05 L133 |
| 8 | Protected time and where the hours come from | `free text` | — | The sprint capacity, budget line or rota slot this consumes. This is the column that decides whether any of it happens | derived |
| 9 | Owner | `owner (named person)` | — | — | org |
| 10 | Competency signal we will watch | `free text` | — | Qualitative: what we would observe if the practice were working. Not a score, and never attached to an individual | ch05 L141 |
| 11 | First session date | `date` | — | Booked, not intended | org |
| 12 | Risk-register row this closes | `free text` | — | The corresponding row of `WS-05-agent-risk-register` | ch05 L114-115 |

**Block B — the 48-hour agent-unavailability drill.** One drill, planned in the session and
closed out afterwards.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 13 | Drill date | `date` | — | Booked against the release calendar, not left as a quarter | ch05 L274 |
| 14 | Scope | `free text` | — | Which teams and which services are in the drill | ch05 L274 |
| 15 | What is withdrawn, precisely | `free text` | — | The named tools disabled — IDE completion, CLI agents, cloud coding agents — and the mechanism used to disable each | derived |
| 16 | What stays available | `free text` | — | The explicit list. A drill with no boundary stops being a drill | derived |
| 17 | Success criteria | `free text` | — | Written **before** the drill. The chapter's bar is that the team can sustain delivery | ch05 L274 |
| 18 | Fallback model configurations tested in the same window | `free text` | The register's model-outage mitigation names fallback configurations, graceful degradation to human-only execution, and quarterly fallback testing | Which configurations we test, and the result | ch05 L112 |
| 19 | Safety valve | `free text` + `owner (named person)` | — | Who can call the drill off, and on what condition. Mandatory | derived |
| 20 | Comms plan | `free text` | — | What on-call, stakeholders and any affected customers are told, and when | derived |
| 21 | Drill owner | `owner (named person)` | — | — | org |
| 22 | Findings | `free text` (filled after the drill) | — | What broke, what held, what surprised us | ch05 L274 |
| 23 | Actions arising | `free text` + `owner (named person)` + `date` | — | One line per action | derived |
| 24 | Next drill date | `date` | — | The chapter's fallback-testing cadence is quarterly | ch05 L112 |
| 25 | Signed | `signature` + `date` | — | The engineering leader signs the plan before the drill and the findings after. Two signatures, two dates | derived |

**Absorbed detail.** This sheet absorbed no other candidate, but it is the deliberately split
half of a pair: `WS-05-agent-risk-register` **scores** knowledge atrophy, and this sheet
**plans** it. Column 12 is the join, and it is load-bearing in both directions — no row here
exists without a register row, and no applicable atrophy row on the register is closed without
a row here. The two must be filled by the same people. Split across two owners, the register
records a risk nobody is mitigating and this sheet builds a programme against a risk nobody
scored.

**Deliberate omission.** No proficiency test, no scored assessment of individual engineers, no
numeric competency baseline, and no "percentage of code written unassisted" metric. The
chapter's parallel is aviation's *mandatory manual-flying requirement* — a practice obligation,
not a grading instrument — and a sheet that scored individuals would convert a development
programme into a performance process, which is the surest way to stop engineers admitting they
are rusty. Column 10 is a team-level signal watched by the owner, never a number held against a
person. An unassisted-code percentage is omitted for a blunter reason: it would be gamed inside
one sprint.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-05-agent-risk-register` - Agent Risk Register (Six Categories, Twelve Named Risks) (Pack E - Guardrails: authority, risk and proof, fill order 1)

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** WS-05-agent-risk-register (closes the knowledge-atrophy rows); hiring and graduate-programme planning

## 8. Facilitation

| | |
|---|---|
| Who fills it | The engineering leader with **the line managers who actually control sprint capacity** — column 8 is the only column that determines whether any of this happens, and nobody else can fill it. Bring the tech leads who would run the practice sessions, since column 6 is their week. **HR is worth having in the room** for the drill's framing and for column 10: a badly framed drill reads to engineers as a test of *them* rather than of the system, and HR will catch that wording before it is announced. Security, legal and compliance are not needed. |
| When in the session | Pack F, second sheet, after `WS-05-agent-risk-register`, which is a hard prerequisite — column 12 joins back to specific register rows, and filled first this sheet builds a programme against risks nobody has scored. The dependency runs the other way too: the register's knowledge-atrophy rows cannot be closed until this sheet exists, so Pack E is not signed off in isolation from it. |
| Duration | Block A, 60 minutes. Block B, 45. The drill *plan* is fast; the time goes into column 16 (what stays available) and column 19 (the safety valve), and a room that hurries past those two runs a drill that becomes an incident and is never repeated. |
| Data needed in advance | The completed risk register; current sprint capacity and who controls it; the inventory of agent tooling actually in use, with a note on how each could be disabled; the on-call rota for the candidate drill window; the release calendar, so the drill lands somewhere survivable; and whatever fallback model configuration exists today, for column 18. |
| Room format | A3 landscape, two-sided. The findings half of block B is deliberately left blank in the session and completed later by the drill owner — **print it anyway.** A visibly unfinished sheet on the wall is the only thing that keeps a booked drill from quietly slipping a quarter. |

**Facilitation note carried from ch05.** Print the aviation parallel at L133 across the head of
the sheet: pilots who rely on autopilot are measurably less proficient at manual flying, and the
industry's answer is a *mandatory requirement*, not an exhortation. It earns its space twice —
it makes the argument without implying anybody in the room is already deskilled, and it supplies
the design standard for column 7. Then hold the room to the chapter's closing line at L141: the
mitigation is not to avoid agents, it is to design deliberate practice **into** the development
process. A mechanism that lives outside the sprint, in a wiki, or in somebody's good intentions
has not been designed in.

Two evasions attract this block reliably. The first is *"we already do brown-bags"*, which is
not deliberate practice against a named atrophy mode. The second is *"our people are
experienced"*, which is the argument the chapter pre-empts at L141: atrophy produces no
short-term failures at all, and the organisation that discovers it does so at the worst possible
moment — when agent assistance is unavailable, when output must be judged in a novel situation,
or when the next generation needs training and nobody can teach them.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All three named atrophy risks carry a practice mechanism, a cadence with a period, a named
   owner and a booked first session date.** This is the sheet on which "we should" becomes "we
   will"; a mechanism with no date has not been scheduled, and a cadence of "periodically" is
   not a cadence.
2. **Every row names protected time and where the hours come from (column 8).** Deliberate
   practice that competes with delivery for unallocated capacity loses in the first busy sprint.
   A blank here is not an omission, it is a prediction.
3. **Column 4 is answered honestly, including where the answer is "we would not detect this
   today".** That entry is legitimate and common, and it must not be replaced with a hopeful
   one. Every row whose column 5 reads `we would not` carries a detection action with a named
   owner and a date.
4. **The sheet reconciles with `WS-05-agent-risk-register` in both directions.** Every row here
   names the register row it closes, and every knowledge-atrophy row scored applicable on the
   register appears here. A gap in either direction means the deliberate split between the two
   instruments has leaked.
5. **The drill has a booked date, a defined scope, an explicit list of what is withdrawn and
   what stays available, success criteria written before the drill, and a named person who can
   call it off.** A drill with no safety valve is an outage with a memo attached, and the
   organisation will not run a second one.
6. **The drill's success criteria are written in terms of sustaining delivery, not in terms of
   how individuals performed.** The unit under test is the organisation, per ch05 L141 and the
   chapter checklist at L274. Criteria that read as an assessment of people fail this sheet on
   its own terms and will corrupt column 10 as well.
7. **After the drill, the findings half is completed with actions, owners and dates, a next
   drill date is set, and both signatures are present.** Until that happens the sheet is
   explicitly incomplete and must not be presented as a closed mitigation for either the
   model-outage row or the knowledge-atrophy rows of the register.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** Three atrophy modes in prose with no fillable structure; the detection method, the practice mechanism and the 48-hour drill plan all need designing.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Scoped out of the risk register deliberately because this risk needs a plan, not a register row. The chapter calls it "the least discussed and most consequential long-term risk" (line 131) and gives three specific atrophy modes at lines 137-141 with no fillable structure, so it needs authoring. Pairs with chapter checklist items 9 and 10 (lines 273-274): design deliberate practice, and verify the team can sustain delivery with agents unavailable for 48 hours - the drill belongs on the same sheet. The drill also closes the Dependency and concentration / model outage row of the risk register (line 114). Priority 2: it shapes hiring and training budget, which a pre-groundbreaking exec conversation should touch, but it is not needed to produce the transformation plan itself.
