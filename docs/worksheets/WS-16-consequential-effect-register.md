# Consequential Side-Effect Register: What Can Our Agents Actually Do To Us?

`WS-16-consequential-effect-register` &middot; **Pack E - Guardrails: authority, risk and proof** &middot; fill order **5** &middot; type `inventory` &middot; audience **eng-leader** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A signed register of every consequential agent-reachable side effect with its reversal cost and its current enforcement point - the org's agent blast-radius baseline.

**Cluster.** `CL-TRUST-BOUNDARY` - The Agent Trust Boundary: What They May Reach, What They May Do, Which Gate Catches It

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch16-deterministic-probabilistic-boundary.qmd` |
| Chapter | The Deterministic/Probabilistic Boundary |
| Heading | Consequential Side Effects Belong on the Deterministic Side |
| Stable anchor | `#sec-seam-consequential-effects` |
| Lines | L45-60 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch16-deterministic-probabilistic-boundary.html#sec-seam-consequential-effects> |
| Locator quote | "Once you see the seam, the rule that follows is short" |

Resolve at any time with `python docs/resolve.py ws WS-16-consequential-effect-register`.

## 3. Source extract - the scaffolding, verbatim

```text
   45 | Once you see the seam, the rule that follows is short. **The model proposes; the gate disposes.** Every consequential side effect — the kind whose reversal costs more than its execution — must be performed by the deterministic side, against a declared shape, against an allowlist the agent did not write.
   46 | 
   47 | The Monday-morning failure had no gate. The fix has one. In a `gh-aw` workflow, the `safe-outputs:` block declares ahead of time the only kinds of side effect this workflow may produce: *create-issue*, *add-issue-comment*, *create-pull-request*, each with a typed schema and an optional allowlist for labels, target repositories, and issue assignees.[^ch14-safeoutputs] The agent emits a JSON artifact during its run; it never holds a token that can call the GitHub API directly. When the agent finishes, a deterministic post-stage reads the artifact, validates each entry against its declared schema, applies the allowlist filter, and only then calls the API. A fully compromised agent — one whose model has been manipulated, prompt-injected, or simply gone off the rails — cannot externalize an effect that the post-stage does not permit. The capability to externalize lives in the substrate, not in the prompt.
   48 | 
   49 | This is **strong-form supervised execution**: the agent never holds the write capability.[^ch14-genesis-a9] We will return to the strong/weak distinction at the end of the chapter.
   50 | 
   51 | `gh-aw` is one realization of this pattern. It is not the canonical form. Several other realizations exist; learning to recognize the same shape across them is the architect's skill.
   52 | 
   53 | - A **CI lambda gating tool execution.** The agent runs in a sandboxed CI job. Its tool surface is restricted to a narrow set of read-only commands plus a single `propose-change` command that writes to a buffered artifact. After the agent exits, a separate Lambda function — running with a different IAM role — reads the artifact, validates it, and applies the change against the system of record. The agent's role has no write permissions. The Lambda's role does.
   54 | - A **Buildkite job-level secret.** The agent runs in a job that has no access to the production deploy secret. It produces a pipeline manifest. A second job, pipeline-triggered and gated on a passing schema check, holds the secret and applies the manifest. Buildkite's per-step secret scoping is the substrate field that enforces the seam.
   55 | - An **Argo workflow with manual approval.** The agent's step in the DAG is `propose-manifest`. The next step is a `Suspend` template that waits for human approval; only the resumption transitions into the deterministic `apply-manifest` step. The seam here is reified as a node in the DAG, not as a buffer between processes.
   56 | - A **Temporal workflow with schema-checked activities.** The agent participates as a workflow step that returns a typed result. Activities — the things that have side effects — are separately registered, separately versioned, and called by the workflow only when the agent's typed result satisfies the activity's input schema. Replay-determinism is the substrate property that makes the seam auditable.
   57 | 
   58 | The realizations differ in detail. They share the shape: the model emits a structured proposal; a deterministic process executes the proposal under a declared schema and a declared allowlist; the agent does not hold the externalization capability. Whichever your team standardizes on, the design conversation should use the substrate-level vocabulary — *capability-based security*, *audit surface*, *post-stage* — not the vendor-specific syntax. The vendor-specific syntax only appears when you finally write the YAML.
   59 | 
   60 | ---
```

## 4. What the user fills

