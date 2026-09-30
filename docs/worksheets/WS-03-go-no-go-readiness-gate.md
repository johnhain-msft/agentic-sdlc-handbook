# Go / No-Go Readiness Gate

`WS-03-go-no-go-readiness-gate` &middot; **Pack G - The plan we leave with** &middot; fill order **6** &middot; type `checklist` &middot; audience **exec** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** The capstone sign-off of the pre-groundbreaking kit: a one-page, signed decision to break ground, with the three conditions and their evidence attached.

**Cluster.** `CL-GO-NO-GO` - Go / No-Go: The Signature Page

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch03-the-business-case.qmd` |
| Chapter | The Business Case |
| Heading | The Honest Version |
| Stable anchor | `#sec-business-case-honest-version` |
| Lines | L352-356 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch03-the-business-case.html#sec-business-case-honest-version> |
| Locator quote | "AI-assisted development tools produce measurable value when three conditions hold" |

Resolve at any time with `python docs/resolve.py ws WS-03-go-no-go-readiness-gate`.

## 3. Source extract - the scaffolding, verbatim

```text
  352 | AI-assisted development tools produce measurable value when three conditions hold: the team invests in structured context so agents work with accurate information, the organization commits to a 4–6 month adoption curve before expecting returns, and success is measured in outcomes — cycle time, defect rates, knowledge retention — rather than in lines of code produced.
  353 | 
  354 | The tools are not free. License costs are the smallest component of a total investment that includes context engineering, training, governance, and the opportunity cost of the learning curve. The value is not 10×. On well-scoped tasks with mature context, expect 20–40% improvements in cycle time and measurable reductions in convention-violation defects. Over 12+ months, the working hypothesis is that the effects of documented knowledge and institutional context compound — that returns accelerate rather than plateau. The early signal from teams 12+ months in is consistent with that hypothesis; the field does not yet have multi-year longitudinal evidence that would close the case. Build the business case on the measurable near-term returns and treat the compounding thesis as the upside, not the foundation.
  355 | 
  356 | This is a real business case. It does not require inflated claims to justify the investment. It requires patience, honest measurement, and a willingness to invest in the infrastructure — context, governance, skills — that makes the tools effective.
```

## 4. What the user fills

A yes/no with named evidence against each of the three conditions - structured context investment committed, 4-6 month adoption curve accepted before returns are expected, success defined in outcome metrics rather than lines of code - plus the signature of the accountable executive and the date of the first review gate.

## 5. Field-level schema

