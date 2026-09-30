# Team Readiness Scorecard — Eight Dimensions, Scored Honestly

`WS-06-team-readiness-scorecard` &middot; **Pack A - Groundwork (pre-work)** &middot; fill order **3** &middot; type `assessment` &middot; audience **eng-leader** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A per-team scorecard with the 1-2 scoring dimensions flagged as blockers that must be closed before that team touches agent work, and a quarterly reassessment date.

**Cluster.** `CL-TEAM-READINESS` - Team Readiness Assessment

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch06-team-structures.qmd` |
| Chapter | Team Structures for AI-Augmented Delivery |
| Heading | Team Assessment Worksheet |
| Stable anchor | `#sec-team-assessment` |
| Lines | L339-354 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch06-team-structures.html#sec-team-assessment> |
| Locator quote | "Use this worksheet to evaluate your current team structure against the patterns described" |

Resolve at any time with `python docs/resolve.py ws WS-06-team-readiness-scorecard`.

## 3. Source extract - the scaffolding, verbatim

```text
  339 | Use this worksheet to evaluate your current team structure against the patterns described in this chapter. Score each dimension honestly. The purpose is to identify specific gaps that need attention, not to generate an overall grade.
  340 | 
  341 | ::: {tbl-colwidths="[16,42,10,32]"}
  342 | 
  343 | | Dimension | Question | Score (1-5) | Notes |
  344 | |---|---|---|---|
  345 | | **Knowledge explicitness** | What percentage of your team's working knowledge is documented vs. tribal? | ___ | 1 = almost all tribal; 5 = comprehensive docs |
  346 | | **Review capability** | Can your team review agent-generated code effectively — catching subtle architectural violations, not just syntax errors? | ___ | 1 = no experience; 5 = structured review process |
  347 | | **Specification discipline** | Do your team's work items contain enough detail for an agent to produce useful output without extensive clarification? | ___ | 1 = vague tickets; 5 = clear, scoped specs |
  348 | | **Senior presence** | Is there sufficient senior judgment to evaluate agent output on every critical path? | ___ | 1 = no senior coverage; 5 = senior review on all critical work |
  349 | | **Junior development** | Does your team have a structured path for juniors to build engineering skills in an agentic environment? | ___ | 1 = no plan; 5 = active apprenticeship models |
  350 | | **Context ownership** | Is someone accountable for the quality of your team's context layer — the instructions, conventions, and agent configurations? | ___ | 1 = nobody; 5 = explicit ownership with maintenance |
  351 | | **Feedback loops** | Does your team systematically capture agent failures and feed corrections back into the context layer? | ___ | 1 = no feedback loop; 5 = weekly context improvement cycle |
  352 | | **Psychological safety** | Can team members admit when agent-assisted work fails without blame? | ___ | 1 = blame culture; 5 = learning culture |
  353 | 
  354 | :::
```

## 4. What the user fills

Eight dimensions (knowledge explicitness, review capability, specification discipline, senior presence, junior development, context ownership, feedback loops, psychological safety), each scored 1-5 with the anchored descriptors already supplied, plus a free-text notes column. Run once per candidate team, not once per organization.

## 5. Field-level schema

Three panels. **Panel A** is one sheet *per candidate team*, nine dimension rows — the book's eight
plus one carried from ch08 (see below). **Panel B** is the single cross-team rollup, one row per
candidate team, and it is where sequencing and sponsorship are decided. **Panel C** is the
expertise-dependency register, one row per practice the organisation intends to adopt. Panel A is
one page per team, printed two-sided: the nine-row table on the front, the interpreting-results
bands and the posture strip on the back. Panel B is A3 landscape, one copy for the room.

**One scale, not two.** The eight book dimensions use the chapter's 1-5 scale with its anchored
descriptors. The absorbed ch08 matrix used a three-point scale over four dimensions; rather than
ask leaders to assess the same teams twice on incompatible scales, the three-point values are
printed as an equivalence key against the 1-5 scale, derived from the chapter's own bands
(1-2 blocks adoption, 3 works for pilot but will not scale, 4-5 ready — ch06 L358-362) which align
with ch08's not ready / partially ready / ready semantics (ch08 L57-66).

