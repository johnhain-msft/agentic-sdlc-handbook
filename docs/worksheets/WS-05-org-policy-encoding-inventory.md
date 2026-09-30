# Organisational Policy Encoding Inventory: What Your Agents Cannot Know

`WS-05-org-policy-encoding-inventory` &middot; **Pack E - Guardrails: authority, risk and proof** &middot; fill order **3** &middot; type `inventory` &middot; audience **mixed** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A ranked backlog of policies to encode as versioned machine-readable context primitives, plus an explicit list of the ones that can only be handled by a human escape valve.

**Cluster.** `CL-POLICY-ENCODING` - What Our Agents Cannot Know: Policy and Fact Encoding

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch05-governance-for-ai-assisted-delivery.qmd` |
| Chapter | Governance for AI-Assisted Delivery |
| Heading | The Organizational Knowledge Gap |
| Stable anchor | `#sec-organizational-policy-gap` |
| Lines | L161-177 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch05-governance-for-ai-assisted-delivery.html#sec-organizational-policy-gap> |
| Locator quote | "The Growth Engine finding above is worth treating as the central governance fact" |

Resolve at any time with `python docs/resolve.py ws WS-05-org-policy-encoding-inventory`.

## 3. Source extract - the scaffolding, verbatim

```text
  161 | The Growth Engine finding above is worth treating as the central governance fact this chapter sets up, not a footnote. It is the single result that most clearly separates "AI got better" from "governance got harder," and it is the result every CTO should expect to see replicated in their own organization within the first year of agent adoption.
  162 | 
  163 | **What happened.** A multi-agent panel of fifteen specialist personas — staffed across seven expert panels covering market analysis, technical architecture, security review, compliance posture, and customer-impact assessment — reviewed a proposed product change end to end. The review produced a structured set of findings, prioritized recommendations, and an explicit go/no-go verdict. A single human reviewer, with thirty seconds and no specialist knowledge, identified a compliance constraint the entire panel had missed. The constraint was a Microsoft-internal policy about the cross-org use of a specific data classification. It is documented in the company's own policy library. It has been in force for years. None of the fifteen specialist agents flagged it. The case study reports the finding verbatim: *"fifteen personas across seven panels missed it because organizational policy is not in the training data."*
  164 | 
  165 | **Why this is permanent, not transient.** The temptation is to read this as a defect of current models that will improve with scale. It will not. Organizational policy is, by construction, not in any training corpus: it is internal, it is privileged, it changes faster than training cycles, and it is often deliberately not written down outside privileged systems. Even if a future model were trained on every public document on the internet, it would still know nothing about your CELA review triggers, your data classification taxonomy, your cross-business-unit data-sharing rules, or your jurisdiction-specific approval thresholds. This gap is a property of *what training data is*, not a property of *how good the model is*. It is a permanent boundary of the methodology.
  166 | 
  167 | **Why specialist agents do not close the gap.** It is tempting to assume that a security-specialist agent or a compliance-specialist agent will know the policies a generalist agent does not. The Growth Engine result rules this out: the failed review *was* a panel of specialists, and the specialists confidently produced authoritative-sounding analysis precisely in the area where they were missing the constraint. A specialist agent without explicit access to your policy library is a generalist agent with a more confident voice, not a more knowledgeable one. The fluency of the output is what makes the gap dangerous: the panel did not say "we don't know" — it said "we have considered everything and recommend proceeding."
  168 | 
  169 | **What the gap means for governance design.** Three implications follow:
  170 | 
  171 | 1. **Policies must be encoded as primitives, not assumed as background.** Every organizational policy that the agent could plausibly need to apply must exist as a versioned, machine-readable artefact in the same context layer the agent already loads. Part III makes the encoding concrete; the governance point is that policies which exist only in PDFs, wikis, or institutional memory are, from the agent's perspective, equivalent to not existing at all.
  172 | 2. **Policy gates belong at the seam, not in the review.** The reflexive response to a policy gap is "we will add another review step." That response is wrong: weak-form supervision (review-after-the-fact) is a poor fit for low-prevalence, high-stakes constraints, because reviewers quickly learn to skim. The strong-form alternative is to encode the policy as an executable check that runs at the seam where the agent's action meets the platform — a CI check, a pre-commit gate, an automated approval rule. The gate either passes or it blocks; there is no "the reviewer was tired today" failure mode.
  173 | 3. **Human-in-the-loop is not a substitute for encoded policy — it is a fallback when the encoding is incomplete.** Mature governance treats the human reviewer as the *escape valve* for the cases the encoded gates cannot anticipate, not as the primary enforcement mechanism. Inverting this — assuming a human will catch what the encoding misses — fails at any scale where review volume exceeds review attention.
  174 | 
  175 | The Growth Engine result is not a story about a single bug; it is a story about the shape of every governance gap your organization will encounter in the next twenty-four months. Treat it as the binding evidence that the Enterprise column of the readiness checklist above is not aspirational ornament — it is the required engineering response to a permanent property of the methodology.
  176 | 
  177 | ---
```

