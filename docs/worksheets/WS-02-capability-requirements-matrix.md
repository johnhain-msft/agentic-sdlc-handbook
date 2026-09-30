# Capability Requirements Matrix

`WS-02-capability-requirements-matrix` &middot; **Pack D - Architecture and ownership** &middot; fill order **1** &middot; type `matrix` &middot; audience **architect** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A vendor-neutral requirements definition that outlives any single landscape snapshot, plus a defensible shortlist score with the reasoning attached.

**Cluster.** `CL-PROCUREMENT` - Capability Requirements and Vendor Posture

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch02-the-ai-native-landscape.qmd` |
| Chapter | The AI-Native Landscape |
| Heading | The Landscape Today: Capabilities That Actually Matter |
| Stable anchor | `#sec-landscape-capabilities` |
| Lines | L100-140 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch02-the-ai-native-landscape.html#sec-landscape-capabilities> |
| Locator quote | "A feature comparison grid is the most natural thing to produce" |

Resolve at any time with `python docs/resolve.py ws WS-02-capability-requirements-matrix`.

## 3. Source extract - the scaffolding, verbatim

```text
  100 | A feature comparison grid is the most natural thing to produce and the least useful thing to read. Every vendor has one. They all look favorable to the vendor that made them. The table below attempts something different: an honest snapshot of where each tool actually is, what it can't do by design, and, critically, which capabilities you should care about first.
  101 | 
  102 | The maturity tiers: **Now** = available and shipping in production. **Emerging** = available but limited, or in public preview. **Directional** = announced, demonstrated in research, or on a public roadmap but not yet usable at production scale. **N/A** = not applicable — the tool's architecture doesn't target this capability, and that's a design choice, not a gap.[^ch2-matrix]
  103 | 
  104 | ::: {.landscape}
  105 | 
  106 | ::: {tbl-colwidths="[20,12,12,12,12,10,12,10]"}
  107 | 
  108 | | Capability | GitHub Copilot | Cursor | Claude Code | Windsurf | OpenCode | Amazon Q Developer | JetBrains AI |
  109 | |---|---|---|---|---|---|---|---|
  110 | | Code completion | Now | Now | N/A | Now | N/A | Now | Now |
  111 | | Chat / explain | Now | Now | Now | Now | Now | Now | Now |
  112 | | Multi-file editing | Now | Now | Now | Now | Emerging | Emerging | Emerging |
  113 | | Agent mode (in-editor) | Now | Now | N/A | Now | N/A | Emerging | Emerging |
  114 | | Terminal / CLI agent | Now | N/A | Now | N/A | Now | Emerging | N/A |
  115 | | Autonomous PR creation | Now | Emerging | Now | Directional | Directional | Directional | N/A |
  116 | | Code review agent | Now | Emerging | Directional | Directional | N/A | Emerging | Directional |
  117 | | Multi-model routing | Now | Now | N/A | Now | Now | Emerging | Now |
  118 | | Custom instructions / rules | Now | Now | Now | Now | Emerging | Emerging | Emerging |
  119 | | Enterprise governance | Now | Emerging | Emerging | Emerging | N/A | Now | Emerging |
  120 | | Full SDLC platform | Now | Directional | N/A | N/A | N/A | Emerging | N/A |
  121 | 
  122 | :::
  123 | 
  124 | :::
  125 | 
  126 | **Where to look first.** Not every row matters equally. If you're a CTO deciding where to invest evaluation time, three capabilities separate "we have a coding tool" from "we have a strategy":
  127 | 
  128 | 1. **Custom instructions / rules.** This is the mechanism that addresses the Vibe Coding Cliff. Without it, every agent interaction starts from zero context. With it, your architectural decisions, conventions, and constraints are loaded automatically. This is the row that determines whether AI tools get more reliable over time or stay permanently mediocre. All major tools support this now, but the implementations differ: GitHub Copilot uses custom instructions and `.github/copilot-instructions.md`, Cursor uses `.cursor/rules`, Claude Code uses `CLAUDE.md`, and OpenCode uses `.opencode/instructions.md`. The methodology in this book is portable across all of them. The pattern is more uniform than the file paths suggest: every harness treats the repository's filesystem as the loader for what the agent sees on each invocation — Part III (For Practitioners) calls this the *agent source code* and makes the load lifecycle explicit in Chapter 14 (@sec-load-lifecycle). The file paths are vendor-specific. The mechanism is not.
  129 | 2. **Enterprise governance.** Audit logs, SSO, data residency controls, policy enforcement. Without these, you're flying blind on compliance. This is where coding tools and platforms diverge most sharply, and where "good enough for a developer" and "acceptable for the organization" are different conversations.
  130 | 3. **Autonomous PR creation and code review agents.** These are the frontier capabilities that move AI from "helps me type faster" to "participates in my workflow." They're also where the governance gap is widest — an agent that can open a PR or approve a review needs the same trust framework you'd apply to a new hire.
  131 | 
  132 | The rest of the matrix (completion, chat, multi-file editing) is table stakes. Every serious tool does it. Don't let a vendor differentiate on capabilities that stopped being differentiators in 2024.
  133 | 
  134 | One more thing the matrix can't show you: **architecture shapes capability.** Claude Code has no code completion and no in-editor agent mode because it's a CLI tool, not an editor plugin — that's a design decision, not a deficiency. Cursor has no terminal agent because it's an editor-first experience. OpenCode is a terminal-native tool like Claude Code, focused on CLI workflows with multi-model routing — it's the newest entrant and its capability set is still expanding. JetBrains AI doesn't do autonomous PRs because it's focused on the IDE experience. The N/A cells matter as much as the Now cells — they tell you what each tool is *trying to be*, which tells you whether it fits your workflow.
  135 | 
  136 | As of mid-2025, Microsoft's tools (GitHub Copilot + GitHub platform) cover the broadest set of categories across both coding-tool and platform dimensions.[^ch02-landscape] This is a factual observation; the author works at Microsoft and discloses this. Whether breadth matters more than depth at any given capability is a decision each organization makes for itself.
  137 | 
  138 | [^ch02-landscape]: Landscape snapshot as of mid-2025. The competitive landscape evolves quarterly; verify current capabilities at each vendor's site before making tool decisions.
  139 | 
  140 | ---
```

