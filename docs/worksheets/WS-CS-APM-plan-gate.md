# Plan Gate and Scope-Change Protocol

`WS-CS-APM-plan-gate` &middot; **Pack Z - Second wave: the practitioner kit** &middot; fill order **17** &middot; type `decision` &middot; audience **eng-leader** &middot; leadership priority **2**

> **Split back out in the re-opening pass.** A governance policy with a named approval authority and a hard scope-change rule -- scope expands only through the gate, never mid-wave -- plus a reusable version/scope/trigger log; a written policy, not a column on a wave table.
>
> Ships as: `facing:WS-18-wave-decomposition-plan`

## 1. Purpose

**Output artifact.** A written plan-gate policy plus a reusable iteration log template.

**Cluster.** `CL-PLAN-GATE` - Plan Gate and Scope-Change Protocol

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `case-study-apm-overhaul.qmd` |
| Chapter | The APM Auth + Logging Overhaul |
| Heading | Eight Plan Iterations |
| Stable anchor | `#sec-cs-apm-plan-iterations` |
| Lines | L73-97 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/case-study-apm-overhaul.html#sec-cs-apm-plan-iterations> |
| Locator quote | "The plan went through eight iterations before approval. This is not a" |

Resolve at any time with `python docs/resolve.py ws WS-CS-APM-plan-gate`.

## 3. Source extract - the scaffolding, verbatim

```text
   73 | The plan went through eight iterations before approval. This is not a
   74 | failure — it is the meta-process working as designed (Ch13 §Plan).
   75 | 
   76 | | Version | Scope | Trigger |
   77 | |---------|-------|---------|
   78 | | v1 | 10 UX message fixes | Initial triage |
   79 | | v2 | Removed v0.8.2-only bug | User correction |
   80 | | v3 | Added auth gap as root cause | Expert panel findings |
   81 | | v4 | Unauth-first → auth-fallback | Architecture expert |
   82 | | v5 | Architecture-first, 4 phases | Orchestrator restructure |
   83 | | v6 | Added agent/skill primitives | Instrumented codebase needs |
   84 | | v7 | ALL commands covered | **User escalation (L4)** |
   85 | | v8 ✓ | 25 todos, 47 files, 5 phases | Approved |
   86 | 
   87 | Version 7 was the critical turn. The user rejected a plan scoped to
   88 | `install` only and demanded every command route through `AuthResolver` and
   89 | `CommandLogger`. The orchestrator dispatched three more **explore agents**
   90 | to audit all logging calls (766+), all auth touchpoints (95+), and
   91 | per-dependency auth paths. This is **Scope Creep** (Anti-pattern #5) —
   92 | but handled correctly. The scope expanded *before* execution began,
   93 | through the plan gate, not mid-wave.
   94 | 
   95 | The plan targeted 47 primary source files. The final PR touched 75 — the additional 28 were test files, configuration updates, and documentation changes discovered during execution. This is typical of dependency-following refactors.
   96 | 
   97 | ---
```

## 4. What the user fills

A blank version/scope/trigger log plus three policy fields the org must decide: who approves a plan version, what evidence must accompany a scope expansion, and the hard rule that scope expands only before execution begins (through the gate), never mid-wave.

## 5. Field-level schema

