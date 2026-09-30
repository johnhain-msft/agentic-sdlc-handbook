# Shadow AI Usage Inventory

`WS-02-shadow-ai-usage-inventory` &middot; **Pack A - Groundwork (pre-work)** &middot; fill order **1** &middot; type `inventory` &middot; audience **eng-leader** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A governable register of actual AI tool usage and unmanaged data paths - the factual basis for the approved-tool list, the enterprise-tier business case, and the developer-preference evidence that stops a top-down mandate failing.

**Cluster.** `CL-SHADOW-AI` - Shadow Adoption Census

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch02-the-ai-native-landscape.qmd` |
| Chapter | The AI-Native Landscape |
| Heading | Two Buying Motions, One Problem |
| Stable anchor | `#sec-landscape-buying-motions` |
| Lines | L150-164 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch02-the-ai-native-landscape.html#sec-landscape-buying-motions> |
| Locator quote | "How AI development tools enter an organization determines how governable they are." |

Resolve at any time with `python docs/resolve.py ws WS-02-shadow-ai-usage-inventory`.

## 3. Source extract - the scaffolding, verbatim

```text
  150 | How AI development tools enter an organization determines how governable they are.
  151 | 
  152 | **Bottom-up adoption.** A developer discovers Claude Code or Cursor, pays for a personal subscription (or uses a free tier), and begins using it on company code. The tool is fast. The developer gets more done. Colleagues notice. Within weeks, a team of twelve engineers may have eight people using different AI tools, none approved by IT, none covered by the company's data processing agreements, none visible in security audit logs.
  153 | 
  154 | This is shadow IT with a new coat of paint, and it carries the same risks: code flowing through unapproved APIs, intellectual property entering training datasets without consent, security and compliance policies circumvented not maliciously but inadvertently, because nobody told the developer that the tool's terms of service include data retention they'd never accept for a production database.
  155 | 
  156 | **Top-down mandates.** Leadership selects a platform, negotiates an enterprise agreement, and rolls it out. The tools are governed, auditable, and compliant. The problem: developers may already prefer the tool they chose themselves. A top-down mandate that doesn't match what developers actually use creates resentment, workarounds, and, in the worst case, developers continuing to use their preferred tool in parallel with the mandated one, creating the worst of both worlds: the cost of enterprise licensing and the risk of ungoverned usage.
  157 | 
  158 | **The winning strategy addresses both motions simultaneously.** Evaluate the tools developers are already using. Understand why they chose them. Then select a platform that satisfies the governance requirements leadership needs while providing the developer experience that drives voluntary adoption. This is harder than either approach alone, and it is the only one that works.
  159 | 
  160 | A useful diagnostic: survey your engineering teams this week. Ask three questions: (1) Which AI coding tools are you currently using? (2) Are you using a personal or company-provided account? (3) What would you lose if the tool were removed?
  161 | 
  162 | The answers will tell you whether you have a strategy or a gap.
  163 | 
  164 | ---
```

## 4. What the user fills

One row per team or developer: which AI tool is in use, personal or company-provided account, who pays, whether it is covered by a data processing agreement, whether it appears in security audit logs, and the free-text answer to "what would you lose if the tool were removed?"

## 5. Field-level schema

Two panels, two different row units, collected by two different people. **Panel A** is the
usage census: one row per developer response, issued as a survey, rolled up by team. **Panel B**
is the repository scan: one row per repository in scope. Panel A is a digital form (it must
accept anonymous returns); Panel B is a spreadsheet the rollup prints to A3 landscape. Neither
panel is filled in the workshop — both are pre-work.

