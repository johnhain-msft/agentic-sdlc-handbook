# Project Decision Register and Staleness Review

`WS-12-project-decision-register` &middot; **Pack Z - Second wave: the practitioner kit** &middot; fill order **2** &middot; type `inventory` &middot; audience **architect** &middot; leadership priority **2**

> **Split back out in the re-opening pass.** A living decision register plus a standing quarterly staleness-review commitment with a named re-verifier -- an ongoing governance artefact with a cadence, not a point-in-time assessment.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A dated decision register (the .memory.md seed) plus a standing quarterly staleness-review commitment with a named owner.

**Cluster.** `CL-DECISION-REGISTER` - Project Decision Register and Staleness Review

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch12-the-instrumented-codebase.qmd` |
| Chapter | The Instrumented Codebase |
| Heading | Memory |
| Stable anchor | `#sec-codebase-memory` |
| Lines | L260-265 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch12-the-instrumented-codebase.html#sec-codebase-memory> |
| Locator quote | "Memory files are the most likely primitive to drift from reality. Include dates." |

Resolve at any time with `python docs/resolve.py ws WS-12-project-decision-register`.

## 3. Source extract - the scaffolding, verbatim

```text
  260 | Memory files are the most likely primitive to drift from reality. Include dates. Review them quarterly. If a section hasn't been updated in six months, verify that it's still accurate or remove it.
  261 | 
  262 | ::: {.callout-note}
  263 | ## Memory Storage Varies by Tool
  264 | While this chapter describes memory as markdown files for portability, some tools implement memory as structured databases. GitHub Copilot, for example, stores memory in a database system rather than flat files. The principles are the same (persistence, discoverability, and staleness management) regardless of the storage mechanism.
  265 | :::
```

## 4. What the user fills

Seed the register with the decisions an agent would otherwise guess wrong: one row per decision with the domain, the decision, the date last verified, the superseded alternative and its deprecation status, and the owner responsible for re-verifying it. A review cadence box records the agreed interval and the next review date.

## 5. Field-level schema

One row per decision an agent would otherwise guess wrong. The register is deliberately
**storage-neutral** — the schema specifies content, not file format, because some harnesses keep
memory in a database rather than a markdown file (ch12 L262-265). Physically it is a live
document with a standing header box, not a printed one-off; the dated per-domain section layout
of the book's worked `.memory.md` (ch12 L234-256) is the reference rendering.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| — | Register scope | `free text` | — | The repository, service or product this register covers | org |
| — | Where this register physically lives | `free text` | — | Markdown file, database-backed memory store, or harness-native store — record which | ch12 L262-265 |
| — | Review cadence | `select` — quarterly / other + reason | Quarterly, pre-selected | Override only with a written reason | ch12 L260 |
| — | Next review date | `date` | — | The date in a real calendar | ch12 L260 |
| — | Review owner | `owner (named person)` | — | Who runs the review, not who attends it | org |
| 1 | Domain / section | `free text` | The worked example's three section names printed as examples — Authentication, API Versioning, Performance Decisions | The org's own domains | ch12 L237, L245, L251 |
| 2 | The decision, stated as context | `free text` | The worked example's context lines, and the rule-versus-context pair beside the field ("use JWT for authentication" is a rule; "we migrated from sessions to JWT in Q1 and `SessionAuth` is deprecated but still present" is context) | The decision, written as what happened and what is still true | ch12 L234-258 |
| 3 | Primitive type this knowledge belongs in | `select` — the seven destinations from the routing table | The full routing table printed beside the column; `memory file` is the only value that stays on this sheet | Which one | ch12 L451-459 |
| 4 | If not a memory file, routed to | `free text` | — | The instruction file, skill, agent file, prompt, spec or hook it was moved to instead | ch12 L451-459 |
| 5 | Date last verified | `date` | The worked example's `(last updated: YYYY-MM-DD)` heading convention | The date | ch12 L237, L245, L251, L260 |
| 6 | Superseded alternative | `free text` | `SessionAuth` printed as the worked example | The class, endpoint, pattern or service this decision replaced | ch12 L242-243 |
| 7 | Deprecation status | `select` — deprecated and still present / removed / not applicable | The worked example's phrasing: "deprecated but not yet removed. Do NOT use it for new code." | Which | ch12 L242-243 |
| 8 | Migration or decision reference | `free text` | The worked example's `JIRA-4521` and `ADR-017` | The org's own ticket and ADR identifiers | ch12 L243, L250 |
| 9 | Recorded agent error | `free text` | The worked example's EMU / `ghu_` line, kept visible in the register rather than deleted | The wrong thing an agent actually believed | ch12 L240 |
| 10 | The correction | `free text` | The worked example's `CORRECTION:` line | The right answer, written for the agent rather than for a human reader | ch12 L241 |
| 11 | Re-verifier | `owner (named person)` | — | A named individual per row | ch12 L260 |
| 12 | Next review due | `date` | — | Derived from the cadence box unless this row needs a tighter one | ch12 L260 |
| 13 | Review outcome | `select` — verified unchanged / updated / removed | The six-month rule printed beside the column: a section untouched for six months is verified as still accurate or removed | The outcome, dated | ch12 L260 |
| 14 | Failure cost if the agent gets this wrong | `select` — Critical / High / Medium / Low | The four bands with the book's definitions: Critical = security, data corruption, production outage; High = architectural violation accruing as debt; Medium = convention violation requiring rework in review; Low = style preference not affecting correctness | Which band | ch12 L444-447 |

