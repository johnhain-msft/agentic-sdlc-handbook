# Organisational Readiness: Which Failure Amplifiers Do We Already Have?

`WS-20-org-failure-amplifier-assessment` &middot; **Pack B - Where we actually are** &middot; fill order **3** &middot; type `assessment` &middot; audience **exec** &middot; leadership priority **1**

> **Split back out in the re-opening pass.** An executive self-assessment needing no telemetry, repo access or engineering data -- the earliest page in the kit anyone can fill -- and the book supplies pairings so it computes against the technical pre-mortem rather than duplicating it.
>
> Ships as: `facing:WS-20-nineteen-failure-mode-premortem`

## 1. Purpose

**Output artifact.** An organisational risk baseline ranking the five amplifiers, each with evidence and a named remediation owner.

**Cluster.** `CL-ORG-AMPLIFIERS` - Organisational Failure Amplifiers: The Honesty Page

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch20-anti-patterns-and-failure-modes.qmd` |
| Chapter | Anti-Patterns and Failure Modes |
| Heading | Team-Level Anti-Patterns |
| Stable anchor | `#sec-anti-team-level` |
| Lines | L361-373 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch20-anti-patterns-and-failure-modes.html#sec-anti-team-level> |
| Locator quote | "Technical anti-patterns happen in code. Organizational anti-patterns amplify every technical failure" |

Resolve at any time with `python docs/resolve.py ws WS-20-org-failure-amplifier-assessment`.

## 3. Source extract - the scaffolding, verbatim

```text
  361 | Technical anti-patterns happen in code. Organizational anti-patterns amplify every technical failure in this chapter.
  362 | 
  363 | **Over-trust.** The team ships agent-generated code with minimal review. Agent code has different failure signatures than human code — locally correct but globally inconsistent. Each function works; the functions don't work together the way a human would have designed them.
  364 | 
  365 | **Under-specification.** No primitives. Each developer prompts ad-hoc, in their own style. Output quality varies wildly between team members — not because of skill differences, but context differences. The team blames the tool instead of the context.
  366 | 
  367 | **No feedback loop.** Failures happen, developers fix them manually, no one updates the primitives. The same mistake recurs weekly. The team experiences AI as unreliable because their system doesn't learn.
  368 | 
  369 | **Cargo-culting complexity.** The team implements full multi-agent orchestration for a 10-file repository with two developers. The overhead exceeds the benefit. The disciplines in this book scale *down* — a solo developer on a small change needs right-sized tasks and good primitives, not a four-wave plan with parallel review agents.
  370 | 
  371 | **Abandoned governance.** No one audits what agents modify outside stated scope. No one tracks token costs against value. AI usage grows organically without the structures that catch these patterns before they become expensive.
  372 | 
  373 | Each organizational pattern amplifies a technical one. Over-trust amplifies the Trust Fall. Under-specification causes Context Dumping. No feedback loop perpetuates Not Fixing the Primitives. The fix is organizational: team agreements, review processes, and treating primitives as shared infrastructure.
```

## 4. What the user fills

Score each of the five organisational anti-patterns -- Over-trust, Under-specification, No feedback loop, Cargo-culting complexity, Abandoned governance -- as present / emerging / absent, cite the evidence for the score, name the technical anti-pattern it amplifies, and write the organisational action plus its owner.

## 5. Field-level schema

One row per organisational amplifier, five fixed rows. One page, portrait, printed to sit facing
`WS-20-nineteen-failure-mode-premortem` so the two pages compute against each other. A
counter-check strip sits below the table. The sheet is filled individually by each executive and
signed, then compared — there is one copy per executive, not one per room.

**The rubric is authored, not sourced.** The chapter supplies five named amplifiers and three
pairings; it supplies no scale. Column 3 uses a three-value qualitative rubric written for this
sheet, printed as a key so that two executives scoring separately mean the same thing by the same
word. It is deliberately evidence-anchored rather than impressionistic, and it carries no numbers.

