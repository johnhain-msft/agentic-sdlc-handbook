# The Plan Charter: Scope, Teams, Waves, Principles, Constraints

`WS-18-plan-charter-and-principles` &middot; **Pack G - The plan we leave with** &middot; fill order **1** &middot; type `canvas` &middot; audience **mixed** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** An approved plan charter - and, more durably, the org's written priority order for resolving trade-offs, which is reusable across every subsequent change.

**Cluster.** `CL-PLAN-CHARTER` - Plan Charter: Scope, Principles, Tie-Breakers and Process Tier

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch18-the-execution-meta-process.qmd` |
| Chapter | The Execution Meta-Process |
| Heading | Phase 2: Plan |
| Stable anchor | `#sec-meta-phase-2-plan` |
| Lines | L53-96 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch18-the-execution-meta-process.html#sec-meta-phase-2-plan> |
| Locator quote | "Transform audit findings into an executable specification: what changes, in what order" |

Resolve at any time with `python docs/resolve.py ws WS-18-plan-charter-and-principles`.

## 3. Source extract - the scaffolding, verbatim

```text
   53 | **Purpose.** Transform audit findings into an executable specification: what changes, in what order, by which agents, with what constraints.
   54 | 
   55 | **How it works.** You define the scope (what's in, what's out, what's deferred), the agent teams (which personas own which concerns), and the wave structure (dependency-ordered batches of work).[^ch13-conway] The plan includes principles — priority-ordered values that anchor every decision when trade-offs arise — and constraints — what must not change.
   56 | 
   57 | A well-structured plan looks like this:
   58 | 
   59 | ```yaml
   60 | Scope
   61 |   Auth resolver deduplication, verbose coverage gaps,
   62 |   CommandLogger migration, unicode cleanup.
   63 |   Out of scope: New auth providers, CLI help text changes.
   64 | 
   65 | Teams
   66 |   Architecture: python-architect leads.
   67 |     Owns: type safety, separation of concerns, dead code.
   68 |   Logging/UX: cli-logging-expert leads.
   69 |     Owns: verbose coverage, CommandLogger, symbols.
   70 | 
   71 | Waves
   72 |   Wave 0 (foundation): Protocol types, method moves — fully parallel.
   73 |   Wave 1 (core): Verbose coverage — depends on Wave 0 APIs.
   74 |   Wave 2 (migration): CommandLogger migration — depends on Wave 1 patterns.
   75 |   Wave 3 (polish): Unicode cleanup — depends on Wave 2 completeness.
   76 | 
   77 | Principles (priority order)
   78 |   1. SECURITY — no token leaks, no path traversal.
   79 |   2. CORRECTNESS — tests pass, behavior preserved.
   80 |   3. UX — first-class developer experience in every message.
   81 |   4. KISS — simplest correct solution.
   82 |   5. SHIP SPEED — favor shipping over perfection.
   83 | 
   84 | Constraints
   85 |   Do NOT modify test infrastructure.
   86 |   Do NOT change CLI command signatures.
   87 |   Do NOT alter public API return types.
   88 | ```
   89 | 
   90 | **The human decision.** You approve the plan. This is the highest-impact moment in the entire process.[^ch13-brooks] A mediocre plan with perfect execution produces mediocre software. A great plan with imperfect execution produces great software — because the test gates catch the imperfections. Take your time here. Review the wave dependencies. Question whether the scope is right. Ask whether the wave structure accounts for the files that will change in multiple phases.
   91 | 
   92 | **Key rule.** No implementation starts until you approve the plan. This is the single most important gate.
   93 | 
   94 | **Enabling capabilities.** Background exploration agents to validate planning assumptions: mapping dependency graphs, tracing call chains, verifying that the wave structure accounts for shared files. The planning itself is human judgment; the agents accelerate the information gathering that informs it.
   95 | 
   96 | **Output.** An approved plan with scope, teams, waves, principles, and constraints.
```

## 4. What the user fills

