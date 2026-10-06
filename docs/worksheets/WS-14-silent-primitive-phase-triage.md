# The Silent Primitive: Four-Phase Triage Sheet

`WS-14-silent-primitive-phase-triage` &middot; **Pack Z - Second wave: the practitioner kit** &middot; fill order **8** &middot; type `diagnostic` &middot; audience **practitioner** &middot; leadership priority **3**

> **Split back out in the re-opening pass.** A different diagnostic tree entirely -- four phases (Resolve / Materialize / Bind / Activate) with falsifiable one-minute tests -- run when a primitive never fired, not when output was wrong.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A completed triage sheet that names the failing phase and the fix - and, aggregated over time, a frequency count showing whether the org's failures are budget-pressure or description-grammar problems.

**Cluster.** `CL-PRIMITIVE-TRIAGE` - The Silent Primitive: Load and Attention Triage Card

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch14-the-load-lifecycle.qmd` |
| Chapter | The Load Lifecycle |
| Heading | Activate |
| Stable anchor | `#sec-load-activate` |
| Lines | L93-107 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch14-the-load-lifecycle.html#sec-load-activate> |
| Locator quote | "The first three phases are deterministic. The fourth is not. Once the harness" |

Resolve at any time with `python docs/resolve.py ws WS-14-silent-primitive-phase-triage`.

## 3. Source extract - the scaffolding, verbatim

```text
   93 | The first three phases are deterministic. The fourth is not. Once the harness has bound every materialized file to a load mode, the dispatcher runs at every decision point and selects which lazy primitives to actually pull into context. This is the phase the opening case's debugging time was burned in, and it is the phase developers most often confuse with the previous three.
   94 | 
   95 | What makes activation deterministic versus probabilistic is itself enumerable, and the enumeration is the most useful thing this chapter has to offer:
   96 | 
   97 | - **Path predicates are deterministic.** An `applyTo` glob either matches the current working path or it does not. There is no model in the loop. If your scope-attached rule did not bind, either the path does not match the glob or the glob is malformed; both are testable in seconds.
   98 | - **Frontmatter validity is deterministic.** A YAML parser either accepts the frontmatter or it does not. A skill with a malformed frontmatter is invisible to the dispatcher; the harness's verbose log will say so.[^ch12-copilot]
   99 | - **The lockfile-driven closure is deterministic.** Once the manifest is resolved and pinned, the set of files materialized is fixed. The same `apm install` against the same lockfile produces the same layout on every machine.
  100 | - **Description matching is probabilistic.** When a skill's `description` is the only signal the dispatcher has, the match is the model's reading of the description against the model's reading of the current task. Two activations of the same skill on similar-but-not-identical tasks may differ. Description grammar matters: precise verbs, named triggers ("when authoring Alembic migrations"), explicit scope predicates ("under `migrations/versions/`") raise hit rate; vague descriptions lower it.[^ch12-skills]
  101 | - **Budget pressure is probabilistic.** When the eager preloads have already consumed a large fraction of the budget — the opener's 6,200-token Python instructions file, an over-eager `applyTo: "**"` rule, a project-wide `CLAUDE.md` that grew to 800 lines — the dispatcher down-ranks lazy candidates that are not strictly required. The skill the user expected is not unloaded; it is *un-considered*. Verbose logs show this as a candidate that was registered but never pulled.
  102 | 
  103 | These five lines of activation contract are what convert a Monday-morning failure into a Monday-morning fix. A skill that does not bind has failed at exactly one of those bullets, and each bullet has a falsifiable test. Glob mismatch: `git ls-files | grep -E "<glob-as-regex>"`. Frontmatter: `yamllint` on the file. Lockfile: `apm install --dry-run`. Description: read the verbose log entry that says *did not match*. Budget: read the verbose log entry that says *registered but not pulled*. The agent stack trace described in Ch19 is built on these tests; this chapter is what makes them sensible.
  104 | 
  105 | The PROSE constraints (@sec-prose) are the normative side of the same story. P (Progressive Disclosure) is what keeps eager preload modest enough that lazy activation has budget room to maneuver. R (Reduced Scope) is what keeps `applyTo` globs from over-eagerly pulling in rules. O (Orchestrated Composition) is what keeps the binding modes coherent across primitives that work together. The constraints in Ch12 are not preference; they are the disciplines required to keep activation predictable. This chapter is the substrate they sit on.
  106 | 
  107 | ---
```

