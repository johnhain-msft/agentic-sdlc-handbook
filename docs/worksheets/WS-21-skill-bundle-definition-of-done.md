# Definition of Done for a Shipped Skill Bundle

`WS-21-skill-bundle-definition-of-done` &middot; **Pack Z - Second wave: the practitioner kit** &middot; fill order **11** &middot; type `checklist` &middot; audience **practitioner** &middot; leadership priority **3**

> **Split back out in the re-opening pass.** A CI merge gate enforced by the platform team on every new or changed bundle, not a target-state definition; it is the mechanism that makes the primitive-governance policy real rather than aspirational.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A merge-gate checklist the platform team enforces in CI on any new or changed Skill bundle.

**Cluster.** `CL-BUNDLE-DOD` - Definition of Done for a Shipped Skill Bundle

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch21-primitives-as-code.qmd` |
| Chapter | Primitives as Code |
| Heading | Modules over monoliths |
| Stable anchor | `#sec-primitives-modules` |
| Lines | L58-72 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch21-primitives-as-code.html#sec-primitives-modules> |
| Locator quote | "A `SKILL.md` body that crosses a few hundred lines is almost always" |

Resolve at any time with `python docs/resolve.py ws WS-21-skill-bundle-definition-of-done`.

## 3. Source extract - the scaffolding, verbatim

```text
   58 | A `SKILL.md` body that crosses a few hundred lines is almost always a hint that the primitive has accreted concerns that should belong to neighbours. The same instinct that makes a senior engineer extract a function from a 400-line method applies here, and the test is the same: *does this section have its own reason to change?* If yes, it wants to be its own primitive — its own module, with its own description, its own version, and its own owner.
   59 | 
   60 | | Anatomy of a skill bundle | Role | Visibility to consumers |
   61 | |---|---|---|
   62 | | `SKILL.md` (entrypoint) | Description-driven activation contract; the body the agent reads when the skill binds.[^ch19-skills-spec] | Public. The `description` is the API. |
   63 | | `assets/` | Reference material the body cites — example diffs, decision tables, checklists too long to inline. | Loaded transitively when the body links them. |
   64 | | Sub-skills | A child `SKILL.md` under the same bundle directory, activated independently or via a parent reference. | Public if the parent re-exports; private otherwise. |
   65 | | `apm.yml` (or equivalent) | Declared dependencies, version, license, ownership. | Public. Drives the lockfile. |
   66 | | Tests | Activation tests, link-integrity checks, schema validation against the manifest. | Internal to the package; CI gate. |
   67 | 
   68 | Two principles hold across the table. First, the entrypoint is *small*. A skill body that lists every consideration the team has ever cared about is a monolith; the same skill that names two or three load-bearing decision rules and links to assets for the rest is a module. Progressive disclosure (Ch14, the attention economy) is enforced at the package boundary as well as inside the body — a consumer who installs the skill should pay for the description at session start, the body when the skill activates, and the assets only when the body cites them.
   69 | 
   70 | Second, the content a skill *imports* is named, not pasted. A single decision rule reused by three skills is a sign that the rule wants to live in a fourth skill on which the other three depend. The cost is one new package; the benefit is one source of truth, one version, one review history. Ch18's Composition vocabulary is exactly the design language this judgement uses — Skill, Bundle, Primitive, Dependency, Override (@sec-composition-patterns). The chapter you are reading is that vocabulary made operational on disk.
   71 | 
   72 | ---
```

## 4. What the user fills

Tick per bundle before merge: entrypoint present and small, description written as an activation contract (it is the API), assets extracted rather than inlined, sub-skills declared, manifest declares dependencies plus version plus license plus owner, tests exist and gate CI (activation test, link-integrity check, schema validation), an eval declares what a pass looks like, and plan persistence is wired.

## 5. Field-level schema

One row per definition-of-done check, twelve in all, applied to a single bundle at a single version.
The checks and what "done" means for each are **pre-printed from the anatomy table and the two
principles at ch21 L60-70, plus the two governance conventions at ch22 L119-121**; the organisation
supplies the verdict, the evidence and — decisively — which checks a machine enforces. A header block
identifies the bundle under review. The physical format is a one-page gate attached to the merge
request, not a poster: it is filled per pull request and its useful life is one review.

