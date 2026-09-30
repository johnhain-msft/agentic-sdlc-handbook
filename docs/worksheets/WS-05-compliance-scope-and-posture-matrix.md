# Regulatory Scope and Required Posture Matrix

`WS-05-compliance-scope-and-posture-matrix` &middot; **Pack E - Guardrails: authority, risk and proof** &middot; fill order **2** &middot; type `matrix` &middot; audience **exec** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A signed statement of regulatory scope with the derived governance floor - which of the six capabilities are non-negotiable for this organisation - and a named owner per framework.

**Cluster.** `CL-COMPLIANCE-SCOPE` - Regulatory Scope, Posture and Residency

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch05-governance-for-ai-assisted-delivery.qmd` |
| Chapter | Governance for AI-Assisted Delivery |
| Heading | Compliance Framework Mapping |
| Stable anchor | `#sec-governance-compliance-mapping` |
| Lines | L75-96 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch05-governance-for-ai-assisted-delivery.html#sec-governance-compliance-mapping> |
| Locator quote | "A checklist without regulatory context is a conversation starter, not a decision tool" |

Resolve at any time with `python docs/resolve.py ws WS-05-compliance-scope-and-posture-matrix`.

## 3. Source extract - the scaffolding, verbatim

```text
   75 | A checklist without regulatory context is a conversation starter, not a decision tool. The matrix below maps each capability row to the compliance frameworks where it is critical. Use it to prioritize: find your regulatory scope in the columns, then focus on the rows marked as critical for that scope.
   76 | 
   77 | ::: {.landscape}
   78 | 
   79 | ::: {tbl-colwidths="[3,15,17,17,16,16,16]"}
   80 | 
   81 | | # | Capability | SOC 2 | ISO 27001 | PCI DSS | HIPAA | EU AI Act |
   82 | |---|---|---|---|---|---|---|
   83 | | 1 | Audit trails | **Critical** — CC8.1 (change management), CC7.2 (monitoring) | **Critical** — A.12.4 (logging and monitoring) | **Critical** — Req. 10 (track and monitor access) | **Critical** — §164.312(b) (audit controls) | **Critical** — Art. 12 (record-keeping) |
   84 | | 2 | Agent access controls | **Critical** — CC6.1, CC6.3 (logical access, least privilege) | **Critical** — A.9.2, A.9.4 (access management, access control) | **Critical** — Req. 7, Req. 8 (restrict access, identify users) | **Critical** — §164.312(a) (access control) | Relevant — Art. 14 (human oversight) |
   85 | | 3 | Approval workflows | **Critical** — CC8.1 (change management) | Relevant — A.14.2 (secure development) | **Critical** — Req. 6 (secure systems) | Relevant — §164.308(a)(5) (security awareness) | **Critical** — Art. 14 (human oversight of high-risk AI) |
   86 | | 4 | Data boundary enforcement | **Critical** — CC6.7 (data transmission), C1.1 (confidentiality) | **Critical** — A.13.2 (information transfer) | **Critical** — Req. 3, Req. 4 (protect stored data, encrypt transmission) | **Critical** — §164.312(e) (transmission security) | Relevant — Art. 10 (data governance) |
   87 | | 5 | Cost controls | Relevant — CC3.1 (risk assessment) | Relevant — A.12.1 (operational planning) | Not directly scoped | Not directly scoped | Not directly scoped |
   88 | | 6 | Compliance reporting | **Critical** — CC4.1 (monitoring activities) | **Critical** — A.18.2 (compliance review) | **Critical** — Req. 12 (security policy) | **Critical** — §164.308(a)(8) (evaluation) | **Critical** — Art. 13 (transparency) |
   89 | 
   90 | :::
   91 | 
   92 | :::
   93 | 
   94 | **How to read this.** If you are SOC 2-scoped, rows 1, 2, 3, 4, and 6 are critical — you will face audit findings if any of these are at "None." If you handle payment data under PCI DSS, rows 1, 2, 3, and 4 are your floor. If you ship to EU markets and your product touches high-risk categories, the EU AI Act makes rows 1, 3, and 6 non-negotiable. Start where your regulatory exposure intersects with your lowest maturity.
   95 | 
   96 | ---
```

