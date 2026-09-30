# Decision Rights and Gate Matrix: Who Decides What, With Which Evidence

`WS-05-decision-rights-gate-matrix` &middot; **Pack F - People and operating model** &middot; fill order **4** &middot; type `matrix` &middot; audience **eng-leader** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** An adapted, org-specific decision-rights and approval-gate matrix - the RACI of agent-assisted delivery - ready to post next to the readiness assessment.

**Cluster.** `CL-DECISION-RIGHTS` - Decision Rights and Agent Authority

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch05-governance-for-ai-assisted-delivery.qmd` |
| Chapter | Governance for AI-Assisted Delivery |
| Heading | The Architecture Decision Matrix |
| Stable anchor | `#sec-governance-decision-matrix` |
| Lines | L295-323 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch05-governance-for-ai-assisted-delivery.html#sec-governance-decision-matrix> |
| Locator quote | "The checklist above tells you what governance capabilities to build" |

Resolve at any time with `python docs/resolve.py ws WS-05-decision-rights-gate-matrix`.

## 3. Source extract - the scaffolding, verbatim

```text
  295 | The checklist above tells you what governance capabilities to build. The matrix below tells you, for each material decision an agent might participate in, *who decides what, with which evidence, gated by which check.* It is the governance overlay that sits on top of the **Governance and Distribution** layer of the reference architecture (Chapter 4) — the layer that ships primitives and lockfiles between teams. The Decision Matrix is what turns those primitives and lockfiles into auditable governance gates.
  296 | 
  297 | The matrix has six columns. Each row is a class of decision. Use it as a starting template; adapt the rows to the decision classes that recur in your organization's pull-request reviews and incident postmortems.
  298 | 
  299 | ::: {tbl-colwidths="[18,14,14,18,18,18]"}
  300 | 
  301 | | Decision class | Agent role | Human role | Evidence captured | Gate | Reversibility |
  302 | |---|---|---|---|---|---|
  303 | | **Code change in a low-risk module** (internal tooling, dev docs, non-production scripts) | Author the diff; run tests; open the PR | Review and merge | Diff, test output, agent stack trace | PR review by one human reviewer | Reversible: revert the commit |
  304 | | **Code change in a regulated path** (auth, payments, data access, customer PII handlers) | Draft the diff; cite the constraint | Review with security-aware reviewer; sign off | Diff, agent stack trace, the loaded scope-attached rules, the cited constraint | Two human approvers; one must hold the relevant security or compliance label | Reversible at code level; downstream effects (data writes) may not be |
  305 | | **Architecture decision affecting two or more teams** (API contract, shared module boundary, cross-cutting convention) | Draft an Architecture Decision Record (ADR); enumerate alternatives | Decide; sign the ADR | Draft ADR, discussion thread, the prior ADRs the agent cited | Architecture review forum; named decision owner signs | Reversible only by another ADR; cost of reversal is the migration |
  306 | | **Production deploy** (any change reaching customer-facing systems) | Build artefact; produce deployment manifest; run pre-deploy checks | Approve the rollout; monitor canary | Artefact hash, lockfile, deployment manifest, pre-deploy check output | CI gate (deterministic); deployment approval (human) | Reversible by rollback within the deployment window; not reversible after data migrations land |
  307 | | **External dependency adoption** (new library, new agentic primitive bundle from outside the org) | Identify the candidate; produce the lockfile diff and the supply-chain summary | Review the supply chain; approve or reject | Lockfile diff, signature verification output, license report, the agent's supply-chain summary | Security review; named library owner signs | Reversible only by removing the dependency and refactoring consumers |
  308 | | **Installing or running a cost-bearing agentic workflow** (frontier-model loops, high-volume automation) | Declare the workflow's model tier, expected per-run cost, and stop condition; emit cost telemetry | Approve install and run against expected ROI; assign the budget pocket | Cost gradient (model tier, eval results), expected per-run cost, budget-pocket assignment, run telemetry | Cost-vs-value approval at install and at run; local and low-gradient workflows waved through | Reversible: uninstall or revoke; spend already incurred is not recoverable |
  309 | | **Production incident response** (active outage, data exposure, security event) | Surface diagnostic context; draft remediation candidates; never execute | The on-call engineer decides and executes | Incident timeline, the diagnostic queries the agent ran, the candidates it drafted, the chosen path | Human-only execution; agent runs in advisory mode | Decision-by-decision; the agent does not hold the write capability |
  310 | 
  311 | :::
  312 | 
  313 | Three principles read across every row.
  314 | 
  315 | **The agent never holds the write capability for an irreversible action.** Code commits are reversible (you can revert). Production deploys are partly reversible (you can roll back within a window). Data migrations and external API calls with side effects are not. Wherever the row says the action is not reversible, the human is in the gate, not adjacent to it. This is the *strong-form supervised execution* bar from the readiness checklist above, applied row-by-row: the matrix is what makes the abstract bar concrete for the decision classes your organization actually encounters.
  316 | 
  317 | **Evidence is captured as artefacts, not as memory.** Every row's "Evidence captured" column lists files: the diff, the lockfile, the ADR, the agent stack trace, the loaded scope-attached rules. None of these are "the agent's reasoning" or "the reviewer's recollection." When an auditor or a postmortem asks *what was loaded into the agent at decision time*, the answer is the lockfile and the trace, not a story. Part III names this discipline; Chapter 21 (@sec-primitives-as-code) makes it operational at the package layer.
  318 | 
  319 | **Gates are layered, not duplicated.** A single decision often passes through more than one gate: a CI gate (deterministic checks), a code review gate (human judgement on the diff), a security review gate (human judgement on the supply-chain or constraint surface). The matrix names which gates apply to which decision class. Adding a gate slows the decision; removing a load-bearing one is how an agent-led pipeline produces a quietly non-compliant outcome that nobody notices until the audit. The matrix is how you keep that decision deliberate.
  320 | 
  321 | The cost-vs-value row is the newest of the six, and it has a chapter of its own. The chapter on the agentic SDLC bill builds the operating model this gate enforces — model tiering, intentional budget pockets, and a central catalogue of cost-effective workflows — so that approving spend becomes a deliberate bet rather than a default.
  322 | 
  323 | The matrix is the artefact your governance team should adapt and post next to the readiness checklist. The checklist tells you whether the *capability* exists; the matrix tells you whether each *decision* uses it. Together they are the governance layer your AI investment deserves.
```

