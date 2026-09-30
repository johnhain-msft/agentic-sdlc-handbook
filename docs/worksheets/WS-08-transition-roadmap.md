# The Transition Roadmap — Three Phases, Named Teams, Dated Gates

`WS-08-transition-roadmap` &middot; **Pack G - The plan we leave with** &middot; fill order **5** &middot; type `roadmap` &middot; audience **mixed** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A dated, team-named, three-phase transition roadmap with realistic durations calibrated to the organization's actual size and documentation maturity — the backbone artifact of the entire delivery.

**Cluster.** `CL-ROADMAP` - The Transition Roadmap: Phases, Gates, Waves and Tasks

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch08-planning-the-transition.qmd` |
| Chapter | Planning the Transition |
| Heading | Phased Adoption |
| Stable anchor | `#sec-transition-phases` |
| Lines | L72-184 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch08-planning-the-transition.html#sec-transition-phases> |
| Locator quote | "The transition from pilot to full adoption follows three phases." |

Resolve at any time with `python docs/resolve.py ws WS-08-transition-roadmap`.

## 3. Source extract - the scaffolding, verbatim

```text
   72 | The transition from pilot to full adoption follows three phases. Each phase has entry criteria, activities, expected duration, exit signals, and rollback criteria. Moving to the next phase before the exit signals are present is the single most common adoption mistake. Ignoring rollback signals is the second.
   73 | 
   74 | #### A note on timelines
   75 | 
   76 | The durations below are ranges, not fixed schedules. Two factors dominate how long each phase actually takes: organization size and documentation maturity. A 50-person startup with a well-documented codebase moves through Phase 1 in weeks. A 2,000-engineer enterprise with an oral-tradition codebase may need months for the same phase. The ranges below include scale guidance. Use your readiness assessment to calibrate.
   77 | 
   78 | ```{mermaid}
   79 | %%| fig-width: 4.5
   80 | %%| label: fig-transition-roadmap
   81 | %%| fig-cap: "Three-phase transition roadmap with exit signals and rollback triggers"
   82 | %%| fig-alt: "Top-to-bottom flowchart showing a three-phase agentic transition roadmap. Pre-Transition (Weeks 1-4) flows down to Phase 1 Pilot (1-2 teams, 1-5 months), which reaches a decision diamond 'Exit signals met?'. Yes leads to Phase 2 Expand (3-5 teams, 3-9 months); No leads to Rollback node 'High rejection/intervention' which loops back to Phase 1 via 'fix and retry'. Phase 2 reaches a second decision diamond 'Exit signals met?'. Yes leads to Phase 3 Scale (All teams, 6-24 months); No leads to Rollback node 'Coach dependency/divergence' which loops back to Phase 2 via 'shrink and reinforce'. Rollback nodes are red, phases progress from blue to orange to green."
   83 | flowchart TB
   84 |     PRE["<b>Pre-Transition</b><br/>Weeks 1–4"]
   85 |     P1["<b>Phase 1: Pilot</b><br/>1–2 teams · 1–5 months"]
   86 |     G1{"Exit signals met?"}
   87 |     P2["<b>Phase 2: Expand</b><br/>3–5 teams · 3–9 months"]
   88 |     G2{"Exit signals met?"}
   89 |     P3["<b>Phase 3: Scale</b><br/>All teams · 6–24 months"]
   90 |     RB1["ROLLBACK<br/>High rejection / intervention"]
   91 |     RB2["ROLLBACK<br/>Coach dependency / divergence"]
   92 | 
   93 |     PRE --> P1
   94 |     P1 --> G1
   95 |     G1 -->|"Yes"| P2
   96 |     G1 -->|"No"| RB1
   97 |     RB1 -->|"fix & retry"| P1
   98 |     P2 --> G2
   99 |     G2 -->|"Yes"| P3
  100 |     G2 -->|"No"| RB2
  101 |     RB2 -->|"shrink & reinforce"| P2
  102 | ```
  103 | 
  104 | > *Each phase has explicit exit signals and rollback criteria. Moving forward without meeting exit signals is the single most common adoption mistake.*
  105 | 
  106 | ### Phase 1: Pilot (1–5 months) {#sec-transition-phase-1-pilot}
  107 | 
  108 | *Typical duration: 1–3 months for orgs under 200 engineers; 3–5 months for 200–1,000; 4–6 months for 1,000+.*
  109 | 
  110 | **Scale factor: documentation maturity.** The single biggest driver of Phase 1 duration is how much working knowledge is already explicit. Building even a minimal context layer (project-level instructions, core conventions, architecture boundaries) is, based on early adopter experience, a 4–6 week effort for a team starting from zero documentation. That work happens *inside* Phase 1, not before it. If your readiness assessment flagged codebase readiness as "not ready" or "partially ready," plan for the longer end of the range.
  111 | 
  112 | **Objective.** Validate that agentic development produces reliable results on your codebase, with your team, under your governance model.
  113 | 
  114 | **Scope.** One or two teams. Select teams that scored "ready" in the readiness assessment. Limit scope to well-defined work: a new feature, a contained refactor, a test suite expansion, not a sprawling cross-cutting change. The goal is controlled conditions, not maximum impact.
  115 | 
  116 | **Activities.**
  117 | - Establish baseline measurements before the pilot begins. You cannot measure improvement without a starting point. Capture current cycle time, review rejection rate, defect rate, and developer satisfaction on the selected workstreams.
  118 | - Build the minimum viable context layer: project-level instructions, core coding conventions, architecture boundaries. Part III (Chapters 9–10) provides the methodology. For the pilot, you need enough context to prevent the most common agent failures, not a comprehensive instrumentation layer.
  119 | - Run the pilot with close observation. The goal is to learn, not to prove a point. Document what agents get right, what they get wrong, and what they can't do. Track human intervention points, every moment a developer had to correct, override, or redo agent output.
  120 | 
  121 | **Exit signals.** Move to Phase 2 when: (1) the pilot team has a documented context layer that improves agent output quality, (2) the team has a review workflow for agent-generated code that they trust, (3) you have baseline and pilot metrics for at least four weeks, and (4) the pilot team can articulate what worked and what other teams would need.
  122 | 
  123 | **Rollback criteria.** Pause or restructure Phase 1 if any of the following hold after six weeks of active piloting:
  124 | - **Review rejection rate exceeds 60%.** This is a starting threshold to calibrate; your baseline rejection rate should inform the actual trigger. Agents are producing output the team cannot trust. This is almost always a context quality problem. Pause generation work, invest in the context layer, and restart the pilot clock.
  125 | - **Human intervention rate is not declining week over week.** The first two weeks will be rough. In our experience, teams on well-scoped pilots see declining intervention by weeks 3–5. A flat or rising line means the team is fighting the tool, not learning from it. Diagnose whether the problem is context, skill, or tool fit before continuing.
  126 | - **Developer satisfaction drops below pre-pilot baseline.** If the people using the tools are less productive or less satisfied than before, the pilot is not validating; it is eroding trust. Stop, debrief, and determine whether the issue is remediable or fundamental.
  127 | 
  128 | The rollback process: revert affected teams to their pre-pilot workflow. Preserve all context assets and metrics; they are not wasted, they are diagnostic. Conduct a structured retrospective focused on *why* the signals triggered, not *who* is responsible. A failed pilot that produces clear lessons is more valuable than a limping pilot that produces ambiguous data.
  129 | 
  130 | **Common failure.** Declaring the pilot a success based on enthusiasm rather than evidence. "The team loves it" is a data point, not a conclusion. The exit signals are structural, not emotional.
  131 | 
  132 | ### Phase 2: Expand (3–9 months from project start)
  133 | 
  134 | *Typical duration of Phase 2 itself: 2–4 months for orgs under 200; 3–6 months for 200–1,000; 4–8 months for 1,000+.*
  135 | 
  136 | **Scale factor: coaching capacity.** The pilot-members-as-coaches model works at this scale, but it has a capacity cost. You are pulling senior engineers off delivery to teach. For organizations expanding to more than five teams, budget for dedicated enablement: a platform engineer, a developer experience lead, or a rotating coaching role. In our experience, the coaching model becomes strained beyond a 1:3 ratio (one coach to three expanding teams). Plan accordingly.
  137 | 
  138 | **Objective.** Extend adoption to additional teams while building the organizational infrastructure (shared context assets, governance processes, skill development) that the pilot didn't require at small scale.
  139 | 
  140 | **Scope.** Three to five additional teams, selected based on readiness. Include at least one team that scored "partially ready" in one dimension — this tests whether your support infrastructure works for teams that need preparation, not just well-positioned ones.
  141 | 
  142 | **Activities.**
  143 | - Pilot team members become internal coaches. Each expanding team should have access to someone who went through the pilot; the tacit knowledge from Phase 1 is the most valuable asset for Phase 2.
  144 | - Build shared context assets. The pilot team's context layer was project-specific. Now you need organizational context assets: shared coding standards, common architectural patterns, cross-project conventions. This is the context moat from Chapter 4, the compounding asset that makes every subsequent adoption cheaper.
  145 | - Establish governance processes for agent-generated code at organizational scale. The pilot used whatever review process the team already had. At this scale, you need explicit policies: what requires human review, what can be auto-merged with sufficient test coverage, how agent-generated changes are attributed. Chapter 5 provides the framework.
  146 | - Begin tracking organizational metrics, not just team metrics. The metrics section below specifies what to measure.
  147 | 
  148 | **Exit signals.** Move to Phase 3 when: (1) expanding teams are productive with agentic tools without daily support from pilot members, (2) shared context assets exist and have a responsible owner, (3) governance processes are documented and followed without enforcement, and (4) organizational metrics show a trend you can explain.
  149 | 
  150 | **Rollback criteria.** Scale back Phase 2 if:
  151 | - **More than half the expanding teams require daily coach intervention after four weeks.** The support infrastructure is not scaling. Either the shared context assets are insufficient, the governance processes are unclear, or the team selection was premature. Pause expansion, reinforce the infrastructure, and resume with fewer teams.
  152 | - **Organizational metrics diverge sharply from pilot metrics.** If the pilot showed a 3:1 generation-to-review ratio and expanding teams are at 1:1 or worse, the pilot conditions are not transferable. Investigate whether the gap is codebase-specific (different teams, different context needs) or structural (the pilot was a hero team on a friendly codebase).
  153 | - **Coach burnout.** If pilot team members are spending more than roughly a quarter to a third of their time coaching and their own delivery is suffering, you have a capacity problem, not an adoption problem. Either hire dedicated enablement or slow the expansion rate.
  154 | 
  155 | The rollback process: teams that are not self-sufficient revert to their pre-adoption workflow. Teams that are functioning well continue. Coaching resources concentrate on fewer teams. The goal is to shrink to a sustainable expansion rate, not to abandon the transition.
  156 | 
  157 | **Common failure.** Expanding too fast. The instinct after a successful pilot is to "accelerate the rollout." Every team added without readiness or support becomes a negative data point, and as most managers have observed, negative data points spread faster than positive ones.[^ch7-bad] A team that has a bad experience with agentic tools will resist for months. Three to five teams in Phase 2 is a deliberate constraint.
  158 | 
  159 | ### Phase 3: Scale (6–24 months from project start)
  160 | 
  161 | *Typical duration: 3–6 months for orgs under 200; 6–12 months for 200–1,000; 12–24 months for 1,000+.*
```