## 4. What the user fills

First, tick which frameworks apply to us (SOC 2, ISO 27001, PCI DSS, HIPAA, EU AI Act, GDPR / data residency) and name the products and jurisdictions that bring each into scope; the ticks then derive which rows of the readiness assessment are mandatory. Second, per in-scope framework record our current posture against the recommended posture, the named legal or compliance owner, the audit date we are working back from, and the gap.

## 5. Field-level schema

Three blocks on one A3 landscape sheet, printed two-sided: **A — regulatory scope** and
**B — the derived governance floor** on the front (this is the face a compliance owner signs),
**C — deployment topology per data class** and the single **D** gap row on the back. The
chapter's not-legal-advice disclaimer prints at the head of the front page, above block A.

**Block A — regulatory scope.** One row per framework; six rows, pre-printed, none removable.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Framework | `select` (fixed 6) | SOC 2 / ISO 27001 / PCI DSS / HIPAA / EU AI Act / GDPR and data residency | — | ch05 L81-88 (five) plus L206 (GDPR and residency) |
| 2 | In scope for us | `select` — yes / no | — | A binary. `unknown` is not an option; an unknown becomes a `no` with an owner and a date in columns 9-10 | ch05 L94 |
| 3 | What brings it into scope | `free text` | — | The named products, data types and jurisdictions. "We are a bank" is not scope | org |
| 4 | Relevance to agent-assisted delivery | `free text` (pre-printed, read-only) | The chapter's one-line relevance statement | — | ch05 L204-209 |
| 5 | Key requirement | `free text` (pre-printed, read-only) | The chapter's key requirement | — | ch05 L204-209 |
| 6 | Recommended posture | `free text` (pre-printed, read-only) | The chapter's recommended posture | — | ch05 L204-209 |
| 7 | Our posture today | `select` — meets / partial / does not meet | — | Against column 6, not against the framework in general | org |
| 8 | Gap | `free text` | — | The difference between columns 6 and 7 in one sentence | derived |
| 9 | Owner | `owner (named person)` | — | A named legal or compliance individual, not "Legal" | org |
| 10 | Audit or assessment date we work back from | `date` | — | The next real audit, certification or filing | org |

**Block B — the derived governance floor.** One row per governance capability; six rows,
pre-printed. This block is read, not argued: column 13 is computed from the ticks in block A.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 11 | Capability | `select` (fixed 6) | Audit trails / Agent access controls / Approval workflows / Data boundary enforcement / Cost controls / Compliance reporting | — | ch05 L83-88 |
| 12 | Criticality by framework (six printed sub-cells) | `free text` (pre-printed, read-only) | **Critical** / Relevant / Not directly scoped, each with the chapter's clause reference verbatim — CC8.1, A.12.4, Req. 10, §164.312(b), Art. 12 and so on | — | ch05 L83-88 |
| 13 | Mandatory for us | `computed` | — | Auto-set to `yes` where column 12 reads **Critical** under any framework marked in scope in column 2 | ch05 L94 — "find your regulatory scope in the columns, then focus on the rows marked as critical" |
| 14 | Transcribed to the readiness assessment | `checkbox` | — | Ticked when the row has been carried across to `WS-05-governance-readiness-assessment` | derived |

**Block C — deployment topology per data class.** One row per data-classification tier or
repository class the organisation actually operates. Rows are org-supplied; the topology options
are fixed.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 15 | Data class or repository class | `free text` | — | Our own classification tiers, named as they are named internally | org |
| 16 | Topology | `select` — full local / hybrid (local client and harness, cloud model) / full cloud | The three canonical combinations, with the chapter's one-line description of each | One per row; no row may be left unassigned | ch11 L65-67 |
| 17 | What crosses the network | `free text` | — | Nothing / inference calls only / checkout and inference — stated as fact, not as intent | ch11 L65-67 |
| 18 | Approved model endpoint | `free text` | — | The named endpoint and its region | org |
| 19 | What the provider retains | `free text` | — | From the executed enterprise agreement or DPA, with the clause reference. Not from the marketing page | ch05 L206 |
| 20 | Authorising compliance control | `free text` | — | The clause from column 12, or the contractual term, that permits this topology for this data class | ch05 L83-88 |
| 21 | Signed off by | `signature` + `date` | — | Security, legal and procurement — three signatures, not one | derived |

