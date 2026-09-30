# Instruction Hierarchy Design Canvas

`WS-13-instruction-hierarchy-canvas` &middot; **Pack Z - Second wave: the practitioner kit** &middot; fill order **6** &middot; type `canvas` &middot; audience **architect** &middot; leadership priority **2**

> **Split back out in the re-opening pass.** Designs a target three-level hierarchy and the migration list to reach it, tested by 'can module-specific rules be added without editing any file above that module?' -- design work, not scoring.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A target instruction hierarchy with at least three specificity levels, and the migration list for flattening or splitting what exists today.

**Cluster.** `CL-INSTRUCTION-HIERARCHY` - Instruction Hierarchy Design Canvas

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch13-the-prose-specification.qmd` |
| Chapter | The PROSE Constraints |
| Heading | E — Explicit Hierarchy |
| Stable anchor | `#sec-prose-explicit-hierarchy` |
| Lines | L295-370 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch13-the-prose-specification.html#sec-prose-explicit-hierarchy> |
| Locator quote | "**Definition.** Instructions form a hierarchy from global to local." |

Resolve at any time with `python docs/resolve.py ws WS-13-instruction-hierarchy-canvas`.

## 3. Source extract - the scaffolding, verbatim

```text
  295 | **Definition.** Instructions form a hierarchy from global to local. Local context inherits from and may override global context. Agents resolve context by walking from the most specific scope to the most general.
  296 | 
  297 | **Why it matters.** Different domains require different guidance, but they also share common ground. Hierarchy solves both problems. Global rules establish consistency: naming conventions, commit message format, documentation standards. Local rules enable specialization: the authentication module gets security-specific instructions, the frontend gets accessibility-specific instructions, the database layer gets migration-specific instructions. Each domain inherits the global rules and adds or overrides with local ones.
  298 | 
  299 | ### Implementation patterns
  300 | 
  301 | **Directory-scoped context files.** The `AGENTS.md` standard uses directory placement to define scope. A file at the project root applies everywhere. A file in `frontend/` applies only to frontend code. A file in `frontend/components/` applies only to components:
  302 | 
  303 | ```
  304 | project/
  305 | ├── AGENTS.md                    # Global: naming, commits, documentation
  306 | ├── frontend/
  307 | │   ├── AGENTS.md               # Frontend: React patterns, accessibility
  308 | │   └── components/
  309 | │       └── AGENTS.md           # Components: prop conventions, testing
  310 | └── backend/
  311 |     ├── AGENTS.md               # Backend: API design, error handling
  312 |     └── auth/
  313 |         └── AGENTS.md           # Auth: security patterns, token handling
  314 | ```
  315 | 
  316 | An agent editing `backend/auth/token.py` resolves context by walking up: `auth/AGENTS.md` + `backend/AGENTS.md` + root `AGENTS.md`. An agent editing `frontend/components/Button.tsx` resolves: `components/AGENTS.md` + `frontend/AGENTS.md` + root `AGENTS.md`. Neither loads the other's domain-specific rules.
  317 | 
  318 | **Pattern-scoped instruction files.** The `applyTo` frontmatter targets instructions by file pattern, achieving hierarchical specificity without requiring directory-level files:
  319 | 
  320 | ```yaml
  321 | # General Python rules
  322 | ---
  323 | applyTo: "**/*.py"
  324 | ---
  325 | 
  326 | # Stricter rules for the public API surface
  327 | ---
  328 | applyTo: "src/api/**/*.py"
  329 | ---
  330 | 
  331 | # Most specific: authentication module security rules
  332 | ---
  333 | applyTo: "src/api/auth/**/*.py"
  334 | ---
  335 | ```
  336 | 
  337 | More specific patterns override or extend less specific ones. The authentication module inherits general Python rules and general API rules, then adds its own security requirements.
  338 | 
  339 | **Compilation for portability.** Instruction files authored in tool-specific formats (`.instructions.md` with `applyTo`) can be compiled into hierarchical `AGENTS.md` files for universal portability. The source of truth is the authored instructions. The compiled output is the portable delivery format. This separation means the hierarchy works regardless of which AI coding tool the developer uses.
  340 | 
  341 | This hierarchical structure is what makes context files distributable. Package managers for agent primitives — such as APM — automate the scaffolding and sharing of instruction hierarchies across repositories and teams. The constraint (hierarchical context) drives the tooling, not the reverse.
  342 | 
  343 | ### Anti-pattern: Flat instructions
  344 | 
  345 | A single instruction file at the project root containing every rule for every domain:
  346 | 
  347 | ```markdown
  348 | # Project Instructions
  349 | 
  350 | ## Python
  351 | Use type hints. Follow PEP 8...
  352 | 
  353 | ## React
  354 | Use functional components. Follow accessibility guidelines...
  355 | 
  356 | ## Authentication
  357 | Use JWT with RS256. Rotate refresh tokens...
  358 | 
  359 | ## Database
  360 | Use migrations for all schema changes...
  361 | 
  362 | ## CSS
  363 | Use CSS modules. Follow BEM naming...
  364 | ```
  365 | 
  366 | Every agent, regardless of what it is working on, loads all of this. The Python backend agent processes CSS naming conventions. The database migration agent processes React accessibility guidelines. Attention is wasted. Worse, rules from unrelated domains can interfere — the agent might apply the "use modules" CSS guidance to Python module organization, producing unexpected results.
  367 | 
  368 | **Fix:** Split by scope. Python rules in a Python-scoped file. React rules in a frontend-scoped file. Authentication rules in an auth-scoped file. Each agent loads only what applies to its current task. Chapter 15 covers the engineering details: how to size each layer for the context budget, compose the hierarchy at runtime, and maintain it as your codebase evolves (see @sec-attention-economy).
  369 | 
  370 | ---
```