**Panel A — per-team scorecard.** One row per dimension, nine fixed rows, one sheet per team.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Dimension | `select` (fixed 9 rows) | Knowledge explicitness / Review capability / Specification discipline / Senior presence / Junior development / Context ownership / Feedback loops / Psychological safety, plus the carried row **Process readiness** | — | ch06 L345-352; row 9 ch08 L37-41 |
| 2 | Question | `free text` | Printed verbatim per row. Row 9 carries ch08's: "Does the team have structured workflows that can accommodate AI-generated code?" | — | ch06 L345-352; ch08 L37 |
| 3 | Score | `1-5 scale` | — | The mark | ch06 L343 |
| 4 | Anchor descriptors | `free text` | Printed verbatim per row — e.g. "1 = almost all tribal; 5 = comprehensive docs". Row 9 anchors written from ch08's three-point descriptors: 1 = ad hoc review, manual testing only; 3 = structured review exists, CI covers basics; 5 = automated quality gates, structured review, fast PR cycles | — | ch06 L345-352; ch08 L62-66 |
| 5 | Three-point equivalent | `computed` | Key printed on the sheet: 1-2 = Not Ready · 3 = Partially Ready · 4-5 = Ready | — | derived (ch06 L358-362 × ch08 L57-66) |
| 6 | Evidence | `free text` | The chapter's assessment questions printed as prompts against the mapped rows — e.g. "Is there a written architecture document a new hire could use?"; "What is the ratio of senior to junior developers?"; "How did the team respond to the last significant tooling change?" | The evidence behind the mark | ch08 L33, L41, L47, L53 |
| 7 | Blocker? | `checkbox` | Auto-ticked when column 3 is 1 or 2 | Confirm | ch06 L358 |
| 8 | Unblocks everything else | `checkbox` | Pre-ticked against **Knowledge explicitness** and **Senior presence** only | — | ch06 L358 |
| 9 | Remediation action | `free text` | — | Required wherever column 7 is ticked | ch06 L358 |
| 10 | Remediation owner | `owner (named person)` | — | A named individual | org |
| 11 | Target date | `date` | — | — | org |
| — | Reassessment date | `date` | Column note: reassess quarterly through the first year | The date | ch06 L366 |

