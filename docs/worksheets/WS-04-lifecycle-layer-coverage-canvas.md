# Lifecycle Layer Coverage Canvas: Who, Which Agent, Which Platform, Per Phase

`WS-04-lifecycle-layer-coverage-canvas` &middot; **Pack B - Where we actually are** &middot; fill order **2** &middot; type `canvas` &middot; audience **mixed** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A one-page baseline map of the organisation current agentic SDLC coverage across all eight phases, with named owners and evidenced gaps.

**Cluster.** `CL-LIFECYCLE-COVERAGE` - Lifecycle Coverage Map and the Phase-Placement Gap

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch04-the-reference-architecture.qmd` |
| Chapter | The Agentic SDLC Reference Architecture |
| Heading | Mapping the Layers Across the Lifecycle |
| Stable anchor | `#sec-ref-arch-lifecycle-mapping` |
| Lines | L69-89 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch04-the-reference-architecture.html#sec-ref-arch-lifecycle-mapping> |
| Locator quote | "The three layers apply at every phase of software delivery" |

Resolve at any time with `python docs/resolve.py ws WS-04-lifecycle-layer-coverage-canvas`.

## 3. Source extract - the scaffolding, verbatim

```text
   69 | The three layers apply at every phase of software delivery. The table below maps what each layer does in each phase and, critically, which capabilities are available today versus emerging or directional.
   70 | 
   71 | Maturity tiers: **Now** = available across two or more vendors. **Emerging** = available in one or two tools, or in limited preview. **Directional** = announced, demonstrated, or on public roadmaps but not production-ready.
   72 | 
   73 | {{< pagebreak >}}
   74 | 
   75 | ::: {.landscape}
   76 | 
   77 | ::: {tbl-colwidths="[9,11,13,13,14,12,12,9,7]"}
   78 | 
   79 | |  | Ideate | Plan | Code | Build | Test | Review | Release | Operate |
   80 | |---|---|---|---|---|---|---|---|---|
   81 | | | *INTENT* | | *BUILD* | | | | *OPERATE* | |
   82 | | **Human** | Set objectives and scope | Make architecture choices | Review agent output | Own build config | Define test policy | Final code sign-off | Go/no-go decision | Own incident response |
   83 | | **Agent** | Research prior art, surface conflicts | Draft ADRs, decompose tasks | Multi-file code generation | Diagnose build failures | Generate tests, find coverage gaps | Automated review, catch defects | Draft changelogs, flag breaking changes | Correlate alerts, suggest actions |
   84 | | **Platform** | Knowledge bases, collaboration tools | Issue trackers, project management | IDE, SCM, context APIs | CI/CD pipelines, dependency management | Test frameworks, infrastructure | Pull request APIs, policy engines | Deployment pipelines, gates | Monitoring, alerting, log systems |
   85 | | **Maturity** | Emerging | Emerging | Now | Now | Emerging | Now | Emerging | Directional |
   86 | 
   87 | :::
   88 | 
   89 | :::
```

## 4. What the user fills

For each of the eight lifecycle phases (Ideate, Plan, Code, Build, Test, Review, Release, Operate) the team names the accountable human role, the agent capability actually in use today (none / pilot / production), the platform systems that back it, a self-rated current-state tickbox (Automated / Assisted / Manual), and a gap note. A final column carries the book vendor maturity tag (Now / Emerging / Directional) so internal state can be compared against what the market can actually deliver.

## 5. Field-level schema

Two panels. **Panel A** is the canvas: one row per lifecycle phase, eight fixed rows. **Panel B**
is the placement gap: two fixed rows on the same four-phase scale. Panel A prints A3 landscape with
the chapter's three-layer diagram (ch04 L31-65) reproduced as the header band, so Human / Agent /
Platform are visible above the columns that ask for them; Panel B is on the reverse and is filled
last. Below Panel B sits the bucket rollup.

**Orientation.** The book prints this table with phases as columns and Human / Agent / Platform /
Maturity as rows, which reads well and fills badly. The canvas transposes it: one row per phase,
because a phase is the unit a room argues about and assigns an owner to. Every cell of the book's
table survives the transposition, pre-printed in columns 3, 5, 7 and 11.

