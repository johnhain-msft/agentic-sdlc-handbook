# Worksheet Map — *The Agentic SDLC Handbook*

**A buildable specification set, not a scope map.** Every place in the book where an
interactive worksheet belongs, addressed by a durable anchor, specified down to its
columns, and sequenced into a kit whose dependency graph resolves.

| | |
|---|---|
| **Scanned** | 33 `.qmd` files · 31 yielded candidates · 423 headings indexed |
| **Found** | **172** worksheet candidates at **164** distinct book locations |
| **Canonical worksheets** | **72** — 95 merged, 5 cut |
| **Re-opening pass** | 10 over-collapsed clusters re-opened · **36 split back out**, 26 folded with detail absorbed |
| **Build specs** | **72** files in `docs\worksheets\`, field-level, **72/72 verified** |
| **Schema detail** | **1,803** named columns · **518** acceptance criteria |
| **Build effort** | **39** near-free lifts · **33** need real authoring |
| **Dependency graph** | **0** dangling prerequisites · 0 cycles · 0 cross-pack order violations |
| **Anchors** | 152 applied on branch `chore/stable-anchors` · explicit ids 38 → **190** of 423 |
| **Resolver state** | `resolve.py check` → **172/172 resolving, 0 drift** |
| **stable_anchor** | **172 / 172** populated |
| **Regenerated** | 2026-09-30 |

---

## 1. What this is, and what it is not

**This is a specification set.** `docs\worksheets\` holds one build spec per worksheet.
Each names its columns, the input type per column, which cells are pre-filled from the book
and which are blank, who fills the sheet and when, what a well-completed sheet looks like, and
which hedged figures it must refuse to print as targets. A builder can work from it without
re-reading the book; the verbatim source extract travels inside the spec.

**It is still not the worksheets.** No layout, no typography, no facilitator script beyond the
notes in section 8 of each spec. The specs say what to build and how to tell whether it is
right. They do not draw it.

**What changed in this pass.** The previous map consolidated 172 candidates to 36. A review
found that defensible for a leadership kit and wrong for a complete worksheet set: ten clusters
held six or more members each and absorbed 72 candidates between them, and those members were
frequently different instruments rather than restatements of one. All ten were re-opened and
every one of their 62 members was decided individually — **36 split back out**,
**26 folded** with their field detail absorbed rather than discarded. Section 4 records
every decision and its reason.

**The book has been modified — locally, on a branch.** 152 headings now carry explicit stable
ids. Heading text is unchanged; only the attribute block was added. Nothing has been pushed and
no pull request exists. See section 6.

---

## 2. The delivery

A facilitated planning engagement run **before** an organisation breaks ground on an AI SDLC.
Pack A goes out ahead of the room. B→G run in sequence. G consumes every pack above it. Z ships
later, to the teams that build.

| Pack | Purpose | Sheets | of which priority 1 | near-free / authoring |
|---|---|---|---|---|
| **A — Groundwork (pre-work)** | Facts that cannot be produced in a workshop. Circulated 2–3 weeks ahead. | 4 | 4 | 1 / 3 |
| **B — Where we actually are** | Force an honest, evidenced current-state picture before anyone proposes a solution. | 4 | 4 | 2 / 2 |
| **C — The case and the money** | Produce a number a CFO can interrogate, and the controls that stop the bill running away. | 12 | 12 | 5 / 7 |
| **D — Architecture and ownership** | Decide the stack, the harness, what we buy, and where the deterministic/probabilistic seam sits. | 9 | 6 | 4 / 5 |
| **E — Guardrails: authority, risk and proof** | Settle what agents may reach, what they may do, and what we must be able to prove. | 6 | 5 | 3 / 3 |
| **F — People and operating model** | Map roles onto real people, settle decision rights, and resolve the central-team question. | 5 | 4 | 1 / 4 |
| **G — The plan we leave with** | Convert everything above into a dated, gated, signed plan. | 10 | 10 | 8 / 2 |
| **Z — Second wave: the practitioner kit** | Delivered after go, to the teams that build. Not part of the leadership engagement. | 22 | 4 | 15 / 7 |

**Leadership engagement = packs B–G = 46 sheets.** Pack A (4 sheets) is pre-work and must
complete first: several gates elsewhere are expressed as deltas from a baseline, and once work
starts the before-picture is unrecoverable. Pack Z (22 sheets) is the practitioner kit and is
not delivered in the leadership engagement at all.

**Why the count went up and the engagement did not.** A complete spec set is not a handout.
Five sheets ship as `facing:` pages physically bound to another sheet, and each spec records its
`ship_as` so the delivered kit stays a kit. The Tier-1 core below is unchanged at 16 sheets.

### The two-day Tier-1 core (16 sheets)

If the engagement compresses, these are the sheets where a human writes something an
unavoidable later decision consumes.

- **Pack A** — `WS-08-baseline-measurement-plan` · `WS-06-team-readiness-scorecard`
- **Pack B** — `WS-04-lifecycle-layer-coverage-canvas`
- **Pack C** — `WS-03-roi-break-even-model` · `WS-07-spend-pool-budget-model`
- **Pack D** — `WS-04-five-layer-supply-chain-canvas` · `WS-APXA-harness-selection-matrix`
- **Pack E** — `WS-05-org-policy-encoding-inventory` · `WS-16-consequential-effect-register`
- **Pack F** — `WS-05-decision-rights-gate-matrix` · `WS-07-central-team-charter`
- **Pack G** — `WS-08-pilot-selection-and-scope` · `WS-08-transition-roadmap` · `WS-08-phase-gate-exit-rollback` · `WS-27-first-week-plan` · `WS-03-go-no-go-readiness-gate`

> **Defect found by this pass, and not yet closed.** The Tier-1 core is not closed under its
> own dependency graph. These Tier-1 sheets declare a prerequisite that is *not* in the Tier-1
> core, so a compressed two-day engagement would reach them with an unfilled input:
>
> - `WS-03-go-no-go-readiness-gate` needs `WS-03-context-moat-asset-inventory` (A — Groundwork (pre-work), fill order 2)
> - `WS-03-roi-break-even-model` needs `WS-03-scenario-assumption-commitment` (C — The case and the money, fill order 2)
> - `WS-03-roi-break-even-model` needs `WS-03-tco-calculator` (C — The case and the money, fill order 3)
> - `WS-05-decision-rights-gate-matrix` needs `WS-05-governance-readiness-assessment` (E — Guardrails: authority, risk and proof, fill order 4)
> - `WS-05-decision-rights-gate-matrix` needs `WS-06-role-map-and-staffing-triggers` (F — People and operating model, fill order 3)
> - `WS-05-governance-readiness-assessment` needs `WS-05-compliance-scope-and-posture-matrix` (E — Guardrails: authority, risk and proof, fill order 2)
> - `WS-07-central-team-charter` needs `WS-06-role-map-and-staffing-triggers` (F — People and operating model, fill order 3)
> - `WS-07-spend-pool-budget-model` needs `WS-07-cost-variance-baseline` (C — The case and the money, fill order 4)
> - `WS-08-pilot-selection-and-scope` needs `WS-08-pitfall-risk-register` (G — The plan we leave with, fill order 8)
> - `WS-16-consequential-effect-register` needs `WS-16-seam-placement-canvas` (D — Architecture and ownership, fill order 3)
> - `WS-APXA-harness-selection-matrix` needs `WS-11-runtime-machine-inventory` (D — Architecture and ownership, fill order 4)
>
> This is a facilitation decision, not a data defect: either promote the named prerequisites
> into Tier-1, or accept that the compressed engagement fills those sheets on partial input
> and records the fact. Tier is a facilitation choice and is deliberately not held in the data.

---

## 3. The 72 canonical worksheets

Fill order is within a pack. `←` counts the candidates absorbed into that sheet; their field
detail is carried in section 6 of the sheet's own spec.

### Pack A — Groundwork (pre-work) — 4 sheets

| # | ws_id | Title | Type | Audience | Pri | ← | Build | Spec |
|---|---|---|---|---|---|---|---|---|
| 1 | `WS-02-shadow-ai-usage-inventory` | Shadow AI Usage Inventory | inventory | eng-leader | 1 | 1 | authoring | [spec](worksheets/WS-02-shadow-ai-usage-inventory.md) |
| 2 | `WS-03-context-moat-asset-inventory` | Context Asset & Debt Inventory | inventory | architect | 1 | 1 | authoring | [spec](worksheets/WS-03-context-moat-asset-inventory.md) |
| 3 | `WS-06-team-readiness-scorecard` | Team Readiness Scorecard — Eight Dimensions, Scored Honestly | assessment | eng-leader | 1 | 4 | near-free | [spec](worksheets/WS-06-team-readiness-scorecard.md) |
| 4 | `WS-08-baseline-measurement-plan` | Baseline Measurement and Instrumentation Plan | inventory | eng-leader | 1 | 4 | authoring | [spec](worksheets/WS-08-baseline-measurement-plan.md) |

### Pack B — Where we actually are — 4 sheets

| # | ws_id | Title | Type | Audience | Pri | ← | Build | Spec |
|---|---|---|---|---|---|---|---|---|
| 1 | `WS-01-vibe-coding-cliff-diagnostic` | Vibe Coding Cliff Symptom Diagnostic | diagnostic | eng-leader | 1 | 4 | authoring | [spec](worksheets/WS-01-vibe-coding-cliff-diagnostic.md) |
| 2 | `WS-04-lifecycle-layer-coverage-canvas` | Lifecycle Layer Coverage Canvas: Who, Which Agent, Which Platform, Per Phase | canvas | mixed | 1 | 2 | near-free | [spec](worksheets/WS-04-lifecycle-layer-coverage-canvas.md) |
| 3 | `WS-20-org-failure-amplifier-assessment` 🆕 | Organisational Readiness: Which Failure Amplifiers Do We Already Have? | assessment | exec | 1 |  | authoring | [spec](worksheets/WS-20-org-failure-amplifier-assessment.md) |
| 4 | `WS-27-workload-triage` | Workload Triage Screen: Does This Work Belong in the Agentic Path? | decision | mixed | 1 | 2 | near-free | [spec](worksheets/WS-27-workload-triage.md) |

### Pack C — The case and the money — 12 sheets

| # | ws_id | Title | Type | Audience | Pri | ← | Build | Spec |
|---|---|---|---|---|---|---|---|---|
| 1 | `WS-01-model-upgrade-assumption-audit` 🆕 | Tooling Assumption Audit: What a Better Model Will Not Fix | assessment | exec | 1 |  | authoring | [spec](worksheets/WS-01-model-upgrade-assumption-audit.md) |
| 2 | `WS-03-scenario-assumption-commitment` 🆕 | Scenario & Assumption Commitment | decision | exec | 1 |  | near-free | [spec](worksheets/WS-03-scenario-assumption-commitment.md) |
| 3 | `WS-03-tco-calculator` 🆕 | Year-One Total Cost of Ownership Calculator | calculator | eng-leader | 1 |  | near-free | [spec](worksheets/WS-03-tco-calculator.md) |
| 4 | `WS-07-cost-variance-baseline` 🆕 | Our Own Cost Spread — Measuring the Variance Before We Budget | calculator | mixed | 1 |  | authoring | [spec](worksheets/WS-07-cost-variance-baseline.md) |
| 5 | `WS-19-where-the-bill-gets-decided` 🆕 | Where Does the Bill Get Decided? Cost-Lever Ownership Map | decision | exec | 1 |  | authoring | [spec](worksheets/WS-19-where-the-bill-gets-decided.md) |
| 6 | `WS-03-roi-break-even-model` | Agentic ROI & Break-Even Model | calculator | exec | 1 | 1 | near-free | [spec](worksheets/WS-03-roi-break-even-model.md) |
| 7 | `WS-04-intent-build-operate-investment-balance` 🆕 | Intent / Build / Operate Investment Balance Sheet | calculator | exec | 1 |  | authoring | [spec](worksheets/WS-04-intent-build-operate-investment-balance.md) |
| 8 | `WS-07-spend-pool-budget-model` | The Four Spend Pools — Allocating and Metering the Agentic Budget | calculator | exec | 1 |  | near-free | [spec](worksheets/WS-07-spend-pool-budget-model.md) |
| 9 | `WS-07-three-variables-audit` 🆕 | The Three Levers Audit — Model, Tokens, Harness | inventory | architect | 1 |  | authoring | [spec](worksheets/WS-07-three-variables-audit.md) |
| 10 | `WS-02-cost-of-delay-case` 🆕 | Cost of Delay Case | assessment | exec | 1 |  | authoring | [spec](worksheets/WS-02-cost-of-delay-case.md) |
| 11 | `WS-07-cost-vs-value-gate` 🆕 | The Cost-vs-Value Gate — Approval Card for a Funded Workflow | checklist | mixed | 1 |  | near-free | [spec](worksheets/WS-07-cost-vs-value-gate.md) |
| 12 | `WS-07-model-tier-access-policy` 🆕 | Model Tier Access Policy — Who Gets the Frontier, and How | decision | eng-leader | 1 |  | authoring | [spec](worksheets/WS-07-model-tier-access-policy.md) |

### Pack D — Architecture and ownership — 9 sheets

| # | ws_id | Title | Type | Audience | Pri | ← | Build | Spec |
|---|---|---|---|---|---|---|---|---|
| 1 | `WS-02-capability-requirements-matrix` | Capability Requirements Matrix | matrix | architect | 1 | 3 | authoring | [spec](worksheets/WS-02-capability-requirements-matrix.md) |
| 2 | `WS-04-five-layer-supply-chain-canvas` | Five-Layer Supply Chain Instantiation Canvas | canvas | architect | 1 | 3 | authoring | [spec](worksheets/WS-04-five-layer-supply-chain-canvas.md) |
| 3 | `WS-16-seam-placement-canvas` | Draw the Seam: Deterministic / Probabilistic Canvas | canvas | architect | 1 |  | authoring | [spec](worksheets/WS-16-seam-placement-canvas.md) |
| 4 | `WS-11-runtime-machine-inventory` 🆕 | Four-Part Runtime Inventory | inventory | architect | 2 | 1 | near-free | [spec](worksheets/WS-11-runtime-machine-inventory.md) |
| 5 | `WS-APXA-harness-selection-matrix` | Harness Selection and Portability Matrix: What We Standardise On, and What It Costs Us | matrix | mixed | 1 | 4 | near-free | [spec](worksheets/WS-APXA-harness-selection-matrix.md) |
| 6 | `WS-17-orchestration-topology-selector` 🆕 | Orchestration Topology Selector: Which Patterns Do We Sanction? | decision | architect | 1 | 1 | authoring | [spec](worksheets/WS-17-orchestration-topology-selector.md) |
| 7 | `WS-17-coordination-tax-calculator` 🆕 | The Coordination Tax Calculator: When Does Orchestration Pay? | calculator | mixed | 1 |  | authoring | [spec](worksheets/WS-17-coordination-tax-calculator.md) |
| 8 | `WS-17-orchestration-state-requirements` 🆕 | Orchestration Layer Requirements: What the Harness Must Track | checklist | architect | 2 | 1 | near-free | [spec](worksheets/WS-17-orchestration-state-requirements.md) |
| 9 | `WS-17-single-vs-multi-agent-decision-matrix` 🆕 | Single Agent or Many? Scoping Decision Matrix | decision | practitioner | 3 |  | near-free | [spec](worksheets/WS-17-single-vs-multi-agent-decision-matrix.md) |

### Pack E — Guardrails: authority, risk and proof — 6 sheets

| # | ws_id | Title | Type | Audience | Pri | ← | Build | Spec |
|---|---|---|---|---|---|---|---|---|
| 1 | `WS-05-agent-risk-register` 🆕 | Agent Risk Register (Six Categories, Twelve Named Risks) | matrix | mixed | 1 |  | near-free | [spec](worksheets/WS-05-agent-risk-register.md) |
| 2 | `WS-05-compliance-scope-and-posture-matrix` | Regulatory Scope and Required Posture Matrix | matrix | exec | 1 | 1 | near-free | [spec](worksheets/WS-05-compliance-scope-and-posture-matrix.md) |
| 3 | `WS-05-org-policy-encoding-inventory` | Organisational Policy Encoding Inventory: What Your Agents Cannot Know | inventory | mixed | 1 | 3 | authoring | [spec](worksheets/WS-05-org-policy-encoding-inventory.md) |
| 4 | `WS-05-governance-readiness-assessment` | Governance Readiness Self-Assessment (Six Capabilities) | assessment | mixed | 1 | 3 | authoring | [spec](worksheets/WS-05-governance-readiness-assessment.md) |
| 5 | `WS-16-consequential-effect-register` | Consequential Side-Effect Register: What Can Our Agents Actually Do To Us? | inventory | eng-leader | 1 | 4 | authoring | [spec](worksheets/WS-16-consequential-effect-register.md) |
| 6 | `WS-17-escalation-autonomy-ladder` | Our Escalation and Autonomy Ladder (L1-L4) | rubric | eng-leader | 2 | 2 | near-free | [spec](worksheets/WS-17-escalation-autonomy-ladder.md) |

### Pack F — People and operating model — 5 sheets

| # | ws_id | Title | Type | Audience | Pri | ← | Build | Spec |
|---|---|---|---|---|---|---|---|---|
| 1 | `WS-06-skill-gap-and-hiring-bar` | Skill Gap Map and the Revised Hiring Bar | rubric | eng-leader | 1 | 4 | authoring | [spec](worksheets/WS-06-skill-gap-and-hiring-bar.md) |
| 2 | `WS-05-capability-retention-plan` 🆕 | Capability Retention and Fallback Plan | diagnostic | eng-leader | 2 |  | authoring | [spec](worksheets/WS-05-capability-retention-plan.md) |
| 3 | `WS-06-role-map-and-staffing-triggers` | The Role Map — Who Holds Each Hat, and When We Staff It | inventory | eng-leader | 1 | 4 | authoring | [spec](worksheets/WS-06-role-map-and-staffing-triggers.md) |
| 4 | `WS-05-decision-rights-gate-matrix` | Decision Rights and Gate Matrix: Who Decides What, With Which Evidence | matrix | eng-leader | 1 | 2 | near-free | [spec](worksheets/WS-05-decision-rights-gate-matrix.md) |
| 5 | `WS-07-central-team-charter` | Central AI Team Charter — Mandate, First Loop, and the Reuse Metric | canvas | eng-leader | 1 | 1 | authoring | [spec](worksheets/WS-07-central-team-charter.md) |

### Pack G — The plan we leave with — 10 sheets

| # | ws_id | Title | Type | Audience | Pri | ← | Build | Spec |
|---|---|---|---|---|---|---|---|---|
| 1 | `WS-18-plan-charter-and-principles` | The Plan Charter: Scope, Teams, Waves, Principles, Constraints | canvas | mixed | 1 | 4 | near-free | [spec](worksheets/WS-18-plan-charter-and-principles.md) |
| 2 | `WS-20-nineteen-failure-mode-premortem` | Pre-Mortem: Which of the 19 Failure Modes Will We Hit? | diagnostic | mixed | 1 | 2 | near-free | [spec](worksheets/WS-20-nineteen-failure-mode-premortem.md) |
| 3 | `WS-27-first-week-plan` | First Week Commitment Register (Day 1 to Day 5) | roadmap | mixed | 1 | 1 | near-free | [spec](worksheets/WS-27-first-week-plan.md) |
| 4 | `WS-08-phase-gate-exit-rollback` | Phase Gate Cards — Exit Signals, Rollback Triggers, and the Kill Switch | checklist | eng-leader | 1 | 2 | authoring | [spec](worksheets/WS-08-phase-gate-exit-rollback.md) |
| 5 | `WS-08-transition-roadmap` | The Transition Roadmap — Three Phases, Named Teams, Dated Gates | roadmap | mixed | 1 | 2 | near-free | [spec](worksheets/WS-08-transition-roadmap.md) |
| 6 | `WS-03-go-no-go-readiness-gate` | Go / No-Go Readiness Gate | checklist | exec | 1 | 2 | near-free | [spec](worksheets/WS-03-go-no-go-readiness-gate.md) |
| 7 | `WS-05-board-reporting-scorecard` | Quarterly Board Scorecard: Adoption, Value, Cost, Risk | canvas | exec | 1 | 4 | near-free | [spec](worksheets/WS-05-board-reporting-scorecard.md) |
| 8 | `WS-08-pitfall-risk-register` 🆕 | Transition Risk Register — Six Predictable Failure Modes | diagnostic | mixed | 1 |  | near-free | [spec](worksheets/WS-08-pitfall-risk-register.md) |
| 9 | `WS-08-pilot-selection-and-scope` | Pilot Selection and Scope Contract | decision | mixed | 1 | 2 | authoring | [spec](worksheets/WS-08-pilot-selection-and-scope.md) |
| 10 | `WS-08-transition-planning-checklist` 🆕 | The Transition Plan — Task-Level Checklist Across Five Blocks | checklist | mixed | 1 |  | near-free | [spec](worksheets/WS-08-transition-planning-checklist.md) |

### Pack Z — Second wave: the practitioner kit — 22 sheets

| # | ws_id | Title | Type | Audience | Pri | ← | Build | Spec |
|---|---|---|---|---|---|---|---|---|
| 1 | `WS-12-agent-persona-design-canvas` 🆕 | Specialist Agent Roster and Persona Canvas | canvas | architect | 2 | 1 | authoring | [spec](worksheets/WS-12-agent-persona-design-canvas.md) |
| 2 | `WS-12-project-decision-register` 🆕 | Project Decision Register and Staleness Review | inventory | architect | 2 |  | near-free | [spec](worksheets/WS-12-project-decision-register.md) |
| 3 | `WS-21-primitive-governance-policy` | Primitive Supply Chain: Registry, Pinning, Versioning and Ownership Decisions | decision | eng-leader | 1 | 4 | authoring | [spec](worksheets/WS-21-primitive-governance-policy.md) |
| 4 | `WS-27-starter-shape-target` | Target-State Primitive Bundle Definition | inventory | architect | 1 |  | near-free | [spec](worksheets/WS-27-starter-shape-target.md) |
| 5 | `WS-12-effective-context-trace` 🆕 | Effective Context Trace | diagnostic | practitioner | 2 |  | near-free | [spec](worksheets/WS-12-effective-context-trace.md) |
| 6 | `WS-13-instruction-hierarchy-canvas` 🆕 | Instruction Hierarchy Design Canvas | canvas | architect | 2 |  | authoring | [spec](worksheets/WS-13-instruction-hierarchy-canvas.md) |
| 7 | `WS-13-prose-readiness-assessment` | PROSE Readiness Assessment and Remediation Plan | rubric | mixed | 1 | 3 | near-free | [spec](worksheets/WS-13-prose-readiness-assessment.md) |
| 8 | `WS-14-silent-primitive-phase-triage` 🆕 | The Silent Primitive: Four-Phase Triage Sheet | diagnostic | practitioner | 3 | 1 | near-free | [spec](worksheets/WS-14-silent-primitive-phase-triage.md) |
| 9 | `WS-15-context-budget-allocation` 🆕 | Context Budget Allocation Worksheet | calculator | practitioner | 2 |  | near-free | [spec](worksheets/WS-15-context-budget-allocation.md) |
| 10 | `WS-20-recovery-runbook` 🆕 | When It Goes Wrong: Our Six-Step Recovery Runbook | checklist | practitioner | 2 |  | near-free | [spec](worksheets/WS-20-recovery-runbook.md) |
| 11 | `WS-21-skill-bundle-definition-of-done` 🆕 | Definition of Done for a Shipped Skill Bundle | checklist | practitioner | 3 |  | near-free | [spec](worksheets/WS-21-skill-bundle-definition-of-done.md) |
| 12 | `WS-22-recursive-architecture-canvas` 🆕 | Instantiate the Reference Architecture: Our Skill / Persona / Context Canvas | canvas | architect | 1 |  | authoring | [spec](worksheets/WS-22-recursive-architecture-canvas.md) |
| 13 | `WS-CS-HB-review-loop` 🆕 | Review Loop Design Canvas | canvas | eng-leader | 2 |  | near-free | [spec](worksheets/WS-CS-HB-review-loop.md) |
| 14 | `WS-12-failure-triage-log` | Agent Failure Triage Log | diagnostic | practitioner | 3 | 2 | near-free | [spec](worksheets/WS-12-failure-triage-log.md) |
| 15 | `WS-16-seam-design-review-gate` | Seam Design-Review Gate Checklist | checklist | architect | 2 | 3 | near-free | [spec](worksheets/WS-16-seam-design-review-gate.md) |
| 16 | `WS-22-recursion-governance-bounds` 🆕 | Bounding the Recursion: Eval, Plan Persistence and Depth Limits per Skill | rubric | architect | 2 |  | authoring | [spec](worksheets/WS-22-recursion-governance-bounds.md) |
| 17 | `WS-CS-APM-plan-gate` 🆕 | Plan Gate and Scope-Change Protocol | decision | eng-leader | 2 |  | near-free | [spec](worksheets/WS-CS-APM-plan-gate.md) |
| 18 | `WS-17-agent-team-charter` 🆕 | Agent Team Charter: Mapping Concerns Onto Owners | canvas | architect | 2 |  | near-free | [spec](worksheets/WS-17-agent-team-charter.md) |
| 19 | `WS-17-conflict-resolution-playbook` 🆕 | Agent Conflict Playbook: File, Semantic, Design | diagnostic | practitioner | 3 | 1 | authoring | [spec](worksheets/WS-17-conflict-resolution-playbook.md) |
| 20 | `WS-17-dispatch-brief-template` 🆕 | Agent Dispatch Brief Template and Quality Check | checklist | practitioner | 3 | 2 | near-free | [spec](worksheets/WS-17-dispatch-brief-template.md) |
| 21 | `WS-18-wave-decomposition-plan` | Wave Decomposition Plan and Self-Sufficiency Check | roadmap | practitioner | 3 | 3 | near-free | [spec](worksheets/WS-18-wave-decomposition-plan.md) |
| 22 | `WS-CS-APM-checkpoint-assertions` 🆕 | Definition of Done: Behavioural Checkpoint Assertions | checklist | eng-leader | 2 |  | authoring | [spec](worksheets/WS-CS-APM-checkpoint-assertions.md) |

🆕 = split back out of an over-collapsed cluster in this pass.

---

## 4. The re-opening pass

### 4.1 What was wrong

Ten clusters held six or more members and absorbed **72 of the 172 candidates**. Their canonical
rows carried a 300–530 character prose description — enough to decide scope, not enough to build
from — and the merged members' detail was not carried anywhere. The worst case,
`CL-WAVE-EXECUTION`, held eleven members whose descriptions totalled 3,450 characters against a
486-character canonical, and those members were a context-budget calculator, checkpoint
assertions, a dispatch-brief template and a thread-handoff contract — four different instruments.

**Three independent signals confirmed the merge was too aggressive, rather than this pass being
too eager to split:**

1. **The dependency graph.** Nine of the 23 dangling `prereq_ws` references pointed at members
   that this pass split back out. The prior session's own model already treated them as separate
   worksheets; the merge simply broke the edges.
2. **Cluster names.** `CL-SPEND-GOVERNANCE` split 5-for-5 with no folds. Its own name lists four
   distinct instruments — *Pools, Tiers, Gates and Levers* — plus a lifecycle allocation.
3. **The source scans said so.** Several merges overrode an explicit instruction in the scan
   notes: ch08's *"ship them as a matched pair … **not merge them**"*, ch19's *"CONFIRMED DE-DUP
   … should **not** be merged into one"*, ch17's warning that two chapters must not yield two
   competing wave-planning worksheets.

### 4.2 The test applied

A member was split out only if **all three** held:

- **(a)** it produces a different *output artifact*, not a section of the canonical's;
- **(b)** it is filled by a different person, or at a different occasion or cadence;
- **(c)** folding it would lose a *decision*, not merely detail.

**Override:** it also splits if a surviving worksheet declares it a `prereq_ws`. A prerequisite
that does not exist as a worksheet makes the dependency graph fiction.

Everything else folded — and a fold is not a deletion. Section 6 of each canonical spec lists
every absorbed member with its address, why it folded, and the fill detail that must appear in
the canonical's field schema.

### 4.3 Every decision

#### `CL-WAVE-EXECUTION` — Wave Planning and Dispatch Kit

Canonical retained: `WS-18-wave-decomposition-plan`. 10 members re-decided: **4 split**, 6 folded.

| ws_id | Decision | Lands in | Reason |
|---|---|---|---|
| `WS-15-context-budget-allocation` | **split** | new cluster `CL-CONTEXT-BUDGET` (Z), ships `standalone` | A per-repository token budget across eleven context categories with a committed eager-load ceiling a team can regression-test against -- a different unit, a different owner and a durable number, not a wave-sizing step. |
| `WS-17-dispatch-brief-template` | **split** | new cluster `CL-DISPATCH-BRIEF` (Z), ships `standalone` | A reusable per-dispatch brief plus a five-point pre-flight gate, named in the canonical's own feeds_into; it is the instrument the wave plan consumes, not a part of it. |
| `WS-CS-APM-checkpoint-assertions` | **split** | new cluster `CL-CHECKPOINT-DOD` (Z), ships `facing:WS-18-wave-decomposition-plan` | A definition-of-done instrument -- observable behaviour, the command that observes it, expected output, signature -- signed per checkpoint by an eng-leader; folding it loses the decision that a green build is insufficient. |
| `WS-CS-APM-plan-gate` | **split** | new cluster `CL-PLAN-GATE` (Z), ships `facing:WS-18-wave-decomposition-plan` | A governance policy with a named approval authority and a hard scope-change rule -- scope expands only through the gate, never mid-wave -- plus a reusable version/scope/trigger log; a written policy, not a column on a wave table. |
| `WS-10-agent-task-brief` | **fold** | absorbed into `WS-17-dispatch-brief-template` | The same artefact, a one-page reusable brief template; contributes the three context categories (structural / constraint / domain) as the brief's content taxonomy and the bad-spec/good-spec calibration pair. |
| `WS-10-first-day-walkthrough` | **fold** | absorbed into `WS-17-dispatch-brief-template` | The dispatch brief's worked first use; contributes the timeline grid (elapsed / role / dispatched-vs-typed / which context file was improved) as the brief's first-run record. |
| `WS-11-thread-handoff-design` | **fold** | absorbed into `WS-17-orchestration-state-requirements` | Both specify where coordination state lives between threads; contributes the per-workflow handoff contract -- which file carries state, who writes it, who re-reads it, what a child inherits. |
| `WS-13-session-decomposition-plan` | **fold** | absorbed into `WS-18-wave-decomposition-plan` | The canonical's task rows at session granularity, governed by the identical self-sufficiency test; contributes the four-column session table and the scope-creep counter-example. |
| `WS-CS-APM-context-budget` | **fold** | absorbed into `WS-18-wave-decomposition-plan` | The arithmetic behind the canonical's own agent-count column (touchpoints / per-agent ceiling = sub-waves); same fill, same person, same sitting. |
| `WS-CS-APM-wave-plan` | **fold** | absorbed into `WS-18-wave-decomposition-plan` | The same wave table at case-study resolution; contributes the named-checkpoint-assertion column and the one-file-one-agent-per-wave rule with its single documented exception. |

#### `CL-COST-MODEL` — Investment, Break-Even and the Cost of Waiting

Canonical retained: `WS-03-roi-break-even-model`. 7 members re-decided: **6 split**, 1 folded.

| ws_id | Decision | Lands in | Reason |
|---|---|---|---|
| `WS-01-model-upgrade-assumption-audit` | **split** | new cluster `CL-TOOLING-ASSUMPTION` (C), ships `standalone` | An assumption register containing no cost arithmetic, filled by executives with no finance input; it is the opening exercise that pre-empts 'wait for the next model', not a block of a break-even model. |
| `WS-02-cost-of-delay-case` | **split** | new cluster `CL-COST-OF-DELAY` (C), ships `standalone` | The board answer to 'what if we wait a year', which consumes the ROI model's output and runs it backwards; a downstream deliverable with its own risk panel, not an input block. |
| `WS-03-scenario-assumption-commitment` | **split** | new cluster `CL-SCENARIO-COMMITMENT` (C), ships `standalone` | A signed, dated assumption set with a named optimism-owner and the gamble gate ('if it only works at aggressive, you have a gamble'); a signature artefact, and a declared prerequisite of the canonical. |
| `WS-03-tco-calculator` | **split** | new cluster `CL-TCO` (C), ships `standalone` | The year-one cost build-up across six components, filled by finance and procurement at a different sitting; the canonical already declares it a prerequisite, which a merged row cannot satisfy. |
| `WS-07-cost-variance-baseline` | **split** | new cluster `CL-COST-VARIANCE` (C), ships `standalone` | A measurement exercise producing the organisation's own spread exhibit in its own numbers; it is the declared prerequisite of WS-07-spend-pool-budget-model, a different canonical. |
| `WS-17-coordination-tax-calculator` | **split** | new cluster `CL-COORDINATION-TAX` (D), ships `standalone` | Answers a different decision in a different unit -- human coordination minutes as a percentage, yielding a multi-agent go/no-go threshold -- and sits between two Pack D worksheets, so leaving it in Pack C inverted the fill order. |
| `WS-27-instrumentation-breakeven` | **fold** | absorbed into `WS-03-roi-break-even-model` | The same output as the canonical (months to break even); contributes the mandatory range-not-point discipline and the 15-20% / 2-3x sensitivity poles as a required sensitivity page. |

#### `CL-TARGET-BUNDLE` — Target State: Starter Bundle, Personas and Pods

Canonical retained: `WS-27-starter-shape-target`. 7 members re-decided: **5 split**, 2 folded.

| ws_id | Decision | Lands in | Reason |
|---|---|---|---|
| `WS-12-agent-persona-design-canvas` | **split** | new cluster `CL-PERSONA-ROSTER` (Z), ships `standalone` | A per-specialist configuration canvas (domain expertise, patterns enforced, anti-patterns never produced, tool whitelist) plus a three-to-five starting roster; the tool-whitelist column is the matched pair to the authority matrix and cannot drift from it. |
| `WS-17-agent-team-charter` | **split** | new cluster `CL-AGENT-TEAM-CHARTER` (Z), ships `standalone` | Maps each concern onto an agent team AND onto the human team that owns the same concern today -- a Conway's-law mapping the persona canvas never asks; already a declared prerequisite of WS-18-plan-charter-and-principles. |
| `WS-21-skill-bundle-definition-of-done` | **split** | new cluster `CL-BUNDLE-DOD` (Z), ships `standalone` | A CI merge gate enforced by the platform team on every new or changed bundle, not a target-state definition; it is the mechanism that makes the primitive-governance policy real rather than aspirational. |
| `WS-22-recursive-architecture-canvas` | **split** | new cluster `CL-RECURSIVE-CANVAS` (Z), ships `standalone` | A two-column today/target canvas for one flagship workflow plus an explicit gap list; it nests inside the five-layer canvas ('opens one cell' of it) and is the declared prerequisite of the recursion-bounds sheet. |
| `WS-CS-HB-review-loop` | **split** | new cluster `CL-REVIEW-LOOP` (Z), ships `standalone` | Designs a draft-review-revise quality loop with a fixed verdict vocabulary, parallel reviewer proxies and a named synthesiser of conflicting fixes -- a process design, not a roster or a bundle definition. |
| `WS-CS-HB-persona-gap-register` | **fold** | absorbed into `WS-12-failure-triage-log` | The same habit and the same output column (the primitive edit that closed it); contributes the gap-versus-failure trigger distinction and the explicit create-a-primitive-not-an-ad-hoc-prompt policy field. |
| `WS-CS-HB-persona-roster` | **fold** | absorbed into `WS-12-agent-persona-design-canvas` | The same roster instrument; contributes the pod structure (coherence / domain / reviewer-proxy / audit) and the 'whose judgement does this proxy' column, plus the warning not to copy the book's editorial personas. |

#### `CL-RISK-PREMORTEM` — Pre-Mortem: Failure Modes, Amplifiers and Agent Risks

Canonical retained: `WS-20-nineteen-failure-mode-premortem`. 6 members re-decided: **4 split**, 2 folded.

| ws_id | Decision | Lands in | Reason |
|---|---|---|---|
| `WS-05-agent-risk-register` | **split** | new cluster `CL-AGENT-RISK` (E), ships `standalone` | A standing governance register tabled at a risk committee on a quarterly cadence with a named individual per risk -- different owner, cadence and audience; contested-merge #6 named exactly this as the split-back condition. |
| `WS-05-capability-retention-plan` | **split** | new cluster `CL-CAPABILITY-RETENTION` (F), ships `standalone` | Not a register at all: a deliberate-practice programme plus a dated 48-hour agent-unavailability drill with scope and success criteria, which sets hiring and training budget. |
| `WS-08-pitfall-risk-register` | **split** | new cluster `CL-TRANSITION-RISK` (G), ships `standalone` | Pre-mortems the plan just drafted (six transition pitfalls with early-warning signals and watchers) rather than the technology; it depends on the roadmap, a dependency the merged position made unsatisfiable. |
| `WS-20-org-failure-amplifier-assessment` | **split** | new cluster `CL-ORG-AMPLIFIERS` (B), ships `facing:WS-20-nineteen-failure-mode-premortem` | An executive self-assessment needing no telemetry, repo access or engineering data -- the earliest page in the kit anyone can fill -- and the book supplies pairings so it computes against the technical pre-mortem rather than duplicating it. |
| `WS-20-house-failure-mode-register` | **fold** | absorbed into `WS-20-nineteen-failure-mode-premortem` | Literally the canonical's table with blank rows plus the five-field row schema printed as a template; its own note recommends shipping it as the back page so the annual re-run stays obvious. |
| `WS-CS-APM-antipattern-diagnostic` | **fold** | absorbed into `WS-20-nineteen-failure-mode-premortem` | A six-row subset of the canonical's nineteen modes; the canonical's own note directs the four case-study tables to become pre-filled exemplar rows rather than four separate sheets. |

#### `CL-SPEC-CONTEXT-DESIGN` — Specification and Context Design Kit

Canonical retained: `WS-13-prose-readiness-assessment`. 6 members re-decided: **3 split**, 3 folded.

| ws_id | Decision | Lands in | Reason |
|---|---|---|---|
| `WS-12-effective-context-trace` | **split** | new cluster `CL-CONTEXT-TRACE` (Z), ships `standalone` | A per-file composition trace whose pass/fail test is that no layer contradicts the layer above; already a declared prerequisite of WS-12-failure-triage-log, a different canonical. |
| `WS-12-project-decision-register` | **split** | new cluster `CL-DECISION-REGISTER` (Z), ships `standalone` | A living decision register plus a standing quarterly staleness-review commitment with a named re-verifier -- an ongoing governance artefact with a cadence, not a point-in-time assessment. |
| `WS-13-instruction-hierarchy-canvas` | **split** | new cluster `CL-INSTRUCTION-HIERARCHY` (Z), ships `standalone` | Designs a target three-level hierarchy and the migration list to reach it, tested by 'can module-specific rules be added without editing any file above that module?' -- design work, not scoring. |
| `WS-01-prose-constraint-readiness` | **fold** | absorbed into `WS-13-prose-readiness-assessment` | The same assessment at five-constraint resolution, which the canonical already claims as its rollup and executive-reporting layer; contributes the anti-pattern hit-list as the scorecard's failure view. |
| `WS-13-disclosure-refactor-audit` | **fold** | absorbed into `WS-13-prose-readiness-assessment` | Produces the file-level backlog behind checklist items P1 and P2, and the canonical's own title already claims remediation; contributes the per-file inventory columns and is where the 40-50 vs 100-line conflict must print. |
| `WS-27-structural-properties-map` | **fold** | absorbed into `WS-13-prose-readiness-assessment` | The book states at ch27 line 106 that these five properties map directly onto the PROSE constraints; its own note directs keeping the PROSE version and attaching the four case-study What Held True sections as pre-filled examples. |

#### `CL-FAILURE-OPS` — Failure Triage and Recovery Runbook

Canonical retained: `WS-12-failure-triage-log`. 6 members re-decided: **3 split**, 3 folded.

| ws_id | Decision | Lands in | Reason |
|---|---|---|---|
| `WS-14-silent-primitive-phase-triage` | **split** | new cluster `CL-PRIMITIVE-TRIAGE` (Z), ships `standalone` | A different diagnostic tree entirely -- four phases (Resolve / Materialize / Bind / Activate) with falsifiable one-minute tests -- run when a primitive never fired, not when output was wrong. |
| `WS-17-conflict-resolution-playbook` | **split** | new cluster `CL-CONFLICT-PLAYBOOK` (Z), ships `standalone` | Produces the named list of coordination-bottleneck files that constrains how waves may be partitioned; already a declared prerequisite of WS-18-wave-decomposition-plan, a different canonical. |
| `WS-20-recovery-runbook` | **split** | new cluster `CL-RECOVERY-RUNBOOK` (Z), ships `standalone` | A runbook pinned in the repo whose load-bearing field is who is authorised to call the stop -- an authority decision the triage log never makes; the cluster rationale itself calls it the front door. |
| `WS-15-attention-starvation-diagnostic` | **fold** | absorbed into `WS-14-silent-primitive-phase-triage` | Its own note specifies the two ship as a single two-sided card -- did the file load (ch14) versus did the model attend to it (ch15); contributes the six-row symptom table and the three numbers that settle most cases. |
| `WS-18-adapt-loop-protocol` | **fold** | absorbed into `WS-17-conflict-resolution-playbook` | Same orchestrator, same recovery discipline, and its own note offers precisely this fold; the guardrail block -- add tasks, split tasks, reorder waves; never skip validation, never merge unvalidated work -- must be preserved verbatim. |
| `WS-CS-PUB-cascade-log` | **fold** | absorbed into `WS-12-failure-triage-log` | A worked exemplar of one anti-pattern rather than a separate sheet, per its own note; contributes the one-fix-rebuild-commit discipline and a pre-set stop-and-reassess threshold as a footer rule. |

#### `CL-SPEND-GOVERNANCE` — The Agentic Budget: Pools, Tiers, Gates and Levers

Canonical retained: `WS-07-spend-pool-budget-model`. 5 members re-decided: **5 split**, 0 folded.

| ws_id | Decision | Lands in | Reason |
|---|---|---|---|
| `WS-04-intent-build-operate-investment-balance` | **split** | new cluster `CL-IBO-BALANCE` (C), ships `standalone` | Allocates along a different axis -- Intent / Build / Operate lifecycle buckets with accountable executives and planning cadences -- not across spend pools; already a declared prerequisite of WS-05-board-reporting-scorecard. |
| `WS-07-cost-vs-value-gate` | **split** | new cluster `CL-SPEND-GATE` (C), ships `facing:WS-05-decision-rights-gate-matrix` | A per-workflow approval card -- owner, expected cost per run and per month, stop condition, off-switch -- completed at install time and re-checked at run time; a standing control, not a budget allocation. |
| `WS-07-model-tier-access-policy` | **split** | new cluster `CL-TIER-POLICY` (C), ships `standalone` | A written two-tier access policy plus an escape-hatch design (approver, time box, budget cap, decision SLA, backlog landing) needing procurement and security in the room -- the gate is a queue, not a wall. |
| `WS-07-three-variables-audit` | **split** | new cluster `CL-LEVER-AUDIT` (C), ships `standalone` | A per-workflow audit naming the specific misroutings and token taxes to fix and who decided each lever; it is the evidence that sets tier policy, and that policy's declared prerequisite. |
| `WS-19-where-the-bill-gets-decided` | **split** | new cluster `CL-COST-LEVER-OWNERSHIP` (C), ships `facing:WS-07-spend-pool-budget-model` | Answers who owns each architectural cost lever rather than what it costs; its own note records the de-dup as confirmed and specifies a half-page facing the spend-pool sheet. |

#### `CL-STACK-OWNERSHIP` — The Five-Layer Stack: What We Run, and Who Owns Each Layer

Canonical retained: `WS-04-five-layer-supply-chain-canvas`. 5 members re-decided: **1 split**, 4 folded.

| ws_id | Decision | Lands in | Reason |
|---|---|---|---|
| `WS-11-runtime-machine-inventory` | **split** | new cluster `CL-RUNTIME-INVENTORY` (D), ships `standalone` | Inventories a different stack -- the four runtime parts (model, harness, agent source code, client) -- and the client row is the trust boundary almost no organisation has inventoried. |
| `WS-06-layer-ownership-map` | **fold** | absorbed into `WS-04-five-layer-supply-chain-canvas` | The same five layers with the owner column the canonical already carries; contributes the two cross-cutting rows (composition across Skills, identity and policy plane) and the named-individual-not-role-label requirement. |
| `WS-09-agentic-vocabulary-alignment` | **fold** | absorbed into `WS-04-five-layer-supply-chain-canvas` | The cluster rationale states outright that it runs as a five-minute warm-up, not as a worksheet; contributes the eight-term glossary block that opens the canonical's session. |
| `WS-09-five-layer-ownership-canvas` | **fold** | absorbed into `WS-04-five-layer-supply-chain-canvas` | An identical five-layer canvas; contributes the job / artefact-on-disk / primary-author columns the chapter hands over verbatim, and the Governance-layer pass/fail probe. |
| `WS-19-runtime-substrate-inventory` | **fold** | absorbed into `WS-11-runtime-machine-inventory` | The same runtime at pattern-layer resolution; contributes the lock-in / 'our decision or the vendor's' column and the three-lens reconciliation table as the facilitation aid. |

#### `CL-SEAM-DESIGN` — Design the Agentic System: Seam, Topology and Bounds

Canonical retained: `WS-16-seam-placement-canvas`. 5 members re-decided: **4 split**, 1 folded.

| ws_id | Decision | Lands in | Reason |
|---|---|---|---|
| `WS-17-orchestration-state-requirements` | **split** | new cluster `CL-ORCH-STATE` (D), ships `standalone` | A build-or-buy requirements checklist used to evaluate harnesses and internal tooling against a named feature list -- a buying question, not a design question. |
| `WS-17-orchestration-topology-selector` | **split** | new cluster `CL-TOPOLOGY-STANDARD` (D), ships `standalone` | An organisation-wide sanctioned-topology standard carrying the recursion-depth and fan-out bounds the harness must enforce; contested-merge #9 named exactly this as the split-back condition. |
| `WS-17-single-vs-multi-agent-decision-matrix` | **split** | new cluster `CL-AGENT-COUNT-DECISION` (D), ships `standalone` | A per-change scoping verdict with a local recalibration field that replaces the book's explicitly unmeasured 10-15 file boundary; used per change, whereas the topology standard is set once per organisation. |
| `WS-22-recursion-governance-bounds` | **split** | new cluster `CL-RECURSION-BOUNDS` (Z), ships `standalone` | Per-Skill quantitative bounds (returned artefact, eval, plan-persistence path and retention, max dispatch depth, compute ceiling); the topology standard bounds work classes, this bounds individual Skills, and no schema enforces it. |
| `WS-09-orchestration-policy-matrix` | **fold** | absorbed into `WS-17-orchestration-topology-selector` | Its own note names ch17 the canonical home and says merge rather than ship both; contributes the per-workflow policy columns (composition pattern, max depth, context budget per thread, eval, plan-persistence path). |

#### `CL-ROADMAP` — The Transition Roadmap: Phases, Gates, Waves and Tasks

Canonical retained: `WS-08-transition-roadmap`. 5 members re-decided: **1 split**, 4 folded.

| ws_id | Decision | Lands in | Reason |
|---|---|---|---|
| `WS-08-transition-planning-checklist` | **split** | new cluster `CL-TRANSITION-CHECKLIST` (G), ships `standalone` | The source scan explicitly forbids merging these two zoom levels; this is the terminal task-level artefact -- 36 pre-written tasks plus owner, target date and evidence -- that a delivery lead loads into a tracker on day one. |
| `WS-02-adoption-sequencing-roadmap` | **fold** | absorbed into `WS-08-transition-roadmap` | Shipping both would hand the organisation two competing plans, which its own note forbids; contributes the six near-term actions as the pre-Phase-1 block with owner / date / budget / exit-criteria columns. |
| `WS-04-adoption-roadmap-with-gates` | **fold** | absorbed into `WS-08-phase-gate-exit-rollback` | Gates already have a canonical home; contributes the five numeric milestone thresholds and the mandatory Month-0 baseline-capture column, without which every gate in the kit is unusable. |
| `WS-12-instrumentation-rollout-roadmap` | **fold** | absorbed into `WS-27-first-week-plan` | Two competing first-N-days plans is the same defect as two competing roadmaps; contributes weeks two and three and the three named week-one files with an author each, extending the five-day plan. |
| `WS-CS-HB-wave-sequencing` | **fold** | absorbed into `WS-08-transition-roadmap` | Four labelled ordering slots rather than a sheet; contributes the risk-ordering rubric -- prove the pipeline, then lowest risk, then hardest, then integration -- as the canonical's sequencing rule. |

The machine-readable version is `docs\_reopen-decisions.tsv` (original cluster, ws_id, title,
decision, target, pack, ship_as, reason).

### 4.4 Delivery shape of the splits

| ship_as | Count | Meaning |
|---|---|---|
| `standalone` | 31 | Its own sheet in the pack's fill order. |
| `facing:<ws_id>` | 5 | A half-page or facing page physically bound to another sheet, filled in the same sitting. |

- `WS-CS-APM-plan-gate` faces `WS-18-wave-decomposition-plan`
- `WS-CS-APM-checkpoint-assertions` faces `WS-18-wave-decomposition-plan`
- `WS-20-org-failure-amplifier-assessment` faces `WS-20-nineteen-failure-mode-premortem`
- `WS-07-cost-vs-value-gate` faces `WS-05-decision-rights-gate-matrix`
- `WS-19-where-the-bill-gets-decided` faces `WS-07-spend-pool-budget-model`

---

## 5. The repaired dependency graph

The previous set had **23 dangling `prereq_ws` references** — prerequisites naming worksheets
that had been merged away. All are repaired: repointed to the surviving canonical, or dropped
where the target was cut or had been merged into the very worksheet that declared it.

**A second class of defect surfaced that the previous map never checked for: six worksheets
declared a prerequisite that fills in a *later* pack**, so the kit could not be filled in its own
stated order. Five pre-date the re-opening pass and were invisible only because the prerequisite
was dangling. Each is recorded rather than silently adjusted:

| Consumer | Prerequisite | Resolution |
|---|---|---|
| `WS-APXA-harness-selection-matrix` | `WS-21-primitive-governance-policy` | **repointed to `WS-11-runtime-machine-inventory`.** Repointed: the harness decision needs an inventory of what we run today (Pack D), not the second-wave primitive-governance policy. The original prereq was the primitive drift audit, whose inventory half now lives on the runtime inventory. |
| `WS-03-context-moat-asset-inventory` | `WS-13-prose-readiness-assessment` | **dropped.** Dropped: the pre-work context-debt census cannot wait on a second-wave PROSE assessment, and the map's own reasoning is that a pre-groundbreaking org has no instruction files to assess yet. |
| `WS-05-board-reporting-scorecard` | `WS-05-governance-readiness-assessment` | **kept — pack moved.** Kept, and CL-BOARD-SCORECARD moves from Pack C to Pack G instead: the scorecard is the quarterly reporting instrument filled against a finished plan, so Pack C seq 3 was the wrong slot. |
| `WS-05-decision-rights-gate-matrix` | `WS-06-role-map-and-staffing-triggers` | **kept — pack moved.** Kept, and CL-DECISION-RIGHTS moves from Pack E to Pack F instead: a decision-rights matrix names people, so it cannot be filled before the role map that names them. |
| `WS-08-baseline-measurement-plan` | `WS-08-pilot-selection-and-scope` | **dropped.** Dropped: the map places the baseline in pre-work precisely because the before-picture is unrecoverable once work starts. Pilot selection refines the baseline's scope downstream; it is a feeds_into, not a prerequisite. |
| `WS-18-plan-charter-and-principles` | `WS-17-agent-team-charter` | **dropped.** Dropped: the charter's Teams block names human teams. The agent team charter is second-wave instantiation work and was already a cross-pack dependency before the re-opening pass. |

Two clusters moved pack as a result:

- `CL-BOARD-SCORECARD` → **G-THE-PLAN**
- `CL-DECISION-RIGHTS` → **F-PEOPLE**

**Invariants now enforced by `docs\apply_reopen.py`**, which exits non-zero if any fails:

1. every `merge_into` names a surviving canonical;
2. every `prereq_ws` entry names a surviving canonical;
3. the prerequisite graph is acyclic;
4. no prerequisite sits in a later pack than its consumer;
5. fill order within a pack is a topological order of the prerequisite graph.

---

## 6. Addressing and the anchor patch — applied locally

**Status: applied on branch `chore/stable-anchors`, committed locally, not pushed.** No pull
request exists. Pushing needs separate explicit approval.

| | Before | After |
|---|---|---|
| Headings with an explicit `{#id}` | 38 of 423 | **190 of 423** |
| Candidates on a derived (fragile) anchor | 172 | **0** |
| `stable_anchor` populated | 0 | **172** |
| `resolve.py check` | 172/172, 0 drift | **172/172, 0 drift** |

**Why it mattered.** A derived slug silently repoints when a heading is edited.
`### Phase 1: Pilot (1–5 months)` yields `#phase-1-pilot-15-months`; editing *1–5* to *1–6*
breaks every inbound link with no build error. Derived slugs also already collide in this book —
*The Architecture Decision Matrix* is a heading in **both** ch04 and ch05, and both are mapped
locations. The convention `sec-<stem>-<topic>` resolves that by construction.

**How it was applied safely.** Every target line was read and verified against the expected
source line before anything was written, with a single mismatch aborting the whole run. The check
requires that the heading text match exactly, that no pre-existing attribute be dropped, that the
id be the first attribute as Pandoc requires, and that no proposed id collide with another or
shadow an existing one. The resulting diff is exactly **152 insertions and 152 deletions across
29 files** — heading text is untouched.

Twelve headings that already carried an explicit id were left alone. A working anchor is a
published URL someone may already hold; changing it to satisfy a convention is a regression.

> **Note on the published URLs in the specs.** Each spec prints the `https://danielmeppiel.github.io/…`
> URL for its section. The *page* resolves today; the *anchor* will only resolve once the anchor
> commit reaches the published site. Until then, resolve locally with `python docs/resolve.py ws <ws_id>`.

---

## 7. Open questions

### 7.1 ch12 vs ch13 — the instruction-file threshold *(unresolved, owner: Daniel Meppiel)*

- **ch12 line 74:** "If your instruction file exceeds 40-50 lines, it's trying to do too much."
  Stated as a design ceiling, with a mechanical justification.
- **ch13 line 541 (PROSE P1):** "Does every instruction file over 100 lines use links (not inline
  content) for subsidiary topics?" Stated as a progressive-disclosure trigger.

