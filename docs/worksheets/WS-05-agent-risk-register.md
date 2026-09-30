# Agent Risk Register (Six Categories, Twelve Named Risks)

`WS-05-agent-risk-register` &middot; **Pack E - Guardrails: authority, risk and proof** &middot; fill order **1** &middot; type `matrix` &middot; audience **mixed** &middot; leadership priority **1**

> **Split back out in the re-opening pass.** A standing governance register tabled at a risk committee on a quarterly cadence with a named individual per risk -- different owner, cadence and audience; contested-merge #6 named exactly this as the split-back condition.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A populated, owned agent risk register that can be tabled at a risk committee and re-reviewed quarterly.

**Cluster.** `CL-AGENT-RISK` - Agent Risk Register (Six Categories, Twelve Named Risks)

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch05-governance-for-ai-assisted-delivery.qmd` |
| Chapter | Governance for AI-Assisted Delivery |
| Heading | Risk Taxonomy |
| Stable anchor | `#sec-governance-risk-taxonomy` |
| Lines | L100-121 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch05-governance-for-ai-assisted-delivery.html#sec-governance-risk-taxonomy> |
| Locator quote | "Agent-introduced risk falls into six categories. Each has specific mechanisms, concrete manifestations" |

Resolve at any time with `python docs/resolve.py ws WS-05-agent-risk-register`.

## 3. Source extract - the scaffolding, verbatim

```text
  100 | Agent-introduced risk falls into six categories. Each has specific mechanisms, concrete manifestations, and identifiable owners. The taxonomy is not theoretical — these are risks that organizations adopting agentic development are encountering now.
  101 | 
  102 | The consolidated table below captures all six risk categories with representative examples, mitigations, and owners. Three risks that introduce novel failure modes — quality degradation, knowledge atrophy, and supply chain integrity — are expanded in the sections that follow.
  103 | 
  104 | ::: {tbl-colwidths="[14,14,24,30,18]"}
  105 | 
  106 | | Category | Risk | Example | Mitigation | Owner |
  107 | |---|---|---|---|---|
  108 | | **IP & data exposure** | Proprietary code sent to external model | Agent context includes auth module source; developer uses cloud-hosted model without enterprise data agreement | Enforce enterprise-tier agreements with training opt-out. Deploy context filters. Maintain data classification policy covering agent workflows. | Security / Legal |
  109 | | | Training data reproduced in output | Agent generates a near-exact copy of a GPL-licensed implementation, merged without review | Integrate license-scanning tools into CI. Flag agent-generated code for IP review in sensitive components. | Legal / Engineering |
  110 | | **Quality degradation** | Plausible incorrectness | Agent implements a data pipeline that passes all tests but silently drops null values the business logic depends on | Require property-based or invariant tests for agent-generated code in critical paths. Review output against ADRs. | Engineering leads |
  111 | | | Convention drift | Fifty agent-generated files use three different error-handling patterns; none match the team standard | Encode conventions as structured context (instruction files, linters, architectural rules) that agents consume during generation. | Tech leads / Architects |
  112 | | **Dependency & concentration** | Model outage | Primary model provider has a 4-hour outage during a release sprint; team cannot complete agent-assisted tasks | Maintain fallback model configurations. Ensure critical workflows degrade gracefully to human-only execution. Test fallback quarterly. | Platform / Engineering |
  113 | | | Vendor lock-in | Organization has 2,000 tool-specific instruction files; switching tools requires rewriting all of them | Use portable, vendor-neutral formats for context artifacts. Separate content from format. | Architecture / Platform |
  114 | | **Knowledge atrophy** | Debugging skill loss | Junior engineers cannot diagnose a production issue because they never debugged code without agent assistance | Require regular unassisted development exercises. Pair juniors with agent output for review practice. | Engineering managers |
  115 | | | Architectural reasoning decay | Team cannot redesign a subsystem because no one has practiced trade-off decisions outside agent-provided constraints | Rotate architecture review responsibilities. Include constraint-design tasks in sprint work. | Architecture / CTO |
  116 | | **Regulatory liability** | Implicit compliance violation | Agent generates a logging module that captures user IP addresses and geolocation where this requires explicit consent | Define compliance constraints as explicit agent context for regulated code paths. Require compliance-aware review. | Legal / Security |
  117 | | | Accountability gap | Regulator asks who decided to store customer data in a specific format; the decision was made by an agent in a 50-file PR | Maintain decision logs for agent-generated code in regulated areas. Include "compliance-relevant choices" in PR review checklists. | Engineering leads / Legal |
  118 | | **Supply chain & context integrity** | Prompt injection via dependency | A transitive dependency README includes hidden instructions causing the agent to exfiltrate environment variables | Restrict agent context to vetted, first-party sources for sensitive operations. Apply context sanitization. | Security / Platform |
  119 | | | Compromised instruction files | Attacker subtly modifies an agent instruction file via PR, causing generated auth code to include a backdoor pattern | Apply code review and change-management controls to instruction files with the same rigor as production code. | Security / Engineering leads |
  120 | 
  121 | :::
```

