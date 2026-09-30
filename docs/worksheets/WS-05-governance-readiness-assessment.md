# Governance Readiness Self-Assessment (Six Capabilities)

`WS-05-governance-readiness-assessment` &middot; **Pack E - Guardrails: authority, risk and proof** &middot; fill order **4** &middot; type `assessment` &middot; audience **mixed** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A scored governance baseline with an owner and a target date per capability, plus a named floor-violation list (any capability sitting at None).

**Cluster.** `CL-GOVERNANCE-CONTROLS` - Governance Capability and the Day-One Install List

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch05-governance-for-ai-assisted-delivery.qmd` |
| Chapter | Governance for AI-Assisted Delivery |
| Heading | Governance Readiness Checklist |
| Stable anchor | `#sec-governance-readiness` |
| Lines | L31-71 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch05-governance-for-ai-assisted-delivery.html#sec-governance-readiness> |
| Locator quote | "Governance for AI-assisted delivery spans six areas. Each exists on a maturity spectrum" |

Resolve at any time with `python docs/resolve.py ws WS-05-governance-readiness-assessment`.

## 3. Source extract - the scaffolding, verbatim

```text
   31 | Governance for AI-assisted delivery spans six areas. Each exists on a maturity spectrum. The checklist below is designed for self-assessment: locate your organization on each row, then prioritize the gaps that carry the most risk in your context.
   32 | 
   33 | Two background terms make the rows below easier to read. Part III distinguishes *strong-form supervised execution* — every agent action that crosses the boundary into the deterministic system is auditable, reversible, and policy-checked at execution time — from *weak-form supervised execution* — a human reviews the agent's output after the fact, but the action itself was not gated. Most organizations begin with weak-form supervision (PR review of agent-generated diffs) and move row-by-row toward strong-form supervision as the stakes rise. The checklist's "Enterprise" column is, in effect, the strong-form bar for that row. The "Basic" column is the weak-form floor.
   34 | 
   35 | ::: {tbl-colwidths="[3,12,25,28,32]"}
   36 | 
   37 | | # | Capability | None | Basic | Enterprise |
   38 | |---|---|---|---|---|
   39 | | 1 | **Audit trails** | No record of which code was agent-generated. Commits attributed to the prompting developer with no distinction. | Agent contributions tagged in commit metadata or PR labels. Prompt history retained for a defined period. | Full provenance chain: instruction given, context consumed, output produced, human review decision, and rationale — all queryable and linked to compliance artifacts. *Part III implements this as the agent-stack-trace and lockfile patterns.* |
   40 | | 2 | **Agent access controls** | Agents run with the developer's full credentials. No distinction between human and agent access scope. | Agents operate under scoped tokens with reduced permissions. File system and network access restricted to declared boundaries. | Least-privilege agent identities with per-task credential issuance, automatic expiration, and separate audit logging for agent actions. *Part III names the mechanism behind this row* capability-based security *— the runtime decides per-invocation which tools and contexts the agent can reach.* |
   41 | | 3 | **Approval workflows** | Standard code review applies identically to human and agent code. No additional scrutiny for agent output. | Agent-generated PRs are flagged for enhanced review. Critical paths (auth, payments, data access) require human sign-off regardless of author. | Risk-tiered review: agent output touching sensitive systems routed through security-aware reviewers with checklist-based verification. Approval latency tracked as a metric. *This is the strong-form supervision bar — the seam (the boundary where agent action meets the platform) is gated, not just observed.* |
   42 | | 4 | **Data boundary enforcement** | No controls on what data agents can access during code generation. Proprietary code, secrets, and customer data may enter agent context. | Agents restricted from accessing production data and secrets. Code sent to external models reviewed against data classification policy. | Data loss prevention integrated into agent workflows. Context filters prevent classified data from entering model prompts. Residency requirements enforced per jurisdiction. *Part III calls this discipline* bounded-scope grounding *— context is loaded with explicit provenance and an explicit boundary, not pulled in opportunistically.* |
   43 | | 5 | **Cost controls** | No visibility into agent-related compute or API spend. Costs absorbed into general cloud bills. | Per-team or per-project token budgets. Alerts on unusual consumption. Monthly cost reporting. | Real-time cost attribution per agent task. Automated circuit breakers on runaway sessions. Cost-per-feature tracking integrated into project planning. |
   44 | | 6 | **Compliance reporting** | Cannot demonstrate to an auditor how agent-generated code is governed. Compliance posture unknown. | Periodic manual reports on agent usage, access scope, and review rates. Policies documented but enforcement is process-dependent. | Automated compliance dashboards. Agent governance artifacts generated alongside code. Audit-ready evidence exportable on demand. Policy enforcement is systemic, not procedural. |
   45 | 
   46 | :::
   47 | 
   48 | Most organizations operating at Phase 3 (agentic coding, as described in Chapter 2) will find themselves in the "None" or "Basic" column for at least four of these six areas. That is expected. The purpose of the checklist is not to achieve "Enterprise" everywhere. It is to ensure you are not at "None" in any area that carries material risk for your business.
   49 | 
   50 | **A note on the Enterprise column.** The rightmost column describes a target state. Some of its requirements (full provenance chains, real-time cost attribution per agent task, automated compliance dashboards) exceed what current-generation tooling delivers out of the box. Treat the Enterprise column as directional, not immediate. When your compliance team asks "when do we get there," the honest answer is: some capabilities are available now with custom integration; others depend on tooling maturity that, as of mid-2025, remains ahead of generally available products. Plan accordingly, and do not let the aspiration prevent progress on Basic.
   51 | 
   52 | **Where to start.** Audit trails and agent access controls are the two capabilities that unblock everything else. Without knowing what agents did and limiting what they can do, the other four capabilities have no foundation. If your assessment shows "None" in these areas, start here.
   53 | 
   54 | ```{mermaid}
   55 | %%| fig-width: 4.5
   56 | %%| fig-cap: "Governance capability quick-start assessment"
   57 | %%| fig-alt: "A top-down decision flowchart for governance assessment. Starting at 'Assess 6 governance capabilities', it flows to a decision diamond: 'Any capability at None?' If Yes, go to 'Start here: Audit Trails + Access Controls' (red, indicating urgency). If No, check 'All at Basic or above?' If Yes, go to 'Safe to expand agent adoption' (green, indicating success), then to 'Invest toward Enterprise per regulatory scope' (blue). If No at the second decision, also go to the Audit Trails step. From Audit Trails, flow to 'Reassess quarterly', which loops back to the initial assessment."
   58 | %%| label: fig-governance-assessment
   59 | flowchart TD
   60 |     START["Assess 6<br/>governance capabilities"] --> Q1{"Any capability<br/>at 'None'?"}
   61 |     Q1 -->|Yes| FIX["Start here:<br/>Audit Trails +<br/>Access Controls"]
   62 |     Q1 -->|No| Q2{"All at<br/>'Basic' or above?"}
   63 |     Q2 -->|Yes| EXPAND["Safe to expand<br/>agent adoption"]
   64 |     Q2 -->|No| FIX
   65 |     FIX --> REASSESS["Reassess<br/>quarterly"]
   66 |     EXPAND --> MATURE["Invest toward<br/>'Enterprise' per<br/>regulatory scope"]
   67 |     REASSESS --> Q1
   68 | 
   69 | ```
   70 | 
   71 | > *The governance floor: no capability at "None" before expanding agent adoption. Start with audit trails and access controls — they unblock everything else.*
```

