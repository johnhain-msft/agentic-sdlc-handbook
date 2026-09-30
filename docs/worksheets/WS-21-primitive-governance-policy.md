# Primitive Supply Chain: Registry, Pinning, Versioning and Ownership Decisions

`WS-21-primitive-governance-policy` &middot; **Pack Z - Second wave: the practitioner kit** &middot; fill order **3** &middot; type `decision` &middot; audience **eng-leader** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A one-page primitive governance policy the platform team can implement, ending with the audit question the organisation must be able to answer on demand.

**Cluster.** `CL-PRIMITIVE-SUPPLY-CHAIN` - Primitive Supply Chain: Registry, Pinning, Versioning, Ownership

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch21-primitives-as-code.qmd` |
| Chapter | Primitives as Code |
| Heading | The lockfile and what it pins |
| Stable anchor | `#sec-primitives-lockfile` |
| Lines | L103-120 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch21-primitives-as-code.html#sec-primitives-lockfile> |
| Locator quote | "A dependency declaration is an intent" |

Resolve at any time with `python docs/resolve.py ws WS-21-primitive-governance-policy`.

## 3. Source extract - the scaffolding, verbatim

```text
  103 | A dependency declaration is an intent (*I want the rubric, version 1.2*). A lockfile is a fact (*on the date of this install, the rubric resolved to commit `9d10…`, content hash `sha256:9d10…`, fetched from this source URL*). The two are different and both are necessary, for the same reasons npm's `package.json` and `package-lock.json` are different.[^ch19-pkg] [^ch19-genesis]
  104 | 
  105 | | Layer | Manifest (`apm.yml`) | Lockfile (`apm.lock.yaml`) |
  106 | |---|---|---|
  107 | | Records | What the project depends on, by version range. | What was actually resolved on a given date, by content hash. |
  108 | | Edited by | Humans, on every dependency change. | The CLI, on every install. |
  109 | | Reviewed in | Pull requests, like any code change. | Pull requests, as a snapshot artifact. |
  110 | | Answers | "What does this project want?" | "What did this project see, last time it built?" |
  111 | | Breaks if | A consumer adds an undeclared dependency. | A resolved file is republished under the same version with different content. |
  112 | 
  113 | The lockfile is what makes a primitive set *reproducible* across machines and across time. Without it, last week's `apm install` and this week's `apm install` will produce different agent behavior on the same project — different transitive closure, different content, different output — with no diff on the consumer's branch to point at. The wave protocol Ch17 describes (@sec-meta-process) depends on this kind of reproducibility: a wave's verdict is honest only if the next wave can be re-run against an identical context. The lockfile is what gives that next wave the same source tree the previous one saw.
  114 | 
  115 | A second function the lockfile serves is integrity. Every resolved entry carries a content hash. If a consumer's install resolves `code-review-rubric@v1.2` to a file whose hash does not match the lockfile, the install fails. Republishing a tag with different content is a supply-chain attack; the lockfile is the local check that catches it.[^ch19-apm] Ch21 picks up the supply-chain thread in detail.
  116 | 
  117 | Pinning is therefore not bureaucracy. It is the only mechanism by which the *transitive closure* of a primitive — the full set of files that load when the skill activates, including the contents of every dependency — is observable, diff-able, and reviewable. The closure is the thing that actually steers the agent. Without a lockfile, the closure is whatever the registry served the last time anyone installed; with one, it is exactly what the team committed.
  118 | 
  119 | ---
  120 | 
```

## 4. What the user fills

The organisation's written position on each governance decision: where the registry lives, whether a manifest and lockfile are mandatory or advisory, who owns each shared primitive (CODEOWNERS), the semver rule (rewording a description's activation criteria is MAJOR; renaming an overrideable slot is MAJOR), which publish-pipeline gates we run (schema validation, link integrity, activation test), the override-versus-fork threshold, and the deprecation window.

## 5. Field-level schema