**Deliberate omission — no confidence score.** The only integrity signal the book gives this
primitive is a date (ch12 L260). A confidence or certainty column would let a row that has not
been looked at for a year present itself as trustworthy, which is precisely the drift the
staleness rule exists to catch.

**Deliberate omission — no file-format column.** The chapter's callout warns that memory is a
database in some harnesses and a flat file in others (ch12 L262-265). Format is recorded once in
the header box and never per row, so the register survives a tooling change intact.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- None. This sheet can be filled cold.

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** WS-03-context-moat-asset-inventory; WS-12-failure-triage-log

## 8. Facilitation

| | |
|---|---|
| Who fills it | The two or three engineers who have been on this codebase longest, plus whoever keeps the ADR index. The rows worth having are the ones only they can supply; anything a newcomer could look up belongs in an instruction file, not here. |
| When in the session | Pack Z, fill order 2, no prerequisites. Run it in the same sitting as `WS-12-agent-persona-design-canvas`, immediately after. Both draw on the same act of recall, and running them together is what stops one fact being written twice — the persona's expertise blocks take the rules, this register takes the history. |
| Duration | 60-90 minutes to seed ten to twenty rows. After that it stops being a workshop instrument and becomes a living document; the sitting exists to start it and to agree the cadence, not to finish it. |
| Data needed in advance | The ADR index. The current deprecation list. The last two quarters of postmortems. The "in heads" column of `WS-03-context-moat-asset-inventory` if that sheet exists — every item there is a candidate row. |
| Room format | Filled live, projected, **in the file or store it will actually live in** — not on paper and not in a separate document. This is the one Pack Z sheet whose output is the artefact itself; transcribing it afterwards is how the dates get lost. |

**Facilitation note — Pack Z prerequisite condition.** Columns 9 and 10 (recorded agent error, and
its correction) will be empty at the first sitting in any organisation that has not yet run agents
against this codebase in anger, and that is the correct result. They are a standing capture rather
than a workshop output: the book's worked example carries a recorded agent error precisely because
it accumulated during real work (ch12 L240-241). Use the sitting to name the capture trigger —
*every time someone corrects an agent on a matter of fact, a row lands here* — and name who is
responsible for it. Without that, the two columns stay empty permanently and the register loses
its single strongest argument for existing.

**Second note — apply the routing gate out loud.** Column 3 is the sheet's filter, and the room
will resist it, because every candidate row feels like it belongs. Read the routing table (ch12
L451-459) aloud before the first row and again when the pace picks up. A register that accepted
every proposal is an instruction file with dates on it.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **Every row carries a date in column 5.** A row without one cannot be aged, and the whole
   staleness discipline the sheet exists to implement is date-driven (ch12 L260).
2. **Every row names an individual re-verifier in column 11.** Not a team, not a rota, not a
   distribution list. A register owned by a group is a register nobody re-reads.
3. **The routing gate was genuinely applied.** At least one candidate was rejected to an
   instruction file, a skill or an agent file in column 4. A register in which every proposed row
   turned out to belong in the register has not been filtered — it has been transcribed
   (ch12 L258, L451-459).
4. **Every row marked "deprecated and still present" in column 7 carries a migration reference in
   column 8.** A deprecation with no ticket behind it is a rumour, and an agent told only that
   something is deprecated will still reach for it.
5. **The cadence box is filled and the next review exists in a real calendar with a named owner.**
   The book asks for quarterly review and for any section untouched for six months to be verified
   or removed (ch12 L260). A register with no scheduled review will fail both tests by default.
6. **It reconciles with `WS-03-context-moat-asset-inventory`.** Every item that inventory
   classified as "in heads" *and* as a decision, trade-off or historical fact appears here, or is
   listed on the sheet as deliberately excluded with a stated reason (ch12 L434-440, L451-459).
7. **No row states a rule.** Column 3 reads `memory file` on every surviving row; everything else
   has been routed out and column 4 says where it went.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** The worked .memory.md example is the template: dated sections per domain with explicit deprecations, ADR references and ticket links.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Anchored at the staleness rule because that is the governance commitment, but the fillable template is the worked example at lines 234-256 — dated sections per domain (Authentication, API Versioning, Performance) with explicit deprecations, ADR references and ticket links. Note the example deliberately contains a recorded agent error and its correction, which is the single best argument for keeping a register at all. The chapter's own discipline: include dates, review quarterly, and delete or re-verify anything untouched for six months. CAVEAT for the synthesizer: the callout at lines 262-265 warns that some tools store memory in a database rather than flat files, so the worksheet should be storage-neutral and specify content, not file format.