## 4. What the user fills

Six rows (audit trails, agent access controls, approval workflows, data boundary enforcement, cost controls, compliance reporting). Per row the team scores its current level None / Basic / Enterprise, cites the evidence for that score, sets a target level and date, names the accountable owner, and rates the business risk of staying put. A summary line records the lowest capability, which is the number that goes to the board.

## 5. Field-level schema

An A3 landscape booklet, four sides. **Front: block A**, the six-capability assessment, with the
governance-floor blockquote (ch05 L71) printed verbatim beneath it and the decision flowchart
(ch05 L54-69) reproduced as the scoring rule in the margin. **Inside spread: block B**, the
day-one observability install, and **block C**, the prompt supply-chain control set. **Back:
block D**, the verification cadence. Blocks B, C and D are the build backlog that block A
generates; they are on the same artefact because a readiness score with no install list is the
thing this chapter's readers reliably produce and never act on.

**Block A — the assessment.** One row per governance capability; six rows, fixed.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Capability | `select` (fixed 6) | Audit trails / Agent access controls / Approval workflows / Data boundary enforcement / Cost controls / Compliance reporting | — | ch05 L39-44 |
| 2 | None — what it looks like | `free text` (pre-printed, read-only) | The chapter's description, verbatim | — | ch05 L39-44 |
| 3 | Basic — what it looks like | `free text` (pre-printed, read-only) | The chapter's description, verbatim. This is the weak-form floor | — | ch05 L39-44, L33 |
| 4 | Enterprise — what it looks like | `free text` (pre-printed, read-only) | The chapter's description, verbatim. This is the strong-form bar, and the L50 caveat prints beside it | — | ch05 L39-44, L33, L50 |
| 5 | Mandatory for us | `computed` | — | Carried across from `WS-05-compliance-scope-and-posture-matrix` block B, not re-decided here | ch05 L94 |
| 6 | Our level today | `select` — None / Basic / Enterprise | — | The honest current score | ch05 L31 |
| 7 | Evidence for column 6 | `free text` | — | The artefact that makes the score checkable: a job name, a policy version, a dashboard, a report | ch05 L317 |
| 8 | Target level | `select` — Basic / Enterprise | — | Defaults to Basic. Selecting Enterprise requires column 9 plus a named dependency | ch05 L48, L50 |
| 9 | Target date | `date` | — | — | org |
| 10 | Accountable owner | `owner (named person)` | — | A named individual | org |
| 11 | Business risk of staying put | `H/M/L` | — | — | ch05 L48 — "not at None in any area that carries material risk" |
| 12 | Floor violation | `computed` | — | Auto-flags where column 6 reads None; these rows compose the floor-violation list | ch05 L71 |
| — | Lowest capability | `computed` | — | The minimum of column 6 across all six rows — the number that goes to the board | ch05 L71 |
| — | Reassessment date | `date` | — | Quarterly | ch05 L65, L276 |
| — | Signed and dated by | `signature` | — | The accountable engineering leader | derived |