Four linked surfaces. The `#` prefix says which surface a column belongs to: **A** the decision
policy (rows = the governance decisions, pre-printed), **B** the primitive register (rows = one per
primitive the org has or plans), **C** the agent-source-code control checklist (rows = the seven
controls), **D** the audit test (a single box, run once, in front of everyone). A, C and D fit an
A3 spread; B is a spreadsheet the moment the estate passes about thirty primitives. The subtitle
across the head of the sheet is the book's own sentence: *"The decisions worth making this week are
about your registry and your CODEOWNERS, not your agent vendor."*

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| — | Our eager-size line | `free text` (token count) | — | The size at which an eager primitive needs justifying. **Org-set — the book publishes no number.** | org |
| — | Policy version and date | `date` + `free text` | — | — | org |
| A1 | Decision | `select` (fixed rows) | Twelve decisions pre-printed: where the registry lives; is a manifest (`apm.yml`) required; is a lockfile (`apm.lock.yaml`) required and reviewed in PRs; who may publish internal primitives; are external primitive packages allowed and under what review; is `--dry-run` closure review mandatory before a manifest change merges; the phantom-dependency rule (inline / local sibling / declared external edge); the published distribution boundary, against bundle leakage; adopt or amend the five semver rules as printed; slot stability — overrideable section names are public contract; the override-versus-fork threshold; the deprecation window | — | ch21 L105-111, L129-131, L143-149; ch14 L43, L63 |
| A2 | Our position | `free text` | — | The written answer, one or two sentences | org |
| A3 | Mandatory or advisory | `select` | — | Which, per decision | ch21 L109 |
| A4 | Owner | `owner (named person)` | — | A named individual | ch22 L192 |
| A5 | Effective date | `date` | — | — | org |
| A6 | Enforcement point | `free text` | — | Where this is actually checked — the CODEOWNERS line, the CI job name, the PR template line, the publish-workflow step | derived |
| B1 | Path | `free text` | — | Every instruction file, skill, persona and prompt across the estate | ch21 L4-12 |
| B2 | Primitive type | `select` | The seven types, printed with the routing table that assigns them | Which | ch12 L451-459 |
| B3 | Binding mode | `select` — eager preload / eager (conditioned) / lazy on-demand / dispatcher-mediated | Defaulted per primitive type from the binding table | Confirm, or record the exception | ch14 L79-85 |
| B4 | Trigger that loads it | `free text` | Defaulted per binding mode — every session; thread touches a matching path; description matches the task; parent spawns and names it | The actual glob, description or dispatcher call | ch14 L79-85 |
| B5 | Measured size | `free text` (token count) | — | Measured, not estimated | ch14 L101 |
| B6 | Cost cadence | `computed` from B3 | Paid every session unconditionally / paid on every session matching the scope / description eager and small, body on activation / paid only inside the child's context | — | ch14 L79-85 |
| B7 | Eager and over our own size line | `checkbox` | — | Ticked against the header box, not against any printed benchmark | derived |
| B8 | Owner / CODEOWNERS entry | `owner (named person)` | — | The person and the literal CODEOWNERS line | ch11 L82-88; ch22 L192 |
| B9 | Last edited | `date` | — | — | ch21 L4-12 |
| B10 | Consuming teams | `free text` | — | Which teams load this primitive | ch21 L4-12 |
| B11 | Overlap with another primitive | `select` — none / COINCIDENTAL / ESSENTIAL | The distinction printed beside the column: coincidental overlap is fine and needs no action; essential overlap is a missing dependency edge | The decision | ch21 L4-12, L37-39 |
| B12 | If ESSENTIAL — extraction target and ticket | `free text` | — | The package the shared content becomes, and the backlog item that does it | ch21 L37-39 |
| B13 | Declared in a manifest | `checkbox` | — | — | ch21 L105-111 |
| B14 | Pinned in a lockfile | `checkbox` | — | — | ch21 L105-111 |
| B15 | Last change and its semver class | `free text` | The five-row semver table printed beside the column — body edit is Patch; new slot or asset is Minor; reworded activation criteria is Major; renamed or removed slot is Major; a changed transitive closure is recorded in the lockfile, not the package version | The version and the class | ch21 L143-149 |
| C1 | Control | `select` (fixed 7) | Seven pre-printed: agent files version-controlled alongside the code they steer; CODEOWNERS entry; reviewed in pull requests; linted; tested (does the agent behave correctly with this rule loaded?); a regression in a primitive is treated as a defect; the dependency closure of the primitive is known | — | ch11 L82-88 |
| C2 | State | `select` — present / partial / absent | — | Which | derived |
| C3 | Evidence | `free text` | — | The CI job name, the CODEOWNERS line, the lint config path, the test file. A `present` with no evidence is downgraded to `partial` | derived |
| C4 | Owner | `owner (named person)` | — | — | ch11 L82-88 |
| C5 | Target date | `date` | — | For anything not `present` | ch11 L82-88 |
| D1 | The audit question | `free text` | Printed verbatim: *"Which version of &lt;primitive&gt; was loaded into the agent that approved &lt;PR&gt;?"* | The specific primitive and the specific merged PR | ch21 L165 |
| D2 | Our answer | `free text` | — | The version, or the reason there isn't one | ch21 L165-167 |
| D3 | Answered from a lockfile lookup alone | `checkbox` | — | Ticked only if the answer came from one lookup against the commit the PR was approved on | ch21 L165 |
| D4 | Attempted by, and when | `owner (named person)` + `date` | — | — | org |
| D5 | If not answerable — the gap | `free text` | The chapter's verdict printed beside the box: a team running primitives without a manifest and a lockfile "cannot answer step 7 honestly" | What is missing, and which Part A decision closes it | ch21 L167 |