One row per side effect an agent could produce: the effect (open a PR, comment, merge, deploy, write to a system of record, email a customer, spend money), the system of record touched, reversal cost (minutes / hours / money / trust - and who pays), where it executes today (agent holds the token, or a post-stage does), the declared schema and allowlist that constrain it, and the grounding lookup that validates any external fact it asserts.

## 5. Field-level schema

A3 landscape, two sides. The sheet is organised the way the chapter is: **front — what agents
may reach** (block A, the five inbound access mechanisms; block B, the data classes and
boundaries); **back — what they may do about it** (block C, the consequential effect register
with its gate selection inline; block D, the signed supervision-form decision per environment).
Four blocks, five merged registers, one artefact — because a security reviewer who is handed
the outbound register alone will immediately ask what the agent can read, and the answer must
be on the same page.

**Block A — inbound: the five access mechanisms.** One row per mechanism; five rows, fixed.
There is no sixth.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Access mechanism | `select` (fixed 5) | Files / CLI / Web fetch / APIs and MCP / Multi-modal | — | ch15 L124-142 |
| 2 | Data sources in scope | `free text` | — | The concrete sources this mechanism reaches here — named repositories, named commands, named endpoints | ch15 L124-142 |
| 3 | What each source is authoritative for | `free text` | — | The bounded-scope grounding statement. Named **before** the fetch, not inferred after it | ch15 L124-142 |
| 4 | Verdict | `select` — approved / approved with controls / prohibited | — | One per mechanism | ch15 L124-142 |
| 5 | Enforcing control | `free text` | — | The specific setting that makes column 4 true, not the intention behind it | ch15 L124-142 |
| 6 | Owner | `owner (named person)` | — | — | org |
| 7 | MCP server allowlist | `free text` (attached list) | — | The explicit list of approved servers. Anything absent is denied; this is an allowlist, not a blocklist | ch15 L124-142 |
| 8 | Web-fetch egress rule | `free text` (one sentence) | — | What an agent may fetch, from where, and what it must drop afterwards | ch15 L124-142 |

**Block B — data classes and boundaries.** One row per repository, directory or data store an
agent may touch. Rows are org-supplied.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 9 | Repository, directory or data store | `free text` | — | Named as it is named in the estate | case study L118-139 |
| 10 | Sensitivity class | `select` | — | Our own classification tiers | case study L118-139 |
| 11 | Agents may read | `select` — yes / no / with controls | — | — | case study L118-139 |
| 12 | Agents may write | `select` — yes / no / with controls | — | — | case study L118-139 |
| 13 | A safety guardrail is expected to refuse here | `checkbox` | — | Tick where a model's own guardrail will likely decline the work even though we have authorised it | case study L118-139 |
| 14 | Named human fallback when it refuses | `owner (named person)` + `free text` | — | The person and the manual route. Required on every ticked row 13 | case study L118-139 |

**Block C — outbound: the consequential effect register.** One row per side effect an agent
could produce. Seeded with the effect classes the chapter names; the room adds its own.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 15 | Side effect | `free text` (seed rows pre-printed) | Create an issue / add an issue comment / create a pull request / merge / deploy or apply a manifest / write to a system of record / call an external API with side effects / spend money | Our own effects, named in our own vocabulary | ch16 L47, L53-56 |
| 16 | System of record touched | `free text` | — | — | org |
| 17 | Consequential? | `select` — yes / no | The test prints on the sheet: yes where **reversal costs more than execution** | The verdict | ch16 L45 |
| 18 | Reversal cost | `free text` — minutes / hours / money / trust | — | State the unit. "Hard" is not a cost | ch16 L45 |
| 19 | Who pays to undo it | `owner (named person)` | — | A person or a budget holder, never "the business" | ch16 L45 |
| 20 | Where it executes today | `select` — the agent holds the token / a deterministic post-stage holds it | — | Observed, not intended | ch16 L47 |
| 21 | Substrate realisation | `select` — declared safe-outputs block with typed schema / CI job whose post-stage runs under a separate IAM role / job-level secret held by a second, gated job / workflow suspend node requiring manual approval / separately registered schema-checked activity / none yet | The chapter's four realisations plus the declared-outputs shape | Which one we standardise on | ch16 L47, L53-56 |
| 22 | Declared schema | `free text` | — | The typed shape the proposal must satisfy before the post-stage will act on it | ch16 L47 |
| 23 | Allowlist | `free text` | — | Labels, target repositories, assignees, destinations — **written by us, not by the agent**. An unbuilt allowlist reads `none yet`, never blank | ch16 L45, L47 |
| 24 | Failure mode we fear | `select` — goal drift / schema violation / hallucinated external fact / typo at volume / scope creep | The five the chapter names | The one that actually worries us for this effect | ch16 L81-95 |
| 25 | Gate cell | `select` — exactly one of: programmatic-internal / judgement-internal / programmatic-external / judgement-external | The 2x2, printed on the sheet with its four mismatch examples | One X, not two | ch16 L81-95 |
| 26 | Concrete gate implementation | `free text` | — | Which validator, which rubric, which reviewer role | ch16 L81-95 |
| 27 | Gate exists today | `select` — yes / no | — | `no` rows compose the gates-we-must-build list | ch16 L81-95 |
| 28 | Gate owner | `owner (named person)` | — | — | org |
| 29 | Grounding lookup for any external fact this effect asserts | `free text` | — | The system-of-record query. A cold reader with a structural rubric does not close this column | ch16 L68-73 |
| 30 | Supervision form for this effect | `select` — strong / weak | — | Strong means the agent never holds the write capability for this effect | ch16 L126-134 |