**Block D — the row the book does not answer.** One row. It prints with a visible gap flag.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 22 | IP posture in agent-generated output: who owns it, and under what licence is it held or released | `free text` + `owner (named person)` + `date` | **Nothing. The source does not address this.** | Our own position, the counsel who gave it, and the date it was taken | **Known gap in the book** |

**Absorbed detail.** `WS-11-layer-locality-decision` is carried whole by block C. Its three
canonical combinations become the fixed options in column 16; "what crosses the network" is
column 17; "which model endpoint is approved" is column 18; "what the provider retains" is
column 19; and "the compliance control that authorises it" is column 20, which is the column
that binds the topology decision back to block B instead of leaving it as a standalone
deployment diagram. Column 21 is its original output — the signed per-data-class topology
decision that security, legal and procurement need before a harness is installed on a
developer machine.

**Known gap in the book — column 22.** Build this row with the gap flag printed on the sheet,
in the words *"Not answered by the source. Requires your own legal position."* The nearest the
book comes is the IP-and-data-exposure row of the risk taxonomy (ch05 L109), which covers
*inbound* licence contamination — an agent reproducing a GPL-licensed implementation — and is
silent on *ownership* of agent-generated output. The only licensing discussion elsewhere in the
book concerns the book's own CC BY-NC-ND terms, which does not transfer. A row that merely
looks blank reads as an oversight and someone will fill it from memory; the flag is what stops
that.

**Deliberate omission.** ISO 27001 appears as a column in the criticality matrix (ch05 L83-88)
but has no row in the framework-to-posture table (L203-209). Columns 4-6 print as *"not covered
by the source"* on that row rather than being back-filled by analogy from the other five. There
is also no maturity score and no percentage-complete figure anywhere on this sheet: posture is
meets / partial / does not meet per framework, because a composite number flattens a HIPAA gap
and a cost-controls gap into the same digit.

## 6. Absorbed members (1)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-11-layer-locality-decision` - Layer Locality and Data Boundary Decision