*(23 further lines in range; read the file for the remainder.)*

## 4. What the user fills

A wall-sized timeline. Per phase (Pilot 1-5 months, Expand 3-9 months, Scale 6-24 months): the named teams entering, the calendar window calibrated using the chapter's org-size bands (under 200 / 200-1000 / 1000+), the named scale factor for that phase (documentation maturity for Phase 1, coaching capacity for Phase 2, organizational breadth for Phase 3), the objective in one sentence, and the named phase owner. Coaching capacity is a hard input: the chapter caps the peer-coaching model at roughly 1 coach to 3 expanding teams.

## 5. Field-level schema

Rows are the five phase bands, preceded by a calibration header filled once and followed by two
absorbed blocks. The physical format is a wall-sized timeline: A0 or a taped wall, phases running
left to right, gates drawn as diamonds between them and the two rollback loops drawn as arrows
running backwards, exactly as @fig-transition-roadmap renders them. The final band has **no right
edge** — it runs off the paper. That is not a print error; ch08 L182 states Phase 3 has no
endpoint.

**Shared phase vocabulary.** These five labels are used verbatim and in this order on this sheet
and on `WS-08-transition-planning-checklist`, which is this same plan at task-level zoom. Neither
sheet may rename, merge or reorder them:

`Pre-Transition` · `Phase 1 — Pilot` · `Phase 2 — Expand` · `Phase 3 — Scale` · `Ongoing`
(ch08 L259, L269, L280, L292, L303)

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | **Calibration header** — Our org size band | `select` under 200 / 200–1,000 / 1,000+ | The three bands are the chapter's own | Tick one. Every duration on this sheet derives from it | ch08 L108, L134, L161 |
| 2 | **Calibration header** — Engineer count | `free text` | — | The actual number the band was read from | org |
| 3 | **Calibration header** — Documentation maturity | `select` Ready / Partially ready / Not ready | The chapter names this the single biggest driver of Phase 1 duration, and notes that building a minimum viable context layer from zero documentation is a 4–6 week effort *inside* Phase 1, not before it | Carried from `WS-06-team-readiness-scorecard`, not re-guessed here | ch08 L110 |
| 4 | **Calibration header** — Calibration recorded by | `owner (named person)` | — | The person who accepted or overrode the book's bands. Calibration is an act with a name on it | derived |
| 5 | **Calibration header** — Calibration date | `date` | — | — | derived |
| 6 | **Calibration header** — Baseline measurement status | `select` captured / in progress / not started | — | From `WS-08-baseline-measurement-plan`. While this reads anything other than `captured`, column 21 stays locked | ch08 L117 |
| 7 | **Calibration header** — Month 0 baseline capture date | `date` | — | The date the pre-pilot measurements were actually taken. No phase row may carry a calendar window until this cell is filled | ch08 L117 |
| 8 | **Phase band** — Phase | `select` (five fixed rows) | Pre-Transition · Phase 1 — Pilot · Phase 2 — Expand · Phase 3 — Scale · Ongoing | — | ch08 L259, L269, L280, L292, L303 |
| 9 | **Phase band** — The book's printed range | `computed`, locked | Weeks 1–4 · 1–5 months · 3–9 months from project start · 6–24 months from project start · no endpoint | — | ch08 L84-89 |
| 10 | **Phase band** — The book's band for *our* org size | `computed`, locked, driven by column 1 | Phase 1: 1–3 months under 200; 3–5 months 200–1,000; 4–6 months 1,000+. Phase 2 itself: 2–4 / 3–6 / 4–8 months. Phase 3: 3–6 / 6–12 / 12–24 months, with the chapter adding *at least 12 months* for 400+ engineers and 18–24 months for 1,000+ | — | ch08 L108, L134, L161, L163 |
| 11 | **Phase band** — Our planned duration | `free text`, range only | — | A range with a floor and a ceiling. The field rejects a single figure; ch08 L76 says the durations are ranges, not fixed schedules | ch08 L76 |
| 12 | **Phase band** — What moved us off the book's band, and why | `free text` | — | **Mandatory whenever column 11 differs from column 10, and mandatory whenever it does not.** "Adopted the book's band after discussion, because …" is a valid entry; a blank is not. A blank cell means the numbers were inherited by default, which is precisely what this column exists to catch | ch08 L76 |
| 13 | **Phase band** — Scale factor | `free text`, locked | Phase 1: documentation maturity · Phase 2: coaching capacity · Phase 3: organisational breadth | — | ch08 L110, L136, L163 |
| 14 | **Phase band** — Our reading of that scale factor | `H/M/L` | — | High means the factor will stretch this phase toward the top of our range | derived |
| 15 | **Phase band** — Objective, one sentence | `free text` | Phase 1: validate that agentic development produces reliable results on your codebase, with your team, under your governance model · Phase 2: extend adoption while building the organisational infrastructure the pilot didn't require at small scale · Phase 3: make agentic development the default working mode | Confirm verbatim or rewrite in our language | ch08 L112, L138, L166 |
| 16 | **Phase band** — Teams entering | `free text` | Phase 1: one or two teams scoring "ready" · Phase 2: three to five additional teams, including at least one that scored "partially ready" in one dimension · Phase 3: remaining teams, including those initially "not ready" that have since been prepared | Named teams, taken from `WS-06-team-readiness-scorecard` | ch08 L114, L140, L168 |
| 17 | **Phase band** — Team count | `computed` | — | Must sit inside the chapter's constraint, or column 12 carries the override. ch08 L157 calls three to five in Phase 2 "a deliberate constraint" | ch08 L114, L140, L157 |
| 18 | **Phase band** — Phase owner | `owner (named person)` | — | One named person per phase, including Ongoing | derived |
| 19 | **Phase band** — Coaching load | `computed` | The chapter reports the peer-coaching model becoming strained beyond roughly one coach to three expanding teams, and advises budgeting for dedicated enablement beyond five teams | Our coach count against our team count, and whether we exceed it | ch08 L136 |
| 20 | **Phase band** — Named coaches / enablement function | `free text` + `owner (named person)` | Phase 3 transitions from peer coaching to a dedicated enablement function with permanent named ownership | The actual people, or the actual function | ch08 L136, L169 |
| 21 | **Phase band** — Indicative calendar window | `date` range, marked PROVISIONAL | — | **Locked until column 6 reads `captured`.** Printed in a lighter weight than every other field, with "planning horizon, not a schedule" set beneath it | ch08 L76; ch04 L252 |
| 22 | **Phase band** — Gate at the end of this phase | `free text`, locked | "Exit signals met?" — the two decision diamonds between Phase 1/2 and Phase 2/3 | The gate card reference in `WS-08-phase-gate-exit-rollback`, and the named person who calls it | ch08 L86, L88 |
| 23 | **Phase band** — Rollback loop | `free text`, locked | Phase 1 → *High rejection / intervention* → fix and retry · Phase 2 → *Coach dependency / divergence* → shrink and reinforce | Confirm the loop is drawn on the wall, not just described | ch08 L90-101 |
| 24 | **Phase band** — Terminator | `select`, locked on the final band | Phase 3 has no endpoint; it is the steady state. The timeline ends in an **ongoing-capability band**, never a completion date | Name the capability we are becoming; the date field is absent by design | ch08 L182 |
| 25 | **Pre-Transition actions** — Action | `free text`, locked (six rows) | Audit current usage · Evaluate coding-phase tools · Establish governance baseline · Pilot agentic capabilities · Extend to adjacent phases · Full lifecycle strategy | — | ch02 L216-223 |
| 26 | **Pre-Transition actions** — The book's indicative timing | `computed`, locked | This week · This month · This quarter · Next quarter · 6–12 months · 12–18 months | — | ch02 L216-223 |
| 27 | **Pre-Transition actions** — What it requires | `free text`, locked | Survey engineering teams and catalogue tools in use · trial two or three options with a representative team · data residency policy, approved tool list, usage guidelines · one team, one workflow, measured before and after · Test, Review and Plan phase automation with structured context · platform selection, organisational context investment, governance maturity | — | ch02 L216-223 |
| 28 | **Pre-Transition actions** — Owner | `owner (named person)` | — | — | org |
| 29 | **Pre-Transition actions** — Committed date | `date` | — | A real date; these six sit inside the Weeks 1–4 band and are not baseline-gated | org |
| 30 | **Pre-Transition actions** — Budget | `currency` | The chapter states the first two rows require no budget, no procurement and no organisational change — only a decision to look | The figure, or an explicit zero | ch02 L225 |
| 31 | **Pre-Transition actions** — Prerequisites | `free text` | — | — | org |
| 32 | **Pre-Transition actions** — Exit criteria that unlock the next action | `free text` | — | What must be true before the next row starts | derived |
| 33 | **Wave slots inside Phase 1** — Slot | `select`, locked (four rows) | Wave 0: single-item pipeline test · Wave 1: the work with the most existing source material, lowest risk · Wave 2: the hardest work, requiring fresh effort · Wave 3: integration work depending on earlier waves | — | `case-study-handbook-writing.qmd` L124 |
| 34 | **Wave slots** — Our work item in this slot | `free text` | — | The team's own items, placed into the four documented slots | `case-study-handbook-writing.qmd` L124 |
| 35 | **Wave slots** — Why it belongs here | `free text` | — | The risk-ordering justification. Wave 0 is a pipeline test, deliberately not the most valuable work | `case-study-handbook-writing.qmd` L124 |
| 36 | **Wave slots** — Integration and polish pass | `checkbox` + `owner (named person)` | The case adds a final integration and polish pass after the four waves | Tick and name the owner | `case-study-handbook-writing.qmd` L118-124 |
| — | Footer legend | printed, non-editable | "This is a planning horizon, not a schedule." Set across the foot of the timeline in the same weight as the phase labels | — | ch04 L252; ch08 L76 |
| — | Calibration signature + date | `signature` | — | Signed by the person in column 4. The signature attests to the *calibration*, not to the dates | derived |