## 4. What the user fills

One row per organisational policy an agent could plausibly need to apply (legal review triggers, data classification taxonomy, cross-business-unit data-sharing rules, PII handling thresholds, jurisdiction-specific approval thresholds, export and licensing constraints). Per row: where the policy lives today (PDF, wiki, privileged system, institutional memory only), is it machine-readable yes/no, who owns and versions it, can it be expressed as an executable gate at the seam (CI check, pre-commit, approval rule) or does it need a human escape valve, and the target date to encode it.

## 5. Field-level schema

Two registers on one A3 landscape sheet, printed two-sided. **Block A — the policy and
constraint inventory** (front) is the ranked encoding backlog. **Block B — the load-bearing
facts register** (back) is the much shorter list of facts about ourselves that agents will
restate everywhere. They are different instruments and must not be merged into one grid: a
policy is a rule an agent must apply, a fact is a datum an agent must not get wrong. Both pages
carry the chapter's callout-warning (ch05 L153-157) and the case-study line at ch05 L163 printed
at the head.

**Block A — policy and constraint inventory.** One row per organisational policy or constraint
an agent could plausibly need to apply. The sheet prints thirteen seed rows drawn from the
categories the book names; the room adds its own and is expected to, because the seed list is a
prompt, not a scope.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Policy or constraint | `free text` (13 seed rows pre-printed) | Legal or CELA review triggers; data classification taxonomy; cross-business-unit data-sharing rules; jurisdiction-specific approval thresholds; PII-touching-feature review; the corporate-to-personal asset boundary; brand and promotional rules; procurement and vendor rules; data residency; open-source contribution policy; export control; retention; compliance thresholds | Our actual policy name and document identifier | ch05 L156, L165; ch20 L375; case study L143-150 |
| 2 | What it requires, in one sentence an agent could act on | `free text` | — | The operative rule, not the policy's title. If it cannot be written in one actionable sentence it cannot be encoded | ch05 L171 |
| 3 | Where it lives today | `select` — instruction file / governance primitive / CI check / privileged system / wiki / PDF / institutional memory only / nowhere | — | — | ch05 L171; absorbed `WS-20-policy-encoding-inventory` |
| 4 | Machine-readable today | `select` — yes / no | — | `no` for every value of column 3 from `privileged system` rightwards | ch05 L171 — policies in PDFs, wikis or institutional memory are "equivalent to not existing at all" |
| 5 | Versioned | `checkbox` | — | Ticked only if it has a version and a change history an agent could pin | ch05 L171 |
| 6 | Owner of record | `owner (named person)` | — | The person who maintains it | org |
| 7 | Who can waive it | `owner (named person)` | — | A different question from column 6, and frequently a different person | case study L143-150 |
| 8 | Encodable as an executable check at the seam | `select` — yes, CI check / yes, pre-commit gate / yes, automated approval rule / no, human escape valve only | — | — | ch05 L172 — "Policy gates belong at the seam, not in the review" |
| 9 | Enforcement mode | `select` — advisory / gate / blocking | — | — | absorbed `WS-20-policy-encoding-inventory` |
| 10 | Prevalence | `select` — routine / low-prevalence | — | How often the constraint actually bites | ch05 L172 — reviewers "quickly learn to skim" low-prevalence constraints |
| 11 | Stakes if missed | `H/M/L` | — | — | org |
| 12 | Encoding priority | `computed` — encode first / encode next / advisory is adequate | — | `encode first` where column 10 is `low-prevalence` and column 11 is `H`; that pairing is the one human review is structurally worst at | ch05 L172 |
| 13 | Encode by | `date` | — | Required on every row whose column 12 is not `advisory is adequate` | org |
| 14 | Escape-valve owner and route | `owner (named person)` + `free text` | — | Required wherever column 8 reads `no`: the named human, and how the agent's workflow physically reaches them | ch05 L173 |

**Block B — load-bearing facts register.** One row per fact about ourselves that agents will
restate across deliverables. Short by design; if it runs past a page the room has started
listing knowledge rather than load-bearing facts.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 15 | Fact class | `select` | Role and job titles / team names / product names / customer names / compliance claims / metrics | Additional classes as needed | case study L110-114 |
| 16 | The correct value | `free text` | — | Written out exactly as it must appear | case study L110-114 |
| 17 | Verified source | `free text` | — | The system of record — an HR system, a customer list, a signed report. **Never another generated artefact** | case study L110-114 |
| 18 | Owner | `owner (named person)` | — | — | org |
| 19 | Review date | `date` | — | — | org |
| 20 | Human-verified before downstream use | `checkbox` + `date` | — | Ticked by a person, not by the wave that produced it | case study L110-114 |