## 4. What the user fills

For a primitive that failed to fire, the practitioner works the four phases in order and records the result of each one-minute test: Resolve (`apm install --dry-run` closure contains it? Y/N), Materialize (file at the harness's expected path? Y/N), Bind (frontmatter parses; correct mode? Y/N), Activate (verbose log says "did not match" vs "registered but not pulled"?). Final field: which phase failed, and the fix applied.

## 5. Field-level schema

A single **two-sided A4 card** (one sheet printed duplex, folded to A5 for the pad if the team prefers), filled at the desk by whoever hit the failure. **Side A** answers
*did the file load?* — the four phases of the load lifecycle, each with its one-minute test.
**Side B** answers *did the model attend to it once it loaded?* — the six symptoms and the three
numbers the chapter says settle almost every case. The card's spine is the book's own two-question
sequence, and the routing rule prints at the foot of side A: **work side A first; flip only when
all four phases pass and the primitive still had no effect.** The chapter's opening case
(ch14 L4-10) prints on the back as the worked example.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| — | Primitive path | `free text` | — | The file that stayed silent | org |
| — | Primitive type and expected binding mode | `select` | The binding table, so the expected mode is read off rather than guessed — eager preload, eager (conditioned), lazy on-demand, dispatcher-mediated | Which | ch14 L79-85 |
| — | The task that should have activated it | `free text` | — | One sentence | org |
| — | Harness, and verbose mode on? | `free text` + `checkbox` | — | Which harness; whether the log was actually read | ch14 L103 |
| — | Practitioner / date | `owner (named person)` + `date` | — | — | org |
| A1 | Phase | `select` (fixed 4, in order) | Resolve, Materialize, Bind, Activate | — | ch14 L24-27 |
| A2 | Who owns this phase | `free text`, pre-printed | The package manager (once per install); the install step (once per install); the harness, at session start; the dispatcher, at every decision point | — | ch14 L20, L31 |
| A3 | The one-minute test | `free text`, pre-printed | `apm install --dry-run` and read the printed closure; is the file at the path *this* harness parses (the cross-harness table prints beside the row); `yamllint` the frontmatter and confirm the binding mode; read the verbose log entry for this primitive | — | ch14 L43, L53-59, L98, L103 |
| A4 | Result | `select` — pass / fail / not run | — | Which | ch14 L103 |
| A5 | Evidence | `free text` | — | The literal line of command output or log text, quoted. A `pass` with this cell empty is `not run` | ch14 L103 |
| A6 | Activate row only — which bullet failed | `select` (fixed 5) | Path predicate (deterministic); frontmatter validity (deterministic); lockfile-driven closure (deterministic); description matching (probabilistic); budget pressure (probabilistic) | Which | ch14 L97-101 |
| A7 | Activate row only — verbose-log verdict | `select` | `did not match`; `registered but not pulled`; no entry for this primitive at all | Which | ch14 L101, L103 |
| A8 | Failing phase | `computed` | The rule printed beside it: a primitive that does not surface has failed at **exactly one** of the four | The first row reading `fail` | ch14 L31-33, L103 |
| A9 | Fix applied | `free text` | — | What was changed | ch14 L103 |
| A10 | Re-tested, and now binds | `checkbox` | — | Ticked only after re-running the same test | derived |
| B1 | Symptom in the session | `select` (fixed 6), pre-printed verbatim | Agent ignores an explicit, scope-loaded instruction; output references a file the agent worked on twenty turns ago, wrongly; agent forgets to call a tool it called correctly five turns ago; hallucinated detail about your codebase; quality cliff after a long error-debugging exchange; inconsistent answers to the same question across two sessions | — | ch15 L36-41 |
| B2 | What is actually happening | `free text`, pre-printed | The book's middle column, unedited | — | ch15 L36-41 |
| B3 | First thing to check | `free text`, pre-printed | The book's right column, unedited | — | ch15 L36-41 |
| B4 | Observed | `checkbox` | — | Tick the row or rows seen | ch15 L36-41 |
| B5 | Number one — token count at the failing turn | `free text` (count) | The book's heuristic printed beside the field: *"If the answer is more than a third of the window, attention is the prime suspect."* | The measured count | ch15 L43 |
| B6 | Number two — position of the failing instruction in the payload | `select` — head / mid-payload / recent turns / tail | The heuristic: *"If it is in the middle, position is the prime suspect,"* with the four zones named as the attention curve names them | Which zone | ch15 L43, L53-72 |
| B7 | Number three — pasted blobs and tool outputs since that instruction was last reinforced | `free text` (count) | The heuristic: *"If the answer is more than a handful, recency-bias is eating your earlier inputs."* | The count | ch15 L43 |
| B8 | Prime suspect | `select` — position / load / closure | — | Which, from B5-B7 | ch15 L43 |
| B9 | Lever applied | `select` — progressive disclosure / subagent isolation / plan-write-then-reload | The three levers named | Which | ch15 L80-98 |
| B10 | Symptom cleared | `checkbox` | — | Ticked after re-running the same task | derived |
| B11 | Tally contribution | `computed` | — | Which failing phase (side A) or which prime suspect (side B) this card adds to the team's running count | derived |

**Absorbed detail.** `WS-15-attention-starvation-diagnostic` is **side B in its entirety**. Its
six-row symptom table is B1/B2/B3, with the book's own middle and right columns pre-printed so the
practitioner only ticks B4. The three numbers the chapter says settle most cases are B5, B6 and B7,
each printed with the book's own heuristic beside it. The lever applied and whether the symptom
cleared are B9 and B10. Its aggregate output — a symptom-frequency profile for the team — is B11,
which is deliberately shared with side A so that one tally answers both halves of the question at
once: are this team's silent primitives a loading problem or an attention problem?

**A note on the numbers on side B.** The three heuristics printed beside B5, B6 and B7 are the
book's own sentences, quoted and attributed (ch15 L43). Nothing on this card is a benchmark the
team is expected to hit. The card's job is to make three numbers visible at the moment of failure,
not to grade them — they are measurements of one failing session, and they would be meaningless as
targets. The same applies to the token figure in the printed opening case on the back: it is what
happened to one engineer, not a threshold.

**Deliberate omission — no budget allocation.** The card diagnoses one failure. Where budget
pressure wins the tally over time, the instrument that acts on it is
`WS-15-context-budget-allocation`; B11 is the hand-off to it and nothing more.

**Deliberate omission — no severity or priority column.** This is a desk card with a one-minute
test per row, and the chapter's whole argument is that naming the phase reduces the search space to
four small falsifiable questions. Adding a priority column adds triage to a triage sheet.

## 6. Absorbed members (1)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-15-attention-starvation-diagnostic` - Attention Starvation Diagnostic

- **Address.** `handbook\ch15-attention-and-context-economy.qmd` L32-47, Symptoms of attention starvation (`#sec-attention-starvation-symptoms`)
- **Why folded.** Its own note specifies the two ship as a single two-sided card -- did the file load (ch14) versus did the model attend to it (ch15); contributes the six-row symptom table and the three numbers that settle most cases.
- **Fill detail to absorb.** Tick the observed symptom from the book's six rows, then record the three numbers the chapter says settle most cases: token count at the failing turn, the position of the failing instruction within the payload (head / mid / recent / tail), and the count of pasted blobs or tool outputs since that instruction was last reinforced. Final field: the lever applied and whether the symptom cleared.
- **Its output was.** A completed diagnosis naming the cause (position, load, or closure) and the countermeasure applied; aggregated, a symptom-frequency profile for the team.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-21-primitive-governance-policy` - Primitive Supply Chain: Registry, Pinning, Versioning and Ownership Decisions (Pack Z - Second wave: the practitioner kit, fill order 3)

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** Team runbook / the agent stack trace in Ch19; aggregated results feed WS-15-context-budget-allocation when budget pressure dominates.

## 8. Facilitation

| | |
|---|---|
| Who fills it | The practitioner who hit the failure, alone, at their own desk. This is not a workshop instrument and it should not be scheduled as one. The only group activity attached to it is the standing read of the tally. |
| When in the session | Pack Z, fill order 8, after `WS-21-primitive-governance-policy`. The dependency is mechanical rather than procedural: the Resolve test is `apm install --dry-run` against a manifest and a lockfile, and whether those exist at all is a Part A decision on that sheet. Where they do not exist, the Resolve row reads `not run` — which is a governance finding, not a pass. |
| Duration | Five to ten minutes for side A, if verbose mode is already on. The chapter's opening case burned an hour without this vocabulary; the card exists to turn that hour into ten minutes, and it fails at its job if filling it becomes a task. |
| Data needed in advance | Verbose mode enabled in the harness — the card is close to useless without it, and this is the single most common reason one comes back half-filled. The primitive's path, its frontmatter, and its `applyTo` glob or description. A token counter. That is the whole list: the chapter is explicit that none of these questions needs special tooling. |
| Room format | A printed two-sided A4 card, exactly two sheets in the build (side A and side B), kept as a pad in the team area. A4 rather than A5 because the phase tests, symptoms and numbers do not fit A5 above 7pt. Not a document, not a form, not a ticket type. The only thing that leaves the card is the tally, transcribed once a month. |

**Facilitation note — Pack Z prerequisite condition.** This is the most immediately usable
instrument in the pack and the one least likely to be filled in a session at all. It needs an
organisation that already has primitives capable of going silent; a pre-groundbreaking organisation
has nothing to triage. The condition that makes it worth printing is simply that somebody has
written a skill or a scope-attached rule file and watched it fail to fire. Introduce the card in
the session immediately after the first such report — not before. A card issued ahead of the
failure it diagnoses will not be in anyone's drawer on the morning the failure arrives.

**Second note — the two-sided design is itself the diagnosis.** The spine is the book's own
sequence: *did the file load?*, then *did the model attend to it once it loaded?* (ch14 L113).
Practitioners reliably reach for the attention explanation first, because it is the more
interesting one, and then spend an hour rewriting a description that was never the problem. The
fold enforces the order. Print the routing rule at the foot of side A and do not soften it: flip
only when all four phases pass.

**Third note — print the opening case on the back.** Ch14 L4-10 is a complete worked example: a
correct skill, a sharp description, the right directory, silent because somebody else's
`applyTo: "**/*.py"` glob was pulling a large Python guidance file into context ahead of it. It is
the fastest way to teach the card, and it is precisely the failure that side A's `budget pressure`
bullet (A6) catches — the skill was not unloaded, it was un-considered.

## 9. Acceptance criteria

A well-completed card satisfies all of:

1. **Exactly one phase is named in A8.** Four phases, one failure — the chapter's claim is that a
   silent primitive has failed at exactly one of them. Two failing rows means the tests were run
   out of order, or one of them was answered from belief rather than from output.
2. **Every A4 result cites evidence in A5** — the literal line of command output or log text,
   quoted. A `pass` with an empty evidence cell is recorded as `not run` before the card is filed.
3. **A Resolve row reading `not run` says why, and becomes a finding against
   `WS-21-primitive-governance-policy`.** A team with no manifest and no lockfile cannot run that
   test, and that fact is information about the governance policy rather than about this
   primitive. It is never left as a blank.
4. **Side B was reached through the routing rule, not around it.** If side B is filled, side A
   shows four passes. A card carrying failures on both sides has diagnosed two things and fixed
   neither.
5. **Where side B is filled, all three numbers are present.** B5, B6 and B7 are the three questions
   the chapter says cover almost every case (ch15 L43). A card with one of them missing has
   recorded a symptom and stopped short of the diagnosis.
6. **A9 names a fix and A10 records whether it worked.** A card that identifies the phase and stops
   is half an artefact: the phase is the search-space reduction, the re-test is the result.
7. **The tally is aggregated and read at a standing interval by a named person.** The card's second
   output, stated in section 1, is the frequency count that tells the organisation whether its
   failures are budget-pressure problems or description-grammar problems. That count exists only if
   somebody counts, and an unaggregated pad of cards has produced individual fixes and no
   institutional knowledge.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Four phases with falsifiable one-minute tests already enumerated, plus a compressed TL;DR as a second source for the same card.
- **Fill (the organisation completing it): `S`.** S - one sitting, data already in the room

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Already well structured: the five deterministic-vs-probabilistic bullets are at lines 97-101 and the falsifiable tests are enumerated at line 103; the TL;DR at lines 120-126 is a second, more compressed source for the same sheet. Purely practitioner-facing debugging aid - deliberately NOT in the leadership kit, but it is the single most immediately usable instrument in the chapter and belongs in a practitioner appendix. Facilitation note: the chapter's opening case (lines 4-10) is a ready-made worked example to print on the back of the sheet.