## 4. What the user fills

Twelve pre-populated risk rows across the six categories. Per row: does this apply to us (yes / no / not yet), our concrete manifestation in our own systems, likelihood and impact scores, which mitigations are in place / planned / absent, the named individual owner, and a review date. Blank rows at the bottom capture organisation-specific risks the taxonomy does not name.

## 5. Field-level schema

One row per named risk. The twelve rows from the consolidated taxonomy table print pre-filled
in chapter order and are not editable; five blank rows follow for risks the taxonomy does not
name. A3 landscape, one side, with a tabling block at the foot. This is a standing register
carried to a risk committee, not a workshop scratchpad — the layout must survive being
photocopied and re-read a quarter later.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Category | `select` (fixed 6) | IP and data exposure / Quality degradation / Dependency and concentration / Knowledge atrophy / Regulatory liability / Supply chain and context integrity | — | ch05 L108-119 |
| 2 | Risk | `free text` (12 rows pre-printed) | The twelve named risks, verbatim | Editable only on the five blank rows | ch05 L108-119 |
| 3 | The book's example | `free text` (pre-printed, read-only) | The chapter's concrete manifestation for that risk | — | ch05 L108-119 |
| 4 | Applies to us | `select` — yes / no / not yet | — | The room's verdict | org |
| 5 | Our manifestation | `free text` | — | The same risk named against a system we own: a repository, a model endpoint, a team | org |
| 6 | Likelihood | `H/M/L` | — | — | org |
| 7 | Impact | `H/M/L` | — | — | org |
| 8 | The book's mitigation | `free text` (pre-printed, read-only) | The chapter's mitigation for that risk | — | ch05 L108-119 |
| 9 | Our control | `free text` | — | The specific tool, gate or process that implements column 8 here | org |
| 10 | Control status | `select` — in place / planned / absent | — | — | org |
| 11 | Evidence for column 10 | `free text` | — | The artefact that proves it: a CI job name, a policy document version, a dashboard location | ch05 L317 — "Evidence is captured as artefacts, not as memory" |
| 12 | Owner — function | `free text` (pre-printed, read-only) | Security / Legal; Legal / Engineering; Engineering leads; Tech leads / Architects; Platform / Engineering; Architecture / Platform; Engineering managers; Architecture / CTO; Security / Platform | — | ch05 L108-119 |
| 13 | Owner — named individual | `owner (named person)` | — | A person with a surname. Column 12 is the book's answer; this column is ours | ch05 L267 |
| 14 | Next review | `date` | — | Within one quarter of the tabling date | ch05 L276 |
| — | Tabled at | `free text` + `date` | — | The committee this register is carried to, and the date it was | ch05 L276 |
| — | Register owner signature | `signature` | — | The person accountable for the register as a whole, distinct from the per-row owners | derived |

**Absorbed detail.** This sheet absorbed no other candidate, and one thing is deliberately
*not* absorbed: rows 7 and 8 (debugging skill loss, architectural reasoning decay) are scored
here but not planned here. Columns 9-11 on those two rows print pre-filled with a forward
pointer to `WS-05-capability-retention-plan`. The chapter gives knowledge atrophy eleven lines
of expanded treatment (ch05 L129-141) precisely because a register row cannot hold it; the
mitigation is a programme, not a control.

**Deliberate omission.** No computed risk score and no 5x5 heat map. Columns 6 and 7 stay as
two independent letters and are never multiplied. The chapter supplies no scoring scheme, and
a number derived from two invented ordinals acquires an authority it has not earned — the room
would then argue about whether a risk is a 12 or a 15 instead of about whether anyone owns it.
There is also no residual-risk column: with control status in column 10 and evidence in column
11, residual risk is a conversation, not a cell.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- None. This sheet can be filled cold.

**Consumed by:**

- `WS-05-capability-retention-plan` - Capability Retention and Fallback Plan (Pack F - People and operating model, fill order 2)

**Feeds into (prose, from the source scan).** WS-05-board-reporting-scorecard and WS-03-go-no-go-readiness-gate

## 8. Facilitation