**Absorbed detail.** All three absorbed members are carried and none is condensed away.
`WS-20-policy-encoding-inventory` supplies block A's spine: its policy categories seed column 1,
its "where is it encoded today" becomes column 3, its human owner of record becomes column 6,
its enforcement mode becomes column 9, and its gap action becomes columns 12-13.
`WS-CS-GROWTH-org-policy-constraints` supplies the constraint classes that exist nowhere in
public documentation — brand and promotional rules, the corporate-to-personal and
cross-business-unit boundaries, procurement and vendor rules, data residency, open-source
contribution policy — which are seed rows in column 1, and its distinctive demand, *the owner
who can waive it*, is column 7 and exists nowhere else in the kit.
`WS-CS-GROWTH-facts-register` is block B in full: fact, verified source, owner and review date
are columns 15-19, and its rule that generated profiles are human-verified before any
downstream wave consumes them is column 20, printed as a tick a person has to sign rather than
a line of policy prose.

**Deliberate omission.** No count, no coverage percentage, no numeric priority score. Column 12
is a three-band qualitative judgement derived from two columns the room filled itself, because
the book supplies no weights and a policy backlog that sorts on an invented score will be
re-sorted by whoever dislikes the answer. There is also no "agent can infer this" column: the
chapter forecloses the question at L165 (this gap is a property of what training data *is*) and
at L167 (a specialist agent without the policy library is a generalist with a more confident
voice), so a column inviting the room to guess would reopen a question the source has closed.

## 6. Absorbed members (3)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-20-policy-encoding-inventory` - Policy Encoding Inventory: Which of Our Rules Does an Agent Actually Know?

