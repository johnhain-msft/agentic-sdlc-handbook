# Pre-Mortem: Which of the 19 Failure Modes Will We Hit?

`WS-20-nineteen-failure-mode-premortem` &middot; **Pack G - The plan we leave with** &middot; fill order **2** &middot; type `diagnostic` &middot; audience **mixed** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A ranked organisational risk register -- typically the top five to seven failure modes -- each with a named owner and a dated mitigation.

**Cluster.** `CL-RISK-PREMORTEM` - Pre-Mortem: Failure Modes, Amplifiers and Agent Risks

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch20-anti-patterns-and-failure-modes.qmd` |
| Chapter | Anti-Patterns and Failure Modes |
| Heading | The Taxonomy |
| Stable anchor | `#sec-anti-taxonomy` |
| Lines | L14-42 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch20-anti-patterns-and-failure-modes.html#sec-anti-taxonomy> |
| Locator quote | "Every anti-pattern maps to a PROSE constraint. This isn't a taxonomy imposed" |

Resolve at any time with `python docs/resolve.py ws WS-20-nineteen-failure-mode-premortem`.

## 3. Source extract - the scaffolding, verbatim

```text
   14 | Every anti-pattern maps to a PROSE constraint. This isn't a taxonomy imposed after the fact; it's why the constraints exist. Each constraint was articulated because a class of failures kept recurring, and ad-hoc fixes weren't enough.
   15 | 
   16 | ::: {tbl-colwidths="[5,20,20,55]"}
   17 | 
   18 | | # | Anti-Pattern | Constraint Violated | Summary |
   19 | |---|---|---|---|
   20 | | 1 | Monolithic Prompt | Orchestrated Composition | All instructions in one block; small changes cause unpredictable cascades |
   21 | | 2 | Context Dumping | Progressive Disclosure | Everything loaded upfront; capacity wasted, attention diluted |
   22 | | 3 | Unbounded Agent | Safety Boundaries | No limits on tools or authority; non-determinism plus unlimited access |
   23 | | 4 | Flat Instructions | Explicit Hierarchy | Same rules everywhere; backend security rules load when editing CSS |
   24 | | 5 | Scope Creep | Reduced Scope | Task grows mid-execution; agent loses coherence as context degrades |
   25 | | 6 | The Solo Hero | Orchestrated Composition | One massive agent doing everything; no decomposition, no review |
   26 | | 7 | The Trust Fall | Safety Boundaries | Accepting agent output without verification |
   27 | | 8 | Same-File Parallel Edits | Orchestrated Composition | Two agents editing one file; second agent's changes fail silently |
   28 | | 9 | Skipping Checkpoints | Safety Boundaries | Committing multiple waves without validation between them |
   29 | | 10 | Not Fixing the Primitives | Explicit Hierarchy | Correcting symptoms manually instead of updating the instruction set |
   30 | | 11 | Context Window Exhaustion | Progressive Disclosure | Agent hits capacity mid-task and silently drops earlier instructions |
   31 | | 12 | Hallucinated Edits | Safety Boundaries | Agent reports success on changes it didn't persist |
   32 | | 13 | Stale Context Between Waves | Progressive Disclosure | Agent in wave N works against wave N-2 state of a file |
   33 | | 14 | Cost Runaway | Reduced Scope | Unbounded retries burn tokens without progress |
   34 | | 15 | The "Almost Done" Trap | Reduced Scope | Last 10% takes longer than starting over |
   35 | | 16 | Session State Loss | Safety Boundaries | Session crashes; no checkpoint means unrecoverable work |
   36 | | 17 | Persona Drift | Explicit Hierarchy | Agent shifts role mid-session, applying wrong domain expertise |
   37 | | 18 | Cross-Wave Merge Conflicts | Orchestrated Composition | Structural conflicts between waves that pass individually but break together |
   38 | | 19 | Prompt Injection via Dependencies | Safety Boundaries | External content in context hijacks agent behavior |
   39 | 
   40 | :::
   41 | 
   42 | Patterns 1–5 are the foundational anti-patterns from Chapter 1. Patterns 6–10 emerge from multi-agent execution mechanics. Patterns 11–19 are session-level and resource-level failure modes identified through systematic audit of early agentic practice. All nineteen are real. All nineteen have cost teams real time, money, and trust.[^ch18-verbatim-inheritance]
```

## 4. What the user fills