**Panel A — usage census.** One row per developer response. The three questions at ch02 L160 are
pre-printed verbatim as columns 3, 4 and 9; everything else is the governance detail the chapter's
risk paragraph (L154) implies.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Team / squad | `select` | — | The org's own team list | org |
| 2 | Respondent | `free text`, optional | Marked optional on the form | Name or pseudonym; blank is a valid return | derived — see amnesty note below |
| 3 | AI coding tool in use | `free text` | Examples printed as prompts: Claude Code, Cursor, GitHub Copilot | Every tool actually in use, one row each | ch02 L152, L160 Q1 |
| 4 | Account type | `select` personal / company-provided / free tier | — | — | ch02 L160 Q2 |
| 5 | Who pays | `select` individual expense / team budget / central IT / nobody | — | — | ch02 L152 |
| 6 | Monthly cost, if known | `currency` | — | Per-seat cost; feeds the enterprise-tier business case | org |
| 7 | Covered by a data processing agreement? | `select` yes / no / unknown | — | `unknown` is a meaningful answer; blank is not | ch02 L152, L154 |
| 8 | Visible in security audit logs? | `select` yes / no / unknown | — | — | ch02 L152 |
| 9 | What code flows through it | `select` production / test / prototypes only / none | — | — | ch02 L154 |
| 10 | What would you lose if it were removed? | `free text` | — | The developer-preference evidence | ch02 L160 Q3 |
| 11 | Why did you choose it? | `free text` | — | — | ch02 L158 |
| 12 | Governance exposure | `H/M/L` | H/M/L anchors printed on the form: **H** — production code, no DPA or DPA unknown, not in audit logs. **M** — any one of those three resolved. **L** — company-provided, DPA in place, visible in audit logs. | Rolled up, not self-scored | derived from cols 7-9 |
| 13 | Disposition | `select` approve / migrate / retire / investigate | — | Set once per distinct tool at rollup, not per respondent | ch02 L158, L215 |
| 14 | Disposition owner | `owner (named person)` | — | A named person per distinct tool | org |
| — | Coverage | `computed` | — | Responses returned ÷ engineers in scope, with the denominator printed | derived |

**Panel B — agent source estate.** One row per repository in scope. The seven primitive types are
pre-printed as fixed columns; each primitive cell takes two marks, a file count and a status.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 15 | Repository | `free text` | — | — | org |
| 16 | Repository owner | `owner (named person)` | — | A named individual, not a team alias | org |
| 17 | In pilot scope? | `checkbox` | — | — | org |
| 18 | Instructions — `.instructions.md` | count + `select` Absent / Ad hoc / Governed | Primitive name and file convention pre-printed | Count and status | ch12 L22-40 |
| 19 | Agents — `.agent.md` | count + `select` Absent / Ad hoc / Governed | Pre-printed | Count and status | ch12 L22-40 |
| 20 | Skills — `SKILL.md` | count + `select` Absent / Ad hoc / Governed | Pre-printed | Count and status | ch12 L22-40 |
| 21 | Prompts — `.prompt.md` | count + `select` Absent / Ad hoc / Governed | Pre-printed | Count and status | ch12 L22-40 |
| 22 | Memory — `.memory.md` | count + `select` Absent / Ad hoc / Governed | Pre-printed | Count and status | ch12 L22-40 |
| 23 | Orchestration / specs — `.spec.md` | count + `select` Absent / Ad hoc / Governed | Pre-printed | Count and status | ch12 L22-40 |
| 24 | Hooks — event-driven | count + `select` Absent / Ad hoc / Governed | Pre-printed | Count and status | ch12 L22-40 |
| 25 | Last modified, any primitive | `date` | — | — | org |
| 26 | Harness convention targeted | `free text` | — | Which harness the files are written for; `mixed` and `unknown` are valid | org |
| — | Estate heat map | `computed` | — | Count of repositories at Absent, Ad hoc and Governed per primitive type | derived |

**Status anchors for columns 18-24 (printed on the sheet).** **Absent** — no files of this type.
**Ad hoc** — files exist, no named owner, no review on change. **Governed** — files exist, a named
owner, and a change to them goes through review like any other code.

**Absorbed detail.** `WS-12-agent-source-estate-survey` is Panel B in its entirety: its row unit
(one per repository), its seven primitive columns with counts, its owner, last-modified and
Absent / Ad hoc / Governed status, and its harness-convention column all appear as columns 15-26,
with the estate heat map as the computed rollup its output described.

**Amnesty note on column 2.** The chapter is explicit that shadow adoption happens "not maliciously
but inadvertently" (L154). Column 2 is optional by design and the form must say so in print. A
census that reads as an audit returns the answer people think is safe, and the whole sheet is then
worthless — including for the three worksheets downstream of it.

**Deliberate omission.** No usage-volume, token-count or per-developer productivity column. The
sheet establishes what is in use, who pays, and what is ungoverned. Adding a volume column turns a
governance census into a performance record, which is the fastest way to guarantee dishonest
returns.

## 6. Absorbed members (1)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-12-agent-source-estate-survey` - Agent Source Code Estate Survey

