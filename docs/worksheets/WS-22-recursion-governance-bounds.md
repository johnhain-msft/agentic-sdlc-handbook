# Bounding the Recursion: Eval, Plan Persistence and Depth Limits per Skill

`WS-22-recursion-governance-bounds` &middot; **Pack Z - Second wave: the practitioner kit** &middot; fill order **16** &middot; type `rubric` &middot; audience **architect** &middot; leadership priority **2**

> **Split back out in the re-opening pass.** Per-Skill quantitative bounds (returned artefact, eval, plan-persistence path and retention, max dispatch depth, compute ceiling); the topology standard bounds work classes, this bounds individual Skills, and no schema enforces it.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A per-Skill bound sheet making compute cost and audit reconstructibility explicit before any Skill is dispatched in anger.

**Cluster.** `CL-RECURSION-BOUNDS` - Per-Skill Recursion Bounds: Eval, Persistence, Depth, Ceiling

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch22-the-reference-architecture-earned.qmd` |
| Chapter | The Reference Architecture, Earned |
| Heading | What makes the recursion governable |
| Stable anchor | `#sec-earned-recursion-governance` |
| Lines | L117-125 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch22-the-reference-architecture-earned.html#sec-earned-recursion-governance> |
| Locator quote | "Recursion without a bound is a generator for unbounded compute and an unauditable trail." |

Resolve at any time with `python docs/resolve.py ws WS-22-recursion-governance-bounds`.

## 3. Source extract - the scaffolding, verbatim

```text
  117 | Recursion without a bound is a generator for unbounded compute and an unauditable trail. Two conventions, applied at every level, convert it from a hazard into an architectural property.
  118 | 
  119 | First, **every Skill carries an eval as discipline**. A Skill that cannot say what its output looks like and how to tell whether it is correct is not a Skill; it is a prompt that has been mistaken for one. The eval is the parent's stop condition. Without it, the parent has to either re-dispatch (paying again) or trust without checking (paying later). With it, the parent reads the artefact and moves on. The eval lives alongside the bundle today — as test inputs, expected outputs, and a runner the bundle author maintains — not yet as a manifest field; the discipline is what matters, and the schema will catch up.
  120 | 
  121 | Second, **every dispatch persists its plan**. The subagent thread writes its working plan to a file the parent can read. When the Security Reviewer in Maya's PR dispatched CVE Triage, the triage thread did not return only its verdict; it returned a verdict *and* a plan trace, persisted alongside the run. The parent reads the verdict; the auditor — six months later, with a regulator on the line — reads the plan.
  122 | 
  123 | Together, the two conventions bound the recursion in space and in time. The eval bounds it in space: each level returns one well-typed artefact. Plan persistence bounds it in time: each level is reconstructible after the fact. What you get back from a dispatch is not "an agent did something"; it is a Skill, of a known version, against a known Context, returning an artefact that passed a known eval, with the trace on disk.
  124 | 
  125 | *A Skill that fails eval-and-plan is a prompt with ambitions.*
```

## 4. What the user fills

Per Skill named on the canvas: what single well-typed artefact it returns, what eval declares a pass (test inputs, expected outputs, the runner, and who maintains it), where the plan trace persists and for how long, the maximum dispatch depth, and the compute ceiling per invocation.

## 5. Field-level schema