## 4. What the user fills

A tree sketch of the target instruction hierarchy for one real repository: what belongs at the root (rules true everywhere), what belongs at each domain, and what belongs at each module — plus, per rule currently held globally, a decision to keep, scope down or delete. The test to apply per level: can module-specific rules be added without editing any file above that module?

## 5. Field-level schema

Two surfaces. **A** is the target tree — one row per node in the target hierarchy, and the book
requires at least three levels, so at least three rows. **B** is the migration list — one row per
rule currently held globally. Physically A is an A3 tree canvas with a labelled block per node,
laid out like the book's four-level directory sketch; B is a list on the reverse. A diagnostic box
sits at the head of surface A and is filled before anything else.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| — | Repository | `free text` | — | The one repository this canvas designs for | org |
| — | Does one root file carry rules for two or more unrelated domains? | `checkbox` | The anti-pattern's worked file printed beside the box — Python, React, Authentication, Database and CSS sections in a single root file | Tick or not | ch13 L343-366 |
| — | The domains found in it | `free text` | — | Listed, by heading | ch13 L347-364 |
| — | Filled by / date | `owner (named person)` + `date` | — | — | org |
| A1 | Level | `select` — root / domain / module / deeper | The worked four-level tree: root, `frontend/`, `frontend/components/`, `backend/`, `backend/auth/` | Which level this node sits at | ch13 L304-314 |
| A2 | Node | `free text` | The worked tree's node names | The org's own directory or glob | ch13 L304-314 |
| A3 | Scope expression | `free text` | Both worked forms: directory placement (`frontend/AGENTS.md`) and `applyTo` glob (`**/*.py`, then `src/api/**/*.py`, then `src/api/auth/**/*.py`) | The literal path or glob | ch13 L304-314, L320-334 |
| A4 | Mechanism | `select` — directory-scoped `AGENTS.md` / `applyTo` pattern / authored then compiled | All three named, with the note that the authored file is the source of truth and the compiled output is the portable delivery format | Which | ch13 L301, L318, L339 |
| A5 | What belongs here | `free text` | The filled three-level sample (root conventions, backend API rules, auth-module security rules) printed as the completed example | Rules true at this scope and no narrower | ch13 L410-474 |
| A6 | Inherits from | `free text` | The worked resolution walk printed beside the column: an agent editing `backend/auth/token.py` resolves `auth/AGENTS.md` + `backend/AGENTS.md` + root `AGENTS.md`, and never loads the frontend's rules | The parent node | ch13 L316 |
| A7 | Single concern — could you name the file after its one topic? | `checkbox` | The test stated as the book states it | Tick per node | ch13 L545 |
| A8 | Subsidiary topics referenced by link, each with a descriptive label | `checkbox` | The before/after pair printed beside the column — bare inlined sections against labelled pointers such as "Authentication patterns and token lifecycle" | Tick per node | ch13 L91-102, L542, L546 |
| A9 | E2 test — can a module-specific rule be added here without editing any file above it? | `select` — pass / fail | The question verbatim | Pass or fail, per node | ch13 L551 |
| A10 | Owner | `owner (named person)` | — | Who maintains this node's file | org |
| — | Levels in the target tree | `computed` | The E1 threshold printed beside it: three or more specificity levels | Count of distinct values in A1 | ch13 L550 |
| B1 | Rule, as currently written | `free text` | — | Quoted, not paraphrased | ch13 L343-366 |
| B2 | Where it lives today | `free text` | — | Path and line number | org |
| B3 | True everywhere? | `checkbox` | — | The question that decides B4 | ch13 L297 |
| B4 | Decision | `select` — keep at root / scope down / delete / split | The chapter's own fix: split by scope, so each agent loads only what applies to its current task | Which | ch13 L368 |
| B5 | Target node | `select` — the nodes named in surface A | — | Required whenever B4 is `scope down` or `split` | derived |
| B6 | Reason, if `delete` | `free text` | — | Why this rule is no longer true, or never was | derived |
| B7 | Owner and target date | `owner (named person)` + `date` | — | — | org |

**Carried from the O constraint.** Section 6 records no absorbed member, but the source scan is
right that this canvas also carries the Orchestrated Composition material (ch13 L160-220): one
concern per file, and workflows that reference shared files by link rather than pasting their
content. Those are columns A7 and A8, and they are not decoration — they are checklist items O1 and
O2, which `WS-13-prose-readiness-assessment` will score against this same estate. A hierarchy whose
nodes fail A7 is three levels of monolith, and it passes E1 while failing everything E1 exists for.