**Absorbed detail.** All four merged candidates fill named columns here; nothing was dropped.
`WS-11-primitives-as-code-governance` is **Part C in its entirety** — its seven yes/no controls are
C1, its owner and target date are C4 and C5, and C3 is the evidence column added so a control
cannot be self-certified. `WS-14-primitive-binding-inventory` is **B1-B7** — path, type, binding
mode, load trigger, measured token size, per-session versus per-activation cost, and its
eager-over-threshold flag, with the threshold moved to the header box and labelled org-set.
`WS-14-primitive-dependency-closure-policy` is **six of the twelve Part A decisions** (lockfile
required and reviewed; who may publish; third-party review; mandatory `--dry-run` closure review;
the phantom-dependency rule; the distribution boundary) **plus B13 and B14**, which are where the
policy becomes an observable fact per primitive. `WS-21-primitive-inventory-drift-audit` is
**B1, B8, B9, B10, B11 and B12** — the current-state register and, in B11/B12, its decision column:
coincidental overlap needs no action, essential overlap is a missing dependency edge and generates
an extraction backlog item.

**Deliberate omission — no printed token threshold.** B7 is ticked against a line the team writes
in the header box. The book's only calibration table for context cost says of itself that it "is
not a benchmark" (ch15 L102), and no chapter publishes a size at which an eager primitive becomes
too large. Printing one would manufacture a threshold the book does not hold.

**Deliberate omission — no printed override count.** The override-versus-fork threshold is a Part A
decision the org writes. The book's sentence — a consumer overriding "three slots, then four, then
six, has crossed the threshold where forking the dependency is more honest" (ch21 L131) — prints
verbatim beside the field as the reasoning, but the number the org commits to is labelled org-set.
It is an escalation in prose, not a rule.

**Deliberate omission — no harness or vendor column.** Deliberate and load-bearing: the sheet's
subtitle is the claim that the decisions worth making are about the registry and CODEOWNERS rather
than the agent vendor (ch22 L192). A vendor column would invite the room to spend its session on
the one question this sheet argues is secondary.

## 6. Absorbed members (4)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-11-primitives-as-code-governance` - Agent Source Code Governance Checklist