- **Address.** `handbook\ch12-the-instrumented-codebase.qmd` L22-326, The Seven Primitive Types (`#sec-codebase-primitive-types`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** One row per repository in scope; one column per primitive type (instructions, agents, skills, prompts, memory, orchestration/specs, hooks): count of files present, owner, last modified, and a status of Absent / Ad hoc / Governed. A final column records which harness convention the files target.
- **Its output was.** An estate-wide heat map of existing — usually shadow-adopted and unowned — agent source code, showing which repositories and which primitive types exist today and which are ungoverned.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- None. This sheet can be filled cold.

**Consumed by:**

- `WS-12-effective-context-trace` - Effective Context Trace (Pack Z - Second wave: the practitioner kit, fill order 5)
- `WS-13-prose-readiness-assessment` - PROSE Readiness Assessment and Remediation Plan (Pack Z - Second wave: the practitioner kit, fill order 7)

**Feeds into (prose, from the source scan).** WS-02-capability-requirements-matrix

## 8. Facilitation

| | |
|---|---|
| Who fills it | Panel A: every engineer in scope, individually. The engineering leader issues it; one named person owns the rollup and is the only one who sees raw returns. Panel B: a platform or tooling engineer with read access across the repository estate — it is a file glob, not a judgement call. Nobody needs to be in a room for either panel. |
| When in the session | Neither panel is filled in the session. Issue both at least one week before Pack A — two if the organisation is large enough that a survey needs a reminder. This is the only sheet in Packs A and B that requires data from outside the room, and `WS-12-effective-context-trace`, `WS-13-prose-readiness-assessment` and `WS-02-capability-requirements-matrix` all degrade to guesswork without it. The book itself dates the task: "Audit current usage — this week" (ch02 L215). |
| Duration | Panel A: 5 minutes per respondent; half a day for the rollup and the H/M/L exposure pass. Panel B: 1-2 hours for the scan across a typical estate, longer if repository access has to be requested. 20 minutes in the room at the top of Pack A to walk the rollup — not to fill it. |
| Data needed in advance | The engineering headcount and team list, so column 12's coverage denominator is real. Read access to every repository in scope. The approved-tool list, if one exists. Expense and procurement records for tool reimbursements, to catch the tools nobody declares. |
| Room format | The rolled-up view is projected; raw Panel A returns are never shown in the room, and never with column 2 populated. Panel B prints to A3 landscape as a heat map. If anonymity was promised on the form, the rollup circulated must be checked for re-identification through the team column on small teams before it leaves the owner's hands. |

**Facilitation note.** The chapter's winning strategy (L158) needs *both* halves of this sheet:
ungoverned usage **and** developer preference. A rollup that reports only the risk side produces a
top-down mandate, which L156 says creates "resentment, workarounds, and, in the worst case,
developers continuing to use their preferred tool in parallel with the mandated one" — the cost of
enterprise licensing plus the risk of ungoverned usage. Present columns 10 and 11 with the same
weight as columns 7 and 8, on the same slide.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **The coverage denominator is printed and the response rate is stated.** Every engineering team
   in scope has either returned rows or is recorded by name as non-responding. A census with an
   unstated denominator cannot distinguish "we have little shadow usage" from "few people answered".
2. **Columns 7 and 8 contain no blanks.** `unknown` is a permitted and informative answer; an empty
   cell is not, because it silently reads as "no exposure" at rollup.
3. **Every row answers column 10.** The "what would you lose" answer is the developer-preference
   evidence the chapter says a platform selection must satisfy; a census without it supports only
   half of the winning strategy.
4. **Every distinct tool carries a disposition and a named individual owner** (columns 13-14).
   A tool left at `investigate` with no owner and no date is an open risk recorded as an action.
5. **Panel B covers every repository intended for the pilot,** and each of columns 18-24 carries
   both a count and one of the three status values — a count with no status does not distinguish
   eight governed files from eight abandoned ones.
6. **Every repository names an individual owner in column 16,** not a team alias, a distribution
   list or a GitHub team.
7. **Anonymity, if promised on the form, survived the rollup** — no circulated copy attributes a
   personal-account row to an identifiable individual, including by inference on a small team.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** Carried unchanged from _section-clusters.md section 7 for CL-SHADOW-AI.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> The book hands over the survey design verbatim at line 160 ("survey your engineering teams this week. Ask three questions..."), and the decision matrix makes it action one ("Audit current usage | This week", line 215). Needs authoring as a collection template plus a rollup view. THIS IS THE ONLY CANDIDATE IN PART I-II THAT REQUIRES DATA FROM OUTSIDE THE ROOM - it must be issued ahead of the workshop or three other worksheets degrade to guesswork. Bottom-up/top-down failure modes at lines 152-158 supply the framing: the rollup should surface both ungoverned usage AND developer preference, because the book's winning strategy (line 158) needs both.