## 4. What the user fills

Against each of the eleven capability rows, mark must-have / nice-to-have / not-applicable for this organisation and state why; then score only the shortlisted vendors using the book's four tiers (Now / Emerging / Directional / N/A).

## 5. Field-level schema

The sheet is deliberately **two artefacts on one form, printed on separate sides so they can be
separated**. Side 1 (blocks A, C, D) is the durable requirements definition: vendor-neutral,
undated, kept, and re-read at every renewal. Side 2 (blocks B and E) is the dated scorecard:
printed fresh for each evaluation cycle and thrown away when it goes stale. Nothing on side 1
carries a vendor name. A3 landscape.

**Block A — capability requirements.** Rows are the eleven capability names from
@sec-landscape-capabilities. The book's *cells* — which vendor was where in mid-2025 — are not
reproduced anywhere on this sheet.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Capability | `select` (fixed 11 rows) | Code completion / Chat-explain / Multi-file editing / Agent mode (in-editor) / Terminal-CLI agent / Autonomous PR creation / Code review agent / Multi-model routing / Custom instructions & rules / Enterprise governance / Full SDLC platform | — | ch02 L110-120 (row labels only) |
| 2 | What this must do for us | `free text` | — | The requirement in the org's own words, written without naming a product | derived |
| 3 | Priority | `select` Must-have / Nice-to-have / Not applicable | — | — | ch02 L100 |
| 4 | Why, in one line | `free text` | — | The reason. A Must-have without a reason is a preference | derived |
| 5 | Book flag: look here first | `checkbox` (pre-ticked, read-only) | Ticked on Custom instructions & rules, Enterprise governance, Autonomous PR creation, Code review agent | — | ch02 L126-130 |
| 6 | Book flag: table stakes | `checkbox` (pre-ticked, read-only) | Ticked on Code completion, Chat-explain, Multi-file editing | — | ch02 L132 |
| 7 | Evidence we will demand | `free text` | — | What a vendor must *demonstrate against our repository*, not assert in a deck | ch04 L103-121 |
| 8 | Our implementation of this today | `free text` | — | For Custom instructions & rules: the file path convention already in use, if any. The mechanism is portable; the paths are vendor-specific | ch02 L128 |
| 9 | Requirements signed off by | `owner (named person)` + `date` | — | Side 1 is closed before side 2 opens | derived |

