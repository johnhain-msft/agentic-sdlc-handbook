# Workload Triage Screen: Does This Work Belong in the Agentic Path?

`WS-27-workload-triage` &middot; **Pack B - Where we actually are** &middot; fill order **4** &middot; type `decision` &middot; audience **mixed** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A triage screen that keeps the pilot backlog free of work the methodology will handle worse than a human would.

**Cluster.** `CL-WORKLOAD-TRIAGE` - What Work Belongs in the Agentic Path

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch27-what-comes-next.qmd` |
| Chapter | What Comes Next |
| Heading | When NOT to Use Agentic Workflows |
| Stable anchor | `#sec-next-when-not-to-use` |
| Lines | L129-143 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch27-what-comes-next.html#sec-next-when-not-to-use> |
| Locator quote | "Not every task benefits from agent orchestration." |

Resolve at any time with `python docs/resolve.py ws WS-27-workload-triage`.

## 3. Source extract - the scaffolding, verbatim

```text
  129 | Not every task benefits from agent orchestration. Applying the methodology where it does not fit wastes time and produces worse outcomes than working manually. Recognize these scenarios early:
  130 | 
  131 | **The task requires fewer than 50 lines of change.** If you can hold the full scope in your head, the overhead of persona design, wave planning, and checkpoint discipline is not worth it. Just write the code.
  132 | 
  133 | **The domain knowledge is entirely implicit.** If the conventions, constraints, and trade-offs cannot be externalized into instruction files -- because they depend on political context, unwritten relationships, or organizational history that resists documentation -- agents will produce plausible but wrong output. Instrument the codebase first (Chapter 12), then apply agents.
  134 | 
  135 | **The cost of failure is low and iteration is cheap.** For throwaway scripts, prototyping, and exploratory work, a single agent prompt with no orchestration is faster and sufficient. The methodology exists for production-grade work where reliability matters.
  136 | 
  137 | **The work is inherently sequential and creative.** Naming things, choosing abstractions, defining API contracts -- these are judgment-dense tasks where agent suggestions help but orchestrated composition adds nothing. Use agents as sounding boards, not as orchestrated fleets.
  138 | 
  139 | **The platform fights automation.** The Growth Engine case study documents three automated approaches to Kit form automation, each hitting React's virtual DOM. When the platform's internals are undocumented and hostile to external manipulation, escalate to a human with a precise checklist rather than attempting a fourth approach.
  140 | 
  141 | The methodology's value is recognizing which category a task falls into before committing to an approach.
  142 | 
  143 | ---
```

## 4. What the user fills

A candidate work item is screened against the five documented exclusions - under ~50 lines of change, domain knowledge entirely implicit and not yet externalized, low failure cost with cheap iteration, inherently sequential and judgment-dense (naming, abstractions, API contracts), and the platform fights automation. Any hit routes the item out of the agentic path, to manual work or to instrumentation first.

## 5. Field-level schema

Two panels. **Panel A** is the screen itself: one row per candidate work item, run against a sample
of fifteen to twenty real backlog items. **Panel B** is the portfolio-fit rubric: four fixed rows,
one per work type, used once to choose the pilot domain. Panel A ships as a deck of cards — one
item per two-sided card — because the room sorts them into physical piles and the piles are the
output. Panel B is a single page.

**One screen, not two.** The chapter's five exclusions (ch27 L131-139) and the delegation decision
tree (ch10 `fig-agent-decision`) both take a single work item and return a routing. They are
therefore the same row, screened once: columns 3-7 are the exclusions, columns 8-10 are the gates.
An item that survives both is delegable.