## 4. What the user fills

Seven pre-populated decision classes plus blank rows the organisation adds from its own recurring pull-request reviews and incident postmortems. Per row: what the agent may do, what the human must do, the named approver role, the evidence artefacts we will actually capture and where they are stored, the gate (CI check / number of human approvers / required label / review forum) and whether that gate exists today, and the reversibility verdict. A validation pass checks the chapter rule that no irreversible action leaves the agent holding the write capability.

## 5. Field-level schema

A3 landscape, two sides. **Front — block A**, the decision-rights matrix itself: this is the
artefact the chapter tells you to post next to the readiness checklist, so it is designed to be
read on a wall and our own columns are kept short. **Back — block B**, the agent authority
matrix; **block C**, the pilot decision-rights strip; and **block D**, the validation pass and
sign-off. The seven decision classes print pre-filled and the organisation is expected to add
its own; the chapter offers them as a starting template, not a scope.

**Block A — the decision-rights matrix.** One row per decision class; seven pre-printed,
extendable.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Decision class | `free text` (7 pre-printed, extendable) | Code change in a low-risk module / code change in a regulated path / architecture decision affecting two or more teams / production deploy / external dependency adoption / installing or running a cost-bearing agentic workflow / production incident response — each with the chapter's parenthetical scope | Rows drawn from our own recurring pull-request reviews and incident postmortems | ch05 L297, L303-309 |
| 2 | Agent role — the book | `free text` (pre-printed, read-only) | The chapter's agent role per class | — | ch05 L303-309 |
| 3 | Agent role — ours | `free text` | — | Where we differ, and why | ch05 L297 |
| 4 | Human role — the book | `free text` (pre-printed, read-only) | The chapter's human role per class | — | ch05 L303-309 |
| 5 | Human role — ours | `free text` | — | — | ch05 L297 |
| 6 | Named approver | `free text` (role) + `owner (named person)` | Security-aware reviewer, named decision owner, named library owner, on-call engineer, as the chapter specifies per row | The role **and** the individual who holds it today | ch05 L304-309 |
| 7 | Evidence captured — the book | `free text` (pre-printed, read-only) | Diff, test output, agent stack trace, the loaded scope-attached rules, the cited constraint, draft ADR, prior ADRs cited, artefact hash, lockfile, deployment manifest, pre-deploy check output, signature verification output, licence report, supply-chain summary, cost gradient, run telemetry, incident timeline, diagnostic queries, drafted candidates | — | ch05 L303-309 |
| 8 | Evidence we will actually capture | `free text` | — | Per artefact, itemised. A row-level summary does not close this column | ch05 L317 |
| 9 | Where each artefact is stored | `free text` | — | **One location per artefact in column 8.** Not a team, not a tool category. Where the honest answer is `nowhere`, that is the entry | ch05 L317 — "Evidence is captured as artefacts, not as memory" |
| 10 | Gate — the book | `free text` (pre-printed, read-only) | The chapter's gate per class | — | ch05 L303-309 |
| 11 | Our gate | `free text` | — | The CI check by name, the number of human approvers, the required label, the named review forum | ch05 L319 |
| 12 | Does this gate exist today | `select` — yes / partial / no | — | Verified against the configuration, not recalled | ch05 L319 |
| 13 | If not: owner and build-by date | `owner (named person)` + `date` | — | Mandatory wherever column 12 is not `yes` | derived |
| 14 | Reversibility | `free text` (pre-printed, read-only) + `free text` | The chapter's verdict per class | Our verdict where our systems differ | ch05 L303-309 |
| 15 | The irreversible step in this row | `free text` | — | The specific point past which reversal is not possible: a data migration landing, an external API call with side effects, spend incurred, a dependency's consumers refactored | ch05 L315 |
| 16 | Does the agent hold the write capability at column 15 | `select` — yes / no | — | A `yes` is a finding, recorded in block D | ch05 L315 |