A reading reconciles them — 40–50 is the target, 100 is where disclosure becomes mandatory — but
**the book never states it**, and the consequence is real: a team auditing against P1 at 100
lines will pass files ch12 calls broken.

**Not settled here.** `WS-13-prose-readiness-assessment` carries **both**, explicitly labelled as
two different tests — a *target* at 40–50 and a *hard trigger* at 100 — with a note that the book
states them in different chapters without reconciling them. If a single threshold is intended,
one of the two numbers has to change in the book, not in the kit.

### 7.2 ch06 vs ch07 — the central AI team *(resolved in the kit, by design)*

ch06 lists a centralised AI team that handles all agent interactions as an anti-pattern; ch07
charters one. The book never reconciles them and read cold it is self-contradictory.
`WS-07-central-team-charter` is built deliberately two-sided — left page the three shapes we
refuse to build, right page the charter — and the fill *is* the reconciliation. The discriminating
test the book already supplies, **loops reused across the organization, not requests approved**,
prints as a mandatory metric row with a named owner and a review date.

### 7.3 IP in agent-generated output — a gap in the book, not just the kit

Who owns agent-generated output, under what licence, is a real leadership-grade question. The
book's only nearby passage is about licensing *a book* under CC BY-NC-ND, not IP in agent-generated
code. `WS-05-compliance-scope-and-posture-matrix` carries a single placeholder row flagged as
unsupported by the book. It must not be authored as though the book answers it.