**Absorbed detail.** `WS-02-adoption-sequencing-roadmap` is columns 25–32: its six sequenced
actions are the Pre-Transition block printed as rows, and its owner / committed date / budget /
prerequisites / exit-criteria columns are 28, 29, 30, 31 and 32 respectively — nothing dropped.
`WS-CS-HB-wave-sequencing` is columns 33–36: its four labelled ordering slots become the wave
structure *inside* Phase 1, with the risk-ordering rubric printed in column 33 and the
justification forced in column 35, plus its integration-and-polish pass as column 36. Placing it
inside Phase 1 rather than across the whole timeline is deliberate: it is a scoping rubric for the
pilot's work items, not a second competing roadmap.

**Deliberate omission.** No milestone or deliverable column, and no percentage-complete column.
Task-level detail lives on `WS-08-transition-planning-checklist`, which is this sheet at the other
zoom level; duplicating it here guarantees the two drift, and a percentage-complete column on a
plan whose final band has no endpoint is meaningless by construction.

**Deliberate omission.** No single-date milestones anywhere. Column 21 is a range, provisional,
and locked behind baseline capture. A roadmap that can print a date before the organisation has
measured its own starting point produces gates that are deltas from nothing.

## 6. Absorbed members (2)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-02-adoption-sequencing-roadmap` - Transformation Sequencing Roadmap