**Panel A — the triage screen.** One row per candidate work item.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Work item ID and title | `free text` | — | From the real backlog | org |
| 2 | Selected how | `select` random / stratified / hand-picked | Recorded once for the sample, printed on the tally sheet | — | derived |
| 3 | Exclusion 1 — fewer than 50 lines of change? | `checkbox` | Test printed: "if you can hold the full scope in your head, the overhead of persona design, wave planning and checkpoint discipline is not worth it. Just write the code." | The tick | ch27 L131 |
| 4 | Exclusion 2 — domain knowledge entirely implicit? | `checkbox` | Test printed: conventions, constraints and trade-offs that cannot be externalised into instruction files because they depend on political context, unwritten relationships or organisational history. **Routes to instrumentation, not rejection.** | The tick | ch27 L133 |
| 5 | Exclusion 3 — failure cost low and iteration cheap? | `checkbox` | Test printed: throwaway scripts, prototyping, exploratory work — a single agent prompt with no orchestration is faster and sufficient | The tick | ch27 L135 |
| 6 | Exclusion 4 — inherently sequential and judgment-dense? | `checkbox` | Examples printed: naming things, choosing abstractions, defining API contracts. "Use agents as sounding boards, not as orchestrated fleets." | The tick | ch27 L137 |
| 7 | Exclusion 5 — the platform fights automation? | `checkbox` | Test printed: the platform's internals are undocumented and hostile to external manipulation; escalate to a human with a precise checklist rather than attempting a fourth approach | The tick | ch27 L139 |
| 8 | Gate A — can you specify it clearly in under two minutes? | `select` yes / no | Test printed: could you explain it to a new team member in two minutes and would they complete it with the right files and a style guide? | The mark | ch10 L88-120 |
| 9 | Gate B — is the spec shorter than the code? | `select` yes / no | Test printed: 200 words of instruction for 20 lines of judgment-dense code means you are faster writing it | The mark | ch10 L88-120 |
| 10 | Gate C — is the scope bounded? | `select` yes / no | — | The mark | ch10 L88-120 |
| 11 | Routing | `select` (4 values) | **Agentic now** · **Split** · **Instrument first** · **Keep manual**. Routing rules printed: any of exclusions 1, 3, 4 or 5 → Keep manual. Exclusion 2 → Instrument first. Gate A `no` with splittable parts → Split. Gate B or C `no` → Keep manual. All clear → Agentic now. | The routing | ch27 L131-139; ch10 L88-120 |
| 12 | Governing reason | `select` | The five exclusion names and the three gate names | Exactly one. An item routed out for two reasons records the one that decided it first. | ch27 L141 |
| 13 | If Instrument first — the primitive to write | `free text` | — | Which instruction file, memory file or skill, and the `WS-03` register row it becomes | ch27 L133; ch12 |
| 14 | If Split — the judgment part reserved for a human | `free text` | — | Named explicitly, not "the tricky bits" | ch10 L88-120 |
| 15 | Screened by, and date | `free text` + `date` | — | — | org |
| — | Delegable share of this sample | `computed` | Label printed: "**measured from this sample of N items — not a target, not a capacity claim, not a projection**" | Count routed Agentic now or Split, ÷ N, with N printed | derived |

**Panel B — portfolio fit.** One row per work type, four fixed rows, scored 0-3 on four questions.
The 0-3 scale is the absorbed member's; the anchors below are authored for this sheet so that two
people scoring separately mean the same thing.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 16 | Work type | `select` (fixed 4 rows) | Production codebase refactor · Editorial / composition work · Infrastructure automation · Non-engineering work | — | case study L10 |
| 17 | Do we have this at volume? | `0-3` | Anchors printed: **0** none · **1** occasional · **2** a steady stream · **3** a backlog we cannot clear | The mark | derived |
| 18 | Do we have a verification harness for it? | `0-3` | **0** none · **1** manual spot-check · **2** partial automated coverage · **3** automated gates we trust to block a bad change | The mark | derived |
| 19 | Do we have a named human orchestrator? | `0-3` | **0** nobody · **1** someone willing but unallocated · **2** named, partial time · **3** named, with protected time | The mark | derived |
| 20 | Is failure recoverable? | `0-3` | **0** production-irreversible · **1** recoverable via incident · **2** recoverable within a release cycle · **3** revert is trivial | The mark | derived |
| 21 | Total | `computed` | — | Sum of 17-20 | derived |
| 22 | Named orchestrator | `owner (named person)` | — | Required on the highest-scoring row | case study L10 |
| 23 | Verdict | `select` pilot domain / wave two / not now | Rule printed: highest-scoring row becomes the pilot domain, runner-up is recorded as wave two | The verdict | case study L10 |