**Block B — shortlist scorecard (dated, disposable).** One column group per shortlisted vendor.
The column headers are printed **blank**; the evaluator writes the vendors actually being
evaluated. The four-tier legend is printed once at the head of the block.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 10 | Vendor | `free text` (blank header per column group) | — | The org writes the names | derived |
| 11 | Tier observed | `select` Now / Emerging / Directional / N/A | Legend only: Now = available and shipping in production; Emerging = available but limited, or in public preview; Directional = announced, demonstrated or roadmapped but not usable at production scale; N/A = the architecture does not target this capability | The evaluator's own observation, never the vendor's claim | ch02 L102 |
| 12 | Evidence class | `select` Demonstrated / Asserted / Not shown | — | — | ch04 L103-121 |
| 13 | If N/A — design intent or genuine gap? | `select` Design intent / Gap | — | Forces the ch02 L134 reading: an N/A tells you what the tool is *trying to be* | ch02 L134 |
| 14 | Assessed on | `date` | — | Mandatory per column group. An undated scorecard is a rumour | ch02 L138 |
| 15 | Re-verify by | `date` | — | The snapshot decays; set the date now | ch02 L138 |

**Block C — tool or platform? (absorbed).** One row per purchase pending or already in flight,
including anything a team has already bought without central approval.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 16 | Purchase under consideration | `free text` | — | — | org |
| 17 | Classification | `select` AI coding tool / Software delivery platform | — | Pick one. The chapter's whole argument is that the two take different criteria | ch02 L77-79 |
| 18 | Who decides | `owner (named person)` | Reference: individual developer (tool) vs engineering leadership (platform) | The actual accountable person for *this* purchase | ch02 L88-95 |
| 19 | Primary value we are buying | `free text` | Reference: coding speed and quality vs lifecycle governance and automation | Our answer | ch02 L88-95 |
| 20 | Evaluation scope | `free text` | Reference: editor experience and model quality vs security, compliance, audit trails | Our answer | ch02 L88-95 |
| 21 | Risk if ungoverned | `free text` | Reference: inconsistent code quality vs shadow IT and compliance exposure | Our answer | ch02 L88-95 |
| 22 | Switching cost | `H/M/L` | Reference: low (editor plugin) vs high (CI/CD, permissions, history) | Our own assessment, with the reason | ch02 L88-95 |
| 23 | SDLC coverage | `free text` | Reference: code (+ expanding) vs ideate through operate | Our answer | ch02 L88-95 |

**Block D — build / buy / compose posture (absorbed).** Three fixed rows.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 24 | Context domain | `select` (fixed 3) | Work context / Data context / Code context | — | ch04 L222-226 |
| 25 | Posture | `select` Build / Buy / Compose | — | One per row | ch04 L218 |
| 26 | Named vendor or team | `free text` | — | — | org |
| 27 | Annual cost | `currency` | — | — | org |
| 28 | Integration burden accepted | `free text` | — | What the org is taking on in exchange for optionality | ch04 L218 |
| 29 | Lock-in exposure — which supply-chain layers this vendor would own | `free text` | — | Cross-reference the bands on `WS-04-five-layer-supply-chain-canvas` by name | ch04 L232 |
| 30 | Exit cost | `free text` | — | — | ch04 L232 |
| 31 | Contract renews | `date` | — | — | ch04 L232 |

**Block E — vendor claims vs reality audit (absorbed, dated).** Rows are the **eight lifecycle
phases**, not the eleven capabilities; columns are the shortlisted vendors from block B.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 32 | Lifecycle phase | `select` (fixed 8) | Ideate / Plan / Code / Build / Test / Review / Release / Operate | — | ch04 L108-118 |
| 33 | Tier the vendor claims | `select` Now / Emerging / Directional / N/A | — | As stated by the vendor | ch04 L103 |
| 34 | The vendor's own definition of that term | `free text` | — | Ask it explicitly. The definition tells you more than the tier | ch04 L120 |
| 35 | Demonstrated or asserted | `select` Demonstrated / Asserted | — | — | ch04 L120 |
| 36 | Evaluator verdict | `free text` | — | — | derived |
| 37 | Claim-to-evidence honesty (summary row, one per vendor) | `H/M/L` | — | **H** — every tier the vendor claimed was demonstrated against our repository. **M** — claims broadly held, but at least one `Now` was asserted rather than shown. **L** — one or more claimed tiers could not be demonstrated at all | derived |