Rows are the three conditions (block A), the twelve governance items (B), the five executive moves
(C) and the calibration acknowledgement (D). **It is one page and it is signed.** A3 portrait,
four blocks, a single decision line and a signature strip at the foot. Block A carries five
columns; blocks B and C are deliberately narrow so all twenty rows fit in one view — this is the
last page of the pack and its whole value is that a reader sees the entire basis of the decision
without turning anything over.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | **A. Conditions** — Condition | `free text`, locked (three rows) | (1) The team invests in structured context so agents work with accurate information · (2) the organisation commits to a 4–6 month adoption curve before expecting returns · (3) success is measured in outcomes — cycle time, defect rates, knowledge retention — rather than in lines of code produced | — | ch03 L352 |
| 2 | **A. Conditions** — Holds | `select` yes / no | — | A straight answer per condition. ch03 L352 makes value conditional on all three | ch03 L352 |
| 3 | **A. Conditions** — Evidence artefact | `free text` | Pre-printed cross-references: condition 1 → `WS-03-context-moat-asset-inventory` · condition 2 → the valley contract on `WS-08-phase-gate-exit-rollback`, reconciled against the calibrated bands on `WS-08-transition-roadmap` · condition 3 → `WS-03-delivery-baseline-scorecard` and `WS-08-baseline-measurement-plan` | The completed sheet, by name and date. An assertion with no artefact is not evidence | derived |
| 4 | **A. Conditions** — Attested by | `owner (named person)` | — | The person who looked at the artefact, not the person chairing | derived |
| 5 | **A. Conditions** — If not: what is missing, and by when | `free text` + `date` | — | A condition marked `no` does not block the decision, but it converts a GO into a GO WITH CONDITIONS and must be written here | derived |
| 6 | **A. Conditions** — Condition 2 reconciliation | `free text` | The book states a 4–6 month adoption curve | **Mandatory.** Our own calibrated curve, carried from the org-size band on `WS-08-transition-roadmap`. For a 1,000+ engineer organisation ch08 L108 puts Phase 1 *alone* at 4–6 months, so 4–6 months to returns is not a universal figure and must not be accepted as one | ch03 L352; ch08 L108, L134, L161 |
| 7 | **B. Governance gate** — Item | `free text`, locked (twelve rows) | Governance readiness self-assessment across the six areas, prioritised by regulatory scope · prioritise audit trails and agent access controls if either is at "None" · classify agent-introduced risks across all six taxonomy categories and assign owners · map products to regulatory frameworks and evaluate agent-specific gaps · review agent instruction files and context sources for supply-chain integrity, applying change-management controls · establish a board reporting cadence with targets and trends · review the code review process for agent-specific failure modes, including implicit compliance decisions · document the data boundary policy and verify enforcement is systemic, not procedural · design deliberate practice into the process to mitigate knowledge atrophy · test the fallback: can delivery be sustained if agent assistance is unavailable for 48 hours · confirm E&O and cyber insurance address agent-generated code, raising it with the CFO before the board does · schedule a quarterly governance review | — | ch05 L265-276 |
| 8 | **B. Governance gate** — Status | `select` complete / in progress / not started | — | — | ch05 L263-276 |
| 9 | **B. Governance gate** — Owner | `owner (named person)` | — | — | ch05 L263-276 |
| 10 | **B. Governance gate** — Due date | `date` | — | — | ch05 L263-276 |
| 11 | **B. Governance gate** — Evidence artefact | `free text` | — | Usually the completed worksheet this item rolls up to. A pointer, not a description | ch05 L263-276 |
| 12 | **B. Governance gate** — Waived | `checkbox` | — | Ticked where the organisation consciously proceeds without it. A waiver is an explicit risk acceptance, not an omission | ch05 L263 |
| 13 | **B. Governance gate** — Waiver accepted by | `owner (named person)` + `signature` | — | **Mandatory wherever column 12 is ticked.** An unsigned waiver is an item quietly dropped, and the record of who waived what is the second output of this page | derived |
| 14 | **C. Five moves** — Move | `free text`, locked (five rows) | Build a team of Agentic Workflow Engineers for recurring, ROI-positive use cases · mandate that each shipped workflow pins its model tier, and the tier of every subagent it spawns, to the cheapest sufficient class with prompt compression and token discipline while output quality holds · release, distribute and monitor the loops as software artifacts, through the package manager and the catalog · gate usage with explicit cost-vs-value approvals, waving through local and low-gradient workflows · give everyone open, baseline access to the most cost-effective versatile models, and treat any spend beyond that baseline as an intentional bet made once monitoring proves net-positive ROI | — | ch07 L177-181 |
| 15 | **C. Five moves** — Accountable executive | `owner (named person)` | ch07 L178 is explicit that doing the pinning is the engineer's job and requiring it is the leader's | A named executive per move | ch07 L177-181 |
| 16 | **C. Five moves** — Target date | `date` | — | — | ch07 L176-183 |
| 17 | **C. Five moves** — Evidence that would prove it done | `free text` | — | What a sceptic would ask to see. Not "the policy exists" — the thing that shows it is being followed | ch07 L176-183 |
| 18 | **C. Five moves** — Current status | `select` not started / in progress / done | — | — | ch07 L176-183 |
| 19 | **D. Calibration** — The book's calibration | printed, non-editable, **initialled by every signatory** | "The value is not 10×. On well-scoped tasks with mature context, expect 20–40% improvements in cycle time and measurable reductions in convention-violation defects. Over 12+ months the compounding of documented knowledge is the working hypothesis, not the foundation — the field does not yet have multi-year longitudinal evidence that would close the case. Licence costs are the smallest component of a total investment that includes context engineering, training, governance, and the opportunity cost of the learning curve." | Initials only. The text is not editable and the figures are not targets | ch03 L354 |
| 20 | **D. Calibration** — Our own expected return | `free text` + `select` `measured` / `author estimate` / `vendor claim` | — | **Mandatory.** What *we* expect, and the evidence grade behind it, using the identical vocabulary to `WS-05-board-reporting-scorecard` column 8. An organisation whose only stated expectation is the book's 20–40% has written `author estimate` and must say so | ch03 L354; ch01 L136-142 |
| 21 | **D. Calibration** — Falsifier for that expectation | `free text` | — | The specific observation that would tell us we were wrong. Same rule as the scorecard: an observation, not a risk | ch01 L136-142 |
| — | Decision | `select` GO / GO WITH CONDITIONS / NO-GO | — | One line, one decision | derived |
| — | Conditions attached to the decision | `free text` | — | Populated from every column 5 entry and every ticked column 12 | derived |
| — | Accountable executive signature + date | `signature` | — | One signature. This is the artefact that authorises breaking ground | ch05 L263 |
| — | First review gate date | `date` | — | The date this decision is next revisited, reconciled to Gate 1 on `WS-08-phase-gate-exit-rollback` | derived |