**Header block.** Bundle name; version being published; bundle author; merge request reference;
reviewer; date; gate verdict (`MERGE` / `BLOCK`).

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Check | `select` (fixed 12 rows) | 1 Entrypoint present · 2 Entrypoint is a module, not a monolith · 3 `description` is written as the activation contract · 4 Assets extracted, not inlined · 5 Sub-skills declared and their visibility decided · 6 Imported content is named, not pasted · 7 Manifest declares dependencies, version, licence and ownership · 8 Activation test · 9 Link-integrity check · 10 Schema validation against the manifest · 11 The bundle carries an eval · 12 Every dispatch persists its plan | — | ch21 L60-70; ch22 L119-121 |
| 2 | What "done" looks like | `free text` (read-only) | The chapter's own phrasing per check — e.g. for 3: *the `description` is the API*; for 6: *a decision rule reused by three skills wants to live in a fourth skill the other three depend on*; for 11: *a Skill that cannot say what its output looks like and how to tell whether it is correct is not a Skill* | — | ch21 L62-70; ch22 L119 |
| 3 | Verdict | `select` — `pass` / `fail` / `not applicable` | — | `not applicable` requires a reason in column 5 | derived |
| 4 | Enforced by | `select` — `CI (automated)` / `reviewer judgement` | The book places checks 7-10 inside the CI gate | The org decides for each of the twelve and records it once, then keeps it | ch21 L65-66 — "Internal to the package; CI gate" |
| 5 | Evidence | `free text` | — | A path, a CI job name or a run link a reviewer can open. An assertion is not evidence | derived |
| 6 | CI job or check name | `free text` | — | Required wherever column 4 reads `CI (automated)`. A check claimed as automated with no job name is reviewer judgement wearing a badge | org |
| 7 | Waived? | `checkbox` | — | Only meaningful against a `fail` | org |
| 8 | Waiver reason | `free text` | — | Mandatory when column 7 is ticked | org |
| 9 | Waiver expiry | `date` | — | Mandatory when column 7 is ticked. A waiver without an expiry is a silent amendment to the standard | org |
| 10 | Reviewer | `owner (named person)` | — | Per check, because checks 2, 3, 6 and 11 are judgements different people are qualified to make | ch21 L175-179 |
| — | Gate verdict | `computed` | `BLOCK` when any check is `fail` and unwaived | — | derived |
| — | Reviewer signature + date | `signature` | — | — | org |

**Check 2 — how to score "small" without a line count.** The book's test is a question, not a
threshold: *does this section have its own reason to change?* The reviewer applies it to each section
of the body and records, in column 5, either "no section has an independent reason to change" or the
list of sections that do — each of which is a candidate primitive of its own. The same instinct that
extracts a function from a four-hundred-line method applies, and the reviewer's written answer is the
evidence. See the deliberate omission below.

**Checks 11 and 12 — the two the schema cannot see.** These come from ch22 rather than ch21, and the
chapter is explicit that the eval "lives alongside the bundle today — as test inputs, expected
outputs, and a runner the bundle author maintains — not yet as a manifest field". They therefore
cannot be set to `CI (automated)` against a manifest field today, and must carry a named reviewer in
column 10. Where `WS-22-recursion-governance-bounds` exists for this Skill, check 11's evidence is a
pointer to that sheet's row and the two must agree; that sheet's `present` / `partial` / `absent`
vocabulary is the same vocabulary used here.

**Absorbed detail.** None — this sheet absorbed no other candidate. It is, however, the enforcement
half of `WS-21-primitive-governance-policy`: column 4's twelve decisions are precisely that policy's
publish-pipeline gates row, and the two must name the same checks in the same words or the policy
describes a gate that does not exist.