**Absorbed detail.** `WS-10-delegation-boundary-triage` supplies Panel A columns 8-10 — the three
gates of the chapter's decision tree in order — the `Split` routing value in column 11, the
reserved-judgment column 14, the governing-reason column 12 drawn from its six named criteria, its
sample size of fifteen to twenty real backlog items, and its stated output, the measured delegable
share, as the computed row. `WS-CS-APM-portfolio-fit` is Panel B in its entirety: its four case
conditions as rows, its four 0-3 questions as columns 17-20, and its stated output — one named
pilot domain with the runner-up recorded as wave two — as columns 22-23.

**Deliberate omission.** No estimate of time or money saved per delegated item. This screen decides
*suitability*; value belongs to `WS-07-cost-vs-value-gate`, and a saving estimate written next to a
routing turns a triage decision into a business case nobody has reviewed. Also omitted: the
escalation procedure behind exclusion 5. The chapter's instruction is to escalate to a human with a
precise checklist; what that checklist contains and when autonomy is withdrawn is
`WS-17-escalation-autonomy-ladder`, which consumes this column rather than duplicating it.

## 6. Absorbed members (2)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-10-delegation-boundary-triage` - Delegation Boundary Triage

- **Address.** `handbook\ch10-the-practitioners-mindset.qmd` L86-130, When to Use Agents and When to Code Manually (`#sec-mindset-delegation-boundary`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Run 15-20 items from the real backlog through the chapter's decision tree, ticking each gate (can you specify it clearly in under two minutes? is the spec shorter than the code? is the scope bounded?) and recording the verdict — Delegate / Split / Manual — plus the governing reason drawn from the six named criteria.
- **Its output was.** A triaged backlog sample yielding a measured delegable percentage — the honest sizing input for any capacity, ROI or headcount claim made about the transformation.

### `WS-CS-APM-portfolio-fit` - Case Pattern Applicability Rubric: Which of the Four Conditions Is Ours?

- **Address.** `case-study-apm-overhaul.qmd` L10-10, Orchestrating a 75-File Architecture Change Across 25 Agents (`#sec-cs-apm-overview`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** For each of the four case conditions named in the passage (production codebase refactor, editorial/composition work, infrastructure automation, non-engineering work), the team scores 0-3 on: do we have this work type at volume, do we have a test/verification harness for it, do we have a named human orchestrator, and is failure recoverable. Highest-scoring row becomes the pilot domain.
- **Its output was.** A one-page scored comparison naming the single pilot domain for first groundbreaking, with the runner-up recorded as wave two.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- None. This sheet can be filled cold.

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** WS-27-workload-triage (which domain) and WS-17-escalation-autonomy-ladder (the platform-fights-automation exclusion becomes a stop rule)

## 8. Facilitation

| | |
|---|---|
| Who fills it | Panel A: the tech lead who owns the backlog, with at least one senior engineer who will actually run the agents. A practitioner must be present — an executive cannot screen a work item they have not read, and columns 3 and 9 require someone who knows roughly what the change involves. Panel B: the same pair, joined by the executive sponsor for that panel only, because column 23 chooses where the pilot lands and column 22 commits a person's protected time. |
| When in the session | Pack B, fill order 4 — last. It needs the room warmed by `WS-01-vibe-coding-cliff-diagnostic` (what goes wrong) and `WS-04-lifecycle-layer-coverage-canvas` (where we are), so that a `Keep manual` routing reads as sound judgement rather than as retreat. It needs nothing from `WS-02` or `WS-08` and can run even if that pre-work has not returned. |
| Duration | 60-75 minutes. Panel A runs at roughly 3-4 minutes per item once the room finds its rhythm — the first three take ten minutes between them and the rest go quickly — so fifteen to twenty items lands in 50-60 minutes. Panel B is 15 minutes. Do not extend Panel A to thirty items; the marginal item teaches nothing and the room's attention is the binding constraint. |
| Data needed in advance | A printed sample of fifteen to twenty real backlog items, one per card, **selected to be representative rather than convenient**. Not the easiest twenty, and specifically not the twenty somebody already wants to automate. Record the selection method in column 2 before the screening starts, not after the result is known. Enough detail on each card that columns 3 and 9 can be answered — a one-line ticket title is not screenable. |
| Room format | A deck of cards, one item per card, and four labelled piles on the table: Agentic now, Split, Instrument first, Keep manual. The piles are the artifact; the tally is written up from them afterwards. Physical sorting matters here more than on any other sheet in the kit, because the visible size of the Keep manual pile is what stops the room over-claiming. Panel B on a single page at the end. |

**Facilitation note.** Two things the room will get wrong. First, exclusion 2 routes to
**instrumentation**, not rejection — a room that treats it as a fifth way of saying no will exclude
precisely the work with the highest context payoff, which is the opposite of what the chapter says
("instrument the codebase first, then apply agents"). Say it before the first card is turned over,
and check column 13 is filled every time that pile grows. Second, the fifth exclusion has a worked
example: the Growth Engine case documents three automated approaches to the same form, each hitting
React's virtual DOM. Read it aloud when the room hits its first platform-fights-automation item —
the discipline being taught is stopping at three, not finding a fourth approach. Frame the whole
screen with the chapter's closing line: the value is recognising which category a task falls into
*before* committing to an approach, which means the items this screen rejects are its output just
as much as the ones it passes.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **At least fifteen real backlog items were screened,** each with a routing in column 11 and
   exactly one governing reason in column 12. An item routed out for three reasons with all three
   recorded tells you nothing about which test is doing the work.
2. **Every item routed `Instrument first` names the primitive to be written and the `WS-03`
   convention-register row it becomes** (column 13). Without it the route is a euphemism for
   rejection, and the work with the highest context payoff leaves the room as a `no`.
3. **Every item routed `Split` names the judgment part reserved for a human** (column 14),
   specifically enough that a second person could act on it. "The design bits" fails.
4. **The delegable share is printed with its denominator and its label intact** — measured from
   this sample of N — and appears nowhere else in the kit as a capacity, headcount or capability
   figure. If it is quoted in the business case, it is quoted with N and with the word *sample*.
5. **The selection method in column 2 is recorded, and the sample is not drawn exclusively from
   work the room already intended to automate.** A hand-picked sample is permissible and useful;
   an unlabelled hand-picked sample producing a high delegable share is not evidence.
6. **Panel B scores all four work types on all four questions,** names one pilot domain and one
   runner-up, and the pilot domain's orchestrator in column 22 is a named individual with protected
   time — a score of 3 on column 19 that nobody has actually scheduled is a 1.
7. **Reconciliation.** The pilot domain named on Panel B is work the pilot team on
   `WS-06-team-readiness-scorecard` Panel B actually owns. A pilot domain that no ready team owns,
   or a ready team with no scored domain, is an unresolved conflict and is settled before Pack G
   builds a roadmap on either.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Carried unchanged from _section-clusters.md section 7 for CL-WORKLOAD-TRIAGE.
- **Fill (the organisation completing it): `S`.** S - one sitting, data already in the room

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Five clearly enumerated, mutually distinct exclusion criteria with rationale for each - the cleanest bulleted-criteria-to-checklist conversion in any of my assigned files, and it needs no authoring. Leadership priority 1 because the fastest way to discredit a transformation in its first month is to point agents at work that was never suited to them. Note the second criterion routes to instrumentation (Chapter 12) rather than to rejection, so the screen needs three outcomes not two: agentic now, instrument first, keep manual. The fifth criterion cites the Growth Engine case directly, so WS-CS-GROWTH-stop-rule is its worked example.