**Absorbed detail.** `WS-05-governance-go-no-go-gate` is block B, columns 7–13: its twelve
pre-populated items, the complete / in progress / not started status, the named owner, the due
date, the pointer to the evidence artefact that proves it, and — the part that must not be lost —
the waiver tick and the **signed** waiver acceptance, so consciously skipped items are recorded as
explicit risk acceptance rather than disappearing between drafts.
`WS-07-leaders-playbook-commitments` is block C, columns 14–18: the five moves as rows, each with
an accountable executive, a target date, the evidence that would prove it done, and its current
status. Its output — the cost operating model expressed as five dated, owned commitments — is
preserved intact and sits on the same page as the decision it conditions.

**Deliberate omission.** No score, no weighting and no "readiness percentage" across the twenty
rows. The chapter states three conditions and does not rank them; a percentage would let ten
complete governance items outweigh a missing baseline, which is exactly the trade this page exists
to refuse.

**Deliberate omission.** No re-statement of the ROI model, the TCO or the spend pools. Those are
`WS-03-roi-break-even-model` and `WS-07-spend-pool-budget-model`, and this page cites them by name
in column 3 rather than carrying a second copy that can disagree with the first.

## 6. Absorbed members (2)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-05-governance-go-no-go-gate` - Governance Go / No-Go Gate Before Breaking Ground