### 7.4 Inconsistencies found in the book during this pass

Each was found while authoring a field schema, and each was verified at source. None is
resolved here; all are authoring questions for Daniel Meppiel. The kit records them rather than
picking a side.

| # | Where | The inconsistency | How the kit handles it |
|---|---|---|---|
| 1 | ch03 L352 vs ch08 L108 / L161 | ch03 makes *"a 4–6 month adoption curve before expecting returns"* a precondition for value. ch08 puts **Phase 1 alone** at 4–6 months for 1,000+ engineers, and Phase 3 at 12–24 months. A large organisation accepting ch03's condition at face value expects returns the moment the pilot ends, before Expand or Scale have begun. The two are compatible for an org under 200 and contradictory at scale. | `WS-03-go-no-go-readiness-gate` carries a mandatory reconciliation column against the org's own calibrated roadmap. |
| 2 | ch17 L28, L35, L42, L373 | Four different single-versus-multi-agent file boundaries in one chapter: *more than 15-20 files*, the matrix's *< 10 / > 15*, *the boundary at 10-15 files*, and *file count exceeds 20 across 2+ concerns*. The chapter never reconciles them. | `WS-17-single-vs-multi-agent-decision-matrix` presents no reconciled figure — it carries a local recalibration field that supersedes all four. Reconciling them in the kit would mean inventing a number. |
| 3 | ch11 L30 vs `fig-runtime-machine` | The prose says the runtime is *"the same four parts … any working setup must fill all four"*; the figure draws **five** nodes — Tools is drawn as a peer of the other four but is not counted. | `WS-11-runtime-machine-inventory` keeps four rows and inventories Tools as a harness attribute, with the discrepancy called out so a facilitator raises it rather than a participant assuming they misread. |
| 4 | ch20 severity fields | Severity is printed only for patterns #11–#19. Patterns #1–#10 carry none, and Medium is present for #14, #15 and #17 though the map's earlier summary omitted them. | `WS-20-nineteen-failure-mode-premortem` records `not printed` rather than inferring a severity, and marks any derived value explicitly. |