**Panel A back page — adoption posture strip.** One block per team, not per dimension.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 12 | Position between the two failure poles | `1-5 scale` | Poles printed: 1 = autocomplete-only, "AI is just autocomplete" · 5 = delegate-everything, sophistication measured by share of code produced by AI. 3 = neither pole | The mark | ch10 L84, L136-138 |
| 13 | Under-adoption symptoms | `checkbox` set | Printed: still Tab-completing only · no written specification before dispatch | Tick what is true | ch10 L136 |
| 14 | Over-delegation symptoms | `checkbox` set | Printed: "we are making non-trivial corrections to more than 20-30% of an agent's output" (the chapter's own stop-signal, ch10 L146) · no category of work reserved for manual implementation | Tick what is true | ch10 L140-146 |
| 15 | Work reserved for manual implementation | `free text` | Prompt printed: the complex, the novel, the architecturally significant | The named categories this team commits to keep writing by hand | ch10 L138 |
| 16 | Posture remediation | `select` onboarding / reserved-manual-work policy / none needed | — | — | ch10 L138-146 |

**Panel B — cross-team rollup and sequencing.** One row per candidate team.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 17 | Team | `free text` | — | — | org |
| 18 | Team lead | `owner (named person)` | — | — | org |
| 19 | Knowledge explicitness score | `computed` from Panel A | — | — | ch06 L358 |
| 20 | Senior presence score | `computed` from Panel A | — | — | ch06 L358 |
| 21 | Dimensions scoring 1-2 | `computed` | — | Count, with the dimension names listed | ch06 L358 |
| 22 | Lowest-scoring dimension | `computed` | — | — | derived |
| 23 | Sequencing verdict | `select` pilot now / targeted investment first / start last | Rule printed: teams "ready" across all dimensions are pilot candidates; "partially ready" in one or two need targeted investment first; "not ready" in codebase or skill readiness start last | The verdict | ch08 L53 |
| 24 | The specific gap, if deferred | `free text` | — | Required whenever column 23 is not "pilot now" | ch08 L53 |
| 25 | Codebase maturity | `computed` from col 19 | Mapping printed: ch27's codebase maturity is Knowledge explicitness | — | ch27 L193 |
| 26 | Process discipline | `computed` from Panel A row 9 | Mapping printed | — | ch27 L193 |
| 27 | Cultural openness | `computed` from Panel A psychological safety | Mapping printed | — | ch27 L193 |
| 28 | Executive sponsor | `owner (named person)` | — | Required on the pilot row | ch27 L193 |
| 29 | Ring-fenced pilot budget | `currency` | — | The funded amount | ch27 L193 |
| 30 | Context-infrastructure ring-fence | `checkbox` + `signature` | Commitment text printed: the sponsor commits that the context-infrastructure line will not be cut ahead of other pilot spend — "it has the highest long-term return and the lowest short-term visibility, which means it is the one most likely to be cut" | Tick and sign | ch27 L193 |
| 31 | Wave | `select` pilot / wave 2 / later | — | — | ch08 L53 |

**Panel C — expertise dependency register.** One row per practice the organisation intends to adopt.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 32 | Practice to be adopted | `free text` | — | Drawn from the org's own adoption plan | index L148 |
| 33 | Do we have the tacit expertise? | `select` yes / partly / no | Anchor printed: someone who can recognise when an agent is drifting, when to push and when to intervene, and what good output looks like in this domain | The mark | index L148 |
| 34 | That person | `owner (named person)` | — | A name, or blank if the answer is `no` | index L148 |
| 35 | Gap action | `select` hire / coach / defer the practice | — | Required wherever column 33 is not `yes` | index L148 |
| 36 | Gap owner and date | `owner (named person)` + `date` | — | — | org |

**Absorbed detail.** `WS-08-team-readiness-matrix` supplies Panel A row 9 (process readiness — the
one ch08 dimension with no equivalent among the eight), the evidence prompts in column 6, the
three-point equivalence key in column 5, and Panel B's sequencing verdict and named-gap columns
(23-24), which are its stated output. `WS-10-adoption-posture-assessment` is the Panel A back-page
posture strip, columns 12-16, including its two failure poles, its four symptom tickboxes and its
reserved-manual-work commitment. `WS-27-pilot-team-rubric` is Panel B columns 25-31: its three
criteria are carried as computed mappings rather than re-scored, and its three unique fields — the
funding line, the named executive sponsor, and the explicit commitment to protect the
context-infrastructure investment — are columns 28, 29 and 30. `WS-FM-expertise-dependency` is
Panel C in its entirety.

**Deliberate omission.** There is no total, no average and no overall grade anywhere on this sheet.
The chapter states the purpose plainly: "to identify specific gaps that need attention, not to
generate an overall grade" (ch06 L339). A composite would also make the nine dimensions
substitutable, which they are not — a 5 on psychological safety does not offset a 1 on senior
presence. Panel B carries counts and named dimensions instead.

## 6. Absorbed members (4)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-08-team-readiness-matrix` - Team Readiness Matrix — Sequencing, Not Gating

- **Address.** `handbook\ch08-planning-the-transition.qmd` L25-67, Team Readiness Assessment (`#sec-transition-readiness`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** One row per candidate team in the organization. Four columns (codebase, process, skill, cultural), each marked not ready / partially ready / ready against the descriptors the chapter already supplies. Each cell is evidenced by answering the chapter's assessment questions in a notes field — for example: is there a written architecture document a new hire could use; does the team have automated quality gates beyond compilation; what is the senior-to-junior ratio; how did the team respond to the last significant tooling change.
- **Its output was.** A ranked sequencing list: which teams pilot, which need targeted investment in a named dimension first, and which start last — with the specific gap written next to each deferred team.

### `WS-10-adoption-posture-assessment` - Team Adoption Posture Assessment

- **Address.** `handbook\ch10-the-practitioners-mindset.qmd` L134-146, The Cost of Over-Reliance (`#sec-mindset-over-reliance`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Per team (or per engineer, anonymously): position on a scale between the two failure poles the chapter names — autocomplete-only use versus delegate-everything; ticked symptoms (still Tab-completing only, no written specification, correcting more than 20-30% of agent output, no category of work reserved for manual implementation); and the named categories of work the team commits to keep writing by hand.
- **Its output was.** A per-team posture score with a named remediation — onboarding for under-adopters, a reserved-manual-work policy for over-delegators.

### `WS-27-pilot-team-rubric` - Pilot Team Selection Scorecard

- **Address.** `handbook\ch27-what-comes-next.qmd` L193-195, For Leaders, Additionally (`#sec-next-first-week-leaders`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Candidate teams as rows; the three criteria named in the passage as scored columns - codebase maturity, process discipline, cultural openness - plus a funding line, a named executive sponsor, and an explicit commitment to protect the context-infrastructure investment from being cut.
- **Its output was.** A scored shortlist naming one pilot team, its sponsor, and its ring-fenced budget.

### `WS-FM-expertise-dependency` - Expertise Dependency Check

- **Address.** `index.qmd` L148-148, A Note on Methodology (`#sec-preface-methodology`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** For each practice the org intends to adopt from the book, the team marks whether it has the tacit expertise the case studies quietly assume - someone who can recognise when an agent is drifting, when to push and when to intervene, and what good output looks like in that domain - and names that person, or records the gap as a hiring or coaching action.
- **Its output was.** A short register of practices the org cannot yet run unsupervised, with a named person or a named gap against each.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- None. This sheet can be filled cold.

**Consumed by:**

- `WS-08-pilot-selection-and-scope` - Pilot Selection and Scope Contract (Pack G - The plan we leave with, fill order 9)
- `WS-08-transition-roadmap` - The Transition Roadmap — Three Phases, Named Teams, Dated Gates (Pack G - The plan we leave with, fill order 5)

**Feeds into (prose, from the source scan).** WS-06-team-readiness-scorecard — this is the finer-grained input that determines which teams are pilot candidates and which need targeted investment first.

## 8. Facilitation

| | |
|---|---|
| Who fills it | Panel A: the team lead for each candidate team, with at least one senior engineer from that team who has actually reviewed agent-generated code — column 6 needs someone who can produce evidence, not an impression. Panel B: the engineering leader, with every team lead present, and the person who will become the executive sponsor physically in the room, because column 30 is a signature and an absent sponsor signs nothing. Panel C: the engineering leader with the architect. |
| When in the session | Pack A, fill order 3. The sheet has no hard prerequisite and can be filled cold, but a completed `WS-03-context-moat-asset-inventory` sharpens the knowledge-explicitness and context-ownership rows from opinion into a register count, so run it after Pack A's fill order 2 where the schedule allows. Panel B must come after every Panel A in scope — a sequencing decision made from three of five team sheets is a guess. |
| Duration | Panel A: 25-35 minutes per team, run in parallel if several teams are represented. Panel A's back page adds 10 minutes. Panel B: 30-40 minutes, and the argument is in columns 23 and 28, not in the scores. Panel C: 15 minutes. For a four-team assessment budget two hours end to end. |
| Data needed in advance | The list of candidate teams with headcount and seniority mix. The ch08 assessment questions issued as a pre-read one week out so leads arrive with answers rather than composing them live. The story of the last significant tooling change and how each team responded — column 6's cultural-readiness evidence is historical, and nobody recalls it accurately under time pressure. Whether a pilot budget exists and who controls it, so column 29 is a number rather than an aspiration. |
| Room format | **Panel A is scored privately by each team lead before anyone compares.** Scores inflate when they are written in front of the person who funds the team, and the chapter's whole instruction is to score honestly. Collect completed sheets, then project Panel B and fill it together. Panel A prints one page per team, two-sided, with the interpreting-results bands on the back. Panel B is A3 landscape, one copy, filled in the room. |

**Facilitation note.** The chapter names the pattern most rooms will produce: high marks on senior
presence and psychological safety, low marks on knowledge explicitness and context ownership
(ch06 L364). Say this *before* the scores are compared. It is normal, it reflects teams with strong
people and weak infrastructure, and naming it in advance stops a low knowledge-explicitness score
being read as a criticism of the team rather than a description of the codebase. Two further
handles worth using: the sheet is a sequencing tool, not a gate (ch08 L53) — no team is being
excluded, they are being ordered; and the chapter's own two unblock-everything dimensions are
pre-ticked in column 8, so a room that wants to remediate everything at once can be pointed at the
two rows that make the rest cheaper.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **There is one Panel A per candidate team, and no organisation-level composite exists anywhere**
   — no total, no average, no overall grade, on any panel. The chapter forbids it by name.
2. **Every dimension scoring 1 or 2 carries a remediation action, a named individual owner and a
   target date** (columns 9-11). A ticked blocker with an empty owner is the gap recorded twice
   rather than addressed.
3. **Knowledge explicitness and senior presence are scored on every team sheet, with evidence.**
   These are the two dimensions the chapter says unblock everything else; a blank in either makes
   the sequencing verdict on Panel B unsupportable.
4. **No score sits next to an empty column 6.** A score with no evidence is an opinion, and the
   sheet is re-run quarterly against the same evidence standard — an unevidenced 4 cannot be
   compared with next quarter's 3.
5. **Every Panel B verdict other than "pilot now" names the specific blocking dimension**
   (column 24), in the vocabulary of column 1, not as "not quite ready yet".
6. **Exactly one team is marked `pilot` on Panel B,** with a named executive sponsor, a currency
   figure in column 29, and column 30 ticked *and* signed. An unsigned ring-fence is the line item
   the chapter says is most likely to be cut.
7. **Reconciliation.** The team marked `pilot` is the same team named in
   `WS-08-pilot-selection-and-scope`, and appears in phase 1 of `WS-08-transition-roadmap`; every
   team marked `targeted investment first` appears in a later phase with its column 24 gap carried
   across verbatim. A team sequenced later on this sheet but scheduled in phase 1 of the roadmap is
   an unresolved conflict and blocks Pack G.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Carried unchanged from _section-clusters.md section 7 for CL-TEAM-READINESS.
- **Fill (the organisation completing it): `S`.** S - one sitting, data already in the room

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> ALREADY A WORKSHEET. This is the most production-ready instrument in Part II — a fillable table with blank score cells and anchored 1-5 descriptors, and it is literally titled Team Assessment Worksheet. Interpreting Results at 356-366 (anchor interpreting-results) supplies scoring bands (1-2 blocks adoption, 3 works for pilot but will not scale, 4-5 ready) and names knowledge explicitness plus senior presence as the two unblock-everything dimensions — that logic belongs on the worksheet back page. The four team properties in The 10x Team, Not the 10x Developer (lines 67-78, anchor the-10x-team-not-the-10x-developer) are the same construct at lower resolution; do not build a second worksheet from them. MAJOR DEDUPE: this overlaps WS-08-team-readiness-matrix (4 dimensions, 3-point scale). Codebase readiness maps to knowledge explicitness; skill readiness maps to review capability plus senior presence; cultural readiness maps to psychological safety. The synthesizer MUST merge these into ONE readiness instrument or the kit asks leaders to assess the same teams twice on incompatible scales.