**Block D — supervision form per environment.** Three rows, fixed. This block is signed.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 31 | Environment | `select` (fixed 3) | Developer laptop / CI / production automation | — | ch16 L126-134 |
| 32 | Does this client offer strong-form capability-based enforcement | `select` — yes / no | — | A fact about the substrate, not a preference | ch16 L126-134 |
| 33 | Chosen form | `select` — strong / weak | — | The preference rule prints beside the column: when the client offers strong-form, use it | ch16 L126-134 |
| 34 | If weak was chosen on a strong-form-capable client | `free text` + `signature` + `date` | — | The reason **and** the compensating control, signed and dated. Mandatory wherever column 32 is `yes` and column 33 is `weak` | ch16 L126-134 |
| 35 | The compliance claim we intend to make about agent-driven change | `free text` | — | Drafted in the chapter's vocabulary: what may be proposed, what the substrate enforces, what the audit trail records | ch16 L126-134 |
| — | Register signed by | `signature` + `date` | — | The engineer or architect accountable for the seam, countersigned by security | derived |

**Absorbed detail.** This is a five-into-one merge and every one of the five is visible on the
printed sheet. **Inbound access mechanisms** (`WS-15-context-access-mechanism-register`) is
block A entire: the five mechanisms are column 1, the bounded-scope "authoritative for"
statement is column 3, the approved / approved-with-controls / prohibited verdict is column 4,
the enforcing control and owner are columns 5-6, and its two specific demands — an explicit MCP
allowlist and a web-fetch egress rule — are columns 7 and 8 rather than prose.
**Data sensitivity classification** (`WS-CS-GROWTH-data-boundaries`) is block B: class, read
verdict and write verdict are columns 10-12, and its distinctive contribution, the expectation
that a guardrail will sometimes refuse work we have authorised and the named human who picks it
up, is columns 13-14. **Outbound consequential effects** is block C columns 15-23, the spine of
the sheet. **Gate selection** (`WS-16-gate-selection-matrix`) is columns 24-28: the feared
failure mode first, then exactly one cell of the 2x2, then the implementation and the owner,
and the `no` values in column 27 are its original output — the explicit list of gates the
organisation must build and does not yet have. **Write-token supervision**
(`WS-16-supervision-form-decision`) appears twice on purpose: per effect at column 30, and per
environment as the signed block D, because the absorbed decision is environment-scoped and its
compliance claim (column 35) has no per-effect equivalent.

**Deliberate omission.** No blast-radius score and no severity scale. Column 17 is binary
because the chapter's test is binary and already sharp — reversal costs more than execution —
and a five-point scale would let the room argue an effect down to a three rather than answer
the question. No vendor syntax anywhere on the sheet either: column 21 names the *shape*, not
the YAML. The chapter is explicit that the design conversation uses substrate vocabulary and
that vendor-specific syntax appears only when you finally write the file (ch16 L51, L58), and a
sheet pre-printed with one vendor's block teaches the room to recognise that vendor instead of
the pattern.

## 6. Absorbed members (4)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-15-context-access-mechanism-register` - What May Our Agents Reach? The Five Access Mechanisms Register