**Deliberate omission.** No line-count limit on the entrypoint, anywhere on the sheet. The book says
a body crossing a few hundred lines is "almost always a hint" — a hedged diagnostic, not a threshold
— and printing any number beside a blank cell would convert a hint into a ceiling teams optimise
against by splitting bodies rather than by separating concerns. Check 2 is scored by the reason-to-
change question and by nothing else. Equally, no bundle count, coverage percentage or adoption target.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-21-primitive-governance-policy` - Primitive Supply Chain: Registry, Pinning, Versioning and Ownership Decisions (Pack Z - Second wave: the practitioner kit, fill order 3)

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** WS-21-primitive-governance-policy (supplies the publish-pipeline gates row)

## 8. Facilitation

| | |
|---|---|
| Who fills it | Per bundle, the platform-team reviewer on the merge request, with the bundle author present for checks 2, 3, 6 and 11. In the session where the gate is *stood up*, a different group: whoever owns CI, whoever owns the registry, and one bundle author who will have to live with it. The standing-up session's real output is column 4 — which of the twelve a machine enforces — and that is a platform decision, not a bundle-author one. |
| When in the session | Pack Z, after `WS-21-primitive-governance-policy`. That policy decides the registry, pinning and ownership model; this sheet is the gate that makes it real rather than aspirational, so it cannot sensibly be agreed first. Second-wave by nature: the condition that makes it worth standing up is that **at least one bundle exists that somebody other than its author will install**. A gate over a single-consumer bundle is ceremony. |
| Duration | 60 minutes to agree the twelve rows and wire column 4, assuming CI already exists. Roughly ten minutes per bundle merge request thereafter — and if it is taking longer than that per PR, the gate has too many reviewer-judgement rows and column 4 needs revisiting. |
| Data needed in advance | One real bundle to run the gate against, ideally one already in use rather than a specimen; the CI configuration, so the four automatable checks can be named to real jobs in the session; the completed `WS-21-primitive-governance-policy`; and, if it exists, the `WS-22-recursion-governance-bounds` row for that bundle so check 11's evidence points somewhere real. |
| Room format | A real merge request on screen, the gate filled live against it. Run it against a bundle the team already believes is good — the checks it fails are the calibration, and calibrating on something real is cheaper than discovering the standard is unmeetable on the first bundle it blocks. |

**Facilitation note.** The two principles at ch21 L68-70 are the rows a machine cannot score, and the
room should say so out loud rather than discovering it during the first blocked PR. *The entrypoint
is small* and *imported content is named, not pasted* are both judgements about whether a section has
its own reason to change — a question a linter cannot ask. Decide in the session which of the twelve
are `CI (automated)` and which are `reviewer judgement`, and be honest: a gate where all twelve read
`reviewer judgement` is a code review with a checklist stapled to it, and will be skipped within a
month. Conversely, checks 7 to 10 are the ones the book itself places inside the CI gate, and a team
that cannot automate those four has a tooling problem to fix before it has a standard to enforce.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All twelve checks carry a verdict, and every `pass` carries openable evidence in column 5** — a
   path, a CI job name or a run link. No blanks: a `not applicable` is permitted but carries its
   reason, because "this bundle has no assets" and "nobody looked" leave the same mark on an unfilled
   row. A reviewer who cannot follow the evidence to the artefact has recorded an opinion, and the
   gate degrades into a signature block within a few bundles.
2. **Column 4 is decided for all twelve and does not change per bundle.** It is a standing property
   of the gate, not a per-review negotiation. Every row marked `CI (automated)` names a real job in
   column 6; a row claimed as automated with an empty column 6 fails this criterion.
3. **Checks 7 to 10 are `CI (automated)`**, or the sheet records why the organisation is overriding
   the book on the four checks it places inside the CI gate. These are the mechanical ones; if they
   are reviewer-judged, nothing about the gate is enforced.
4. **Checks 11 and 12 are present as rows with a named reviewer in column 10.** They are the two the
   manifest schema cannot see today, which makes them the two most likely to be silently dropped —
   and the two whose absence turns a published Skill into a prompt with ambitions. Where a
   `WS-22-recursion-governance-bounds` row exists for this bundle, check 11's evidence points to it
   and the two verdicts agree.
5. **Every `fail` is either blocking or waived with both a reason and an expiry date**, and check 2's
   evidence is the answer to the reason-to-change question rather than a line count. An unexpiring
   waiver is an amendment to the standard made by one reviewer on one afternoon. A reviewer who has
   written "412 lines — too long" has applied a number the book does not publish; a reviewer who has
   written "the retry-policy section has its own reason to change and wants to be its own primitive"
   has applied the test.
6. **Reconciliation with `WS-21-primitive-governance-policy`: the twelve checks and their column 4
   settings appear in that policy's publish-pipeline gates row, in the same words.** A gate described
   in the policy but absent here, or vice versa, means the policy documents an enforcement that does
   not run.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** The anatomy table is already a checklist in disguise; ch22 contributes two further rows in the same register.
- **Fill (the organisation completing it): `S`.** S - one sitting, data already in the room

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> CONSOLIDATED ACROSS TWO CHAPTERS: the anatomy table at 60-66 plus the two principles at 68-72 (the entrypoint is small; imported content is named, not pasted), merged with ch22:119-121, which contributes two more definition-of-done rows in the same register -- "every Skill carries an eval as discipline" ("A Skill that cannot say what its output looks like and how to tell whether it is correct is not a Skill; it is a prompt that has been mistaken for one") and "every dispatch persists its plan". Recorded here rather than twice. Practitioner-facing merge gate, not part of the exec kit, but it is the mechanism that makes WS-21-primitive-governance-policy real rather than aspirational. Nearly ready to lift -- the table is already a checklist in disguise.