- **Address.** `handbook\ch11-the-runtime-machine.qmd` L76-90, Markdown that steers an LLM is code (`#sec-runtime-markdown-is-code`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Yes/No per control, each with an owner and a target date: are agent files version-controlled alongside the code they steer, do they have CODEOWNERS, are they reviewed in pull requests, are they linted, do they have tests (does the agent behave correctly with this rule loaded?), is a regression in a primitive treated as a defect, and is the dependency closure of a primitive known.
- **Its output was.** A governance gap list for the agent-source-code layer with named owners — the policy half of the transformation plan.

### `WS-14-primitive-binding-inventory` - Primitive Inventory and Binding-Mode Ledger

- **Address.** `handbook\ch14-the-load-lifecycle.qmd` L69-89, Bind (`#sec-load-bind`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** One row per primitive the org has or plans: file path, primitive type, binding mode (eager preload / eager-conditioned / lazy on-demand / dispatcher-mediated), the trigger that loads it, measured token size, and whether that cost is paid every session or only on activation. A final column flags anything eager over a token threshold the team sets.
- **Its output was.** A ledger of every context-loading primitive with its binding mode and per-session token cost - the raw input to any context-budget conversation.

### `WS-14-primitive-dependency-closure-policy` - Agent Primitive Supply-Chain Policy

- **Address.** `handbook\ch14-the-load-lifecycle.qmd` L37-45, Resolve (`#sec-load-resolve`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Tick and name owners for each control: is a lockfile required and reviewed in PRs? who may publish internal primitives? are third-party/external primitive packages allowed, and under what review? is `--dry-run` closure review mandatory before a manifest change merges? what is the rule against phantom dependencies (inline / local sibling / declared external edge)? what stays outside the published distribution boundary to prevent bundle leakage?
- **Its output was.** A one-page primitive supply-chain policy with named owners and a review gate, attachable to the org's existing dependency/security policy.

### `WS-21-primitive-inventory-drift-audit` - Primitive Inventory and Drift Audit: What Do We Have, and Where Has It Forked?

- **Address.** `handbook\ch21-primitives-as-code.qmd` L4-12, Primitives as Code (`#sec-primitives-as-code`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** One row per existing instruction file, skill, persona or prompt across the estate: path, owner, last edited, which teams consume it, and -- the decision column -- whether content it shares with another primitive is COINCIDENTAL overlap (fine, no action) or ESSENTIAL overlap (a missing dependency edge; extract a package, declare the dependency, delete the copy).
- **Its output was.** A current-state primitive register plus an extraction backlog naming the shared content that must become its own package.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- None. This sheet can be filled cold.

**Consumed by:**

- `WS-14-silent-primitive-phase-triage` - The Silent Primitive: Four-Phase Triage Sheet (Pack Z - Second wave: the practitioner kit, fill order 8)
- `WS-15-context-budget-allocation` - Context Budget Allocation Worksheet (Pack Z - Second wave: the practitioner kit, fill order 9)
- `WS-21-skill-bundle-definition-of-done` - Definition of Done for a Shipped Skill Bundle (Pack Z - Second wave: the practitioner kit, fill order 11)
- `WS-22-recursive-architecture-canvas` - Instantiate the Reference Architecture: Our Skill / Persona / Context Canvas (Pack Z - Second wave: the practitioner kit, fill order 12)

**Feeds into (prose, from the source scan).** WS-05-governance-readiness-assessment (the lockfile row) and the platform-team charter

## 8. Facilitation

| | |
|---|---|
| Who fills it | The platform-team lead who will implement the policy, whoever owns CODEOWNERS across the primary repositories, and whoever runs their CI. One engineering leader with the authority to make an `A3 = mandatory` actually stick — without that person in the room, every decision drifts to advisory. |
| When in the session | Pack Z, fill order 3, fillable cold, and a prerequisite of four later sheets in the same pack (`WS-14-silent-primitive-phase-triage`, `WS-15-context-budget-allocation`, `WS-21-skill-bundle-definition-of-done`, `WS-22-recursive-architecture-canvas`). It gates the back half of the pack, so it must land before them and not merely be scheduled before them. |
| Duration | Part A, 90 minutes. Part C, 30 minutes in the same sitting. Part B is **not** a workshop item — it is an inventory pass across the estate, typically a day inside someone's week, done before the session or committed to in it. Part D takes five minutes and is deliberately done last. |
| Data needed in advance | A file listing of every instruction file, skill, persona and prompt across the estate — this is Part B's row set and it is the long pole. The current CODEOWNERS files. The CI configuration for the primary repositories. Whether any manifest or lockfile exists anywhere today, and if so where. |
| Room format | A3 spread for Parts A, C and D, filled live. Part B projected from a spreadsheet — it will not fit on paper past about thirty primitives, and the estate is usually larger than the room expects. |

**Facilitation note — Pack Z prerequisite condition.** This sheet governs an estate, and an
organisation that has not yet written primitives has nothing to register. The condition that makes
it worth a session is the shadow-AI census (`WS-02-shadow-ai-usage-inventory`) having turned up
substantial existing instruction files — in practice, the moment two teams are found maintaining
near-identical copies of the same guidance. That is precisely the drift the chapter opens with
(ch21 L4-12), and it is what turns column B11 from a hypothetical into a decision with a ticket
attached. Where the census found little, run Parts A and C only and book Part B for when there is
an estate to inventory; do not fill B with primitives the org intends to write.

**Second note — run Part D live, and last.** Pick a real primitive and a real merged pull request
and try to answer the question in front of everyone. The chapter's verdict is that a team without a
manifest and a lockfile "cannot answer step 7 honestly" (ch21 L167). A room that watches its own
answer fail funds the lockfile; a room that discussed the lockfile in the abstract does not. If the
answer succeeds, that is equally worth recording — it is the strongest evidence the policy is
already partly real.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **Every Part A decision has a position, a mandatory/advisory flag, a named owner and an
   enforcement point.** A decision with a position but a blank A6 is a preference. The sheet's
   stated output is a policy the platform team can implement, and A6 is the only column that makes
   it implementable.
2. **Part D was attempted against a real primitive and a real merged PR, and the outcome is
   recorded whichever way it went.** An unattempted Part D invalidates the sheet — it is the
   chapter's own governing test, not a closing formality (ch21 L165-167).
3. **Every primitive in Part B carries a binding mode and an owner.** Primitives with no owner are
   extracted into a separate list and become the first items of the remediation backlog; an
   unowned primitive is the one that drifts first.
4. **Every ESSENTIAL overlap in B11 has an extraction target and a ticket in B12.** An essential
   overlap recorded and left alone is the opening drift of ch21 written down and ignored
   (ch21 L4-12, L37-39).
5. **Both org-set numbers are labelled as org-set** — the eager-size line in the header box and the
   override-versus-fork threshold in Part A. Neither may be attributed to the book on the printed
   sheet, because the book states neither as a rule.
6. **Every Part C control marked `present` cites evidence in C3** — a CODEOWNERS line, a CI job
   name, a lint config path, a test file. A `present` with an empty evidence cell is downgraded to
   `partial` before the sheet closes (ch11 L82-88).
7. **It reconciles forward with the sheets that depend on it.** The binding modes recorded in B3
   are the values `WS-14-silent-primitive-phase-triage` will test at its Bind row, and the Part B
   rows are the primitives `WS-15-context-budget-allocation` will cost. A primitive present in one
   and absent from the other is a gap logged against whichever sheet is missing it, not a
   discrepancy to be smoothed over.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** Carried unchanged from _section-clusters.md section 7 for CL-PRIMITIVE-SUPPLY-CHAIN.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> FOUR LOCATIONS, recorded as ONE candidate: manifest-versus-lockfile table at 105-107; semver rules table at 143-149; the seven-step walkthrough at 157-169 whose step 7 is the governing acceptance test -- "which version of the rubric was loaded into the agent that approved PR #4711?" -- and which the chapter says a team without manifest and lockfile "cannot answer honestly"; the override-versus-fork threshold at 121-135 (a consumer overriding three, then four, then six slots has crossed into forking); and ch22:190-192, which supplies the sharpest leadership framing anywhere in Part III: "The decisions worth making this week are about your registry and your CODEOWNERS, not your agent vendor." Use that sentence as the worksheet's subtitle. OVERLAPS WS-20-agent-supply-chain-security-gate -- that is the threat/control half of the same supply chain, this is the governance/reproducibility half; ship facing or merge. Mostly structured already; only the decision column needs authoring. CONFIRMED DE-DUP: overlaps WS-14-primitive-dependency-closure-policy (Ch14, p2) and WS-11-primitives-as-code-governance (Ch11, p2). This row is the most concrete of the three -- it carries the manifest/lockfile distinction, the semver rules table and the step-7 audit test -- so it should be the surviving body, with the Ch11/Ch14 rows folded in.