- **Address.** `handbook\ch02-the-ai-native-landscape.qmd` L211-222, Inaction Is a Decision (`#sec-landscape-inaction`)
- **Why folded.** Shipping both would hand the organisation two competing plans, which its own note forbids; contributes the six near-term actions as the pre-Phase-1 block with owner / date / budget / exit-criteria columns.
- **Fill detail to absorb.** For each of the six sequenced actions (audit usage, evaluate coding-phase tools, establish governance baseline, pilot agentic capabilities, extend to adjacent phases, full lifecycle strategy): a named owner, a committed date, a budget figure, the prerequisites, and the exit criteria that unlock the next action.
- **Its output was.** The skeleton of the transformation plan itself - a dated, owned, gated sequence that every other worksheet in the kit populates. This is the artefact the organisation leaves the room holding.

### `WS-CS-HB-wave-sequencing` - Risk-Ordered Wave Sequencing Template

- **Address.** `case-study-handbook-writing.qmd` L124-126, Execution Timeline: Four Waves Plus Integration (`#sec-cs-handbook-timeline`)
- **Why folded.** Four labelled ordering slots rather than a sheet; contributes the risk-ordering rubric -- prove the pipeline, then lowest risk, then hardest, then integration -- as the canonical's sequencing rule.
- **Fill detail to absorb.** The team places its own work items into the four documented slots: Wave 0 = single-item pipeline test, Wave 1 = most existing source material / lowest risk, Wave 2 = hardest and requiring fresh work, Wave 3 = integration work depending on earlier waves. Plus an integration and polish pass.
- **Its output was.** A sequenced transformation roadmap where the first wave is deliberately a pipeline test, not the most valuable work.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-06-team-readiness-scorecard` - Team Readiness Scorecard — Eight Dimensions, Scored Honestly (Pack A - Groundwork (pre-work), fill order 3)

**Consumed by:**

- `WS-03-go-no-go-readiness-gate` - Go / No-Go Readiness Gate (Pack G - The plan we leave with, fill order 6)
- `WS-08-pitfall-risk-register` - Transition Risk Register — Six Predictable Failure Modes (Pack G - The plan we leave with, fill order 8)
- `WS-08-transition-planning-checklist` - The Transition Plan — Task-Level Checklist Across Five Blocks (Pack G - The plan we leave with, fill order 10)

**Feeds into (prose, from the source scan).** Everything downstream. WS-08-phase-gate-exit-rollback hangs the gates on it; WS-08-transition-planning-checklist is its task-level expansion; WS-06 and WS-07 staffing and budget milestones get dated onto it.

## 8. Facilitation

| | |
|---|---|
| Who fills it | The executive sponsor and the transition lead together, with the engineering managers of every candidate team. The sponsor owns the calibration header; the managers own columns 16 and 18. This is the one sheet in Pack G that cannot be filled by a subset of the room — a phase with an absent owner acquires one by default, and defaults do not turn up to gates. |
| When in the session | After `WS-06-team-readiness-scorecard`, and after `WS-18-plan-charter-and-principles` has established the principles that will settle the sequencing arguments. It is the fifth sheet in Pack G and the pivot of the whole pack: `WS-03-go-no-go-readiness-gate`, `WS-08-pitfall-risk-register` and `WS-08-transition-planning-checklist` all consume it. |
| Duration | 120 minutes, and it will want more. Budget 20 minutes for the calibration header alone — column 1, column 3 and column 12 are where the session earns its value, and the room will try to move past them quickly. Allow 60 minutes for the five phase bands, 25 for the Pre-Transition actions and 15 for the wave slots. |
| Data needed in advance | The completed `WS-06-team-readiness-scorecard` for every candidate team, including the documentation-maturity dimension; the actual engineer headcount; the status of `WS-08-baseline-measurement-plan` and, if captured, the Month 0 date; the current names and workloads of anyone who could coach; the organisation's existing planning calendar, so the provisional windows can be sanity-checked against known freezes and commitments. |
| Room format | Wall-sized. A0 sheet or a taped-off wall, phases left to right, gate diamonds and rollback arrows drawn in, teams on movable cards so they can be shifted between phases during the argument. Print the "planning horizon, not a schedule" legend on the wall **before** the session starts, not after. The final band is drawn running off the right edge of the paper. |

**Facilitation note.** The calibration header is the session, and the room will treat it as
admin. Slow down there. Ask the question in the form the chapter puts it: *a 50-person startup
with a well-documented codebase moves through Phase 1 in weeks; a 2,000-engineer enterprise with
an oral-tradition codebase may need months for the same phase* — which of those are we, honestly?
Then force column 12 on every row, including the rows where the room is adopting the book's band
unchanged. Writing "we accepted 3–5 months because our documentation scored Partially ready"
takes ten seconds and converts an inherited number into a decision with a name on it. Do not let
column 21 be filled if column 6 does not read `captured`; a roadmap with dates and no baseline
produces gates that are deltas from nothing, and the room will defend those dates for a year.
Finally, refuse the request — and it will come — to put an end date on the final band.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **The calibration header is complete and signed.** Columns 1, 2, 3, 4 and 5 are filled, and the
   signature attests to the calibration rather than to the dates. An unsigned header means nobody
   owns the choice of duration band.
2. **Column 12 is filled on every phase band, including the bands where the book's range was
   adopted unchanged.** This is the criterion that distinguishes a calibrated plan from a copied
   one. A 1,000+ engineer organisation carrying a 1–3 month Phase 1 with a blank column 12 fails
   this sheet outright.
3. **Every duration in column 11 is a range, and every range is consistent with the org-size band
   in column 1** — or carries an explicit written override in column 12. No single-figure
   durations anywhere.
4. **No calendar window appears in column 21 unless column 6 reads `captured` and column 7 carries
   a date.** Until `WS-08-baseline-measurement-plan` is complete, this sheet ships with column 21
   struck through. Gates are deltas from a baseline; dates against no baseline are decoration.
5. **The final band terminates in an ongoing capability, not a date.** Column 24 names what the
   organisation is becoming, there is no end date on the Phase 3 or Ongoing band, and the timeline
   is drawn running off the edge of the sheet.
6. **Every phase band has a named individual in column 18, and Phase 2's coaching load in column
   19 is either inside the roughly one-to-three ratio or carries a funded enablement line.** A
   Phase 2 with five expanding teams and one coach is a plan to burn out the pilot team.
7. **The phase labels are byte-identical to those on `WS-08-transition-planning-checklist`**, and
   every one of the thirty-six tasks on that sheet maps to exactly one band here. The two sheets
   are the same plan at two zoom levels; if a reader has to translate between them, they have
   drifted and one of them is wrong.
8. **The six Pre-Transition actions all carry an owner and a committed date**, and the first two
   carry a budget of zero or an explicit figure — the chapter is specific that auditing usage and
   evaluating tools require no budget and no procurement, so a figure there invites challenge.
9. **The gate references in column 22 resolve to real cards in `WS-08-phase-gate-exit-rollback`**,
   and each names the person who calls that gate. A gate on the timeline with no card behind it is
   a diamond, not a decision.

## 10. Integrity constraint

**Named rule for this sheet.** ch04's and ch08's gate thresholds are deltas from a baseline and are not dateable until WS-08-baseline-measurement-plan is complete. Printed values are calibration starting points.

**Hedged figures reachable from this source range.** Each is listed with the book's own hedge, verbatim, and where that hedge lives. Present the figure as a pre-filled prior the organisation overwrites, or as a facilitation prompt - never as a benchmark, target or acceptance threshold. **Carry the hedge onto the sheet with the number; do not restate it in your own words.**

- **The rollback trigger at a review rejection rate above 60%.**
  - *Appears at* `handbook\ch08-planning-the-transition.qmd` L120-130
  - *The book's hedge (ch08 L124):* 'This is a starting threshold to calibrate; your baseline rejection rate should inform the actual trigger.'
- **The programme kill criterion at fewer than 40% of participating teams showing improvement.**
  - *Appears at* `handbook\ch08-planning-the-transition.qmd` L176-184
  - *The book's hedge (ch08 L180):* '(a suggested threshold; adjust based on your organization's risk tolerance)'

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Carried unchanged from _section-clusters.md section 7 for CL-ROADMAP.
- **Fill (the organisation completing it): `L`.** L - needs the real repository, finance input or cross-team agreement

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> THIS IS THE SPINE. Chapter 8 already proposes the full structure — three phases, each with entry criteria, activities, expected duration, exit signals, and rollback criteria, plus a mermaid roadmap at lines 80-104 (fig-transition-roadmap) that renders the phases, the gate diamonds, and the two rollback loops. Book content is genuinely strong and needs adaptation, not authoring. The single most important calibration the worksheet must force: the durations are ranges, not schedules, and the chapter names documentation maturity and org size as the two dominant factors — a kit that lets a 2000-engineer enterprise copy the 1-3 month Phase 1 number has done active harm. Phase 3 has no endpoint by design (it is the steady state), so the roadmap must end in an ongoing-capability band, not a completion date. Sub-anchors: phase-1-pilot-15-months (106), phase-2-expand-39-months-from-project-start (132), phase-3-scale-624-months-from-project-start (159).