Five blocks, filled directly from the book's template. Scope: what is in, what is out, what is deferred. Teams: which persona owns which concern. Waves: dependency-ordered batches. Principles: the org's own priority-ordered value list (the book's example runs SECURITY > CORRECTNESS > UX > KISS > SHIP SPEED) - participants must rank, not just list. Constraints: the explicit do-NOT list. Signed off by the approver.

## 5. Field-level schema

Rows are the fields of an eight-block canvas. Blocks A–E reprint the chapter's own plan
template (ch18 L59-88) verbatim as the skeleton; blocks F–H carry the absorbed members. The
physical format is a wall canvas (A0 or a taped-off whiteboard), block-partitioned, with a
single approval strip at the foot — ch18 L90 calls plan approval "the highest-impact moment
in the entire process", so the charter is *approved*, not merely drafted.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | **A. Scope** — In scope | `free text` | Auth resolver deduplication, verbose coverage gaps, CommandLogger migration, unicode cleanup — printed in grey as a worked example, never as a starting list | The org's own change items | ch18 L60-62 |
| 2 | **A. Scope** — Out of scope | `free text` | New auth providers, CLI help text changes (worked example) | The org's own exclusions | ch18 L63 |
| 3 | **A. Scope** — Deferred, and the trigger that reopens it | `free text` | — | Items that are neither in nor out, plus the condition that pulls them in | ch18 L55 |
| 4 | **B. Teams** — Team name | `free text` | Architecture; Logging/UX (worked example) | The org's own team names | ch18 L66-69 |
| 5 | **B. Teams** — Lead persona | `free text` | python-architect; cli-logging-expert (worked example) | Which persona leads this team | ch18 L66, L68 |
| 6 | **B. Teams** — Owns (concerns) | `free text` | Type safety, separation of concerns, dead code; verbose coverage, CommandLogger, symbols | The concerns this team owns | ch18 L67, L69 |
| 7 | **B. Teams** — Accountable human | `owner (named person)` | — | A person, never a persona. The persona leads the work; the person answers for it | derived |
| 8 | **C. Waves** — Wave number | `select` 0…N | Wave 0 foundation / Wave 1 core / Wave 2 migration / Wave 3 polish | — | ch18 L72-75 |
| 9 | **C. Waves** — Wave content | `free text` | Protocol types and method moves; verbose coverage; CommandLogger migration; unicode cleanup (worked example) | The org's own batch of work | ch18 L72-75 |
| 10 | **C. Waves** — Depends on | `select` (an earlier wave, or `none`) | Wave 1 depends on Wave 0 APIs; Wave 2 on Wave 1 patterns; Wave 3 on Wave 2 completeness | The org's own dependency edge | ch18 L72-75 |
| 11 | **C. Waves** — Wave 0 is a pipeline test | `checkbox` | Pre-ticked. Wave 0 proves the pipeline on a single item before any valuable work is attempted | Confirm, or untick and write the override in column 12 | `case-study-handbook-writing.qmd` L124 |
| 12 | **C. Waves** — Risk-ordering rationale | `free text` | The ordering rule: prove the pipeline, then the work with the most existing material (lowest risk), then the hardest work requiring fresh effort, then integration work that depends on earlier waves | Why our order follows or departs from it | `case-study-handbook-writing.qmd` L124 |
| 13 | **C. Waves** — Files changing in more than one wave | `free text` | — | The shared files the chapter tells the approver to hunt for | ch18 L90 |
| 14 | **D. Principles** — Rank | `select` 1…N, no ties permitted | 1–5 in the worked example | A forced rank. Two principles may not share a rank | ch18 L77-82 |
| 15 | **D. Principles** — Principle, one sentence | `free text` | SECURITY (no token leaks, no path traversal) · CORRECTNESS (tests pass, behaviour preserved) · UX (first-class developer experience in every message) · KISS (simplest correct solution) · SHIP SPEED (favour shipping over perfection) — the book's worked list, printed in grey | The org's own three to five, in its own words | ch18 L78-82 |
| 16 | **D. Principles** — The tension it resolves | `free text` | — | Which two goods this principle arbitrates between | `case-study-handbook-writing.qmd` L250-256 |
| 17 | **D. Principles** — Worked example: one decision it settles | `free text` | "The book is 100% useful without APM. APM appears as proof, not prerequisite." — printed as the exemplar of a principle stated so that downstream decisions become mechanical | Our own worked example, for every principle | `case-study-handbook-writing.qmd` L254-256 |
| 18 | **D. Principles** — Who may amend it | `owner (named person)` | — | The single person who can change the rank order | `case-study-handbook-writing.qmd` L250-256 |
| 19 | **E. Constraints** — Constraint (Do NOT …) | `free text` | Do NOT modify test infrastructure · Do NOT change CLI command signatures · Do NOT alter public API return types (worked example) | The org's own do-NOT list | ch18 L84-87 |
| 20 | **E. Constraints** — Who may waive it, and by what route | `owner (named person)` + `free text` | — | A constraint with no named waiver route is either absolute or fiction; say which | derived |
| 21 | **F. Operating model** — Phase | `select` (five fixed rows) | Audit · Plan · Wave · Validate · Ship | — | ch18 L14-32 |
| 22 | **F. Operating model** — Human decision this phase requires | `free text` | Audit: which findings warrant action · Plan: approve the plan · Wave: dispatch, no decision · Validate: spot-check the sample, triage failures · Ship: final verification and merge | Confirm or adapt to our process | ch18 L30, L42, L90, L216-232 |
| 23 | **F. Operating model** — Named role who makes it | `owner (named person)` | — | A named person per phase | org |
| 24 | **F. Operating model** — Phase output | `free text` | Audit: a set of prioritised findings with citations · Plan: an approved plan with scope, teams, waves, principles and constraints | Confirm or adapt | ch18 L50, L96 |
| 25 | **F. Operating model** — Enabling capability: have / must build | `select` have / must build / partial | Audit: parallel background agents with session isolation and read-only access · Plan: background exploration agents for dependency graphs and call chains | Which we already have | ch18 L46, L94 |
| 26 | **F. Operating model** — Gate that exists today | `free text` | — | The gate actually enforced in our pipeline now, not the one we intend | org |
| 27 | **F. Operating model** — Readiness | `select` Ready / Partial / Absent | — | Honest rating. Every Absent needs an owner in column 23 | derived |
| 28 | **F. Operating model** — ADAPT: who may replan mid-execution | `owner (named person)` | The loop itself is printed: Validate → Adapt → Plan, and the chapter states the loop "is not a sign of failure" | The named person authorised to fire it | ch18 L24-32 |
| 29 | **G. Process tiering** — Tier | `select` (three fixed rows) | Small · Standard · Large | — | ch18 L276, L288 |
| 30 | **G. Process tiering** — Our trigger (file count or risk) | `free text` | The book anchors Small at "fewer than 10 files" and Large at "more than 100 files"; these are the author's working anchors, not our policy | Our own trigger, written in our terms | ch18 L276, L288 |
| 31 | **G. Process tiering** — What compresses, and what never does | `free text` | Small: audit becomes a single expert agent, plan becomes a mental model, one wave with 1–2 agents, Validate and Ship unchanged · Large: 4–6 audit agents, 6–10 waves, two-team structure, slack left in the wave structure for recovery waves | Our own compression per tier | ch18 L278-282, L290-294 |
| 32 | **G. Process tiering** — Approval required at this tier | `owner (named person)` | — | Who signs off at each tier | org |
| 33 | **G. Process tiering** — Non-negotiables at every tier | `checkbox` | Pre-ticked and not editable: test before committing; know what you are changing before you change it | Tick to acknowledge, not to choose | ch18 L284 |
| 34 | **H. Disclosure** — What we disclose about agent involvement | `free text` | — | The stance, written out | `case-study-handbook-writing.qmd` L266-274 |
| 35 | **H. Disclosure** — To whom | `select` (multi) customers / auditors / regulators / our own engineers | — | Tick each audience and note where the stance differs | `case-study-handbook-writing.qmd` L266-268 |
| 36 | **H. Disclosure** — Approved framing sentence | `free text` | "built using the same methodology it teaches" — never "AI-written" | Our own wording, approved verbatim | `case-study-handbook-writing.qmd` L272 |
| 37 | **H. Disclosure** — Credibility test and our answer | `free text` | "Could this person have written a credible book without AI? If yes, AI reads as methodology demonstration." | Our answer to the same question, about our own work | `case-study-handbook-writing.qmd` L270 |
| 38 | **H. Disclosure** — Expected objection + prepared answer | `free text` | Expected: initial scepticism from people who dismiss anything AI-assisted; engaged audiences find the transparency more impressive than the alternative | Our prepared answer, in the words we would actually use | `case-study-handbook-writing.qmd` L272-274 |
| — | Approver signature + date | `signature` | — | The person who approves the plan. ch18 L92: "No implementation starts until you approve the plan" | ch18 L90-92 |

**Absorbed detail.** `WS-18-five-phase-adoption-map` is block F in full: columns 21–27 are its
per-phase row (human decision, named role, output, enabling capability have-versus-build, today's
gate, readiness rating) and column 28 is its ADAPT-loop row. `WS-18-process-tiering-policy` is
block G: column 29 the three tiers, 30 the org's own trigger, 31 what compresses and what never
does, 32 the approval, 33 the invariant controls printed as non-editable ticks.
`WS-CS-HB-disclosure-stance` is block H: column 34 what we disclose, 35 to whom, 36 the framing
sentence, 37 the credibility test, 38 the expected objections. `WS-CS-HB-governing-principles` is
absorbed into block D rather than appended — columns 16 (the tension it resolves), 17 (one worked
decision it settles) and 18 (who may amend it) are its contribution, and they are the three
columns that turn a values poster into a tie-breaker register.

**Deliberate omission.** No effort, duration or date column anywhere on this canvas. The charter
is a scope-and-authority artefact; dates belong on `WS-08-transition-roadmap` and tasks on
`WS-08-transition-planning-checklist`. A charter that carries dates gets managed as a schedule
and stops being re-read when trade-offs arise, which is the one job it has.

## 6. Absorbed members (4)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-18-five-phase-adoption-map` - The Five-Phase Operating Model: Adoption Map

- **Address.** `handbook\ch18-the-execution-meta-process.qmd` L14-134, The Five Phases (`#sec-meta-five-phases`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** One row per phase - Audit, Plan, Wave, Validate, Ship. Columns: the human decision that phase requires, the named role who makes it, the phase output, the enabling capability we already have versus must build, the gate that exists today, and a readiness rating (Ready / Partial / Absent). A final row captures the ADAPT loop: who is authorised to replan mid-execution.
- **Its output was.** The org's declared agentic operating model with a readiness rating per phase - the spine of the transformation plan and its sequencing.

### `WS-18-process-tiering-policy` - Process Tiering: How Much Ceremony for How Much Change?

- **Address.** `handbook\ch18-the-execution-meta-process.qmd` L274-298, Adapting the Meta-Process (`#sec-meta-adapting`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Define three tiers against the org's own thresholds - small (compressed: audit is one agent, plan is a mental model, one wave), standard, and large (4-6 audit agents, 6-10 waves, two-team structure, slack left for recovery waves). For each tier record the file-count or risk trigger, which phases compress and which never do, the approval required, and the non-negotiables that hold at every tier (test before commit; know what you are changing before you change it).
- **Its output was.** A published process-tiering policy that prevents both over-ceremony on small changes and under-planning on large ones - with the invariant controls named explicitly.

### `WS-CS-HB-disclosure-stance` - Disclosure and Framing Stance for Agent-Produced Work

- **Address.** `case-study-handbook-writing.qmd` L266-274, The Authenticity Question (`#sec-cs-handbook-authenticity`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** The team decides and records: what we disclose about agent involvement, to whom (customers, auditors, regulators, our own engineers), the exact framing sentence we use, the credibility test we apply, and the expected objections with our prepared answers.
- **Its output was.** An agreed internal and external communications stance on agent-produced work, with an approved framing sentence.

### `WS-CS-HB-governing-principles` - Governing Principles and Tie-Breaker Register

- **Address.** `case-study-handbook-writing.qmd` L250-262, 4. Panel Disagreement on APM Prominence (`#sec-cs-handbook-panel-disagreement`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** The leadership team writes three to five governing principles in the case's single-sentence form, each stated so that it makes downstream decisions mechanical. For each principle: the tension it resolves, who may amend it, and one worked example of a decision it settles.
- **Its output was.** A short, quotable set of governing principles that resolves panel and reviewer deadlocks without escalating every one to an executive.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- None. This sheet can be filled cold.

**Consumed by:**

- `WS-18-wave-decomposition-plan` - Wave Decomposition Plan and Self-Sufficiency Check (Pack Z - Second wave: the practitioner kit, fill order 21)

**Feeds into (prose, from the source scan).** WS-18-wave-decomposition-plan (the Waves block expands into it) and WS-17-conflict-resolution-playbook (design conflicts resolve against the Principles block).

## 8. Facilitation

| | |
|---|---|
| Who fills it | The accountable engineering leader who will approve the plan, with the two or three people who own the concerns in block B and whoever currently signs off on scope. Blocks D and H need the executive in the room: ranking organisational values and agreeing a public disclosure stance are not delegable to a delivery lead. |
| When in the session | Opens Pack G. It has no prerequisites and is filled cold, which is deliberate — every later sheet in the pack resolves its trade-offs against block D, so the ranking must exist before the roadmap, the gates and the risk registers are drawn. |
| Duration | 90–120 minutes. Blocks A, B, C and E take about 40 minutes between them. Block D takes the rest, and should be allowed to: the argument *is* the deliverable. Blocks F, G and H can be pre-drafted and confirmed in the room if time is short. |
| Data needed in advance | The list of candidate work items with rough file counts (for block G's trigger); the current team and persona inventory; the existing approval routes for scope changes; any existing public statement the organisation has already made about AI-assisted work, so block H amends rather than contradicts it. |
| Room format | Wall canvas, blocks taped out in advance, sticky notes for blocks A–C so items can be moved between in / out / deferred without rewriting. Block D is run on a separate visible surface with the ranks numbered and the notes physically re-ordered, so the room watches the order change. |

**Facilitation note.** Run the block D ranking live, with disagreement surfaced rather than
smoothed. A principles list the room agrees with instantly has not been ranked — it has been
listed. Force the pairwise question: *when SHIP SPEED and CORRECTNESS conflict on a Friday
afternoon, which one wins?* Then make each principle earn column 17 by naming a real decision it
settles. A principle nobody can attach a worked decision to is a slogan and should be struck
before it reaches the wall. Block H is easy to skip and is the block most likely to be needed at
short notice; give it ten minutes even if the room thinks it is premature.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **Block D is forced-ranked with no ties.** Every principle holds a distinct integer rank in
   column 14. A charter with three joint-first principles has not resolved anything and will
   escalate every trade-off it was written to settle.
2. **Every principle carries a worked example in column 17.** An unexemplified principle has not
   been tested against a real decision, and will not survive its first contact with one.
3. **Blocks A-out and A-deferred are both non-empty.** A charter with nothing out of scope has not
   scoped; a charter with nothing deferred has not been honest about pressure it will face later.
   Each deferred item names the trigger that reopens it.
4. **Wave 0 is a pipeline test, or the tick in column 11 is cleared and the override is written
   into column 12.** Silently skipping it is the failure the ordering rule exists to prevent.
5. **Every one of the five rows in block F carries a readiness rating (column 27) and a named
   person (column 23), and every `Absent` rating has a named remediation owner.** An unrated phase
   is an untested assumption about our own process.
6. **Block G names our own trigger in column 30**, or records explicitly that we have adopted the
   book's file-count anchors as our policy after discussion. Inheriting them by default is the
   thing this column exists to catch.
7. **The approver has signed.** Per ch18 L92, no implementation starts until the plan is approved;
   an unsigned charter must not be carried forward into `WS-08-transition-roadmap`.
8. **The wave names in column 8 are the names used downstream.** When
   `WS-18-wave-decomposition-plan` is filled, its wave labels reconcile to this block without
   translation, and design conflicts routed to `WS-17-conflict-resolution-playbook` cite a rank
   from column 14 rather than an opinion.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Carried unchanged from _section-clusters.md section 7 for CL-PLAN-CHARTER.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> The priority-ordered principles block is the highest-value leadership content in the chapter and the reason this is a 1: it makes trade-offs resolve mechanically instead of by escalation, and ranking organisational values is an exec/leader act that cannot be delegated to a practitioner. The chapter names plan approval "the highest-impact moment in the entire process" (line 93) and argues at the same line that "A great plan with imperfect execution produces great software - because the test gates catch the imperfections." Already structured: the full YAML template is at lines 59-91 and can be reprinted as the worksheet skeleton. FACILITATION TIP: run the ranking exercise live with disagreement surfaced - a principles list everyone agrees with instantly has not been ranked. Note the plan is also the plan-memento artefact from ch15 lever three (footnote ch16-plan-memento: "The handoff packet... is the only artifact passed forward. No tacit context.").