For each of the 19 rows: likelihood for us (High / Medium / Low), have we already seen it (cite the incident), blast radius, severity (the book supplies it for #11-19), the single mitigation we commit to, the owner, and the date it lands. Rows scoring High with no committed mitigation are the go/no-go items.

## 5. Field-level schema

Rows are the nineteen anti-patterns, pre-printed one per row in the chapter's own order, followed
by blank continuation rows numbered from 20 for the house taxonomy. The front page is A3
landscape and must hold all nineteen rows in one view — the instrument only works if the room can
*rank*, and ranking requires seeing every row at once. The per-pattern detail (ch20 L50-294) ships
as a facilitator's appendix, not on the sheet.

**The kit's shared risk scale.** Used with identical wording on `WS-08-pitfall-risk-register` so
the two registers can be laid side by side and read as one view.

*Likelihood here* — `High` / `Medium` / `Low`:

- **High** — we have already seen it, or a named precondition for it is present in our environment today.
- **Medium** — no precedent here, but nothing in our current practice would prevent it.
- **Low** — a named, existing control would catch it before it did harm. Name the control or the rating is not Low.

*Impact here* — `Critical` / `High` / `Medium` / `Low`. The first three are the book's own printed
severities (ch20 L169-289); `Low` is added as the floor so the scale has one.

- **Critical** — corrupts the codebase or crosses a trust boundary, and is discovered late or not at all.
- **High** — costs a wave or a sprint of rework, or loses the room's confidence in the programme.
- **Medium** — costs hours, and is visible at the next checkpoint.
- **Low** — an irritation absorbed inside the normal loop.

*Watch band* is derived by rule, not by arithmetic: **Band 1** = `High` likelihood with `Critical`
or `High` impact; **Band 2** = any other pairing containing a `Critical` or `High`; **Band 3** =
everything else. There is no weighting, no multiplication and no index — the book supplies no
scoring formula and inventing one would give the register false precision.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Pattern number | `computed` (fixed) | 1–19, then 20+ for house entries | — | ch20 L20-38 |
| 2 | Anti-pattern | `free text` (locked on rows 1–19) | All nineteen names, Monolithic Prompt through Prompt Injection via Dependencies | The name, on house rows only | ch20 L20-38 |
| 3 | Constraint violated | `select` (locked on rows 1–19) | Orchestrated Composition / Progressive Disclosure / Safety Boundaries / Explicit Hierarchy / Reduced Scope, per row as printed | The constraint, on house rows only | ch20 L20-38 |
| 4 | Summary | `free text` (locked on rows 1–19) | The chapter's one-line summary for each of the nineteen | — | ch20 L20-38 |
| 5 | Severity printed in the book | `select` Critical / High / Medium / *not printed* | Critical for #12 and #19; High for #11, #13, #16, #18; Medium for #14, #15, #17; *not printed* for #1–#10 | — | ch20 L169, L184, L199, L214, L229, L244, L259, L274, L289 |
| 6 | Likelihood here | `H/M/L` | — | Scored silently and individually first, then reconciled | derived (scale above) |
| 7 | Impact here | `select` Critical / High / Medium / Low | — | Our own rating; it may differ from column 5 and the difference is the interesting part | derived (scale above) |
| 8 | Seen it already | `checkbox` | — | Tick only where an actual incident can be cited in column 9 | ch20 L42 |
| 9 | Incident or evidence reference | `free text` | — | The ticket, PR, postmortem or date. An unticked-but-remembered incident is a blank | org |
| 10 | Blast radius | `free text` | — | What this would touch if it fired here: which repo, which team, which customer-facing surface | ch20 L42 |
| 11 | Control we already have | `free text` | The chapter's Prevention line per pattern, printed in the facilitator's appendix as the prompt | Our actual control, named — the linter, the hook, the review step | ch20 L50-294 |
| 12 | Control we must build before the pilot starts | `free text` | — | The gap between column 11 and what column 6–7 demand | `case-study-apm-overhaul.qmd` L230-239 |
| 13 | The single mitigation we commit to | `free text` | The chapter's Recovery line per pattern is the prompt, in the appendix | One mitigation, not a list. A row with four mitigations has none | ch20 L50-294 |
| 14 | Owner | `owner (named person)` | — | A named individual, never a team | org |
| 15 | Date it lands | `date` | — | A calendar date, not a phase | org |
| 16 | Watch band | `computed` | — | Derived from columns 6 and 7 by the rule above | derived |
| 17 | Go / no-go item | `computed` | — | Automatically set where Band 1 and column 13 is blank. These are the rows that block the pilot | derived |
| 18 | **House rows (20+)** — Symptom | `free text` | The five-field format is the chapter's own and is pre-printed as the row template | What we actually observed | ch20 L496-500 |
| 19 | **House rows** — Root cause | `free text` | — | Why it happened, not who | ch20 L496-500 |
| 20 | **House rows** — Constraint violated | `select` (same five as column 3) | The five PROSE constraints | Which one this violates | ch20 L496-500 |
| 21 | **House rows** — Prevention | `free text` | — | — | ch20 L496-500 |
| 22 | **House rows** — Recovery | `free text` | — | — | ch20 L496-500 |
| 23 | **House rows** — Severity | `select` Critical / High / Medium / Low | — | Using the same impact vocabulary as column 7 | derived |
| 24 | **House rows** — First seen | `date` | — | — | org |
| 25 | **House rows** — Incident link | `free text` | — | — | org |
| 26 | **House rows** — Primitive that now guards against it | `free text` | — | The instruction file, skill, hook or check that exists *because* of this row. A house entry with no guarding primitive is a story, not a control | ch20 L496-500 |
| — | Re-run date | `date` | — | The chapter calls the taxonomy a living document; this is the date the register is next re-read | ch20 L496-500 |

**Absorbed detail.** `WS-20-house-failure-mode-register` is columns 18–26 plus the continuation
rows numbered from 20 and the re-run date at the foot — printed as the back page of the same
sheet, exactly as its own note recommended, so the annual re-run stays obvious rather than
becoming a separate artefact nobody reopens.
`WS-CS-APM-antipattern-diagnostic` is absorbed as **six pre-filled exemplar rows** rather than a
separate sheet: rows 11, 12, 7, 13, 5 and 9 ship with the case study's escalation and resolution
printed in grey in columns 9 and 13 (install.py stuck → split file across waves; unicode
persistence → file-state verification after every dispatch, and never accept self-report without
a diff check; token type error → re-validate expert findings before wiring; PAT 403 → escalate
through the plan gate; silent NameError → assert on observable behaviour, not just pass/fail).
Its own "control we already have / control we must build" pair is columns 11 and 12, applied to
all nineteen rows rather than only its six.

**Deliberate omission.** No numeric risk score and no probability percentage. The book prints a
three-value severity and nothing else; a 1–25 matrix would manufacture precision the source does
not carry, and would let the room settle an argument by arithmetic instead of by discussion —
which is the one thing this instrument exists to prevent.

## 6. Absorbed members (2)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-20-house-failure-mode-register` - Our Failure-Mode Register: Blank Template for #20 Onward

- **Address.** `handbook\ch20-anti-patterns-and-failure-modes.qmd` L496-500, What This Chapter Is Not (`#sec-anti-scope-limits`)
- **Why folded.** Literally the canonical's table with blank rows plus the five-field row schema printed as a template; its own note recommends shipping it as the back page so the annual re-run stays obvious.
- **Fill detail to absorb.** Blank rows in the chapter's own five-field format -- symptom, root cause, constraint violated (which PROSE constraint), prevention, recovery -- extended with severity, first-seen date, the incident link, and the primitive that now guards against it.
- **Its output was.** A living house taxonomy that extends the book's 19 with the organisation's own scar tissue, re-read at each annual pre-mortem.

### `WS-CS-APM-antipattern-diagnostic` - Failure-Mode Pre-Mortem: Which Anti-Patterns Will Bite Us First?

- **Address.** `case-study-apm-overhaul.qmd` L230-239, Anti-Pattern Mapping (`#sec-cs-apm-antipattern-map`)
- **Why folded.** A six-row subset of the canonical's nineteen modes; the canonical's own note directs the four case-study tables to become pre-filled exemplar rows rather than four separate sheets.
- **Fill detail to absorb.** For each of the six anti-patterns named in the table (Context Window Exhaustion, Hallucinated Edits, The Trust Fall, Stale Context Between Waves, Scope Creep, Skipping Checkpoints), the team marks likelihood in our environment, the control we already have, and the control we must build before the pilot starts.
- **Its output was.** A ranked failure-mode register with an owner and a control per row.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- None. This sheet can be filled cold.

**Consumed by:**

- `WS-20-recovery-runbook` - When It Goes Wrong: Our Six-Step Recovery Runbook (Pack Z - Second wave: the practitioner kit, fill order 10)

**Feeds into (prose, from the source scan).** WS-05-governance-readiness-assessment (every mitigation must become a scheduled check), WS-20-org-failure-amplifier-assessment, and the risk section of the transformation plan

## 8. Facilitation

| | |
|---|---|
| Who fills it | The people who will actually run the delivery: the engineering leader, the tech leads of the candidate pilot teams, and at least one senior engineer who has already used agents on this codebase. Mixed audience by design — the exec needs to hear the room disagree. Anyone who has only read the chapter and never dispatched an agent scores, but does not arbitrate. |
| When in the session | Early in Pack G, second only to the charter. It has no prerequisites and is filled cold, which is the point: it is scored *before* the plan exists, so the plan is drawn around the Band 1 rows rather than the Band 1 rows being rationalised against a plan the room has already committed to. |
| Duration | 75–90 minutes. Budget 20 minutes for silent individual scoring of all nineteen rows, 40–50 minutes for the disagreement discussion, and 15 minutes to assign owners and dates to the Band 1 rows. Do not attempt to discuss all nineteen; most will be unanimous and need no air time. |
| Data needed in advance | The nineteen rows printed with the book's severity already in column 5; the facilitator's appendix (ch20 L50-294) to hand for any row the room queries; any existing incident log, postmortem set or agent-related ticket history, so column 9 can be filled with references rather than recollections; the current list of controls, hooks and checks in the pipeline, for column 11. |
| Room format | A3 landscape front page, one per person, plus a single wall copy for the reconciliation. Individual scoring is done on paper, face down, before any discussion. The wall copy is only marked up after the individual sheets are collected. |

**Facilitation note.** Score silently and individually first, then discuss **only the rows where
the room disagrees** — disagreement is the signal. A row where everyone independently writes
`High / Critical` needs a mitigation, not a conversation. A row where one person writes `Low` and
another writes `High` means two people hold different models of how this organisation works, and
the twenty minutes spent resolving that is the highest-value time in the session. Open with the
chapter's own framing (ch20 L8): *AI failures don't crash. They produce plausible wrong output.*
Resist the pull to rank all nineteen into a strict order; the deliverable is Band 1, typically
five to seven rows, each with an owner and a date — not a league table.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All nineteen rows carry a likelihood (column 6) and an impact (column 7).** No blanks, no
   "n/a". A pattern the room believes cannot happen here is scored `Low` with the preventing
   control named in column 11 — that is a claim the register can later be held to, and a blank is
   not.
2. **Every Band 1 row has a single named mitigation (column 13), a named individual owner
   (column 14) and a calendar date (column 15).** A team name in column 14 fails this criterion.
   Column 17 is the audit: it must be empty on a completed sheet.
3. **Every `Seen it already` tick (column 8) carries a reference in column 9.** A tick with no
   ticket, PR or postmortem behind it is a memory, and memories inflate likelihood scores.
4. **Every `Low` likelihood names the control that makes it low.** This is the criterion that
   catches optimism. "We wouldn't do that" is not a control.
5. **Where our impact rating (column 7) differs from the book's printed severity (column 5), the
   divergence is written down** — in column 10 or alongside it. A quietly downgraded `Critical`
   is exactly the laundering the kit's integrity rule exists to stop.
6. **The likelihood and impact vocabulary is identical to `WS-08-pitfall-risk-register`.** Lay the
   two sheets side by side: a reader must be able to compare a Band 1 row here with a Band 1 row
   there without translating. Where the same underlying concern appears on both (the hero pilot,
   the wrong metric), the two sheets cross-reference rather than restate the mitigation.
7. **Every mitigation in column 13 that is a recurring check, rather than a one-off build, is
   carried into `WS-05-governance-readiness-assessment` as a scheduled control**, and the house
   back page carries a re-run date. A mitigation with no scheduled re-read decays to a note.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Carried unchanged from _section-clusters.md section 7 for CL-RISK-PREMORTEM.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> THIS IS THE CONSOLIDATION, and I recommend ONE instrument rather than several. The 19-row taxonomy at 18-38 is the front page; the per-pattern detail is the facilitator's appendix and already follows a fixed schema -- five foundational patterns at 50-114 (symptom / root cause / constraint violated / scenario / prevention / recovery), five execution patterns at 120-154, nine session-and-resource patterns at 160-294 which additionally carry an explicit Severity field (Critical for Hallucinated Edits #12 and Prompt Injection #19; High for #11, #13, #16, #18). Splitting this into nineteen worksheets would destroy the one thing that makes it work as a leadership instrument: forcing a room to RANK, which means arguing about relative likelihood in one view. Facilitation tip: silent individual scoring first, then discuss only the rows where the room disagrees -- disagreement is the signal. The chapter's own framing at 8 is the opening line for the session: "AI failures don't crash. They produce plausible wrong output." RISK-REGISTER CLUSTER -- the kit already has WS-05-agent-risk-register (governance risks), WS-08-pitfall-risk-register (transition risks) and WS-27-assumption-risk-register (strategic assumptions). This one is distinct and should survive: it is the only TECHNICAL DELIVERY failure-mode diagnostic, and it is the only one with 19 pre-enumerated named modes and severities. Synthesizer should sequence them, not merge them, and give the kit one shared risk-scoring scale so the four registers can be read side by side.
