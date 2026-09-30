# Agent Team Charter: Mapping Concerns Onto Owners

`WS-17-agent-team-charter` &middot; **Pack Z - Second wave: the practitioner kit** &middot; fill order **18** &middot; type `canvas` &middot; audience **architect** &middot; leadership priority **2**

> **Split back out in the re-opening pass.** Maps each concern onto an agent team AND onto the human team that owns the same concern today -- a Conway's-law mapping the persona canvas never asks; already a declared prerequisite of WS-18-plan-charter-and-principles.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A set of agent team charters aligned to the org's real concern ownership - and, as a by-product, an explicit map of which existing conventions are written down and which live only in people's heads.

**Cluster.** `CL-AGENT-TEAM-CHARTER` - Agent Team Charter: Concerns onto Owners

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch17-multi-agent-orchestration.qmd` |
| Chapter | Multi-Agent Orchestration |
| Heading | Pattern 2: Domain Teams |
| Stable anchor | `#sec-multi-agent-domain-teams` |
| Lines | L77-87 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch17-multi-agent-orchestration.html#sec-multi-agent-domain-teams> |
| Locator quote | "For cross-cutting changes, organize agents by area of expertise rather than" |

Resolve at any time with `python docs/resolve.py ws WS-17-agent-team-charter`.

## 3. Source extract - the scaffolding, verbatim

```text
   77 | For cross-cutting changes, organize agents by area of expertise rather than by workflow stage. Each team owns a concern and is responsible for all files related to that concern.
   78 | 
   79 | | Aspect | Architecture Team | Domain Expert Team |
   80 | |--------|-------------------|---------------------|
   81 | | **Context loaded** | Type definitions, Module boundaries, Pattern catalog, Dependency graph | Output conventions, Symbol dictionaries, UX guidelines, Migration patterns |
   82 | | **Owns** | Type safety fixes, Dead code removal, API consolidation | Verbose coverage, Logger migration, Formatting cleanup |
   83 | 
   84 | In the auth-logging overhaul ([PR #394](https://github.com/microsoft/apm/pull/394), detailed in the [case study](../case-study-apm-overhaul.qmd) and summarized in Chapter 18), this two-team structure (architecture team led by an architect agent, domain team led by a logging expert agent) handled a 75-file change across five concerns. The architecture team carried type definitions and architectural patterns. The domain team carried output conventions and migration examples. Neither team needed the other's context, and both produced output consistent with their specialization.
   85 | 
   86 | This pattern scales by adding teams. A security concern adds a security team. A documentation concern adds a documentation team. Each team brings its own specialized context, its own instruction files, and its own validation criteria. The coordination cost is between teams, not within them.[^ch15-genesis-panel]
   87 | 
```

## 4. What the user fills

One column per agent team the org will define. Rows: the concern it owns, the human team or guild that owns the same concern today, the context it loads (which instruction files, conventions, catalogues, dictionaries), the file or module territory it owns, its validation criteria, and the named human sponsor who maintains its instruction files.

## 5. Field-level schema