- **Address.** `handbook\ch15-attention-and-context-economy.qmd` L124-142, Five access mechanisms for the Context layer (`#sec-attention-access-mechanisms`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** One block per mechanism - Files, CLI, Web fetch, APIs/MCP, Multi-modal. For each: what data sources are in scope, what each source is *authoritative for* (the bounded-scope grounding statement), Approved / Approved-with-controls / Prohibited, the control that enforces it, and the named owner. Includes an explicit MCP server allowlist and an egress rule for web fetch.
- **Its output was.** A signed access-mechanism register: the agent data plane, its bounded scopes, and its allowlists - the document a security or compliance reviewer asks for first.

### `WS-16-gate-selection-matrix` - Gate Selection Matrix: Pick the Gate That Matches the Failure

- **Address.** `handbook\ch16-deterministic-probabilistic-boundary.qmd` L81-95, The Four Kinds of Quality Gate (`#sec-seam-quality-gates`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** For each consequential effect carried over from the register, the team names the specific failure mode it fears (goal drift, schema violation, hallucinated external fact, typo at volume, scope creep), then places an X in exactly one cell of the 2x2 - programmatic-internal, judgement-internal, programmatic-external, judgement-external - and writes the concrete implementation (which validator, which rubric, which reviewer role) plus who owns building it.
- **Its output was.** A completed gate matrix: every consequential effect mapped to one named gate with an owner and an implementation - and an explicit list of gates the org must build but does not yet have.

### `WS-16-supervision-form-decision` - Strong-Form or Weak-Form? The Write-Token Decision

- **Address.** `handbook\ch16-deterministic-probabilistic-boundary.qmd` L126-134, Strong-Form Supervised Execution (`#sec-seam-supervision-forms`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Per environment (developer laptop, CI, production automation): does this client offer strong-form capability-based enforcement? Y/N. Chosen form: strong / weak. If weak was chosen on a strong-form-capable client, the reason and the compensating control must be written in, signed and dated. A final field drafts the compliance claim the org intends to make about agent-driven change.
- **Its output was.** A dated, signed supervision-form decision per environment, with documented exceptions and compensating controls - the artefact a compliance reviewer can audit.

### `WS-CS-GROWTH-data-boundaries` - Agent Data Boundary and Sensitivity Classification

- **Address.** `case-study-growth-engine.qmd` L118-139, The PII Audit Pipeline (`#sec-cs-growth-pii-audit`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** One row per repository, directory or data store an agent may touch: sensitivity class, whether agents may read it, whether agents may write it, whether a safety guardrail is expected to refuse, and the named human fallback when it does.
- **Its output was.** A data boundary map that tells every agent primitive where it may operate, plus a fallback path for guardrail refusals.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-16-seam-placement-canvas` - Draw the Seam: Deterministic / Probabilistic Canvas (Pack D - Architecture and ownership, fill order 3)

**Consumed by:**

- `WS-16-seam-design-review-gate` - Seam Design-Review Gate Checklist (Pack Z - Second wave: the practitioner kit, fill order 15)
- `WS-17-escalation-autonomy-ladder` - Our Escalation and Autonomy Ladder (L1-L4) (Pack E - Guardrails: authority, risk and proof, fill order 6)

**Feeds into (prose, from the source scan).** WS-16-consequential-effect-register (one gate chosen per row) and WS-16-consequential-effect-register (per-row strong/weak form verdict).

## 8. Facilitation

| | |
|---|---|
| Who fills it | The engineer or architect who will build the seam, with the platform owner who actually controls tokens, secrets and IAM roles. **Security must be physically in the room**: columns 20-23 and the whole of block D are the organisation's write-token posture, and the MCP allowlist at column 7 is theirs to approve, not to be told about. Bring the data owners for the stores that appear in block B. Compliance attends for column 35 — the claim is drafted here but they are the ones who will have to stand behind it. Legal is not required; this is a substrate decision, not a contractual one. |
| When in the session | Pack E, fifth sheet, after `WS-16-seam-placement-canvas`, which is a hard prerequisite — you cannot register what crosses a seam nobody has drawn. It must precede `WS-17-escalation-autonomy-ladder`, which consumes it. The scheduling constraint that matters most is outside the session: **this sheet is completed before any write token is issued.** Running it after the first agent has a token converts it from a design instrument into an incident review. |
| Duration | Two to two and a half hours. Block A, 30 minutes. Block B, 30. Block C is the bulk — roughly 20 minutes per consequential effect once the room finds its rhythm, and most organisations surface somewhere between eight and fifteen. Block D is 20 minutes and must not be rushed, because column 34 is a signed exception and signatures collected in a hurry are the ones that are later disowned. |
| Data needed in advance | The list of tokens and credentials agents hold today, by environment — this is usually the first surprise; the MCP servers already installed, including transitive ones; current egress rules; which CI/CD platform is in use and whether it supports per-step secret scoping or a post-stage running under a separate role; the data classification policy; and the completed `WS-16-seam-placement-canvas`. |
| Room format | A3 landscape, two-sided. Run block C on a whiteboard first as a bare column of effects under the question *what is the worst thing an agent could do to us, and who pays to undo it* — the honest answers arrive in conversation and not in a grid — then transcribe. Blocks A and B fill straight onto the sheet. Block D is printed and signed in the room, not circulated afterwards. |

**Facilitation note carried from ch16.** The four substrate realisations at L53-56 are the
facilitator's cheat sheet for column 21, and their value is comparative: read them aloud so the
room hears the same shape in a CI job with a separate IAM role, a Buildkite job-level secret, an
Argo suspend node and a Temporal schema-checked activity. Then enforce the vocabulary rule at
L51 and L58 — the conversation runs in substrate terms (*capability-based security*, *audit
surface*, *post-stage*), and the moment someone starts writing YAML the room has stopped
designing. The second note is the one that changes outcomes: when a hallucination story comes
up, the instinct in the room will be to tighten the prompt. The chapter forecloses that at
L68-73. Grounding reduces the rate; the gate reduces the consequence; cost scales with blast
radius, not with incidence. Column 29 and columns 25-26 are therefore both required on every
consequential row, and a team that fills one and leaves the other blank has made the wrong fix
in writing.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **Every effect marked consequential in column 17 has been tested against the chapter's own
   definition in writing, and names who pays in column 19 as an individual or a budget holder.**
   The test is whether reversal costs more than execution (ch16 L45). "The business" pays for
   nothing; a register whose reversal costs are unowned is a list of worries.
2. **No consequential row reads `the agent holds the token` in column 20 without a named owner
   and a date against column 21.** That single combination is the entire reason this register
   exists, and an unremediated instance of it is the Monday-morning failure waiting to be
   repeated.
3. **Every consequential row has a declared schema (column 22) and an allowlist (column 23) the
   agent did not write.** A blank allowlist is read as "everything permitted"; an unbuilt one
   must say `none yet` and appear on the build list. The capability to externalise has to live
   in the substrate, and a schema nobody declared is not a substrate.
4. **Every row carries exactly one gate cell in column 25, and it matches the failure mode in
   column 24 rather than the gate that was cheapest to add.** Two specific pairings fail on
   sight: goal drift gated programmatic-internal, and a hallucinated external fact gated
   programmatic-external. The chapter names both as design mistakes (ch16 L81-95), and column 29
   is what closes the second.
5. **All five merged registers are populated, not just the spine.** Five access mechanisms each
   with a bounded-scope statement and a verdict, plus an explicit MCP allowlist and an egress
   rule; every sensitive store in block B with read and write verdicts and a named human
   fallback on each row where a guardrail refusal is expected; every consequential effect; one
   gate per effect with an owner; and a supervision verdict for all three environments. A sheet
   with block C filled and blocks A, B or D blank has answered a fifth of the question.
6. **Any `weak` in column 33 on a client that column 32 says is strong-form-capable carries a
   written reason, a named compensating control, a signature and a date.** The chapter's rule is
   that weak-form is a fallback for substrates without capability-based security, not a
   stylistic alternative (ch16 L126-134). An unsigned weak-form choice is drift, not an
   exception, and must be flagged in review.
7. **Reconciliation with `WS-17-escalation-autonomy-ladder`.** Every effect whose gate cell is
   judgement-external appears on that ladder at L3 or L4 with the same named owner. An effect
   gated on a human here and resolving at L1 there is a contradiction between two sheets that
   were filled by the same room, and it is resolved before either is published.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** Carried unchanged from _section-clusters.md section 7 for CL-TRUST-BOUNDARY.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Pre-groundbreaking governance instrument: the question "what is the worst thing an agent can do to us, and who pays to undo it" must be answered before any write token is issued. The book supplies the rule (line 45: "The model proposes; the gate disposes"), the definition of consequential ("the kind whose reversal costs more than its execution"), and four substrate realizations at lines 53-56 (gh-aw safe-outputs, CI lambda with a separate IAM role, Buildkite job-level secret, Argo suspend/approval, Temporal schema-checked activities) that populate the "where it executes" column. MERGED FIND: the grounding-versus-verification pair at lines 68-73 ("Grounding reduces the hallucination rate. Verification reduces the *consequence*") wanted its own blast-radius sheet; it is folded in here as two extra columns rather than duplicated, because it is the same register. Source is prose - needs authoring into a table, but every column is grounded in the text.