| | |
|---|---|
| Who fills it | The engineering leader who will own the register, with **Security and Legal physically in the room**. Four of the twelve rows name Security or Legal in column 12; filled without them, columns 9-11 are guesses about other people's controls. If the organisation is externally audited, Compliance attends too. HR is not needed — the knowledge-atrophy rows are scored here and planned elsewhere. |
| When in the session | Pack E, first sheet. It has no prerequisites and can be filled cold, which is the point: it generates the demand for everything downstream of it in the pack. Do not run it after the readiness assessment — the register is what tells the room which capabilities carry material risk. |
| Duration | 90-120 minutes. Twelve rows sounds fast and is not. Columns 1-3 and 8 read aloud in ten minutes; the time goes into column 5 (naming our own manifestation) and column 13 (naming a person), which are the two columns the room will try to skip. |
| Data needed in advance | The list of external model endpoints in use and the enterprise-agreement status of each; the current convention, if any, for tagging agent contributions in commits or PRs; the data classification policy; the most recent dependency or SBOM report; and the answer to "who has write access to our agent instruction files today?" — that last one is usually the surprise. |
| Room format | Printed A3 landscape, one copy per table, filled by hand and transcribed afterwards. Do not distribute columns 4-7 as pre-work. The disagreement about whether a row applies to us is the content of the session, not an overhead on the way to it. |

**Facilitation note carried from ch05.** Three of the six categories get expanded treatment
later in the chapter, and the facilitator should have that text to hand as marginal notes
against the relevant rows: quality degradation at L123-127 (plausible incorrectness,
hallucinated dependencies, convention drift — the failure mode of a *strong* model with poor
context, which is the harder sell in the room), knowledge atrophy at L129-141 with the aviation
parallel, and supply chain and context integrity at L143-151, including the bounded-scope
grounding defence at L151. Say out loud, when rows 7 and 8 come up, that the mitigation is
`WS-05-capability-retention-plan` and not a control invented at the table — otherwise the room
designs the same programme twice and neither version gets owned.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **Every row marked "applies to us" carries a named individual in column 13** — a person with
   a surname, not "Security", not "the platform team", not "TBC". The chapter assigns owners by
   function (ch05 L108-119) because it is writing for every reader; a register that copies the
   function straight across is unowned, and the chapter checklist at L267 asks for assigned
   owners precisely to close that gap.
2. **Every applicable row names our own manifestation in column 5, against a system we can
   name.** A repository, a model endpoint, a team, a pipeline. "Could happen to anyone" is not a
   manifestation. A row nobody can make concrete is scored `not yet`, not left as prose.
3. **All six categories are represented.** An entire category left blank is a scoping decision
   and must be written as one: marked `no` with the reason in column 5. A blank is indistinguishable
   from an oversight a quarter later.
4. **No control is marked `in place` without an artefact in column 11.** A CI job name, a policy
   document version, a dashboard location. Evidence is an artefact, not a recollection
   (ch05 L317); "we do that already" is the sentence this criterion exists to catch.
5. **The two knowledge-atrophy rows point to `WS-05-capability-retention-plan`, not to a control
   invented at the table.** If that sheet is not yet filled, the register records the dependency
   and the date it will be closed. Reconciliation runs the other way too: every atrophy risk
   scored applicable here must appear on that plan.
6. **Every row has a review date within one quarter of the tabling date, and the register is
   signed and tabled.** The chapter's cadence is quarterly (ch05 L276). An unsigned, untabled
   register is a workshop output, not a governance instrument, and must not be carried into
   Pack G as evidence.
7. **Any blank row the organisation added is completed to the same standard as the twelve
   printed ones** — manifestation, likelihood, impact, control, status, evidence, named owner,
   review date. Organisation-specific risks are the ones most likely to be real and least likely
   to be owned.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Twelve pre-populated rows already carrying Example / Mitigation / Owner; authoring is limited to applicability, scoring, status and a named-person column.
- **Fill (the organisation completing it): `L`.** L - needs the real repository, finance input or cross-team agreement

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Chapter checklist item 3 (line 269) asks for exactly this: "Classify your agent-introduced risks across all six taxonomy categories. Assign owners." The table already carries Example / Mitigation / Owner columns so authoring is limited to applicability, scoring, status and named-owner columns. Important: the book assigns owners by function (Security / Legal, Engineering leads); the worksheet must force a named person or the register is unowned. Three categories get expanded treatment later in the chapter - quality degradation (lines 123-127), knowledge atrophy (lines 129-141) and supply chain / context integrity (lines 143-151) - and that detail should print as facilitator notes on the relevant rows. Knowledge atrophy is deliberately scoped out to WS-05-capability-retention-plan because it needs a plan, not a register row.