### 7.5 Contested merges left standing

The re-opening pass touched only the ten clusters with six or more members. The other 27 were
left alone by decision. Two contested calls inside them are still worth a second opinion:

- `WS-16-consequential-effect-register` remains a **five-into-one** merge (inbound access,
  sensitivity classification, outbound effects, gate selection, write-token supervision). Split it
  if the inbound and outbound halves are approved by different people on different dates in your
  organisation. It was merged because splitting is how one half ends up undefended.
- `WS-05-board-reporting-scorecard` absorbed the evidence and falsification register. Ask the
  sponsor whether the honesty artefact needs its own signature page; it is filled once before go,
  while the scorecard is filled quarterly after.

---

## 8. Integrity constraint — a standing rule

**The book's headline numbers are explicitly hedged in-text. Any worksheet that surfaces one must
present it as a prior or a prompt — never as a benchmark, target, or acceptance threshold.**

### 8.1 A correction to the previous version of this rule

The earlier integrity list named a **"3:1 senior-to-junior ratio"**. **No such figure exists in
the book.** Verified at source:

- **3:1 is the *generation-to-review* ratio** (ch08 L234) — hours of review per hour of
  agent-assisted generation, hedged as *"starting benchmarks based on the author's observation of
  early adopter teams, not industry-validated thresholds."*
