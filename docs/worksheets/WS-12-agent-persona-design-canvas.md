# Specialist Agent Roster and Persona Canvas

`WS-12-agent-persona-design-canvas` &middot; **Pack Z - Second wave: the practitioner kit** &middot; fill order **1** &middot; type `canvas` &middot; audience **architect** &middot; leadership priority **2**

> **Split back out in the re-opening pass.** A per-specialist configuration canvas (domain expertise, patterns enforced, anti-patterns never produced, tool whitelist) plus a three-to-five starting roster; the tool-whitelist column is the matched pair to the authority matrix and cannot drift from it.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A starting roster of three to five agent configurations with drafted persona files, plus a rule for when a new specialisation has earned its place.

**Cluster.** `CL-PERSONA-ROSTER` - Specialist Agent Roster and Persona Canvas

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch12-the-instrumented-codebase.qmd` |
| Chapter | The Instrumented Codebase |
| Heading | Agents |
| Stable anchor | `#sec-codebase-agents` |
| Lines | L115-122 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch12-the-instrumented-codebase.html#sec-codebase-agents> |
| Locator quote | "Four elements make an agent configuration effective:" |

Resolve at any time with `python docs/resolve.py ws WS-12-agent-persona-design-canvas`.

## 3. Source extract - the scaffolding, verbatim

```text
  115 | Four elements make an agent configuration effective:
  116 | 
  117 | 1. **Domain expertise.** Specific enough to constrain the agent's decisions. "You are an expert Python developer" is too broad to be useful. "You specialize in CLI tool design using the Click framework with Rich terminal output" constrains the solution space meaningfully.
  118 | 2. **Named patterns.** When the agent knows patterns by name ("BaseIntegrator," "CredentialChain," "CommandLogger") it can reference them in its reasoning and produce code that uses them correctly.
  119 | 3. **Anti-patterns.** What the agent must never do. These encode institutional memory; each item represents a mistake that happened at least once and cost the team time to fix.
  120 | 4. **Tool boundaries.** Which tools the agent can invoke. A documentation agent shouldn't execute destructive commands. A frontend agent shouldn't access backend databases. Tool boundaries are safety boundaries made concrete.
  121 | 
  122 | Start with three to five agent configurations. An architect, a domain expert for your core business logic, and a documentation writer cover most tasks. Add configurations when you observe repeated corrections; that's the signal that a new specialization has earned its place.
```

## 4. What the user fills

One canvas per proposed specialist, filled against the chapter's four elements: domain expertise stated narrowly enough to constrain the solution space, the patterns it enforces by name, the anti-patterns it must never produce (each one a mistake that actually cost the team time), and the explicit tool whitelist. A roster sheet then names the three to five personas the organisation starts with.

## 5. Field-level schema