**Block B — the day-one observability install.** One row per primitive; three rows, fixed.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 13 | Primitive | `select` (fixed 3) | Agent Stack Trace / Lockfile / Audit Trail | — | ch19 L149-157 |
| 14 | Intent | `free text` (pre-printed, read-only) | The chapter's intent sentence for each | — | ch19 L149-157 |
| 15 | Our tool | `free text` | — | The named product or in-house component | org |
| 16 | Owner | `owner (named person)` | — | — | org |
| 17 | In place by | `date` | — | Before the first agent runs in anger, not after the first incident | ch19 L157 |
| 18 | Where the trail physically lives | `free text` | — | A storage location, not a team | ch19 L149-157 |
| 19 | Who is able to rewrite it | `free text` | **nobody** — pre-filled | Confirm, or record a signed exception. The trail must be on a surface the agent cannot rewrite | ch19 L149-157 |
| 20 | Storage and query budget accepted | `currency` + `free text` | — | The cost is paid up front; the alternative is being undebuggable after the fact | ch19 L149-157 |

**Block C — the prompt supply-chain control set.** One row per control; eight rows, fixed.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 21 | Control | `select` (fixed 8) | Pre-deployment scanning of primitive content before agents read it / hidden-Unicode detection for tag characters, bidirectional overrides and variation selectors / lockfile pinning with content hashes / transitive MCP servers blocked by default / allowlist rather than blocklist for context inclusion / filesystem access restricted to relevant directories / credential files excluded from context / secret scanning and SAST on changed files | — | ch20 L297-307 |
| 22 | In place today | `select` — yes / partial / no | — | — | org |
| 23 | Tooling | `free text` | — | The scanner, the gate, the config setting | org |
| 24 | Owner | `owner (named person)` | — | — | org |
| 25 | Go / no-go line for installing any third-party primitive | `free text` + `signature` | — | One sentence: what must be true before we install a primitive we did not write. Signed | ch20 L297-307 — "file presence is execution" |