- **Senior-to-junior is 1:2–1:3 today, projected to 1:1–2:1** (ch06 L309), dagger-marked as
  *"projected figures … based on early adopter reports and the author's observations, not
  longitudinal studies."*

A second mislabel was corrected at the same time: the **30–60%** figure at ch01 L25 is a *rework*
range, and it is **not an author figure** — the book sources it explicitly to *"the 2025 Stack
Overflow survey and GitClear's code churn analysis … though no controlled study has established a
definitive figure."* Labelling a third-party figure as author-observed is the same integrity
failure in the opposite direction, and it would have led a builder to strip a legitimately sourced
number or to misattribute it.

Both were caught during the authoring pass, by sub-agents reading the source rather than the
summary. That is the argument for the mechanism below.

### 8.2 How it is enforced now

Section 10 of every spec is generated from a **location-anchored register**
(`docs\integrity_figures.py`): 26 figures, each registered by **file and line range**, each
carrying **the book's own hedge verbatim with its location**. A figure appears on a spec only if
its range overlaps that worksheet's source range or that of a member it absorbed — so no
worksheet inherits a caution about a number it never prints, and none misses one it does.

The register **self-checks**: every entry must still find its probe string inside its declared
range, and the generator refuses to run if any entry has drifted. A register that silently rots
as the book is edited is worse than no register.