**Block B — the agent authority matrix.** One row per agent role the organisation intends to
run; five seeded, extendable.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 17 | Agent role | `free text` (5 seeded) | Code writer / Reviewer / Test runner / Deployer / planning agent (architect chatmode) | Our own agent roles | ch13 L234-239, L243 |
| 18 | Capability — explicit tool whitelist | `free text` | The chapter's whitelist per seeded role | Ours. **No wildcards.** A `tools: ["*"]` entry is the chapter's named anti-pattern and fails review on sight | ch13 L224, L234-239 |
| 19 | Knowledge — the file scope it can see | `free text` | The chapter's scope per seeded role, including what each role explicitly cannot see | Ours | ch13 L234-239 |
| 20 | Authority — the named operations that must **STOP** for human approval | `free text` | The chapter's STOP list per seeded role | Ours, named as operations rather than as categories | ch13 L234-239 |
| 21 | Who gives that approval | `owner (named person)` | — | — | derived |
| 22 | Within what time | `free text` | — | A response window the approver has agreed to | derived |

**Block C — the pilot decision-rights strip.** One row per decision class in the pilot; five
seeded.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 23 | Decision class in the pilot | `select` (5 seeded) | Philosophy and strategy / architecture / tool selection / implementation / refinement | Our pilot's own classes | case study publishing L28-34 |
| 24 | Who decides | `owner (named person)` | — | — | case study publishing L28-34 |
| 25 | Who executes | `free text` | — | Human, agent, or both, per class | case study publishing L28-34 |
| 26 | What evidence the agent must surface before the human decides | `free text` | — | The options and the trade-offs, surfaced **before** the call and not justified after it | case study publishing L28-34 |
| 27 | Is the human decision reversible | `select` — yes / no | — | — | case study publishing L28-34 |

**Block D — validation pass and sign-off.**

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 28 | Validation: no irreversible action leaves the agent holding the write capability | `checkbox` + `signature` | The rule prints beside it: wherever the action is not reversible, the human is **in** the gate, not adjacent to it | Tick only after every column 16 has been checked, and list every `yes` as a finding with a remediation owner | ch05 L315 |
| 29 | Gates added, gates removed, this revision | `free text` | The caution prints beside it: adding a gate slows the decision; removing a load-bearing one is how an agent-led pipeline produces a quietly non-compliant outcome nobody notices until the audit | Our change log | ch05 L319 |
| 30 | Posted where | `free text` | Next to the governance readiness checklist | The physical or digital location | ch05 L323 |
| 31 | Signed | `signature` + `date` | — | — | derived |

**Absorbed detail.** `WS-13-agent-authority-matrix` is block B entire, and the three-column
shape the chapter defines survives as columns 18-20: capability as an explicit tool whitelist
with no wildcards, knowledge as the file scope the agent can see, authority as the named
operations that must STOP. Its fourth column — who gives that approval and within what time — is
columns 21-22. Block B sits on this sheet rather than on its own because the two matrices answer
the same question at different grain: block A says which human decides a class of change,
block B says what an agent is even able to attempt before a human is involved.
`WS-CS-PUB-decision-rights` is block C: decision class, who decides, who executes, the evidence
the agent must surface before the human decides, and whether the human decision is reversible.
It is kept separate from block A deliberately — block A governs production decisions in the
steady state, block C governs a pilot before the steady state exists, and a team running a pilot
needs the second one first.