> **Rubric key, printed on the sheet.**
> **Present** — we can name at least one occurrence in the last quarter, and no control exists that
> would stop it recurring.
> **Emerging** — we can name an occurrence, but a control exists or is being built.
> **Absent** — we cannot name an occurrence, and a control exists that would have caught one.
> *Note: "we cannot name an occurrence" with no control in place is **Present**, not Absent — an
> unobserved failure in an unmonitored area is the definition of this chapter's subject.*

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Organisational amplifier | `select` (fixed 5 rows) | Over-trust · Under-specification · No feedback loop · Cargo-culting complexity · Abandoned governance | — | ch20 L363-371 |
| 2 | What it looks like | `free text` | One line per row: ships agent-generated code with minimal review, and agent code fails differently — locally correct, globally inconsistent · no primitives, each developer prompts ad hoc, output quality varies by context not skill, and the team blames the tool · failures get fixed manually and no one updates the primitives, so the same mistake recurs weekly · full multi-agent orchestration where the overhead exceeds the benefit; the disciplines scale *down* · nobody audits what agents modify outside stated scope, nobody tracks token cost against value | — | ch20 L363-371 |
| 3 | Present / Emerging / Absent | `select` | The rubric key above, printed in full | The mark | derived — authored for this sheet |
| 4 | Evidence | `free text` | — | The occurrence: what, when, which team. Required for Present and Emerging. | derived |
| 5 | Evidence type | `select` incident / review record / cost record / recollection | — | The mark. `recollection` is permitted and is itself a signal. | derived |
| 6 | Technical anti-pattern it amplifies | `free text` | Printed on three rows only: Over-trust → **The Trust Fall** · Under-specification → **Context Dumping** · No feedback loop → **Not Fixing the Primitives**. Rows 4 and 5 are **deliberately blank** — see the note below. | Rows 4 and 5, written in by the room against the facing page's list | ch20 L373 |
| 7 | Likelihood uplift on the paired pattern | `H/M/L` | Anchors printed: **H** — amplifier Present *and* the paired pattern already observed · **M** — amplifier Present or Emerging, paired pattern plausible but not yet seen · **L** — amplifier Absent | The mark, carried to the facing page | derived from §7 |
| 8 | Organisational action | `free text` | The chapter's three named fix categories printed as prompts: team agreements · review processes · treating primitives as shared infrastructure | The specific action | ch20 L373 |
| 9 | Action owner | `owner (named person)` | — | A named individual. Required wherever column 3 is Present or Emerging. | org |
| 10 | Review date | `date` | — | — | org |
| — | Scored by | `free text` + `signature` | — | The individual executive, and the date | org |
| — | Divergence record | `free text` | — | Where two executives marked the same row differently, both marks and both pieces of evidence, kept side by side | derived |

**Counter-check strip — cargo-culting.** Printed below the table, because this is the one amplifier
that cuts the other way and a room enthusiastic about the methodology will reflexively mark it
Absent.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 11 | The smallest change we have run a full wave plan against | `free text` | Chapter's example printed alongside as the shape of the problem, not as a threshold: "full multi-agent orchestration for a 10-file repository with two developers" | Our own smallest case: what the change was | ch20 L369 |
| 12 | Repository size and team size on that change | `free text` | — | Ours | org |
| 13 | Wave plan used? Parallel review agents used? | `checkbox` ×2 | — | — | ch20 L369 |
| 14 | Was the overhead justified? | `select` yes / no / unclear | — | — | ch20 L369 |
| 15 | Reason | `free text` | — | Required whichever way column 14 falls | ch20 L369 |

**Absorbed detail.** This worksheet absorbed no other candidate. It is, however, one half of a
facing pair and is not complete on its own: columns 6 and 7 are written to be read across to
`WS-20-nineteen-failure-mode-premortem`, which carries the nineteen technical patterns. Keep the
vocabulary in column 6 identical to the pattern names on that page — "The Trust Fall", not
"over-trusting agent output" — or the two pages stop computing.

**Deliberate omission — and the two blank pairings.** There is no aggregate amplifier score, no
total and no index. Five amplifiers with five different remedies do not average into anything a
leader can act on, and a total invites a board slide that hides which one is live. More
importantly, columns 6 rows 4 and 5 are left blank **on purpose**. The chapter supplies exactly
three pairings (L373) and the kit does not invent the other two. Cargo-culting complexity and
Abandoned governance must be paired by the room against the facing page's actual list — that
pairing is a judgement about this organisation, and a pre-printed guess would be a fabrication
wearing a citation.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- None. This sheet can be filled cold.

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** WS-20-nineteen-failure-mode-premortem (a high amplifier score raises the likelihood of its paired technical pattern) and the operating-model section of the transformation plan

## 8. Facilitation