The sheet is **transposed**, matching the book's own layout at ch17 L79-82: each field below is
printed as a **row**, and each agent team the organisation defines is a **column**. One A1 sheet or
whiteboard panel per exercise, teams side by side, so that the disjointness of territory at field 9
is visible at a glance rather than discovered at dispatch. The schema table lists the fields in
printed order; read "Column" as "the field, printed as a row".

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Team name | `free text` | Two starting teams: Architecture Team, Domain Expert Team. The chapter names Security and Documentation as the scaling examples | The org's own team names, and any further teams it adds | ch17 L79-82, L86 |
| 2 | Concern owned | `free text` | Architecture: type safety fixes, dead code removal, API consolidation. Domain: verbose coverage, logger migration, formatting cleanup | The org's actual concerns, in its own vocabulary | ch17 L82 |
| 3 | Human team or guild that owns this concern today | `free text` | — | The real org-chart answer, or `unowned` — never left blank | ch18 L320 (Conway footnote) |
| 4 | Named human sponsor who maintains this team's instruction files | `owner (named person)` | — | An individual. Instruction files decay without a maintainer | ch17 L86 "its own instruction files" |
| 5 | Context loaded — one line per item | `free text` (list) | Architecture: type definitions, module boundaries, pattern catalogue, dependency graph. Domain: output conventions, symbol dictionaries, UX guidelines, migration patterns | The org's equivalents, named individually rather than as a category | ch17 L81 |
| 6 | **Written down?** — per context item at field 5 | `select` written / partial / unwritten | — | The honest state of each item. This is the discovery column | derived from ch17 L81 |
| 7 | Where it lives, or where it must be created | `free text` (path) | — | An existing repository path for `written`; a target path for `partial` and `unwritten` | org |
| 8 | Who writes the missing one | `owner (named person)` | — | Required wherever field 6 reads `partial` or `unwritten` | org |
| 9 | File or module territory owned | `free text` (paths or globs) | — | Must be disjoint across every team column | ch17 L77 "responsible for all files related to that concern" |
| 10 | Validation criteria | `free text` (runnable command) | The chapter's requirement: each team brings "its own validation criteria" | The actual command this team's output must pass | ch17 L86 |
| 11 | Coordination interface with other teams | `free text` | Pre-printed: "The coordination cost is between teams, not within them" | What this team hands to, or receives from, each other team | ch17 L86 |
| 12 | Does this team need another team's context? | `checkbox` (expected unticked) | Pre-printed: in the reference two-team structure, "Neither team needed the other's context" | A tick is a signal the concern split is wrong, not a note | ch17 L84 |
| 13 | Charter sponsor signature + date | `signature` | — | Field 4's holder, signing to maintain | org |
| — | **Instrumentation backlog** | `computed` (list, not a score) | — | Every field-5 item marked `partial` or `unwritten`, with its field-7 target path and field-8 owner, collated across all team columns | derived |

**The backlog is the deliverable, not a by-product.** The computed row above is a named output of
this worksheet and must be printed as a separate block at the foot of the sheet with space to write,
not left as an idea. A team cannot list the context an agent loads for a concern that has never been
written down; the cells it cannot fill *are* the instrumentation gap, and that list is the line a
transformation plan must fund. Facilitators should expect field 6 to stall the room, and should
treat the stall as the exercise working. Do not accept "tribal knowledge" or "it's in people's
heads" as a terminal answer in field 5 — that answer is `unwritten` at field 6, with a path at 7 and
a name at 8.

**Deliberate omission.** No agent-count, dispatch-count or team-size field. Agent counts are a
property of a specific wave and belong to `WS-18-wave-decomposition-plan`, where they are computed
against a ceiling the team measures for itself. Also omitted: the reference case's file and concern
figures. Printing "75 files across five concerns" beside a blank column would read as a scale a team
should match, and it is one project's shape.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-17-orchestration-topology-selector` - Orchestration Topology Selector: Which Patterns Do We Sanction? (Pack D - Architecture and ownership, fill order 6)

**Consumed by:**

- `WS-17-conflict-resolution-playbook` - Agent Conflict Playbook: File, Semantic, Design (Pack Z - Second wave: the practitioner kit, fill order 19)
- `WS-17-dispatch-brief-template` - Agent Dispatch Brief Template and Quality Check (Pack Z - Second wave: the practitioner kit, fill order 20)

**Feeds into (prose, from the source scan).** WS-17-dispatch-brief-template (charters supply the instruction-file list) and WS-18-plan-charter-and-principles (the Teams block of the plan).

## 8. Facilitation