- **Address.** `handbook\ch05-governance-for-ai-assisted-delivery.qmd` L263-291, Chapter Checklist (`#sec-governance-chapter-checklist`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Twelve pre-populated items, each ticked complete / in progress / not started, with the named owner, the due date, and a pointer to the evidence artefact that proves it (usually the completed worksheet it rolls up). A final go / no-go line is signed by the accountable executive, with any consciously waived items recorded as explicit risk acceptance.
- **Its output was.** A signed governance go/no-go gate - the closing artefact of the pre-groundbreaking kit, and the record of which items were waived and by whom.

### `WS-07-leaders-playbook-commitments` - The Five Moves — Owner, Date, Evidence of Done

- **Address.** `handbook\ch07-the-agentic-sdlc-bill.qmd` L176-183, The Leader's Playbook (`#sec-bill-leaders-playbook`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Five rows, one per move (build the Agentic Workflow Engineer team; mandate model-tier pinning including subagents; release and monitor loops as software artifacts; gate with cost-vs-value approvals; give everyone baseline access and treat anything beyond as an intentional bet). Per row: accountable executive, target date, evidence that would prove it done, and current status.
- **Its output was.** A signed executive commitment sheet — the closing page of the leadership delivery, where the cost operating model becomes five dated, owned commitments.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-08-transition-roadmap` - The Transition Roadmap — Three Phases, Named Teams, Dated Gates (Pack G - The plan we leave with, fill order 5)
- `WS-03-roi-break-even-model` - Agentic ROI & Break-Even Model (Pack C - The case and the money, fill order 6)
- `WS-08-phase-gate-exit-rollback` - Phase Gate Cards — Exit Signals, Rollback Triggers, and the Kill Switch (Pack G - The plan we leave with, fill order 4)
- `WS-03-context-moat-asset-inventory` - Context Asset & Debt Inventory (Pack A - Groundwork (pre-work), fill order 2)

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** Chapter 4 reference architecture and the build-out plan that follows it

## 8. Facilitation

| | |
|---|---|
| Who fills it | The accountable executive who will sign it, with the owners named on the sheets it consumes: the context asset inventory, the ROI model, the calibrated roadmap and the gate cards. Whoever holds governance must be present for block B — the twelve items are ticked against evidence, and the person who knows whether the evidence exists is rarely the person chairing. |
| When in the session | Last. Fill order 6 in Pack G, but it closes the pack: it consumes `WS-08-transition-roadmap`, `WS-08-phase-gate-exit-rollback`, `WS-03-roi-break-even-model` and `WS-03-context-moat-asset-inventory`, and it must not be attempted before all four are on the table. It is a consuming gate, not new content. |
| Duration | 45–60 minutes, and it should feel short. If block A takes an hour, the pack has not done its job and the correct outcome is NO-GO or a reconvene, not a longer meeting. Budget 20 minutes for block A including the condition 2 reconciliation, 20 for block B's twelve rows, 10 for block C, and 10 to write and sign the decision line. |
| Data needed in advance | Every prerequisite sheet, completed and dated, physically present in the room — not summarised. The calibrated org-size band from the roadmap, for column 6. The governance readiness assessment, for block B. The current owner of each of the five moves. Anyone who cannot produce their artefact should be asked before the meeting, not in it. |
| Room format | Single printed A3 page, one copy, filled by hand and signed in the room with the prerequisite sheets laid out on the table beside it. Not projected and not circulated for e-signature afterwards: the physical act of laying out four completed worksheets and pointing at them while column 3 is filled is the verification, and it does not survive being done over email. |

**Facilitation note.** Three things reliably go wrong here. First, **condition 2**. The room reads
"4–6 month adoption curve", recognises it, and accepts it — and for an organisation above a
thousand engineers that is wrong by a wide margin, because ch08 puts Phase 1 alone at 4–6 months
at that scale. Force column 6 open and read the calibrated band off the roadmap. Second, **block
B waivers**. Items get marked "in progress" when they mean "not started and not owned"; ask for
the evidence artefact in column 11 and downgrade anything that cannot produce one. A genuine
waiver, signed, is a better outcome than an optimistic status. Third, **column 19**. Read the
calibration paragraph aloud, in full, before anyone initials it — the 20–40% figure is the single
most likely number in this pack to reappear in a board deck as an industry benchmark, and column
20 exists so that what travels upward is the organisation's own expectation carrying its own
grade. A room that will not write its own number in column 20 has not accepted the business case;
it has accepted the book's.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All three conditions carry a yes/no and a named evidence artefact.** A `yes` in column 2 with
   an empty column 3 is an opinion. Each artefact is a completed, dated worksheet that is
   physically present when the page is signed.
2. **Column 6 is filled with the organisation's own calibrated curve, not the book's.** An
   organisation that has calibrated its roadmap to a 1,000+ engineer band and still records a 4–6
   month time-to-returns has copied a figure that its own Phase 1 range contradicts, and the two
   sheets disagree.
3. **Every one of the twelve governance items has a status, an owner and either an evidence
   artefact or a signed waiver.** Column 13 is signed wherever column 12 is ticked. The register of
   what was waived and by whom is the second deliverable of this page and must survive it.
4. **All five moves carry an accountable executive, a target date and an evidence statement.** A
   move with a status and no evidence definition cannot later be shown to be done.
5. **Column 20 contains the organisation's own expected return with an evidence grade**, using the
   same three-value vocabulary as `WS-05-board-reporting-scorecard`, and column 21 contains a
   falsifier that is an observation rather than a risk. A page whose only stated expectation is the
   book's 20–40% must show `author estimate` in column 20.
6. **Every signatory has initialled column 19.** The calibration paragraph is read before it is
   initialled, not after.
7. **The decision line reconciles with what is above it.** A GO with an unmet condition in block A,
   or with an unsigned waiver in block B, is a GO WITH CONDITIONS — and the conditions are written
   out, not implied.
8. **The first review gate date matches Gate 1 on `WS-08-phase-gate-exit-rollback`**, and the
   named decision-maker is the same person on both sheets. A go/no-go whose next review is not the
   first phase gate has created a second, parallel review track.
9. **The page is signed, dated and one page.** If it needed a second page, something that belongs
   on a prerequisite sheet has been restated here and should be removed.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** A consuming gate, not new content: the book states the three conditions verbatim at ch03 line 352 and each maps to an instrument already in the kit. The sheet is a one-page signature block over three pre-written rows.
- **Fill (the organisation completing it): `S`.** S - one sitting, data already in the room

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> THE NATURAL CLOSING ARTEFACT FOR THE WHOLE DELIVERY. The book states three conditions that must hold for value to appear (line 352), and each maps cleanly to an instrument already in this inventory: condition 1 to WS-03-context-moat-asset-inventory, condition 2 to WS-03-adoption-jcurve-contract, condition 3 to WS-03-delivery-baseline-scorecard. That makes this a consuming gate, not new content - it should be the last page of the pack and must be short (one page, signed). Also carries the book's calibration to print on the sheet: value is not 10x; expect 20-40% cycle time improvement on well-scoped tasks with mature context; treat the compounding thesis as upside, not foundation (lines 354-356). Synthesizer note: if any later chapter also proposes a readiness gate, this one wins on placement - it closes the leadership block before Chapter 4 opens the architecture.