**Block D — the verification cadence.** One row per check; sixteen rows, fixed, grouped under
four cadence headings.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 26 | Cadence | `select` (fixed 4) | After every agent dispatch / after every wave, before committing / after every PR at the human review gate / weekly at team level | — | ch20 L317-357 |
| 27 | Check | `free text` (16 rows pre-printed, read-only) | The chapter's sixteen checks, verbatim | — | ch20 L317-357 |
| 28 | The book's method | `free text` (pre-printed, read-only) | The chapter's "How" column verbatim, including its week-over-week token-spike heuristic on the weekly cost row | — | ch20 L317-357 |
| 29 | What it catches | `free text` (pre-printed, read-only) | The chapter's named anti-pattern for that check | — | ch20 L317-357 |
| 30 | Our tool or command | `free text` | — | The real command or CI job name. Where column 28 carries a printed threshold, our own value goes here | org |
| 31 | Automated or manual | `select` | — | — | ch20 L357 — "Automate what you can. Checklist the rest" |
| 32 | Owner | `owner (named person)` | — | — | org |
| 33 | In place today | `select` — yes / partial / no | — | — | org |
| 34 | Hard gate or advisory | `select` | — | — | org |
| — | Checks we are choosing not to run | `free text` + `owner (named person)` + `signature` | — | The explicit list, with a reason per check | derived |

**Absorbed detail.** All three absorbed members survive intact as blocks B, C and D.
`WS-19-day-one-observability-install` is block B row-for-row: its three primitives are column
13, tool/owner/date are columns 15-17, "where the trail physically lives" is column 18, its
hard requirement that nobody can rewrite the trail is column 19 pre-filled rather than left to
the room, and its accepted storage-and-query budget is column 20.
`WS-20-agent-supply-chain-security-gate` is block C: all eight named controls are the fixed
options in column 21, owner and tooling are columns 23-24, and its written go/no-go line for
installing a third-party primitive is column 25, carrying a signature because "file presence is
execution" makes that sentence the install gate itself.
`WS-20-silent-failure-verification-cadence` is block D: all sixteen checks across all four
cadences are pre-printed in columns 26-29, our tool, automation status, owner, in-place status
and gate-or-advisory verdict are columns 30-34, and its explicit list of checks the
organisation is choosing not to run is the signed footer — omissions are recorded, never
implied by a blank.

**Deliberate omission.** No composite maturity score, no average, no percentage-ready figure.
The chapter's own scoring logic (ch05 L54-69) is a two-question decision — is any capability at
None, and is everything at Basic or above — and an average would let an Enterprise cost-controls
row offset a None in audit trails, which is exactly the trade the governance floor at L71
forbids. Column 8 also has no `None` option: a target of None is not a target, and a capability
the organisation genuinely will not invest in is recorded as a floor violation with a reason,
not as an achieved goal.

## 6. Absorbed members (3)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-19-day-one-observability-install` - Day-One Observability and Audit Install Checklist