**Panel A — lifecycle coverage canvas.** One row per phase, eight fixed rows.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Phase | `select` (fixed 8 rows) | Ideate · Plan · Code · Build · Test · Review · Release · Operate | — | ch04 L79 |
| 2 | Bucket | `computed` | INTENT (Ideate, Plan) · BUILD (Code, Build, Test, Review) · OPERATE (Release, Operate) | — | ch04 L81; ch02 L189-191 |
| 3 | Human role, per the book | `free text` | Set objectives and scope · Make architecture choices · Review agent output · Own build config · Define test policy · Final code sign-off · Go/no-go decision · Own incident response | — | ch04 L82 |
| 4 | **Our accountable human** | `owner (named person)` | — | A named individual. If nobody owns the phase, write `unowned` — that is the finding. | org |
| 5 | Agent capability, per the book | `free text` | Research prior art, surface conflicts · Draft ADRs, decompose tasks · Multi-file code generation · Diagnose build failures · Generate tests, find coverage gaps · Automated review, catch defects · Draft changelogs, flag breaking changes · Correlate alerts, suggest actions | — | ch04 L83 |
| 6 | **Our agent capability today** | `select` none / pilot / production | — | The mark | org |
| 7 | Platform systems, per the book | `free text` | Knowledge bases, collaboration tools · Issue trackers, project management · IDE, SCM, context APIs · CI/CD pipelines, dependency management · Test frameworks, infrastructure · Pull request APIs, policy engines · Deployment pipelines, gates · Monitoring, alerting, log systems | — | ch04 L84 |
| 8 | **Our platform systems** | `free text` | — | The named products actually in use for this phase | org |
| 9 | **Our current state** | `select` Automated / Assisted / Manual | — | One tick per row | ch02 L174-181 |
| 10 | Evidence for the tick | `free text` | — | The tool, pipeline or workflow that justifies it. Required for any tick above Manual. | derived from ch02 L195 |
| 11 | Book's vendor maturity tag | `free text` | Emerging · Emerging · Now · Now · Emerging · Now · Emerging · Directional, with the tier definitions printed as a key on the sheet: **Now** = available across two or more vendors · **Emerging** = available in one or two tools, or in limited preview · **Directional** = announced, demonstrated or on public roadmaps but not production-ready | Not editable | ch04 L71, L85 |
| 12 | Gap note | `free text` | — | What is missing, in one line | org |
| 13 | Target state at 6 months | `select` Automated / Assisted / Manual | — | — | org |
| 14 | Target state at 12 months | `select` Automated / Assisted / Manual | — | — | org |
| — | Bucket coverage rollup | `computed` | — | Per bucket: count of phases at Manual, Assisted, Automated. Printed as three small bars, not a score. | derived |

**Panel B — leadership-versus-reality placement gap.** Two fixed rows on the same scale. The two
marks are made independently and neither party sees the other's before both are written.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 15 | Mark | `select` (fixed 2 rows) | "Where leadership believes we operate" · "Where our developers actually operate" | — | ch02 L66-68 |
| 16 | Phase | `select` 1-4 | Phase 1 Code completion (2021-2023), passive suggestion · Phase 2 Conversational assistance (2023-2024), active Q&A · Phase 3 Agentic coding (2024-2025), goal-directed execution · Phase 4 Orchestrated SDLC (emerging), autonomous lifecycle participation | The mark | ch02 L33-39, L57-64 |
| 17 | Evidence for this mark | `free text` | — | Required on both rows | org |
| 18 | Source of the mark | `free text` | Row 1 is supplied by the executive present. **Row 2 must be sourced from `WS-02-shadow-ai-usage-inventory` returns**, not from anyone's impression of what developers are doing. | The named source | ch02 L160; §7 |
| 19 | Key risk at the developers' actual phase | `free text` | Printed per phase: Low — easy to reject · Medium — harder to verify · High — confident errors at scale · Very high — governance gap | — | ch02 L59-64 |
| — | Gap statement | `computed` + `free text` | Template printed: "We are evaluating Phase __ while our teams run Phase __." | The completed sentence, in one line | ch02 L66-68 |
| — | Governance exposure sitting in the gap | `free text` | — | What is ungoverned because of the difference | ch02 L68 |
| — | Exposure owner and date | `owner (named person)` + `date` | — | A named individual and a date by which it is closed or accepted | org |