Registered figures include the 8.5× spread and the $4.81/$41.01 run, the 30–60% rework range, the
ch03 dagger-marked TCO / scenario / sensitivity tables, ch06's time-allocation and team-profile
projections, ch04's Month 1/3/6/12/18 gates, ch08's 60% rollback trigger, 40% kill criterion and
generation-to-review ratio, ch15's context budget table, ch17's file boundaries, coordination-tax
bands and escalation rates, ch27's documentation-burden poles, and the case study's ~25-call-sites
threshold.

The hedges are the author's own words, at source:

> *"The reader should treat specific numbers as starting points for their own calibration, not as
> industry benchmarks."* — ch10, chapter-opening disclaimer
>
> *"† Author projections based on early-adopter patterns and the author's advisory work. Not
> derived from controlled studies."* — ch03 L198
>
> *"The table below is not a benchmark; it is a starting calibration."* — ch15 L102

**Why it is a rule rather than a matter of taste.** A facilitated kit is precisely the vehicle
that launders a hedged anecdote into an apparent industry statistic. The hedge lives in an italic
chapter opener or a dagger footnote; the number travels onto a worksheet, then a whiteboard, then
a board deck — and by the third hop it is "the industry benchmark is 3:1" with the handbook as its
citation. **A printed sheet is a worse offender than prose, because a blank cell next to a printed
number reads as a target by layout alone.**