**Deliberate omission — the cost-bearing workflow row.** Row six of block A prints with its
gate, evidence and approver, and nothing more. Its expected per-run cost, budget-pocket
assignment and stop condition are **not** re-elicited here: the chapter defers that operating
model to the cost chapter at L321, and `WS-07-cost-vs-value-gate` owns it. The row carries a
printed pointer to that sheet so the omission reads as a hand-off rather than a gap.

**Deliberate omission — the naming hazard.** This sheet is built **only** from ch05's
Architecture Decision Matrix at L295-323. Chapter 4 carries a section with the identical heading
that resolves to the same anchor and is a different instrument — adoption sequencing, not
decision rights. No content from it appears here, and the sheet prints its own stable anchor
(`#sec-governance-decision-matrix`) on the artefact so a builder resolving the heading cannot
land on the wrong one.

## 6. Absorbed members (2)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-13-agent-authority-matrix` - Agent Authority and Approval Gate Matrix

- **Address.** `handbook\ch13-the-prose-specification.qmd` L224-291, S — Safety Boundaries (`#sec-prose-safety-boundaries`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** One row per agent role the organisation intends to run. Three columns the chapter defines: capability (the explicit tool whitelist — no wildcards), knowledge (the file scope it can see), and authority (the named operations that must STOP for human approval). A fourth column records who gives that approval and within what time.
- **Its output was.** A signed agent authority matrix: the organisation's written answer to what an agent may do without a human, and who is accountable when it does.

### `WS-CS-PUB-decision-rights` - Decision Rights Matrix: What Humans Decide, What Agents Execute

- **Address.** `case-study-publishing-pipeline.qmd` L28-34, Publishing Strategy: Three Rounds of Deliberation (`#sec-cs-publishing-strategy`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** One row per decision class in the pilot (philosophy/strategy, architecture, tool selection, implementation, refinement). Columns: who decides, who executes, what evidence the agent must surface before the human decides, and whether the human decision is reversible.
- **Its output was.** A signed decision-rights matrix that makes the human/agent division explicit before work starts rather than discovering it in conflict.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-05-governance-readiness-assessment` - Governance Readiness Self-Assessment (Six Capabilities) (Pack E - Guardrails: authority, risk and proof, fill order 4)
- `WS-06-role-map-and-staffing-triggers` - The Role Map — Who Holds Each Hat, and When We Staff It (Pack F - People and operating model, fill order 3)

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** Policy and CI gate implementation backlog; the Risk section of WS-05-board-reporting-scorecard

## 8. Facilitation

| | |
|---|---|
| Who fills it | The engineering leader, **with the named approvers from column 6 actually present** — a gate nobody in the room can staff is a gate that will not run. **Security must be in the room** for the regulated-path and external-dependency rows; **compliance** for the regulated-path and incident rows wherever the organisation is externally audited. Legal is not required provided they were present for `WS-05-compliance-scope-and-posture-matrix`. The platform or CI owner is essential for columns 11-13, because they are the only person who can answer whether a gate exists rather than whether it is believed to exist. Block B needs whoever configures the agent tooling. |
| When in the session | Pack F, fourth sheet, after both hard prerequisites: `WS-05-governance-readiness-assessment`, because a capability has to exist before a decision can use it, and `WS-06-role-map-and-staffing-triggers`, because columns 6 and 21 name people that sheet identified. It also wants `WS-05-org-policy-encoding-inventory` — not a formal prerequisite, but the gates enumerated there are the ones that belong in column 11, and running this sheet first means deriving the same list twice. |
| Duration | Block A, 90-120 minutes: seven rows, of which columns 9, 12 and 15 are each a small investigation rather than a question. Block B, 45. Block C, 20. Block D, 15 — and it must not be compressed, because it is the validation the chapter's first principle demands and the only place a `yes` in column 16 gets recorded. |
| Data needed in advance | The CI configuration with job names; branch protection and required-reviewer settings **as configured**, not as remembered; the real storage location of every evidence artefact the organisation already produces — build logs, lockfiles, ADRs, audit logs, incident timelines; the agent tooling configuration files, for block B column 18; and the outputs of both prerequisite sheets. |
| Room format | A3 landscape, two-sided. Block A is the posted artefact — design it to be legible on a wall next to the readiness assessment, and hold the room to short entries in the our-columns. **Fill columns 12 and 16 by checking, not by asserting:** one laptop open on the CI configuration during block A saves a quarter's worth of embarrassment, and it is the single highest-value piece of room setup on this sheet. |

**Facilitation note carried from ch05.** Three principles read across every row, and each has an
operational consequence the facilitator has to enforce rather than merely read out.

*The agent never holds the write capability for an irreversible action* (L315). That is column
16, and a `yes` is a finding recorded in block D with a remediation owner — not a shrug and a
"well, in practice it's fine".

*Evidence is captured as artefacts, not as memory* (L317). Column 9 wants a location per
artefact. "It's in the PR somewhere" is not a location. The test the chapter supplies is the one
to use in the room: when an auditor or a postmortem asks *what was loaded into the agent at
decision time*, the answer has to be the lockfile and the trace, not a story.

*Gates are layered, not duplicated* (L319). A single decision often passes a CI gate, a code
review gate and a security review gate, and column 11 exists to name which apply deliberately.
When the room starts trimming — and it will, because every gate is someone's latency — use the
chapter's own sentence: adding a gate slows the decision, and removing a load-bearing one is how
an agent-led pipeline produces a quietly non-compliant outcome that nobody notices until the
audit.

One last framing. The chapter offers its seven rows as a starting template and asks explicitly
that they be adapted (L297). A completed sheet with exactly seven rows has been transcribed, not
adapted; the extra rows come from the organisation's own recurring pull-request reviews and
incident postmortems, which is why the postmortem archive is worth having in the room.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **Every row names a gate, states whether it exists today, and — where it does not — carries
   an owner and a build-by date.** A matrix of gates that do not exist is a wish list. Column 12
   is what converts it into a backlog, and it is answered from the configuration rather than
   from recollection.
2. **Every evidence artefact in column 8 has exactly one storage location in column 9.** A team
   name, a tool category or "the PR" are not locations. Rows whose honest answer is `nowhere`
   say so and appear on the build backlog — that is a finding the chapter's second principle
   (L317) exists to surface, not a failure to be smoothed over.
3. **Every row names its irreversible step and answers column 16, and every `yes` is recorded in
   block D as a finding with a remediation owner.** The block D tick is made only after all rows
   have been checked, and the block is signed. An unsigned block D means the sheet's central
   rule — the agent never holds the write capability for an irreversible action — has not been
   validated, only asserted.
4. **At least one decision class has been added from our own pull-request reviews or incident
   postmortems.** Seven rows and no additions means the template was transcribed rather than
   adapted, which the chapter explicitly asks for at L297.
5. **Every approver in column 6 is a named individual as well as a role, and those names
   reconcile with `WS-06-role-map-and-staffing-triggers`.** An approver who exists only as a
   role title cannot be paged, and a name that appears here but not on the role map means one of
   the two sheets describes an organisation that does not exist.
6. **Block B contains no wildcard in column 18 on any row**, and every role's column 20 lists
   named operations that must STOP, each with an approver in column 21 and a response window in
   column 22. `tools: ["*"]` is the chapter's named anti-pattern; a blank authority column is
   the same anti-pattern expressed by omission.
7. **The cost-bearing-workflow row points to `WS-07-cost-vs-value-gate` rather than re-deriving
   expected cost, budget pockets and stop conditions here, and column 30 records where the sheet
   is posted** — beside the governance readiness assessment. The chapter's closing instruction
   is that the checklist tells you whether the capability exists and the matrix tells you whether
   each decision uses it; separated, neither does its job.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Carried unchanged from _section-clusters.md section 7 for CL-DECISION-RIGHTS.
- **Fill (the organisation completing it): `L`.** L - needs the real repository, finance input or cross-team agreement

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Strongest single governance instrument in the chapter and already close to worksheet form: six columns, seven rows, explicitly offered as "a starting template; adapt the rows" (line 297). Authoring needed is a "does this gate exist today?" column and a storage-location column per evidence artefact, since the chapter key claim is that evidence must be artefacts not memory (line 315). CRITICAL naming hazard: this section shares the exact heading "The Architecture Decision Matrix" with a completely different section in ch04 (line 185), so both resolve to anchor the-architecture-decision-matrix. They are different instruments - ch04 is adoption sequencing, ch05 is decision rights - and must not be merged. The cost-bearing-workflow row (line 308) is deferred to the dedicated cost chapter; check that chapter before duplicating.