**Absorbed detail.** `WS-02-tool-vs-platform-decision-frame` is block C in full: the
classification at column 17, all six criteria rows at columns 18-23, and the named accountable
decision-maker at column 18. `WS-04-build-buy-compose-posture` is block D in full: three context
domains, the posture, the named vendor or team, the annual cost, the integration burden, and the
three-part lock-in exposure — layers owned, exit cost, renewal date — at columns 29-31.
`WS-04-vendor-maturity-claims-audit` is block E in full: eight lifecycle-phase rows by vendor
columns, the claimed tier, the vendor's own definition of the term, demonstrated-versus-asserted,
the evaluator verdict, and the per-vendor honesty summary row at column 37.

**Deliberate omission.** Three things in the source range are deliberately not printed. First, the
mid-2025 vendor-by-capability grid itself: reproducing those cells would put a decaying snapshot
on a sheet that outlives it, and the footnote at ch02 L138 says plainly that the landscape evolves
quarterly and must be verified at each vendor's site. The row labels are durable; the cells are
not. Second, the author's Microsoft disclosure at ch02 L136 — accurate in the book, out of place
in a vendor-neutral kit the organisation fills in for itself. Third, no weighted total or composite
vendor score. Column 37 is an anchored H/M/L on honesty, not an aggregate: a single number invites
the room to buy the highest total rather than the capability it wrote down as Must-have in block A.

## 6. Absorbed members (3)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-02-tool-vs-platform-decision-frame` - Tool-or-Platform Decision Frame