One row per Skill named on the completed `WS-22-recursive-architecture-canvas` — at **every** depth,
including Skills the canvas only reached through a subagent thread. A Skill that appears on the
canvas and not on this sheet is precisely the unbounded case the chapter warns about. Portrait, one
page per canvas, with a standing banner at the head (see below) and a verdict column that closes
each row.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Skill | `free text` | — | Bundle name as it resolves in the lockfile | ch22 L123 — "a Skill, of a known version" |
| 2 | Version pin | `free text` | — | The exact pin, e.g. `#v1.4.2` form. An unpinned Skill cannot be bounded | ch22 L123 |
| 3 | Depth on the canvas | `select` — `1` / `2` / `3+` | — | Where this Skill sits in the dispatch tree drawn on the canvas | `WS-22-recursive-architecture-canvas` |
| 4 | Dispatched by | `free text` | — | The parent Skill or Persona. Blank only for the top-level Skill | ch22 L121 |
| 5 | Returned artefact | `free text` | — | **One** well-typed artefact. If two things are named here, the row is not bounded | ch22 L123 — "each level returns one well-typed artefact" |
| 6 | How the parent knows it is correct | `free text` | — | The pass condition in a sentence, before any tooling is named | ch22 L119 — the eval is the parent's stop condition |
| 7 | Eval: test inputs | `free text` | — | Where they live — path or repo | ch22 L119 |
| 8 | Eval: expected outputs | `free text` | — | Where they live | ch22 L119 |
| 9 | Eval: runner | `free text` | — | The command a reviewer can actually run | ch22 L119 |
| 10 | Eval completeness | `select` — `present` / `partial` / `absent` | — | `present` = all three of columns 7-9 exist and the runner passes today; `partial` = one or two exist; `absent` = none | derived from ch22 L119 |
| 11 | Eval maintainer | `owner (named person)` | — | The bundle author who maintains it. The book assigns the eval set to the Domain Specialist | ch21 L175-179 (WHAT concern) |
| 12 | Plan-persistence path | `free text` | — | Where the subagent thread writes its working plan, e.g. a run-scoped directory beside the artefact | ch22 L121; layout example at ch22 L172-181 |
| 13 | Retention | `free text` | — | How long the trace is kept, and against which obligation. The chapter's reader is an auditor six months on with a regulator on the line | ch22 L121 |
| 14 | Who reads what | `free text` | Parent reads the verdict; auditor reads the plan | Name the actual parent and the actual audit function | ch22 L121 |
| 15 | Max dispatch depth | `free text` (integer) | — | The org's own number. Beyond it, no further dispatch | ch22 L117 — "unbounded compute" |
| 16 | Compute ceiling per invocation | `currency` or `free text` | — | The org's own ceiling, in whatever unit it actually meters | ch22 L117; `WS-19-where-the-bill-gets-decided` |
| 17 | On breach | `select` — `hard stop` / `escalate to owner` / `degrade and return partial` | — | What the harness does when 15 or 16 is reached. "Nothing" is not an option | derived |
| 18 | Bound owner | `owner (named person)` | — | Who owns the ceiling and the trace expectations. The book assigns these to the Agent Operations Specialist | ch21 L175-179 (OPERATIONS concern) |
| 19 | Verdict | `select` — `BOUNDED` / `PROMPT WITH AMBITIONS` | — | `BOUNDED` requires column 10 `present` **and** columns 12, 13, 15, 16, 17 filled. Anything else is the other verdict | ch22 L125 |
| 20 | Re-review date | `date` | — | When this row is checked again | org |
| — | Architect signature + date | `signature` | — | The architect who owns the canvas this sheet bounds | org |

**Standing banner — print this at the head of the sheet.** *Nothing enforces this sheet but this
sheet.* The chapter is explicit that the eval "lives alongside the bundle today — as test inputs,
expected outputs, and a runner the bundle author maintains — not yet as a manifest field; the
discipline is what matters, and the schema will catch up." No lockfile field, no CI check and no
registry validation currently reads columns 7 to 10. Until the schema catches up, this worksheet is
the **only** place the discipline is recorded, which is why column 18 names a person and column 20
names a date. A team that treats this as paperwork has no bound at all; a team that treats it as the
register of record has one, manually.

**Absorbed detail.** None — this sheet absorbed no other candidate. It is, however, the per-Skill
*quantitative* half of a trio and must not drift from the other two: `WS-21-skill-bundle-definition-of-done`
is the merge gate that asks whether an eval exists at all, and `WS-21-primitive-governance-policy`
owns the registry and pinning that make column 2 meaningful. Column 10's three-value vocabulary is
the same vocabulary those sheets use; keep them identical or the gate and the register disagree.