`WS-05-board-reporting-scorecard` is the structural control point: every metric row carries an
**evidence grade** (measured / author estimate / vendor claim) and a **falsifier** in the same row
as the target, so a hedged anecdote cannot be reported upward without its grade travelling with
it.

---

## 9. Build effort

**39 near-free** — the book already prints a table, checkboxes or a fill-in template, so the
work is adding columns. **33 need real authoring** — prose only, no fillable
structure, or a rubric must be invented.

Rating the five clusters the prior session left deliberately unrated surfaced a flaw in the
two-band scheme: **it conflates the cost of building the sheet with the cost of the organisation
filling it.** `WS-18-wave-decomposition-plan` is the proof — every element is already printed
(wave table, sizing trade-off table, self-sufficiency test), so it is near-free to *build*, yet it
is rated effort **L** because filling it honestly needs the real repository and cross-team
agreement on file ownership. Every spec now carries **both**: section 11 states build effort and
fill load separately.

### The five previously unrated

| ws_id | Build | Reason |
|---|---|---|
| `WS-03-go-no-go-readiness-gate` | **near-free** | A consuming gate, not new content: the book states the three conditions verbatim at ch03 line 352 and each maps to an instrument already in the kit. The sheet is a one-page signature block over three pre-written rows. |
| `WS-27-starter-shape-target` | **near-free** | Five named bundle elements with sizing guidance, plus three acceptance properties that convert directly into a pass/fail test. Only the owner and target-date columns are additions. |
| `WS-18-wave-decomposition-plan` | **near-free** | The wave table, the wave-sizing trade-off table (ch18 L165-172) and the self-sufficiency test are all printed. Near-free to BUILD; the effort-L rating is fill load, not build cost. |
| `WS-12-failure-triage-log` | **near-free** | The ASCII diagnosis tree supplies the root-cause picklist and the four-row table supplies worked examples from a real project. Adding date and owner columns completes it. |
| `WS-08-pilot-selection-and-scope` | **authoring** | Prose only. The representative-not-exceptional rubric (seniority mix, codebase age, greenfield versus legacy) and the exclusion criteria must be invented; the book supplies the test by negation, not a scale. |