- **Address.** `handbook\ch19-architectural-patterns-rosetta-stone.qmd` L149-157, 6. Recovery and observability layer (`#sec-recovery-patterns`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Three rows -- Agent Stack Trace, Lockfile, Audit Trail -- and per row: the tool we will use, the named owner, the in-place-by date, where the trail physically lives, who is able to rewrite it (the chapter requires: nobody), and the storage plus query budget accepted.
- **Its output was.** A signed day-one platform commitment: three observability primitives with tools, owners and dates, budgeted before the first agent runs in anger.

### `WS-20-agent-supply-chain-security-gate` - Prompt Supply-Chain Security Gate: Controls Before We Install Anything

- **Address.** `handbook\ch20-anti-patterns-and-failure-modes.qmd` L297-307, File Presence Is Execution (`#sec-anti-file-presence`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Tick and assign an owner to each control the chapter names: pre-deployment scanning of primitive content before agents read it, hidden-Unicode detection (tag characters, bidirectional overrides, variation selectors), lockfile pinning with content hashes, transitive MCP servers blocked by default, allowlist rather than blocklist for context inclusion, filesystem access restricted to relevant directories, credential files excluded from context, and secret scanning plus SAST on changed files.
- **Its output was.** A prompt-supply-chain control set with owner and tooling per control, and a written go/no-go line for installing any third-party primitive.

### `WS-20-silent-failure-verification-cadence` - Verification Cadence: Who Checks What, When, With Which Tool

- **Address.** `handbook\ch20-anti-patterns-and-failure-modes.qmd` L317-357, Silent Failure Detection Checklist (`#sec-anti-silent-failure-checklist`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** For each of the 16 checks across the four cadences (after every agent dispatch, after every wave before committing, after every PR at the human review gate, weekly at team level): our actual tool or command, automated or manual, the named owner, in place today (tick: yes / partial / no), and whether it is a hard gate or advisory.
- **Its output was.** A signed verification operating model -- the four-cadence control plane with named tools, owners and automation status, and an explicit list of checks we are choosing not to run.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-05-compliance-scope-and-posture-matrix` - Regulatory Scope and Required Posture Matrix (Pack E - Guardrails: authority, risk and proof, fill order 2)

**Consumed by:**

- `WS-05-board-reporting-scorecard` - Quarterly Board Scorecard: Adoption, Value, Cost, Risk (Pack G - The plan we leave with, fill order 7)
- `WS-05-decision-rights-gate-matrix` - Decision Rights and Gate Matrix: Who Decides What, With Which Evidence (Pack F - People and operating model, fill order 4)

**Feeds into (prose, from the source scan).** WS-03-go-no-go-readiness-gate and the Risk section of WS-05-board-reporting-scorecard

## 8. Facilitation

| | |
|---|---|
| Who fills it | The engineering leader who will own the plan, with the platform or CI owner beside them — blocks B, C and D are all their build backlog. **Security must be in the room** for capabilities 2 and 4 and for the whole of block C; there is no version of the supply-chain control set that can be scored without them. Bring whoever owns the tooling and inference spend line for capability 5, because "we can't see it" is a finding and they are the only person who can say it. Compliance attends for capability 6. Legal is **not** required here provided they were present for `WS-05-compliance-scope-and-posture-matrix`, whose output column 5 simply carries across. |
| When in the session | Pack E, fourth sheet — after the compliance scope matrix, which is a hard prerequisite, and after the risk register. The chapter prioritises by regulatory scope (ch05 L31, L94), so column 5 must already be settled or the room scores six capabilities with no way to tell which ones it is allowed to leave at Basic. Fill block A to completion, including column 8, **before** anyone opens block D; a room that starts on the sixteen checks first will design a control plane for capabilities it is not required to reach. |
| Duration | Block A, 60 minutes. Blocks B and C, 45 together. Block D, 60-90 and it frequently needs a second sitting with the platform team rather than the leadership group — that is a normal outcome, not a failure. Budget three hours for the whole booklet, or split A+B+C from D across two sessions. |
| Data needed in advance | The completed `WS-05-compliance-scope-and-posture-matrix`; the current CI configuration with job names; whether agent contributions are tagged in commit metadata or PR labels today, and how; current visibility of agent-related compute and API spend, at whatever granularity exists; the list of MCP servers and third-party primitives already installed; and the repository's existing lint, test and scanning jobs by name, so block D column 30 is observed rather than aspirational. |
| Room format | A3 landscape booklet, four sides. Block A projected and scored live — the argument about whether the organisation is at None or Basic on audit trails is the content of the session, and pre-filling it as homework removes the only part that matters. Blocks B, C and D printed, and filled by the platform group with the leader present to set dates. |

**Facilitation note carried from ch05.** Two passages print verbatim on the artefact. The
governance-floor blockquote at L71 goes under block A: *no capability at "None" before expanding
agent adoption*. The caveat at L50 goes beside column 4 and column 8: the Enterprise column is
directional, several of its requirements exceed what current tooling delivers out of the box,
and the honest answer to "when do we get there" is that some capabilities need custom
integration today and others wait on tooling maturity. A room that targets Enterprise on all
six rows has not read it, and will produce a plan that stalls in month two. Carry L52 as the
tie-break whenever the room wants to start somewhere more interesting: audit trails and agent
access controls unblock everything else, so if either is at None those two rows take the
earliest dates on the sheet regardless of what the rest of the assessment says. The decision
flowchart at L54-69 is the scoring rule, not decoration — reproduce it in the margin so the
room can see that "most organizations will be at None or Basic in at least four of six" is
expected (L48), and that the sheet is not a grade.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All six capabilities carry a level in column 6 and an artefact in column 7.** A score with
   no evidence is an opinion, and the rows were written (ch05 L39-44) so that the score is
   readable off observable state — a tagging convention, a token scope, a dashboard. "Probably
   Basic" fails this criterion.
2. **No capability marked mandatory in column 5 targets below Basic in column 8.** This
   reconciles row-for-row with block B of `WS-05-compliance-scope-and-posture-matrix`: a
   capability marked **Critical** under an in-scope framework cannot be left at None here. A
   mismatch between the two sheets is resolved before Pack E closes, not deferred.
3. **Every row at None is flagged in column 12 and appears on the floor-violation list with a
   named owner and a date — and if audit trails or agent access controls are among them, those
   two rows carry the earliest dates on the sheet.** That ordering is the chapter's own (L52);
   a plan that fixes compliance reporting before access controls has inverted it.
4. **Not all six rows target Enterprise.** If they do, the room has written down that it is
   overriding the L50 caveat, and every Enterprise row names the custom integration or vendor
   capability it depends on. An unqualified all-Enterprise target column is the signature of a
   sheet filled as an aspiration rather than a plan.
5. **Every row has a named individual in column 10 and the booklet carries a reassessment date
   within one quarter**, plus the accountable leader's signature. A capability owned by "the
   platform team" has no owner, and an unsigned assessment must not be carried into
   `WS-05-board-reporting-scorecard` as the risk baseline.
6. **Block B is complete on all three primitives — tool, owner and in-place-by date — with
   column 19 reading `nobody` or carrying a signed exception; and every block C control is
   scored with the go/no-go line in column 25 written and signed.** An unsigned go/no-go line
   means third-party primitives are being installed under no rule at all, which, given that file
   presence is execution (ch20 L297-307), is the most consequential blank on the booklet.
7. **All sixteen block D checks are scored; every check marked `in place` names a real command
   or job in column 30; and the checks the organisation is choosing not to run are listed
   explicitly with a reason and an owner.** An unlisted omission is indistinguishable from an
   oversight a quarter later, and the chapter's point (ch20 L357) is that silent failures are
   caught by structure, not by vigilance — a check with no command behind it is vigilance.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** Carried unchanged from _section-clusters.md section 7 for CL-GOVERNANCE-CONTROLS.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Anchor instrument of the governance half of the kit and the closest thing in Part II to the ch02 seed table. The book says it "is designed for self-assessment" (line 31) but provides no column to record the assessment in - add current / target / owner / evidence / risk columns. The decision flowchart at lines 54-69 is the scoring logic and should be reproduced as the worksheet decision rule; the governance-floor blockquote at line 71 belongs on the sheet verbatim. Facilitation caveat: the chapter warns the Enterprise column is directional and exceeds what current tooling delivers (line 50), so the worksheet must not let teams target Enterprise everywhere. Ordering note: the chapter says to prioritise by regulatory scope, so the compliance scope matrix must be filled first even though it appears later in the chapter.