**Deliberate omission — no line counts.** How large a node's file is is not a hierarchy question,
and the two thresholds the book states for it do not agree. Both print on
`WS-13-prose-readiness-assessment` surface C, where the disagreement is flagged as an open
question. Putting a line-count column here would force this sheet to pick one of the two, which is
not this sheet's decision to make.

**Deliberate omission — no priority or severity per rule.** Surface B's only decision is placement.
Ranking the rules invites the room to migrate the important ones and leave the rest global, which
reproduces the flat file with fewer entries in it.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-03-context-moat-asset-inventory` - Context Asset & Debt Inventory (Pack A - Groundwork (pre-work), fill order 2)

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** WS-13-prose-readiness-assessment (checks E1 and E2)

## 8. Facilitation

| | |
|---|---|
| Who fills it | The architect, plus one engineer who owns each candidate domain. The repository owner must be present for surface B: deleting a global rule needs somebody with the standing to declare it no longer true, and without that person every `delete` silently becomes a `keep at root`. |
| When in the session | Pack Z, fill order 6, after `WS-03-context-moat-asset-inventory`. The dependency is substantive — that inventory's classified rule list is surface B's row set. Run it before `WS-13-prose-readiness-assessment`, which checks E1 and E2 against exactly what this canvas produces. |
| Duration | Two hours for one repository. The diagnostic box takes ten minutes and usually settles the mood. Surface A is about 45 minutes. Surface B takes the rest, and it is where the argument happens, because every global rule has its author somewhere in the room. |
| Data needed in advance | The current root instruction file, printed, with line numbers. Every existing scoped file with its `applyTo` glob. A directory tree of the repository, two or three levels deep. The output of `WS-03-context-moat-asset-inventory`. |
| Room format | A3 tree canvas on the wall, **drawn rather than typed** — the tree shape is the argument, and flattening it into a list to type it loses exactly the thing the sheet is trying to establish. Surface B on a projected list, so the decision column can be filled at pace. |

**Facilitation note — Pack Z prerequisite condition.** This is a design sheet, which makes it one
of the few Pack Z instruments an organisation with almost no estate can still run usefully: an
empty hierarchy is designed the same way a flat one is refactored. The diagnostic box and surface
B, though, both assess what exists. Where the shadow-AI census found a single root file that has
accumulated several unrelated domains, this sheet is urgent and the box is ticked in seconds. Where
it found nothing at all, skip the box, run surface A as a greenfield design, and leave surface B
empty with a note saying why — rather than inventing global rules in order to have something to
migrate.

**Second note — run the diagnostic box first, and out loud.** The anti-pattern's worked file
(ch13 L347-364) carries Python, React, authentication, database and CSS rules in one place, and a
room will recognise its own file in about a minute. That recognition is what pays for the two hours
that follow. It is considerably cheaper than arguing for hierarchy in the abstract.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **Surface A has at least three levels.** This is PROSE E1 stated verbatim (ch13 L550) and it is
   the sheet's minimum viable output. A two-level tree is a flat file with a subdirectory.
2. **Every node passes A9.** Where a node fails — a module-specific rule cannot be added without
   editing something above it — the node is redesigned before the sheet closes. That is PROSE E2
   (ch13 L551), and `WS-13-prose-readiness-assessment` will fail the estate on it otherwise.
3. **Every node passes A7, or is split into nodes that do.** A node that cannot be named after its
   single topic is two nodes wearing one filename (ch13 L545).
4. **Every rule in surface B carries a decision, and every `scope down` or `split` names a node
   that exists in surface A.** A migration item pointing at a node nobody designed does not
   migrate; it stays global and is forgotten.
5. **Every `delete` carries a reason in B6 and an owner in B7.** Removing a global rule is the
   highest-value and highest-risk action on the sheet, and it is the one most likely to be done
   quietly.
6. **The diagnostic box is filled, including when the answer is "no".** A blank box is
   indistinguishable from an unasked question, and the flat-instruction finding is the single most
   useful thing this sheet produces for an organisation that has one.
7. **It reconciles with `WS-13-prose-readiness-assessment`.** The computed level count answers E1
   and the A9 column answers E2 for this repository. If the readiness assessment was filled first
   and scored either item differently, the discrepancy is recorded with a date — the canvas is the
   newer evidence, so the assessment is re-run rather than edited to match.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** A tree canvas must be laid out from prose; the three-level worked example supplies a completed sample but not a blank form.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> The chapter gives two mechanisms for the same hierarchy — directory-scoped AGENTS.md placement and applyTo pattern scoping — and the worked example at lines 410-474 shows all three levels filled in (root, backend, auth module), so the canvas has a completed sample for free. Also absorbs the O (Orchestrated Composition) material at lines 160-220: single responsibility per file, and workflows that reference shared files by link rather than pasting content. The flat-instructions anti-pattern at lines 343-370 is the diagnostic to run first — if one root file contains Python, React, auth, database and CSS rules, every agent loads all of them. The chapter notes instruction files can be compiled from authored format into portable AGENTS.md, which is the portability link back to WS-11-harness-standardisation-decision.