- **Address.** `handbook\ch02-the-ai-native-landscape.qmd` L75-96, Coding Tools vs. Software Delivery Platforms (`#sec-landscape-tools-vs-platforms`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** For each pending or in-flight purchase, classify it as an AI coding tool or a software delivery platform, then fill the six criteria rows (who decides, primary value, evaluation scope, risk if ungoverned, switching cost, SDLC coverage) with this organisation's own answers, and name the accountable decision-maker.
- **Its output was.** A decision-rights record that stops platform decisions being made on coding-tool criteria and vice versa - and makes explicit which purchases developers own versus which leadership owns.

### `WS-04-build-buy-compose-posture` - Build / Buy / Compose Posture per Context Domain

- **Address.** `handbook\ch04-the-reference-architecture.qmd` L218-233, Build, Buy, or Compose (`#sec-ref-arch-build-buy-compose`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Three rows (Work context, Data context, Code context). Per row choose one posture - Build, Buy or Compose - and record the named vendor or team, the annual cost, the integration burden accepted, and an explicit lock-in exposure note: which supply-chain layers this vendor would own, what the exit cost would be, and when the contract renews.
- **Its output was.** A procurement posture statement per context domain with lock-in exposure made explicit and priced.

### `WS-04-vendor-maturity-claims-audit` - Vendor Claims vs Reality Audit (Now / Emerging / Directional)

- **Address.** `handbook\ch04-the-reference-architecture.qmd` L103-121, Three-Tier Honesty (`#sec-ref-arch-three-tier-honesty`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Rows are the eight lifecycle phases; columns are the vendors on the shortlist. In each cell the evaluator records the maturity tier the vendor claims, the vendor own definition of that term, what was actually demonstrated versus asserted, and the evaluator verdict. A summary row scores each vendor on claim-to-evidence honesty.
- **Its output was.** A procurement scorecard that makes vendor overclaiming visible and comparable across a shortlist.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- None. This sheet can be filled cold.

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** WS-08-transition-roadmap

## 8. Facilitation

| | |
|---|---|
| Who fills it | Side 1 is filled by the accountable decision-maker for the purchase — and which person that is differs by classification, which is why block C runs first. An engineer who will use the thing daily, a security and compliance representative for the enterprise-governance row, and procurement for block D's renewal dates. Side 2 is filled by whoever runs the evaluation, per vendor, in separate sittings. |
| When in the session | Opens Pack D; fills cold with no prerequisites. **Side 1 must be finished and signed at column 9 before a single vendor name is written on side 2.** Run it the other way round and the requirements get reverse-engineered from whoever gave the best demo, which is the exact failure the chapter opens by naming. |
| Duration | 60-75 minutes for side 1 (block A, then C, then D). Side 2 is not a workshop activity — budget a separate 45-60 minute sitting per shortlisted vendor, with the vendor present for block E, because columns 34 and 35 require asking them to define their own terms and then show the thing. |
| Data needed in advance | Every purchase pending or in flight, including tools teams have already bought without central approval; current contract renewal dates; who signed the last tooling purchase and under what authority; security's existing SSO, audit-log and data-residency requirements; and the file path convention, if any, the org already uses for agent instructions. |
| Room format | A3 landscape, printed double-sided, then physically separated. Side 1 goes on the wall and stays there through the renewal cycle. Side 2 is reprinted per evaluation and binned when it expires. The separation is the point: if the two live on one page, the dated half will be read as though it were as durable as the other. |

**Facilitation note carried from ch02.** Say the L134 framing out loud before anyone scores a
cell: *architecture shapes capability*. An `N/A` is a design decision, not a deficiency — a
CLI-first tool has no in-editor agent mode because it is not an editor, and a room that scores
architecture choices as gaps will shortlist on breadth and buy the wrong thing. Column 13 exists
to force that reading into the record. Two supporting points are worth carrying: the table-stakes
rows at L132 (completion, chat, multi-file editing) are where vendors most want to differentiate
and where the room should refuse to let them; and Custom instructions & rules is flagged first at
L128 because it is the mechanism that decides whether the tooling compounds over time or stays
permanently mediocre — the implementations differ by vendor, the mechanism does not, and the
methodology is portable across all of them.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All eleven rows in block A carry a priority (column 3) and a reason (column 4).** A
   Must-have with an empty reason cell is a preference that has been promoted by layout.
2. **No vendor or product name appears anywhere on side 1.** If one has been written in, the
   requirement was derived from a product rather than the other way round, and that row must be
   rewritten before the sheet is signed.
3. **The four rows the book flags at column 5 — custom instructions and rules, enterprise
   governance, autonomous PR creation, code review agent — are each marked Must-have, or the row
   carries a written reason for demoting it.** These are the rows that separate a coding tool
   from a strategy; demoting one silently is the thing to catch.
4. **Every scored cell in block B carries an evidence class (column 12) and every column group
   carries both an assessment date and a re-verify date.** An undated scorecard cannot be audited
   and will be quoted a year later as though it were current.
5. **Every `N/A` scored in block B is classified at column 13 as design intent or genuine gap.**
   Unclassified N/A cells are how a room converts an architecture choice into a deduction.
6. **Block C names an accountable individual per purchase, and that person matches the
   classification.** A purchase classified as a software delivery platform with an individual
   developer named at column 18 — or a coding tool escalated to an executive committee — is
   precisely the mismatch ch02 L96 describes, and the sheet has found it.
7. **Every Buy or Compose posture in block D carries a renewal date (column 31) and a named
   lock-in exposure (column 29) expressed in the band names used on
   `WS-04-five-layer-supply-chain-canvas`.** A lock-in note that does not say which layers the
   vendor would own is not an exposure statement, and it will not reconcile with the canvas.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** Carried unchanged from _section-clusters.md section 7 for CL-PROCUREMENT.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Matrix exists at lines 108-120 but is a mid-2025 vendor snapshot the book itself says will go stale (footnote ch02-landscape). THE WORKSHEET MUST INVERT IT: the durable artefact is the requirement column, not the vendor columns - author it so vendor columns are blank and dated. Pre-weight the book's "where to look first" trio (lines 128-130: custom instructions/rules, enterprise governance, autonomous PR + code review agents) - the first of those is the direct mechanism against the Ch01 Vibe Coding Cliff. Facilitation tip: line 136 argues N/A cells are design intent, not gaps - keep that framing or teams will score architecture choices as deficiencies. Author disclosure about Microsoft breadth (line 138) should not be reproduced in a vendor-neutral kit.