Two parts on one sheet. **Part A** is a policy block filled once per organisation — the rows are
policy fields. **Part B** is the iteration log, filled once per initiative — the rows are plan
versions, one per version, accruing over the life of the plan. Part B is issued as a live file in
the repository rather than a printed form, because it gains rows over weeks; Part A is printed,
signed and pinned.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| A1 | Plan gate approval authority | `owner (named person)` | — | The individual who approves a plan version | derived from cs-apm L85 "Approved" |
| A2 | Deputy when A1 is unavailable | `owner (named person)` | — | A second named individual; a gate with one name is a gate that closes on holiday | org |
| A3 | Evidence required for a scope expansion | `free text` | Worked instances: expert panel findings (v3), architecture expert review (v4), an audit by dispatched explore agents (v7) | The evidence classes this org will accept | cs-apm L80-81, L89-90 |
| A4 | The hard rule | `free text` (pre-printed, signed against) | "The scope expanded *before* execution began, through the plan gate, not mid-wave." | Countersignature only — this row is not editable | cs-apm L92-93 |
| A5 | What happens when scope changes are discovered mid-wave | `free text` | The ladder's L4 response: a follow-up task, raised for the next gate | The org's actual routing: who receives it, and where it waits | ch17 L349 via `WS-17-escalation-autonomy-ladder` |
| A6 | In-plan file classes | `free text` | Primary source files (the case planned 47) | Which file classes the org counts as planned scope | cs-apm L95 |
| A7 | Incidental file classes — discovery does not re-open the gate | `free text` | Test files, configuration updates, documentation changes (the case's additional 28) | The org's own list; anything not listed here re-opens the gate | cs-apm L95 |
| A8 | Policy sponsor signature + date | `signature` | — | The engineering leader who owns delivery | org |
| B1 | Version | `free text` | Shape only: `v1`, `v2`, … `v8 ✓` | — | cs-apm L78-85 |
| B2 | Date raised | `date` | — | — | org |
| B3 | Scope, one line | `free text` | Worked instances at cs-apm L78-85 shown as a calibration column on the reverse | The actual scope of this version | cs-apm L78-85 |
| B4 | Trigger | `select` | Initial triage / user correction / expert panel findings / architecture expert / orchestrator restructure / instrumented-codebase need / user escalation / approved | Add trigger classes the org meets that the case did not | cs-apm L78-85 |
| B5 | Escalation level, if any | `select` L1 / L2 / L3 / L4 / none | Pre-printed definitions from the ladder; the case's v7 is an L4 | Which level this version was raised at | ch17 L344-349 |
| B6 | Evidence attached | `free text` | — | The artefact itself, or a link to it; must satisfy A3 | org |
| B7 | Raised by | `owner (named person)` | — | — | org |
| B8 | Execution already begun? | `checkbox` | Pre-printed: a tick here means A4 has been breached and the change routes to A5 instead | Ticked honestly, not conveniently | cs-apm L92-93 |
| B9 | Gate decision | `select` approved / revise / rejected | — | — | cs-apm L85 |
| B10 | Approver | `owner (named person)` | — | Must be A1 or A2 | org |
| B11 | Decision date | `date` | — | — | org |
| — | Approved version in force | `computed` | — | The single row where B9 is `approved`; this is the version `WS-18-wave-decomposition-plan` waves | derived |

**Deliberate omission.** No iteration-count field, no target, no "versions to approval" metric. The
case took eight iterations and the chapter opens by saying so is *not a failure* — it is the
meta-process working as designed. A sheet that counts iterations teaches a team to minimise them,
which is the precise behaviour the passage argues against. Likewise no field records the ratio of
planned to actual files; A6 and A7 make the distinction qualitative, because the case's 47-to-75
spread is one refactor's shape, not a tolerance.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-17-escalation-autonomy-ladder` - Our Escalation and Autonomy Ladder (L1-L4) (Pack E - Guardrails: authority, risk and proof, fill order 6)

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** WS-18-wave-decomposition-plan (only an approved plan gets waved) and WS-17-escalation-autonomy-ladder (L4 is the gate re-opening)

## 8. Facilitation

| | |
|---|---|
| Who fills it | The engineering leader who owns delivery, the person who will orchestrate the pilot's waves, and whoever currently holds authority to change scope — usually a product owner or engineering manager. A1 must be agreed by the person who will actually be interrupted, in the room, not nominated in their absence. |
| When in the session | Opens Pack Z. It runs after `WS-17-escalation-autonomy-ladder` from Pack E, which supplies the L1-L4 vocabulary that B5 and A5 depend on, and it must close before `WS-18-wave-decomposition-plan` is attempted: only an approved plan gets waved, so a pack that reaches wave planning with no gate has nothing to wave. |
| Duration | 30-45 minutes. Part B is a blank form and takes five minutes to explain. The time goes on A1/A2 (naming a person who can be woken up), A3 (what counts as evidence) and A6/A7 — the in-plan versus incidental split is where the room argues, and the argument is worth having once rather than every wave. |
| Data needed in advance | The completed escalation and autonomy ladder, with each level's holder named. The organisation's existing change-approval path, however informal, written down before the session — the sheet is usually replacing something, and it helps to see what. If a pilot has already been chosen, its draft plan and current scope statement. |
| Room format | Part A projected and filled live on one page, then printed and signed before the room breaks. Part B is issued as a file in the pilot repository — a spreadsheet or a markdown table under version control — never as a printed form, because it accrues rows across the life of the plan and a printed log stops being filled the moment it leaves the wall. |

**Facilitation note carried from the source scan.** The load-bearing sentence is the distinction
between scope expanding *through the plan gate* and scope expanding *mid-wave* — the same expansion,
correctly or incorrectly handled. Read cs-apm L91-93 aloud before filling A4: the case study labels
its own v7 as Scope Creep, an anti-pattern, and then says it was handled correctly. Rooms find that
pairing counter-intuitive, and it is the whole policy. If the delivery includes a governance module,
promote this sheet to leadership priority 1 and run it in the pre-groundbreaking session instead.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **A1 and A2 are named individuals**, not a function, a committee or a role label, and both were
   present when the sheet was agreed. An approval authority the room nominated in absentia is not
   an authority; it is a queue with no server.
2. **A4 is countersigned unedited.** The hard rule — scope expands only before execution begins,
   through the gate, never mid-wave — is the one row on the sheet the organisation does not get to
   reword. If the room wants to soften it, that is a decision to record in A5, not a redraft of A4.
3. **A5 names a destination, not a principle.** "Raise it at the next gate" is incomplete: the sheet
   must say who receives a mid-wave discovery, where it waits, and what the running wave does in the
   meantime. Without that, the hard rule has no escape hatch and will be routed around.
4. **A6 and A7 together partition the repository's file classes with no gap.** Every file class is
   either in-plan or incidental. A class that appears in neither list will be argued about mid-wave,
   which is exactly the argument A4 forbids.
5. **Every Part B row carries a trigger (B4) and a named raiser (B7).** A version whose trigger reads
   "refinement" or "cleanup" has no source, and a log of unsourced versions cannot show whether the
   plan is converging or drifting.
6. **Exactly one Part B row is marked approved (B9), with an approver (B10) who is A1 or A2, and a
   date (B11).** That row is the version in force. An initiative that reaches wave planning with two
   approved rows, or none, has no plan of record.
7. **No B8 tick sits above an approved row.** Execution beginning before approval is the failure the
   sheet exists to catch; if it happened, the tick stays and the deviation is written down rather
   than tidied away.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Already a Version/Scope/Trigger table with a worked v1-v8 progression, so the blank form derives trivially; only the three policy fields are added.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Already structured as a Version/Scope/Trigger table with a worked v1-v8 progression, so the blank form is trivial to derive. The load-bearing sentence for the policy is the distinction between scope expanding through the plan gate versus mid-wave. Priority 2 rather than 1 because it governs execution of a chosen initiative rather than the decision to break ground - but promote to 1 if the delivery includes a governance module.