- **Address.** `handbook\ch11-the-runtime-machine.qmd` L63-72, Where the layers run (`#sec-runtime-layer-locality`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Per repository class or data-classification tier, choose one of the three canonical combinations — full local, hybrid (local client and harness, cloud model), or full cloud — and record what crosses the network, which model endpoint is approved, what the provider retains, and the compliance control that authorises it.
- **Its output was.** A signed deployment-topology decision per data class: the artefact security, legal and procurement need before any harness is installed on a developer machine.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- None. This sheet can be filled cold.

**Consumed by:**

- `WS-05-governance-readiness-assessment` - Governance Readiness Self-Assessment (Six Capabilities) (Pack E - Guardrails: authority, risk and proof, fill order 4)

**Feeds into (prose, from the source scan).** WS-05-governance-readiness-assessment

## 8. Facilitation

| | |
|---|---|
| Who fills it | **Legal or compliance must physically be in the room** and owns column 9; this sheet cannot be completed by engineering and circulated for approval afterwards, because column 2 is a legal determination and column 7 is a posture claim someone will be held to. Security owns block C. **Procurement attends for column 19** — what a provider retains is a contract question, not a product question, and the engineer who "checked the docs" will get it wrong. The engineering leader is present to be told, not to decide. |
| When in the session | Pack E, second sheet — after `WS-05-agent-risk-register`, and **before** `WS-05-governance-readiness-assessment`. The chapter is explicit that priority derives from regulatory scope (ch05 L94, and "start where your regulatory exposure intersects with your lowest maturity"), so the ticks in column 2 are what make block B's mandatory rows computable. Run the readiness assessment first and the room produces a maturity plan aimed at the wrong rows. |
| Duration | 60-75 minutes for blocks A and B when legal is present and prepared. Block C adds 30 and routinely cannot be closed in the room, because column 19 needs a contract nobody has open; park it with an owner and a date rather than guessing. |
| Data needed in advance | The audit calendar and next assessment date per framework; existing SOC 2 or ISO scope statements; the data classification policy; the executed enterprise agreement or DPA for **every** model provider in use, with the retention and training-opt-out clauses flagged; the list of jurisdictions the product ships to; and the current list of model endpoints and their regions. |
| Room format | A3 landscape, printed two-sided, one copy per attendee because legal will annotate their own. The disclaimer prints at the head of the front page. Blocks A and C are filled live; block B is read aloud and transcribed — it is derived, and treating it as a discussion invites the room to negotiate its own floor. |

**Facilitation note carried from ch05.** The chapter's disclaimer at L181 prints on the sheet
verbatim and above the table, never as a footnote: this is awareness of frameworks, not legal
advice, and requirements vary by jurisdiction, industry and use case. Print the counterweight
from L183 immediately beneath it — *ignorance is not a viable compliance strategy* — so the
disclaimer reads as an instruction to route to counsel rather than as permission to leave the
sheet blank. The derivation rule at L94 is the sheet's operating instruction and belongs in the
gutter between blocks A and B, where the room can see that block B is computed rather than
debated.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All six framework rows carry an explicit `yes` or `no` in column 2.** Six rows, six
   decisions. A blank, a question mark or an "unknown" is a failed sheet: the chapter's entire
   prioritisation rule (ch05 L94) reads off this column, so an ambiguous tick propagates into
   block B and from there into the readiness assessment's targets.
2. **Every in-scope framework names what brings it into scope in column 3** — a product, a data
   type, a jurisdiction. Sector self-description is not scope, and a framework whose trigger
   nobody can name is a framework nobody can descope later either.
3. **Every in-scope framework has a named individual in column 9 and a real date in column 10.**
   The date is the audit, certification or filing the organisation is actually working back
   from; "annually" is not a date.
4. **Block B is derived, not negotiated, and reconciles to the readiness assessment.** Every
   capability marked **Critical** under any in-scope framework reads `yes` in column 13, and
   `WS-05-governance-readiness-assessment` targets at least Basic on every one of those rows.
   A capability that is mandatory here and targeted at None there is a contradiction the pack
   must resolve before Pack E closes.
5. **Every data class in block C has exactly one topology, an authorising control in column 20,
   and all three signatures in column 21 — and column 19 is filled from the contract.**
   "Standard terms", "they don't train on it" and "the enterprise tier" are not answers to
   column 19; a clause reference is. A topology with no authorising clause is a preference, and
   the absorbed decision this block exists to capture is exactly the one security, legal and
   procurement sign jointly. Any row where the contract was not available in the room is parked
   with an owner and a date, not left blank.
6. **Column 22 carries its gap flag on the printed sheet and is never filled from the book.** It
   is either completed with our own counsel's position, that counsel's name and the date, or
   explicitly left open with a named owner and a target date. A confident-looking answer in
   column 22 with no attributable source is the single worst outcome this sheet can produce.
7. **The not-legal-advice disclaimer (ch05 L181) is on the printed artefact**, above block A.
   A copy circulated without it is not the artefact and must not be filed as one.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Carried unchanged from _section-clusters.md section 7 for CL-COMPLIANCE-SCOPE.
- **Fill (the organisation completing it): `S`.** S - one sitting, data already in the room

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Two passages want this same worksheet and should be merged into one: the capability-to-framework criticality matrix at lines 79-94, including the derivation rule at line 94 ("How to read this"), and the Regulatory Landscape framework-to-posture table at lines 179-213 (section "Regulatory Landscape", anchor regulatory-landscape) which adds GDPR / data residency as a column the first table omits. Both are already structured; authoring needed is only the in-scope tick column, the owner column and the current-posture column. Facilitation note: fill this BEFORE the readiness assessment because it sets which rows are mandatory. Carry the chapter disclaimer that this is not legal advice (line 181) onto the worksheet.