One row per proposed specialist. The sheet ships twice from the same schema: an **A3 canvas
per persona**, laid out as labelled blocks in the order of the book's worked Python Architect
example (Design Philosophy / Patterns You Enforce / You Never, ch12 L93-113), and a
**one-page roster table** carrying every persona as a row so duplication between two
personas is visible in one glance.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Persona name and file path | `free text` | The starting three printed as ghosted row labels: an architect, a domain expert for core business logic, a documentation writer | The org's own names and `.agent.md` paths | ch12 L122 |
| 2 | Pod | `select` — editorial/coherence, domain expert, reviewer proxy, audit | The four pod names | Which pod this persona sits in | `case-study-handbook-writing.qmd` L33-74 |
| 3 | Whose judgement it proxies | `owner (named person)` | — | A living colleague, never a job title | `case-study-handbook-writing.qmd` L33-74 |
| 4 | Domain expertise, one sentence | `free text` | The calibration pair printed beside the field — "You are an expert Python developer" (too broad) against "You specialize in CLI tool design using the Click framework with Rich terminal output" (constrains the solution space) | The sentence | ch12 L117 |
| 5 | Named patterns it enforces | `free text` (list) | The worked example's three — `BaseIntegrator`, `CommandLogger`, `AuthResolver` — printed as shape, not content | The org's own pattern names | ch12 L104-107, L118 |
| 6 | You Never (anti-patterns) | `free text` (list) | The worked example's three `You Never` lines | The org's own | ch12 L109-111, L119 |
| 7 | The incident behind each anti-pattern | `free text` | — | Date, ticket or postmortem for every line in column 6 | ch12 L119 |
| 8 | Tool whitelist (capability) | `free text` — explicit list, no wildcards | The example `tools:` frontmatter, plus the four standard role rows (code writer / reviewer / test runner / deployer) as starting shapes | This persona's actual tool list | ch12 L87-88, L120; ch13 L234-239 |
| 9 | Model | `free text` | The book's two worked values shown as examples of what the field holds, not as recommendations | The model the org pins | ch12 L89, L672 |
| 10 | File-path boundary | `free text` | — | The explicit list of directories this persona may modify | ch13 L549 |
| 11 | STOP gates | `free text` | The named gate classes — auth logic, database schemas, production config — and the three-step gate block | This persona's own gates | ch13 L260-266, L548 |
| 12 | Required output format | `select` + `free text` — plan / commentary / diff / verdict / other | — | What this persona must hand back | `case-study-handbook-writing.qmd` L33-74 |
| 13 | Binding mode | `select` | Pre-set to `dispatcher-mediated` on every row | Confirm, or record the exception and why | ch12 L78; ch14 L83 |
| 14 | Authority-matrix row | `computed` (cross-reference) | — | The row on `WS-13-agent-authority-matrix` carrying this persona's capability list | derived |
| 15 | Earned its place | `select` — starting roster / added on observed repeated correction | The rule: add configurations when you observe repeated corrections | The evidence — which corrections, how often, where recorded | ch12 L122 |
| 16 | Owner | `owner (named person)` | — | Who maintains this `.agent.md` | org |
| 17 | Drafted / last reviewed | `date` | — | — | org |
| — | Roster size | `computed` | The sizing guidance printed beside the total: start with three to five | Count of rows | ch12 L122 |

**Absorbed detail.** `WS-CS-HB-persona-roster` contributes four columns and one warning. The pod
structure (coherence / domain / reviewer-proxy / audit) is column 2; *whose judgement does this
proxy* is column 3; the scope boundary it must not cross is column 10; the required output format
is column 12. Its warning — that the book's own eleven editorial personas are the roster for
writing a book, not a template for an engineering org — prints as a standing note on the roster
sheet: the **pod structure ports, the personas do not**.

**Matched pair — this column cannot drift.** Column 8 and the capability column of
`WS-13-agent-authority-matrix` are one field printed on two sheets. The canvas is the single
source of truth, because the canvas is the thing that becomes a `tools:` frontmatter list in a
real file; the matrix transcribes it. Enforce this three ways: give the authority matrix a
`Source persona` column pointing back at column 1; print column 14 on this sheet pointing forward;
and print the same one-line rule on both — *if these two lists differ, the canvas is right and the
matrix is stale.* A difference is a defect logged against the matrix, never silently harmonised.

**Deliberate omission.** No effectiveness, maturity or quality score per persona. The book's only
test of whether a persona deserves to exist is behavioural — repeated corrections observed in real
work (ch12 L122) — and that evidence lives in column 15. A score column would let the room rate
personas it has never run.

## 6. Absorbed members (1)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-CS-HB-persona-roster` - Agent Persona Roster and Pod Map

- **Address.** `case-study-handbook-writing.qmd` L33-74, Team Topology: 11 Personas, Four Pods (`#sec-cs-handbook-topology`)
- **Why folded.** The same roster instrument; contributes the pod structure (coherence / domain / reviewer-proxy / audit) and the 'whose judgement does this proxy' column, plus the warning not to copy the book's editorial personas.
- **Fill detail to absorb.** One row per planned persona: persona name, the pod it belongs to (editorial/coherence, domain expert, reviewer proxy, audit), the real human whose judgement it proxies, the scope boundary it must not cross, and its required output format.
- **Its output was.** A named agent team roster mapped onto the real org chart, with an owner per persona.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- None. This sheet can be filled cold.

**Consumed by:**

- `WS-CS-HB-review-loop` - Review Loop Design Canvas (Pack Z - Second wave: the practitioner kit, fill order 13)

**Feeds into (prose, from the source scan).** WS-05-decision-rights-gate-matrix

## 8. Facilitation