| | |
|---|---|
| Who fills it | The executive group, individually: the engineering leader, whoever holds the budget, and whoever owns governance or security. One copy each, signed. **Deliberately nobody from the delivery teams.** Four of the five amplifiers are leadership failures — nobody audits, nobody tracks cost, nobody updates the primitives — and the presence of the people being described suppresses the honest mark. The practitioners' view arrives separately, on the facing page. |
| When in the session | Pack B, fill order 3 — but it can genuinely be filled first, and often should be. It has no prerequisites, needs no data, and is the earliest page in the kit anyone can complete. Fill it **before** `WS-20-nineteen-failure-mode-premortem`, so the amplifier marks are made without knowing which technical patterns the practitioners have flagged; filled afterwards, column 3 drifts towards whatever the pre-mortem already found. |
| Duration | 25-35 minutes. Five rows scored in silence takes eight; the rest is column 4. The time goes on evidence, not on scoring, and a sheet that comes back in ten minutes has skipped column 4. |
| Data needed in advance | **Nothing.** No telemetry, no repository access, no engineering data, no survey — only honesty. This is the property that makes it the first page an executive can fill, and it should be stated when the sheet is handed out. Optionally, and only if the room prefers to argue from record rather than memory: the last quarter's incident list and the three most recent postmortems. |
| Room format | One page per executive, filled individually and in silence, then turned face up together. Do not fill it as a group and do not average. Where two executives mark the same row differently, record **both** marks and both pieces of evidence in the divergence row — that disagreement is the most useful output the page produces, and it is exactly what a group fill destroys. The page then sits physically facing the pre-mortem in the kit. |

**Facilitation note.** Cargo-culting complexity is the trap. A room that has just spent two hours
being persuaded of the methodology will mark it Absent without thinking, because the amplifier
reads as "we are not doing enough". It is the opposite: the chapter warns the disciplines scale
*down*, and that a four-wave plan with parallel review agents on a two-developer repository costs
more than it returns. Do not ask "do we cargo-cult complexity?" — ask the counter-check strip's
question instead: what is the smallest change we have run a full wave plan against, and was it
worth it? Second handle: the three supplied pairings are the chapter's, and the other two are the
room's to write. Say so when you hand out the sheet, or column 6 will be left blank on the
assumption that the facilitator forgot to print it.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All five amplifiers carry one of the three rubric values, and no fourth value has been
   invented.** "Partly", "improving" and "n/a" are not marks; a row the executive cannot place
   against the printed rubric is marked Present, per the note in the key.
2. **Every Present or Emerging mark cites a specific occurrence in column 4** — what happened, when,
   and which team — with an evidence type in column 5. "We probably do this" is not evidence, and a
   sheet on which every row is `recollection` is recorded as an impression rather than an
   assessment.
3. **Every Present or Emerging row carries an organisational action, a named individual owner and a
   review date** (columns 8-10). An amplifier acknowledged and unowned is the Abandoned governance
   row demonstrating itself.
4. **Columns 6 rows 4 and 5 are filled in by the room** against the facing page's list, or are
   explicitly marked `no paired pattern identified`. Left blank, the sheet looks misprinted and the
   two pages stop computing.
5. **The sheet was filled individually and signed before comparison, and every divergence between
   executives on the same row is recorded rather than averaged.** A single room-consensus copy with
   no divergence row fails this criterion regardless of what it says.
6. **The counter-check strip is complete, including the reason in column 15.** A `yes` in column 14
   with no reason is the reflexive answer the strip exists to catch.
7. **Reconciliation.** Every amplifier marked Present appears on
   `WS-20-nineteen-failure-mode-premortem` with its paired technical pattern rated at the
   likelihood uplift recorded in column 7. A Present amplifier whose paired pattern is rated low on
   the facing page is an unresolved contradiction between the executives' view and the
   practitioners', and it is resolved in the room rather than reconciled afterwards by whoever
   types up the pack.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** Five bold-lead paragraphs. The present/emerging/absent scoring rubric must be invented; the amplification pairings are supplied.
- **Fill (the organisation completing it): `S`.** S - one sitting, data already in the room

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> The exec-facing half of the pre-mortem and it should sit physically facing it in the kit. The chapter supplies the amplification pairings at 373 ("Over-trust amplifies the Trust Fall. Under-specification causes Context Dumping. No feedback loop perpetuates Not Fixing the Primitives"), so the two pages compute against each other. Best candidate for the FIRST page an exec fills in the whole kit, because it needs no telemetry, no repo access and no engineering data -- only honesty. Note Cargo-culting complexity is the one that cuts the other way and is worth calling out in facilitation: the chapter warns the disciplines "scale down" and that full multi-agent orchestration on a 10-file repo with two developers costs more than it returns. Content is five bold-lead paragraphs -- the scoring rubric needs authoring.