**Deliberate omission.** No token, latency or cost benchmark is printed anywhere on the sheet. The
book names unbounded compute as the hazard but publishes no figure for what bounded looks like, and
a printed number here would be read as the recommended ceiling within a week. Columns 15 and 16 are
deliberately blank rectangles the organisation fills from its own metering. Equally, no pass/fail
percentage for column 10 — the three named states are the whole scale.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-22-recursive-architecture-canvas` - Instantiate the Reference Architecture: Our Skill / Persona / Context Canvas (Pack Z - Second wave: the practitioner kit, fill order 12)

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** WS-05-governance-readiness-assessment (audit trail and stack trace rows) and WS-19-where-the-bill-gets-decided (the compute ceiling)

## 8. Facilitation

| | |
|---|---|
| Who fills it | The architect who owns the canvas, working with whoever holds the two concerns the book separates: the Domain Specialist or bundle author for columns 6-11 (what a pass looks like), and the Agent Operations Specialist for columns 12-18 (what it costs and what it leaves behind). In a small team one person wears both hats — but fill the columns in that order regardless, because the WHAT has to be settled before the ceiling means anything. |
| When in the session | Immediately after `WS-22-recursive-architecture-canvas`, in the same sitting if the room's energy holds. The canvas produces the list of Skills; this sheet is that list with bounds attached, and the two drift apart within days if they are filled a week apart. Pack Z timing: this is a second-wave sheet, filled once the organisation has real Skills rather than intended ones — the condition that makes it worth running is that **at least one Skill on the canvas has actually been dispatched, or is about to be**. Bounding an imaginary Skill produces imaginary numbers. |
| Duration | About 90 minutes for a canvas carrying up to roughly six Skills. Per Skill the eval columns go quickly or not at all: a bundle with an eval is a two-minute row, a bundle without one is a twenty-minute argument. Expect the depth-2 nested Skills to take longer than the top-level one, because nobody has thought about them. |
| Data needed in advance | The completed `WS-22-recursive-architecture-canvas` with every Skill named and pinned; read access to each bundle repository so columns 7-9 can be checked rather than asserted; whatever the organisation currently meters agent compute with, so column 16 has a unit; and the audit-retention obligation that column 13 must satisfy, fetched from compliance beforehand rather than guessed in the room. |
| Room format | A screen with the canvas on one side and the bundle repository on the other, filled live. Every eval claim is verified by opening the path, not by asking the author whether one exists — the gap between "we have an eval" and a runner that passes today is exactly what column 10 is for. |

**Facilitation note.** Open by naming both halves of the concern the chapter states in its first
sentence: recursion without a bound generates *unbounded compute* — a cost problem — and an
*unauditable trail* — a compliance problem. That is why this is a page rather than a bullet, and it
is the line that gets a finance or risk stakeholder to care about a practitioner sheet. Then say the
uncomfortable part plainly, because it changes how seriously the room treats every row: the chapter
notes the eval lives alongside the bundle today and *not yet as a manifest field*, so no schema, CI
check or lockfile enforces any of this. This worksheet is currently the only place the discipline
gets recorded. A row filled carelessly here is not caught anywhere downstream.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **Every Skill on `WS-22-recursive-architecture-canvas` has a row here, at every depth.** Count
   the Skills on the canvas — including the ones reached only through a subagent thread — and count
   the rows. The numbers match, or the canvas contains a dispatch nobody has bounded.
2. **Every row names exactly one artefact in column 5.** Two artefacts, or a description that
   resolves to "whatever it produces", means the level is not bounded in space and the verdict in
   column 19 cannot be `BOUNDED`.
3. **Every Skill that has been dispatched, or is about to be, shows `present` in column 10** — all
   three of test inputs, expected outputs and a runner, each verified by opening the path during the
   session. A `partial` or `absent` row is permitted only if it carries a re-review date in column
   20 and a verdict of `PROMPT WITH AMBITIONS`; it must not be quietly recorded as bounded.
4. **Every eval has a named maintainer and every bound has a named owner** — columns 11 and 18 are
   individuals, never a team, a function or a rota. An unowned eval drifts and nothing reports it.
5. **Columns 12 and 13 are both filled, and the retention in column 13 is reconciled against a real
   obligation**, not a preference. The test to apply in the room: could an auditor six months from
   now reconstruct this dispatch from what column 12 names, within the window column 13 states?
6. **Columns 15, 16 and 17 all carry a value.** A max depth with no compute ceiling bounds the tree
   but not the bill; a ceiling with no breach behaviour in column 17 is an observation, not a bound.
   The ceiling in column 16 must use the same unit as the metering in `WS-19-where-the-bill-gets-decided`,
   so the two reconcile rather than describing the same spend in different currencies.
7. **The standing banner is printed on the sheet and every row carries a re-review date.** Because
   no schema enforces this discipline, an undated sheet decays silently into a historical document
   while the bundles it describes keep changing.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** Prose only, and the chapter notes no schema enforces the discipline - so the worksheet is currently the only place it gets recorded.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> The chapter gives the two conventions at 119-121 and the rationale at 123: "The eval bounds it in space: each level returns one well-typed artefact. Plan persistence bounds it in time: each level is reconstructible after the fact." Both halves of the exec concern are named in the opening sentence at 117 -- unbounded COMPUTE (cost) and an unauditable TRAIL (compliance) -- which is why this is worth a page rather than a bullet. Facilitator note worth passing on: the chapter states the eval "lives alongside the bundle today... not yet as a manifest field", so this worksheet is currently the only place the discipline gets recorded -- there is no schema enforcing it. Overlaps ch21's OPERATIONS concern at 175-179 and ch21's bundle definition of done; this is the per-Skill QUANTITATIVE sheet, those are role ownership and merge gate respectively. Prose only -- needs authoring.