| | |
|---|---|
| Who fills it | The architect or tech lead who will actually author the `.agent.md` files, with one senior engineer per proposed domain. Column 7 needs whoever was on the team when the mistakes happened — without them the anti-patterns column fills with plausible rules nobody has ever needed. |
| When in the session | Opens Pack Z (fill order 1, no prerequisites). Run it **before** `WS-13-agent-authority-matrix`, never after: the canvas authors the tool list the matrix audits, and reversing the order lets the matrix invent capabilities no persona file carries. |
| Duration | 90 minutes for three to five personas — roughly 20 minutes per canvas plus 20 to size and prune the roster. The anti-patterns column is the slow one; it is the only column that requires the room to remember rather than decide. |
| Data needed in advance | The last two or three months of agent corrections — PR comments, session transcripts, the "we had to tell it that again" list. The harness's literal tool vocabulary (the exact strings that go in `tools:`). The repository directory map, for column 10. The org chart, for column 3. |
| Room format | One A3 canvas per persona, all of them on one wall at once, plus a projected roster table. Overlap between two personas is only visible side by side; a persona reviewed alone always looks necessary. |

**Facilitation note — Pack Z prerequisite condition.** This is a second-wave sheet and it degrades
badly when run too early. It can technically be filled cold, but column 15 asks for *observed
repeated corrections*, and an organisation a fortnight into agentic work has none. Where that is
the case, the correct output is the book's starting three (architect, core-domain expert,
documentation writer, ch12 L122) and nothing more — a three-row roster with an empty
evidence column is the honest answer, not a thin one. Book the fourth and fifth canvases for a
later session and name the trigger: the first correction logged twice.

**Second note, carried from the case study.** Do not transplant the book's own eleven editorial
personas. They are the roster for writing a book. The four-pod structure ports; the personas
themselves do not, and a roster that contains a "Chief Editor" for a payments platform is a sign
the room copied rather than designed.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **The roster is three to five personas, or the sheet says why it is not.** More than five on day
   one means the room designed specialisations it has not yet needed; fewer than three usually
   means a domain expert was skipped. Either is allowed, neither is allowed silently (ch12 L122).
2. **Every column-4 sentence names a framework, a library, a layer or a file scope.** No persona
   reads "expert *language* developer" — that is the book's own printed example of a description
   too broad to constrain anything (ch12 L117).
3. **Every `You Never` line in column 6 carries a dated incident in column 7.** A line with no
   incident behind it is a preference, not institutional memory. Strike it or find the incident;
   the book's whole claim for this column is that each item cost the team time at least once
   (ch12 L119).
4. **No tool whitelist contains a wildcard, and every persona has a file-path boundary.** Column 8
   is an explicit list; column 10 is an explicit directory list. These are PROSE S1 and S3 and they
   are checked again on `WS-13-prose-readiness-assessment` — the two sheets must agree.
5. **The canvas and `WS-13-agent-authority-matrix` reconcile row for row.** Every persona in
   column 1 appears in the matrix, and column 8 is character-identical to the matrix's capability
   column. Any difference is written up as a matrix defect, with a date and an owner; it is never
   resolved by editing whichever sheet is closer to hand.
6. **Every persona names a living person in column 3 and an owner in column 16.** A persona that
   proxies "the security team" proxies nobody, and an unowned `.agent.md` is the file that drifts
   first.
7. **No persona is one of the book's eleven editorial personas transplanted without a domain
   reason.** If one survives, the sheet records the reason it genuinely fits this org.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** The four elements are an unstructured numbered list; the worked Python Architect example gives the layout, so this is fast authoring rather than hard authoring.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> The four elements are a numbered list at lines 115-120 with no fillable structure — a clean implicit find. The worked Python Architect example at lines 84-111 (Design Philosophy / Patterns You Enforce / You Never) is literally the canvas layout and should be reproduced as the filled sample. The roster-sizing rule is at line 122: start with three to five (an architect, a domain expert for core business logic, a documentation writer), and add only when you observe repeated corrections. OVERLAP: the tool-boundary element is the capability column of WS-13-agent-authority-matrix — design them as a matched pair so the persona canvas and the authority matrix cannot drift. The annotated session at lines 605-713 shows a real auth-expert.agent.md being created and corrected mid-session; use it as the "this is what filled-in looks like" exhibit.