- **Address.** `handbook\ch20-anti-patterns-and-failure-modes.qmd` L375-375, Team-Level Anti-Patterns (`#sec-anti-team-level`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** One row per organisational policy -- legal review triggers, data classification rules, compliance thresholds, export control, procurement rules, retention: the policy, its human owner of record, where it is encoded today (instruction file / governance primitive / CI check / nowhere), the enforcement mode (advisory, gate, blocking), and the gap action.
- **Its output was.** A policy-to-primitive traceability matrix with an explicit gap list of the policies that currently exist only in human heads.

### `WS-CS-GROWTH-facts-register` - Load-Bearing Facts Register

- **Address.** `case-study-growth-engine.qmd` L110-114, The Persona Drift Correction (`#sec-cs-growth-persona-drift`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** The team lists the facts about itself that agents will restate everywhere and must never get wrong - role titles, team and product names, customer names, compliance claims, metrics - with a verified source for each, an owner, and a review date. Plus the rule that generated profiles are human-verified before any downstream wave consumes them.
- **Its output was.** A single verified source-of-truth sheet that every agent primitive references, preventing one wrong fact from propagating into every deliverable.

### `WS-CS-GROWTH-org-policy-constraints` - Organizational Policy Constraints That No Agent Can Infer

- **Address.** `case-study-growth-engine.qmd` L143-150, Constraint Discovery (`#sec-cs-growth-constraint-discovery`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** The leadership team enumerates the constraints that exist nowhere in public documentation or training data: compliance and legal review gates, brand and promotional rules, what may cross the boundary between corporate and personal or between business units, procurement and vendor rules, data residency, and open-source contribution policy. Each with the owner who can waive it.
- **Its output was.** A named constraint list injected into every agent primitive and panel brief - the input no model can produce for itself.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- None. This sheet can be filled cold.

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** WS-05-decision-rights-gate-matrix and the Evidence captured column of every gate

## 8. Facilitation

| | |
|---|---|
| Who fills it | **Legal or compliance and security must physically be in the room** — between them they own most of column 6 and all of column 7, and a waiver authority cannot be nominated in absentia. Add the platform or developer-experience engineer who will actually build the checks: a legal owner will over-promise what is encodable and an engineer is the only person who can say what a gate at the seam can actually see. Bring HR only if the policy set includes employment or conduct rules that agents touch. Where `WS-06-role-map-and-staffing-triggers` is already filled, the named Domain Specialists attend for the policies in their domain. |
| When in the session | Pack E, third sheet. It can be filled cold, but it lands better after `WS-05-compliance-scope-and-posture-matrix`, because the frameworks ticked there generate seed rows here that the room would otherwise miss. It must precede `WS-05-decision-rights-gate-matrix`, whose Gate and Evidence-captured columns consume column 8 and column 9 directly. |
| Duration | Two hours as a first sitting, and **plan not to finish.** Block A's first pass is discovery: the room reliably surfaces policies nobody present knew existed and cannot name an owner for several. Schedule a second sitting to close columns 6, 7 and 13 rather than pretending one session covers it. Block B takes 30 minutes and is usually the easiest half-hour in Pack E. |
| Data needed in advance | The policy library index, whatever form it takes — a SharePoint folder counts; the last dozen legal review requests and what triggered each; the data classification taxonomy; the open-source contribution policy; a current inventory of instruction files and CI checks in the real repository, so column 3 is observed rather than assumed; and the frameworks ticked on `WS-05-compliance-scope-and-posture-matrix`. |
| Room format | Run block A on a wall — one sticky per policy, in silence for the first ten minutes — and transcribe to the printed A3 afterwards. A printed grid with thirteen rows on it caps the room's output at thirteen rows, which is exactly the failure this sheet exists to avoid. Block B is filled directly on the sheet. |

**Facilitation note carried from ch05.** Print the callout-warning (L153-157) and the verbatim
case-study line at L163 — *fifteen personas across seven panels missed it because
organizational policy is not in the training data* — at the head of the sheet, and read them
aloud before the first sticky goes up. Then watch for the trap the chapter names at L172: the
reflexive response to a policy gap is "we will add another review step", and it is the wrong
response for low-prevalence, high-stakes constraints because reviewers learn to skim. Every
time a row's column 8 comes back as `no, human escape valve only`, ask once more whether the
policy is genuinely unencodable or merely unencoded. The chapter permits the escape valve at
L173 as a fallback for what the encoding cannot anticipate, never as the primary mechanism, so
a sheet on which most rows choose the valve has recorded a preference rather than a design.
Have L167 ready for the room that proposes a compliance-specialist agent as the answer: the
failed Growth Engine review *was* a panel of specialists.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **Every block A row carries both an owner of record (column 6) and a named waiver authority
   (column 7), and they are answered separately.** These are two different questions, and the
   second is the one the Growth Engine constraint actually turned on — someone had to be able
   to say "this may not cross that boundary". A row where column 7 reads "Legal" has not been
   filled.
2. **No row whose column 3 reads `institutional memory only` or `nowhere` is left without either
   an encode-by date (column 13) or a written, owned decision to accept the gap.** The chapter
   is unambiguous at L171: from the agent's perspective such a policy does not exist. Silence
   here is the sheet quietly agreeing that it does.
3. **Every row where column 8 reads `no, human escape valve only` appears on the printed
   escape-valve list with a named human and a physical route (column 14).** An escape valve with
   no reachable person is not a fallback; it is the assumption the chapter rules out at L173.
4. **The rows ranked `encode first` are the low-prevalence, high-stakes ones.** If the top of the
   backlog is populated by routine constraints, the ranking has been done by ease of
   implementation, not by where review fails (ch05 L172). At least one row must be ranked
   `encode first`, or the room has concluded it has no low-prevalence high-stakes policy at all
   — a claim that should be written down and defended, not arrived at by omission.
5. **Block B covers every fact class the case study names** — role and job titles, team names,
   product names, customer names, compliance claims, metrics — **every column 17 entry is a
   system of record, and every row is ticked and dated in column 20 by a person before any
   downstream worksheet or agent primitive cites it.** A verified source that is itself an
   agent-generated profile is the exact failure the case study records and fails this criterion
   outright; an unticked fact may not be consumed at all.
6. **Reconciliation with `WS-05-decision-rights-gate-matrix`.** Every policy that column 8 says
   will be a CI check, pre-commit gate or automated approval rule appears in that sheet's Gate
   column for at least one decision class, and its artefact appears in that sheet's Evidence
   captured column. A gate that exists here and nowhere there is an orphan; a decision class
   there with no policy here is a gap in this inventory.
7. **No row names a specialist agent as its control.** "The compliance agent will catch it" is
   foreclosed by ch05 L167 — the review that missed the constraint was a panel of fifteen
   specialists — and any row offering it must be re-filled with an encoded check or a named
   escape valve.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** Carried unchanged from _section-clusters.md section 7 for CL-POLICY-ENCODING.
- **Fill (the organisation completing it): `L`.** L - needs the real repository, finance input or cross-team agreement

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Highest-value implicit find in ch05 and arguably in all of Part II. The chapter names this as "the central governance fact this chapter sets up" (line 161) and as permanent rather than transient (line 165): fifteen specialist agents across seven panels missed a policy a human caught in thirty seconds. Despite that weight the book gives NO fillable structure, so this must be authored from the three implications at lines 171-175. The second and third implications supply the two hardest columns - policies living only in PDFs or memory are "equivalent to not existing at all" (line 171), and "Policy gates belong at the seam, not in the review" (line 173). The callout-warning at lines 153-157 states the same finding and should be quoted on the worksheet. The Growth Engine case study file linked at line 157 may carry further detail worth mining.