### Cheapest proof of concept

11 sheets are near-free to build, leadership priority 1, and have **no prerequisite** —
they can be built and filled cold, in any order:

- `WS-06-team-readiness-scorecard` — Team Readiness Scorecard — Eight Dimensions, Scored Honestly (A — Groundwork (pre-work))
- `WS-04-lifecycle-layer-coverage-canvas` — Lifecycle Layer Coverage Canvas: Who, Which Agent, Which Platform, Per Phase (B — Where we actually are)
- `WS-27-workload-triage` — Workload Triage Screen: Does This Work Belong in the Agentic Path? (B — Where we actually are)
- `WS-03-scenario-assumption-commitment` — Scenario & Assumption Commitment (C — The case and the money)
- `WS-03-tco-calculator` — Year-One Total Cost of Ownership Calculator (C — The case and the money)
- `WS-05-agent-risk-register` — Agent Risk Register (Six Categories, Twelve Named Risks) (E — Guardrails: authority, risk and proof)
- `WS-05-compliance-scope-and-posture-matrix` — Regulatory Scope and Required Posture Matrix (E — Guardrails: authority, risk and proof)
- `WS-18-plan-charter-and-principles` — The Plan Charter: Scope, Teams, Waves, Principles, Constraints (G — The plan we leave with)
- `WS-20-nineteen-failure-mode-premortem` — Pre-Mortem: Which of the 19 Failure Modes Will We Hit? (G — The plan we leave with)
- `WS-27-first-week-plan` — First Week Commitment Register (Day 1 to Day 5) (G — The plan we leave with)
- `WS-27-starter-shape-target` — Target-State Primitive Bundle Definition (Z — Second wave: the practitioner kit)

---

## 10. Ready for implementation planning

### Settled — the next session may assume these

1. **The worksheet set is 72 canonical sheets.** Every one has a build spec in
   `docs\worksheets\` carrying its field-level schema, book address, facilitation notes and
   acceptance criteria. Ten over-collapsed clusters were re-opened and all 62 of their members
   decided individually, each with a recorded reason.
2. **The dependency graph resolves.** No dangling prerequisite, no cycle, no cross-pack ordering
   violation. Fill order within each pack is a topological order of the prerequisite graph, and
   `docs\apply_reopen.py` fails loudly if that stops being true.
3. **Addressing is durable.** 152 anchors applied locally; all 172 candidates carry a
   `stable_anchor`; `resolve.py check` reports 172/172 with 0 drift.
4. **No merged detail was discarded.** Every fold is recorded with its address, its reason, and
   the fill detail the surviving spec must absorb — enforced by section 6 of each spec.
5. **The integrity rule is mechanised**, not left to taste: per-spec flags plus a named structural
   control point.
6. **Build effort is rated for all of them**, separated into build cost and fill load.

### Open — decide before or during implementation

| # | Question | Owner | Blocks |
|---|---|---|---|
| 1 | ch12 vs ch13 instruction-file threshold — 40–50 or 100 lines? | Daniel Meppiel (book author) | Nothing. `WS-13-prose-readiness-assessment` ships both, labelled as two tests. |
| 2 | ch03 vs ch08 time-to-returns — is the 4–6 month adoption curve compatible with a 4–6 month Phase 1 at 1,000+ engineers? (§7.4) | Daniel Meppiel | Nothing. The go/no-go gate carries a reconciliation column. |
| 3 | ch17's four different file-count boundaries (§7.4) | Daniel Meppiel | Nothing. The sheet carries a recalibration field instead of a reconciled figure. |
| 4 | ch11's four-parts prose versus a five-node figure (§7.4) | Daniel Meppiel | Nothing. Flagged on the sheet for the facilitator. |
| 5 | Is the Tier-1 core closed under its own prerequisites? It is not today (§2) — promote the named prerequisites, or accept partial input? | Engagement owner | The compressed two-day variant only. |
| 6 | Push the anchor branch and open a PR upstream? | John | Publication of the durable anchors. Specs resolve locally regardless. |
| 7 | Split `WS-16-consequential-effect-register` into inbound and outbound halves? | Customer's security and governance owners | Nothing; decide per engagement. |
| 8 | Does the evidence and falsification register need its own signature page, separate from the board scorecard? | Exec sponsor | Nothing; decide per engagement. |
| 9 | IP in agent-generated output is a genuine gap in the book (§7.3). | Daniel Meppiel | Nothing; flagged as unsupported on the sheet. |

### Not done, deliberately

- **No worksheet is authored.** The specs describe; they do not lay out.
- **The other 27 clusters were not re-clustered.** Out of scope by decision; §7.4 lists the two
  calls inside them still worth a second opinion.
- **Nothing was pushed.** The anchor work is a local branch with two commits.

---

## 11. Provenance

### Pipeline, in order

```text
docs\apply_reopen.py          split/fold decisions, dependency repair, pack sequencing
                               -> candidates.refined.json, clusters.refined.json,
                                  _reopen-decisions.tsv   [exits non-zero on any violation]
docs\apply_anchor_patches.py  read-verify-then-write 152 heading lines  [--write to apply]
docs\build_heading_index.py   re-derive all 423 headings from source
docs\repair_anchors_json.py   re-point candidate anchors, populate stable_anchor
                               -> candidates.json
docs\resolve.py check         172/172 resolving, 0 drift
docs\gen_worksheet_specs.py   -> docs\worksheets\<ws_id>.md  (one per canonical worksheet)
docs\gen_worksheet_map.py     -> this file
```

### Decision record

`docs\decisions_reopen.py` is the single source of truth for every judgement in this pass:
the 62 split/fold decisions with reasons, the 6 pack-order repairs, the 2 pack moves, and the
build-effort rating for all 41 worksheets that needed one. It is data, not prose, so the pipeline
re-runs deterministically.

### Validation performed

- 172/172 `locator_quote` values re-resolve to their recorded line ranges against the patched book.
- Every anchor is re-derived from `.qmd` source at check time, not trusted from the cached index.
- 152/152 anchor patches verified against the on-disk line before writing; 0 mismatches.
- Diff is exactly 152 insertions / 152 deletions across 29 files.
- 0 dangling `merge_into`; 0 dangling `prereq_ws`; 0 cycles; 0 cross-pack order violations.
- The hedged-figure register self-checks: all 26 probes still resolve inside their declared ranges.
- **72/72 specs pass `docs\verify_specs.py`**, which regenerates a pristine
  scaffold for each and confirms that sections 1–4, 6, 7 and 10–12 are byte-identical, that no
  `<<AUTHOR:>>` marker survives, that every schema names input types, that every spec with
  absorbed members carries an `Absorbed detail` paragraph, that all five facilitation rows are
  filled, that each spec has at least three acceptance criteria, and that no markdown table row
  is malformed by an unescaped pipe.

### Caveats

1. **The split/fold calls, the pack moves and the build ratings are judgement.** They are recorded
   with reasons in `docs\decisions_reopen.py` and surfaced in §4 precisely so a call you disagree
   with can be overruled by editing one dict entry and re-running the pipeline.
2. **Section 12 of each spec is verbatim scan commentary and its line numbers drift by one or two
   in places** (for example a ch05 checklist item cited at L269 that sits at L267). It was left
   verbatim rather than silently corrected, because it is evidence of what the scanning agent saw.
   The authoritative coordinates are sections 2 and 3, which are re-derived from source and
   checked by `resolve.py`.
3. **Section 12 may still name a worksheet that was cut or merged.** `feeds_into` was repointed to
   surviving canonicals; the scan notes were not, for the same reason.
4. **The published anchor URLs resolve only after the anchor branch is pushed.** Until then use
   `python docs/resolve.py ws <ws_id>`.