| | |
|---|---|
| Who fills it | The architect or principal engineer who owns the codebase's module structure, one representative from each human team that owns a concern today, and whoever maintains whatever conventions already exist — the `AGENTS.md`, the wiki page, the style guide nobody has touched in a year. Field 3 cannot be answered by one person, and field 6 cannot be answered honestly by anyone who was not there when the convention was invented. |
| When in the session | Pack Z, straight after the plan gate. It runs after `WS-17-orchestration-topology-selector` from Pack D — that sheet sanctions Domain Teams as a pattern the org will use, this one instantiates it — and it must close before both `WS-17-conflict-resolution-playbook` and `WS-17-dispatch-brief-template`, which consume field 5 and field 9 directly. |
| Duration | 60-90 minutes for two or three teams. It runs longer than it looks, and the overrun is always field 6. Budget the stall rather than guillotining it: the minutes spent discovering that nobody can name the file where the error-handling convention lives are the highest-value minutes in the pack. |
| Data needed in advance | Whatever instruction and convention files the repository already has, gathered and listed — `.ai/` or equivalent, `CONTRIBUTING`, `AGENTS.md`, wiki pages, onboarding docs. A module or ownership map, or `CODEOWNERS` if one exists. The list of concerns in the chosen pilot. And an honest warning to the room that it will be asked which of its conventions are written down, so that nobody feels ambushed into defending a gap. |
| Room format | One A1 sheet or whiteboard panel per team, hung side by side, fields as rows. Not pre-work and not a document: the value is in two people discovering in the same minute that they believed different things about who owns a module. Photograph the wall before it comes down, then transcribe the instrumentation backlog into the transformation plan the same day. |

**Facilitation note carried from the source scan.** The highest-value side effect of this sheet is
the discovery of undocumented conventions, and it only happens if the facilitator refuses the easy
answer. When the room cannot fill a context cell, do not let it write "tribal knowledge" and move
on — mark it `unwritten`, demand a target path and a name, and keep going. Carry the Conway framing
explicitly (ch18 L320): agent team boundaries mirror module boundaries by design, not by accident,
so field 3 is not decoration — a concern whose agent team and human team disagree is a boundary the
org will fight at every wave. A lightweight version of this sheet, columns 1-3 only, works as an
exec-level Conway's-Law exercise in the pre-groundbreaking session if the full version cannot wait.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **Every team has a named individual at field 4**, not a function, a guild or a rota. Instruction
   files without a maintainer go stale silently, and a stale instruction file is worse than a
   missing one because agents load it with confidence.
2. **Every context item at field 5 carries a field-6 classification.** No blanks, and no cell whose
   terminal answer is "tribal knowledge", "it's obvious" or "in people's heads" — those are
   `unwritten`, and recording them as such is the point of the column.
3. **Every `partial` or `unwritten` item has a target path (7) and a named owner (8)**, and the
   collated instrumentation backlog has been physically handed to whoever funds the transformation
   plan before the pack closes. A backlog that stays on the wall was never a deliverable.
4. **Territories at field 9 are disjoint: no path or glob appears under two teams.** A charter that
   overlaps guarantees file conflicts before wave planning has even started, and those conflicts are
   planning errors rather than runtime ones — cheaper to fix here than anywhere downstream.
5. **Every concern at field 2 maps to a named human team at field 3, or is explicitly recorded as
   `unowned`.** An unowned concern is a finding to carry forward, not a cell to leave empty.
6. **Field 12 is unticked for every team**, or the room has written down why it is keeping a split
   whose teams need each other's context. In the reference structure neither team needed the
   other's; a tick means the concerns are entangled and the charter is describing a coordination
   problem rather than solving one.
7. **Field 10 names a runnable command for every team**, not a sentiment. "Code review" and "quality
   bar" are not validation criteria; a command with an exit status is.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** The two-column Context-loaded / Owns table already shows the shape and the PR #394 two-team structure is the worked instance.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> The brief's "role/team descriptions that need mapping onto a real org chart" case. Already partly structured: the two-column table at lines 79-84 shows the shape (Context loaded / Owns) for an architecture team and a domain expert team; the worked instance is the PR #394 two-team structure at line 86. The highest-value side effect of filling this in is the discovery of undocumented conventions - a team cannot list the context an agent loads for a concern that has never been written down, which is exactly the instrumentation gap a transformation plan must fund. Scored 2: it is instantiation work that needs a real codebase and cross-team input, so it belongs in the second wave rather than the pre-groundbreaking session - though a lightweight version (just the concern/owner columns) works as an exec-level Conway's-Law exercise. ch18 footnote ch13-conway makes the Conway framing explicit.