**Absorbed detail.** `WS-02-sdlc-phase-automation-audit` supplies Panel A columns 9, 10, 4, 13 and
14 — the Automated / Assisted / Manual tick the chapter already prints as a blank checkbox column,
plus the evidence behind the tick, the named phase owner, and the 6- and 12-month target states —
and its stated output, the coverage heat map showing which of the three buckets is empty, is the
computed bucket rollup. `WS-02-agentic-phase-placement-gap` is Panel B in its entirety: two marks
on the four-phase scale, the evidence for each, the single-sentence gap statement that is its
stated output, and the named governance exposure sitting between them.

**Deliberate omission.** No agent boundary, escalation rule or autonomy level appears on this
canvas, even though column 6 invites it. That material belongs to the Chapter 5 decision matrix and
its worksheet; duplicating it here would produce two authorities on what an agent may do
unsupervised. Also omitted: any percentage-automated figure or coverage score. The rollup is three
counts per bucket, because the question the canvas answers is *which bucket is empty*, and a
percentage answers a different and less useful one.

## 6. Absorbed members (2)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-02-agentic-phase-placement-gap` - Leadership-vs-Reality Phase Placement

- **Address.** `handbook\ch02-the-ai-native-landscape.qmd` L31-71, From Autocomplete to Agents (`#sec-landscape-autocomplete-to-agents`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Two marks on the same four-phase scale - where leadership believes the organisation operates, and where developers actually operate - with the evidence for each mark and the named governance exposure sitting in the gap between them.
- **Its output was.** A single-slide gap statement ("we are evaluating Phase 2 while our teams run Phase 3") with the risk that gap creates, which is the sharpest way to open the exec conversation.

### `WS-02-sdlc-phase-automation-audit` - SDLC Phase Automation Audit

- **Address.** `handbook\ch02-the-ai-native-landscape.qmd` L168-197, The 8-Phase Evaluation Framework (`#sec-landscape-phase-evaluation`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** One tick per phase in the existing "Your current state" column (Automated / Assisted / Manual) across all eight phases, plus added columns for the evidence behind the tick, the named owner of that phase, and the target state at 6 and 12 months.
- **Its output was.** A per-phase automation baseline they can re-score in six months, plus a coverage heat-map showing which of the three buckets (Intent / Build / Operate) is empty.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- None. This sheet can be filled cold.

**Consumed by:**

- `WS-04-intent-build-operate-investment-balance` - Intent / Build / Operate Investment Balance Sheet (Pack C - The case and the money, fill order 7)

**Feeds into (prose, from the source scan).** WS-04-intent-build-operate-investment-balance and WS-08-pilot-selection-and-scope

## 8. Facilitation

| | |
|---|---|
| Who fills it | This is the one canvas in Pack B that requires an executive and a practitioner at the same table. Panel A: the engineering leader with at least one practitioner per bucket — somebody who actually works in Ideate or Plan, somebody in Build, and somebody in Release or Operate. The Operate row will otherwise be filled by people guessing about on-call. Panel B: the executive who will supply the leadership mark must be **physically present**. A gap statement written on an absent executive's behalf is a strawman and the room knows it. |
| When in the session | Pack B, fill order 2, after `WS-01-vibe-coding-cliff-diagnostic`. The cliff diagnostic gives the room the vocabulary and the honesty; this canvas gives it the map. Panel B additionally needs `WS-02-shadow-ai-usage-inventory`'s returns in hand, because column 18 forbids sourcing the developer mark from anything else — if the census has not returned, fill Panel A and defer Panel B rather than guessing the row. |
| Duration | 60-75 minutes. Panel A takes 45, and the Ideate, Plan and Operate rows take most of it because they are the phases nobody has thought about. Panel B is 20 minutes, of which 5 is the independent marking and 15 is the conversation that follows. The rollup is 10. |
| Data needed in advance | The `WS-02` shadow-AI returns. The current toolchain per phase — CI system, issue tracker, code review platform, monitoring stack — so column 8 is filled from fact rather than from what the platform team intended. Who owns each phase today, or the honest answer that nobody does. Any existing automation inventory, so an Assisted tick can cite something. |
| Room format | A3 landscape, one canvas per group, with the ch04 three-layer diagram printed as a header band. Panel B on the reverse, folded so it is not visible while Panel A is being filled. For the two marks: hand the executive and the practitioner each a sticky note, have them write a phase number **before either speaks**, then place both at once. Filled any other way, the second mark anchors to the first and the gap disappears. |

**Facilitation note.** The tier key in column 11 must be printed on the sheet, or the Now /
Emerging / Directional tags read as a maturity target the organisation is behind on. They are a
statement about what vendors can currently deliver: Now means two or more vendors ship it, and
Directional means nobody does yet. A phase tagged Directional where the organisation is Manual is
not a gap — it is the market. Use the chapter's own observation to open Panel B: most organisations
are evaluating Phase 1-2 tools while their developers already operate at Phase 3, and that
difference is itself the risk (ch02 L66-68). If the two sticky notes land on the same phase,
probe it — either the organisation is genuinely well-calibrated, which is worth documenting, or the
census in column 18 was not consulted.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All eight phases carry a current-state tick and a named individual in column 4.** A phase with
   no owner is recorded as `unowned`, never left blank — an empty owner cell reads as an oversight,
   the word `unowned` reads as a decision the organisation has made by default.
2. **Every tick of Automated or Assisted cites evidence in column 10** naming a specific tool,
   pipeline or workflow. Ticks that cannot cite one are downgraded to Manual before the canvas
   leaves the room; this single rule is what stops the canvas becoming an aspiration map.
3. **No row claims a current state above the book's maturity tag in column 11 without a written
   explanation.** Claiming production automation in a phase the market rates Directional is either
   a genuinely leading position worth documenting for the business case, or a misread of what the
   tooling does — and the sheet must say which.
4. **Panel B's two marks were made independently, both cite evidence, and the developer mark names
   `WS-02-shadow-ai-usage-inventory` as its source** in column 18. A developer mark sourced from the
   room's impression invalidates the gap statement.
5. **The gap statement is written as a single sentence,** and the governance exposure it names has
   a named individual owner and a date by which it is closed or formally accepted.
6. **The bucket rollup is computed and identifies which of Intent, Build and Operate has the least
   coverage.** The chapter's expectation is that Build is well covered and Intent and Operate are
   not; a rollup that shows otherwise is either a genuine finding or an over-generous set of ticks
   in column 9, and the room should say which before it moves on.
7. **Reconciliation.** Every phase with a 6- or 12-month target above its current state
   (columns 13-14) carries a corresponding line in
   `WS-04-intent-build-operate-investment-balance`. A target with no investment behind it is an
   intention, and a bucket receiving investment that this canvas shows already covered is a
   misallocation — both are resolved before Pack C closes.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Carried unchanged from _section-clusters.md section 7 for CL-LIFECYCLE-COVERAGE.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Direct scale-up of the ch02 seed table (handbook\ch02-the-ai-native-landscape.qmd approx line 174, "Your current state / Automated / Assisted / Manual"). Synthesizer must decide whether ch02 and ch04 get one merged canvas or a coarse (ch02) plus fine-grained (ch04) pair. Book content is already a well-formed table; only the fillable columns need authoring. The three-layer Mermaid diagram at lines 31-65 (section "The Three Layers", anchor the-three-layers) is the visual for this canvas and should be reproduced as the worksheet header. Agent boundary and escalation detail is deliberately NOT here because the ch05 decision matrix covers it.
