# Instantiate the Reference Architecture: Our Skill / Persona / Context Canvas

`WS-22-recursive-architecture-canvas` &middot; **Pack Z - Second wave: the practitioner kit** &middot; fill order **12** &middot; type `canvas` &middot; audience **architect** &middot; leadership priority **1**

> **Split back out in the re-opening pass.** A two-column today/target canvas for one flagship workflow plus an explicit gap list; it nests inside the five-layer canvas ('opens one cell' of it) and is the declared prerequisite of the recursion-bounds sheet.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A filled two-column canvas (current state versus target state) for one flagship workflow, plus the explicit gap list between the columns.

**Cluster.** `CL-RECURSIVE-CANVAS` - Recursive Architecture Canvas: One Workflow, Today and Target

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch22-the-reference-architecture-earned.qmd` |
| Chapter | The Reference Architecture, Earned |
| Heading | Composition is recursive |
| Stable anchor | `#sec-recursion-mechanics` |
| Lines | L15-113 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch22-the-reference-architecture-earned.html#sec-recursion-mechanics> |
| Locator quote | "The five-layer picture from Chapter 4 (@fig-five-layers) names the vocabulary." |

Resolve at any time with `python docs/resolve.py ws WS-22-recursive-architecture-canvas`.

## 3. Source extract - the scaffolding, verbatim

```text
   15 | The five-layer picture from Chapter 4 (@fig-five-layers) names the vocabulary. It does not yet name the property of the system that carries the most weight at scale, which is this: the same Skill–Persona–Context triplet repeats at every depth. A Skill dispatches Personas. A Persona, in its own thread, may dispatch further Skills. Each of those Skills may dispatch further Personas. One composition rule, applied many times, is the whole shape.
   16 | 
   17 | The figure below is that rule applied once, with Maya's PR substituted for the variables. The team's Agentic SDLC sits at the top of the frame; the `Review` phase is the cell the team is currently in, and that phase triggers the top-level Skill, `payments-review v2.3.0`. From the Skill downward, the recursion takes over — Personas, then Context, then (via the subagent thread from `Security`) the same shape one frame deeper, with `CVE Triage v1.4.2` and its own Personas and Context — all of it still inside the same `Review` phase. The substrate row at the foot of the frame names the three layers of @fig-five-layers that carry this structure but are not the subject of this chapter. It is the bridge to the manifest below, because the manifest is what makes the recursion declarable on disk.
   18 | 
   19 | ::: {.content-visible unless-format="pdf"}
   20 | 
   21 | ```{mermaid}
   22 | %%| label: fig-recursion-maya
   23 | %%| fig-cap: "Maya's PR #4711. The team's Agentic SDLC sits at the top; the Review phase triggers the payments-review Skill, which dispatches Personas against Context. The same Skill→Persona→Context shape repeats at depth two when the Security Reviewer dispatches CVE Triage inside the same Review phase."
   24 | %%| fig-alt: "A top-to-bottom diagram. At the top is the team's Agentic SDLC band, showing seven sequential phases — Spec, Plan, Build, Test, Review, Refine, Release. Six are dimmed; only the Review phase is highlighted, signalling that Maya's entire example occupies one cell of the lifecycle. Below the Review cell, the diagram zooms in: depth one names the Skill that the Review phase triggers — payments-review v2.3.0 (SKILL.md · PR #4711) — followed by two horizontal bands. The Persona Pool band contains six named lenses the Skill dispatches in parallel subagent threads: Tech Lead, Senior Backend Engineer, Security Reviewer, Accessibility Reviewer, Documentation Editor, Product Reviewer. The Context Pool band contains six named sources grouped by access mechanism: the diff via git, the codebase as files, security policies as files in the policy repo, the linked Jira ticket via the Jira MCP server, the originating RFC fetched from the wiki, and any Figma frames loaded as multi-modal artefacts. A solid edge labelled 'subagent thread' descends from the Security Reviewer Persona into a depth-two frame — CVE Triage v1.4.2 (SKILL.md) — which has the same two bands at smaller scale: two Personas, Threat Modeller and Compliance, and two context sources, the public CVE advisory feed via web fetch and the organisation's allow-list policy as files. The depth-two bands use the identical colour palette as depth one, demonstrating that the same Skill→Persona→Context composition rule is being applied a second time at greater depth, all still within the Review phase. A substrate row at the foot names the lower three layers from Chapter 4 — Agent Harness, Governance and Distribution, and Platform — that carry the visible structure."
   25 | %%{init: {'theme':'base','themeVariables':{'fontSize':'16px','fontFamily':'Helvetica, Arial, sans-serif'}}}%%
   26 | block-beta
   27 |   columns 3
   28 | 
   29 |   L0H["AGENTIC SDLC — the team's lifecycle"]:3
   30 |   SPEC["Spec"] PLAN["Plan"] BUILD["Build"]
   31 |   TEST["Test"] REVIEW["Review"] REFINE["Refine"]
   32 |   RELEASE["Release"] sA["&nbsp;"] sB["&nbsp;"]
   33 | 
   34 |   GAP0["▼ Review triggers"]:3
   35 | 
   36 |   D1H["DEPTH 1 — payments-review v2.3.0
   37 | (SKILL.md · PR #4711)"]:3
   38 | 
   39 |   L2HA["PERSONA POOL — 6 .agent.md files"]:3
   40 |   P_TL["Tech Lead"] P_BE["Backend"] P_SR["Security"]
   41 |   P_AX["A11y"] P_DE["Docs"] P_PR["Product"]
   42 | 
   43 |   L3HA["CONTEXT POOL — 6 sources"]:3
   44 |   C_DIFF["Diff (git)"] C_CODE["Code"] C_POL["Policy"]
   45 |   C_JIRA["Jira (MCP)"] C_RFC["RFC (web)"] C_FIG["Figma"]
   46 | 
   47 |   GAP1["&nbsp;"]:3
   48 | 
   49 |   D2H["DEPTH 2 — CVE Triage v1.4.2
   50 | (SKILL.md · same shape, deeper · still inside Review)"]:3
   51 | 
   52 |   L2HB["PERSONA POOL — 2 .agent.md files"]:3
   53 |   P_TM["Threat Modeller"] P_CC["Compliance"] sC["&nbsp;"]
   54 | 
   55 |   L3HB["CONTEXT POOL — 2 sources"]:3
   56 |   C_FEED["CVE feed (web)"] C_AL["Allow-list (files)"] sD["&nbsp;"]
   57 | 
   58 |   GAP2["&nbsp;"]:3
   59 | 
   60 |   SUB["SUBSTRATE (Ch. 4) — lower three layers
   61 | Agent Harness · Governance · Platform"]:3
   62 | 
   63 |   P_SR --"subagent thread"--> D2H
   64 | 
   65 |   classDef bandlabel fill:#ffffff,stroke:#cfcfcf,color:#444,font-weight:bold
   66 |   classDef depthlabel fill:#eaeaea,stroke:#666,color:#000,font-weight:bold
   67 |   classDef lifecycle fill:#eef6ff,stroke:#3a6ea5,color:#000
   68 |   classDef persona   fill:#fff8e0,stroke:#a8862c,color:#000
   69 |   classDef context   fill:#eef9ee,stroke:#3a8a3a,color:#000
   70 |   classDef dim       fill:#f4f4f4,stroke:#bdbdbd,color:#6b6b6b,stroke-dasharray:3 3
   71 |   classDef gap       fill:#ffffff,stroke:#ffffff,color:#ffffff
   72 |   classDef arrowhint fill:#ffffff,stroke:#ffffff,color:#3a6ea5,font-style:italic
   73 |   classDef substrate fill:#e4e4ea,stroke:#7d7d86,color:#3a3a3a
   74 | 
   75 |   class D1H,D2H depthlabel
   76 |   class L0H,L2HA,L3HA,L2HB,L3HB bandlabel
   77 |   class REVIEW lifecycle
   78 |   class SPEC,PLAN,BUILD,TEST,REFINE,RELEASE dim
   79 |   class P_TL,P_BE,P_SR,P_AX,P_DE,P_PR,P_TM,P_CC persona
   80 |   class C_DIFF,C_CODE,C_POL,C_JIRA,C_RFC,C_FIG,C_FEED,C_AL context
   81 |   class sA,sB,sC,sD gap
   82 |   class GAP1,GAP2 gap
   83 |   class GAP0 arrowhint
   84 |   class SUB substrate
   85 | ```
   86 | 
   87 | :::
   88 | 
   89 | ::: {.content-visible when-format="pdf"}
   90 | 
   91 | ![Maya's PR #4711. The team's Agentic SDLC sits at the top; the Review phase triggers the payments-review Skill, which dispatches Personas against Context. The same Skill→Persona→Context shape repeats at depth two when the Security Reviewer dispatches CVE Triage inside the same Review phase.](../assets/ch21-fig-recursion-maya.png){#fig-recursion-maya fig-alt="A top-to-bottom diagram showing the Agentic SDLC band at top with seven phases (Spec, Plan, Build, Test, Review, Refine, Release; only Review highlighted), then a depth-one frame for payments-review v2.3.0 with Persona Pool (Tech Lead, Backend, Security, A11y, Docs, Product) and Context Pool (Diff, Code, Policy, Jira, RFC, Figma), a subagent-thread arrow from Security to a depth-two frame for CVE Triage v1.4.2 with two Personas and two context sources, and a Substrate row naming Agent Harness, Governance, and Platform." width=100%}
   92 | 
   93 | :::
   94 | 
   95 | The figure opens one cell of Chapter 4's five-layer picture. The Agentic SDLC band at the top is `SDLC Phases`, with `Review` highlighted as the cell Maya's example occupies. Everything below the `▼ Review triggers` arrow — the Skill, its Personas, its Context, and the depth-two repetition — is what `Context & Capabilities` looks like once a phase has fired. The substrate row at the foot is the rest of the stack at work: the version pins (`v2.3.0`, `v1.4.2`) are `Governance & Distribution` doing its job; the `subagent thread` edge from Security Reviewer to CVE Triage is the `Agent Harness` doing its; every file behind every band lives on the `Platform`. The next snippet is how the cell is declared on disk. A Skill bundle's manifest names the nested Skills it depends on the same way any other package names the packages it depends on:
   96 | 
   97 | ```yaml
   98 | # packages/payments-review/apm.yml
   99 | name: payments-review
  100 | version: 2.3.0
  101 | description: Multi-lens code review for the payments service.
  102 | author: payments-platform
  103 | dependencies:
  104 |   apm:
```

*(9 further lines in range; read the file for the remainder.)*

## 4. What the user fills

Pick one real workflow and fill the canvas TWICE -- a today column and a target column: which SDLC phase triggers it, the top-level Skill and its pinned version, every Persona it dispatches, every Context source with its access mechanism named explicitly (file / git / CLI / MCP server / fetched URL / multi-modal artefact), where recursion fires and to what depth, what artefact each level returns, and what the single human finally reads.

## 5. Field-level schema

**Canvas layout — this is a two-column canvas, and the layout is load-bearing.** One sheet, A1 or A0
landscape (or a digital board at equivalent size), for **one** flagship workflow. The sheet is split
vertically into two equal columns — **TODAY** on the left, **TARGET** on the right — with a narrower
third strip down the right-hand edge headed **GAP**. Horizontally it is banded: the workflow header,
then a depth-1 band (Skill / Persona pool / Context pool), then a depth-2-and-deeper band, then the
return band (artefacts, synthesis, the single human read), then the substrate footer. Every field
below is filled **twice**, once in each column; the GAP strip carries one entry for every band where
the two columns differ. A canvas with a rich TODAY column and a sparse TARGET column is half an
instrument; a canvas with no GAP entries is two descriptions rather than a plan.

Maya's PR #4711 is printed **beside** the canvas as a fully worked exemplar column, greyed and
clearly outside the fill area — never inside it. It is the thing the facilitator walks the room
through before anyone writes.

| # | Field (filled once per column) | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Workflow | `free text` | — | One real workflow, named. Not a category of work | ch22 L17 |
| 2 | SDLC phase that triggers it | `select` — Spec / Plan / Build / Test / Review / Refine / Release | The seven phases, printed as a band with one cell highlightable | Highlight exactly one | ch22 L29-32 |
| 3 | Trigger event | `free text` | Exemplar: a label applied to a PR, picked up by a CI watcher | The team's actual event | ch22 L129 |
| 4 | Top-level Skill | `free text` | — | Bundle name as it resolves | ch22 L36-37 |
| 5 | Version pin | `free text` | — | The exact pin. A TARGET-column Skill with no pin is an intention | ch22 L95 — the pins are Governance doing its job |
| 6 | Resolved from | `free text` | — | Registry and lockfile path | ch22 L106-108 |
| 7 | Personas dispatched | `free text`, one per line | Exemplar names six lenses: Tech Lead, Backend, Security, A11y, Docs, Product | The team's own lenses | ch22 L39-41 |
| 8 | Persona file location | `free text` | Exemplar: `.agent.md` files inside the bundle | Path per Persona | ch22 L106 |
| 9 | Context sources | `free text`, one per line | Exemplar names six: diff, codebase, policy, ticket, RFC, design frames | The team's own sources | ch22 L43-45 |
| 10 | **Access mechanism, per context source** | `select` — `file` / `git` / `CLI` / `MCP server` / `fetched URL` / `multi-modal artefact` | The six mechanisms, printed as the only permitted answers | One per source in row 9. Mandatory; see the note below | ch22 L188 |
| 11 | Where recursion fires | `free text` | Exemplar: the Security Reviewer dispatches CVE Triage on a dependency bump | Which Persona dispatches which nested Skill, and on what condition | ch22 L63, L132 |
| 12 | Nested Skill + pin | `free text` | — | One line per nested Skill | ch22 L49-50 |
| 13 | Depth reached | `select` — `1` / `2` / `3+` | — | The deepest dispatch in this workflow | ch22 L15 |
| 14 | Artefact returned, per level | `free text` | — | **One** artefact per level. Consumed directly by `WS-22-recursion-governance-bounds` | ch22 L123 |
| 15 | Synthesiser | `free text` | Exemplar: a Tech Lead Persona structured to preserve dissent rather than average it | Who or what composes the verdicts | ch22 L158 |
| 16 | What the single human reads | `free text` | Exemplar: one verdict comment, not eight threads | The one artefact a human actually opens | ch22 L182 |
| 17 | Who that human is | `owner (named person)` | — | A person, in both columns | derived |
| 18 | Persisted-trail location | `free text` | Exemplar directory layout printed: a run-scoped folder holding the plan, one file per Persona, a `nested/` folder, the synthesis and a lockfile snapshot | The team's own path and structure | ch22 L172-181 |
| 19 | Substrate — harness | `free text` | Named in the exemplar's footer band | Which harness carries the subagent threads | ch22 L60-61, L95 |
| 20 | Substrate — governance and distribution | `free text` | — | What pins the versions and owns the bundles | ch22 L95 |
| 21 | Substrate — platform | `free text` | — | Where the files live | ch22 L95 |
| 22 | Owner of this band's target state | `owner (named person)` | — | TARGET column only. One per band, not one per canvas | derived |

**The GAP strip — its own small schema.** One entry per band where TODAY and TARGET differ.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| G1 | Band | `select` (the canvas bands) | — | Which band this gap sits in | derived |
| G2 | The gap, in one line | `free text` | — | What is true on the left and not on the right | derived |
| G3 | Owner | `owner (named person)` | — | Who closes it | derived |
| G4 | Sequenced into | `free text` | — | Which delivery increment. A gap with no increment is an observation | ch22 §12 — feeds the first delivery increment |

**Row 10 is the row that earns the canvas.** The chapter names treating MCP as the architecture,
rather than as one access mechanism sitting in the Context half of the triplet alongside files, CLI
invocations, fetched URLs and multi-modal artefacts, as "the most common shape of mistake an
architect new to this substrate makes". Forcing a mechanism to be named per source, from a closed
list, defuses it by construction: a team that has written `MCP server` beside two of nine sources
cannot also believe MCP is the substrate. Do not allow a free-text answer here.

**Absorbed detail.** None — this sheet absorbed no other candidate. It **nests** rather than
duplicates: `WS-04-five-layer-supply-chain-canvas` is the outer canvas, and this chapter states
explicitly that its figure opens one cell of that five-layer picture. Ship them as a matched pair,
Ch04's canvas first. Rows 19-21 here are that canvas's lower three layers, and the TARGET column of
this sheet inherits from it — where the two disagree about the harness, the registry or the platform,
the outer canvas wins and the difference is a GAP entry, not a local decision.

**Deliberate omission.** No maturity score, no percentage-complete and no rating of the TODAY column.
The instrument is the distance between two columns and the list in the GAP strip; a score would
invite the room to argue about the number instead of writing the gaps. Equally, no token, cost or
duration figures anywhere on the canvas — those belong to `WS-15-context-budget-allocation` and
`WS-22-recursion-governance-bounds`, and putting them here would duplicate two sheets and disagree
with both.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-21-primitive-governance-policy` - Primitive Supply Chain: Registry, Pinning, Versioning and Ownership Decisions (Pack Z - Second wave: the practitioner kit, fill order 3)

**Consumed by:**

- `WS-22-recursion-governance-bounds` - Bounding the Recursion: Eval, Plan Persistence and Depth Limits per Skill (Pack Z - Second wave: the practitioner kit, fill order 16)

**Feeds into (prose, from the source scan).** WS-22-recursion-governance-bounds, WS-06-role-map-and-staffing-triggers, and the first delivery increment of the transformation roadmap

## 8. Facilitation

| | |
|---|---|
| Who fills it | The architect who owns the workflow, an engineer who actually runs it today, and whoever owns the primitives it loads. The TODAY column needs someone who has watched the thing run; the TARGET column needs someone who can commit to changing it. Expect to need people from outside the team for row 9 — the ticket system, the policy repository and the wiki usually belong to somebody else, and row 10 cannot be filled honestly without them. This is why the fill effort is L. |
| When in the session | Pack Z, after `WS-21-primitive-governance-policy` — the registry, pinning and ownership decisions are what make rows 5 and 6 answerable. Run it as the **zoom** into `WS-04-five-layer-supply-chain-canvas`: that outer canvas first, this one second, on the same wall if possible. The condition that makes it worth running: the organisation has chosen its flagship workflow and at least some of it already runs. A canvas whose TODAY column is entirely empty is not a today column, it is a second target column with a different heading. |
| Duration | Half a day — three to four hours for one workflow — and it does not compress. The TODAY column is researched, not recalled: most rooms discover during row 9 that nobody present can list every context source the workflow loads, and finding out is the work. Budget the last 45 minutes for the GAP strip, which teams otherwise run out of time for and which is the only part that produces a plan. |
| Data needed in advance | The real repository and the workflow's current configuration; the lockfile, so rows 5 and 6 carry actual pins; a list of every context source the workflow touches **and who owns each one**, gathered before the session; the completed `WS-04-five-layer-supply-chain-canvas` so the TARGET column can inherit its substrate rows; and the completed `WS-21-primitive-governance-policy`. |
| Room format | A large printed canvas or a digital board, two columns plus the GAP strip, with Maya's PR printed as a separate greyed exemplar beside it. Sticky notes for rows 7, 9 and 12 so the room can move Personas and sources between columns. Photograph the board before anyone transcribes it; the argument about which column a source belongs in is the part that gets lost in transcription. |

**Facilitation note — there is a script, and it is in the chapter.** Do not start by asking the room
about its own workflow. Start by walking Maya's PR #4711 end to end through the chapter's seven
numbered steps: **Trigger** (a label applied, a watcher picks it up, the Skill resolves from the
lockfile), **Load** (six Personas, six context sources, each with its access mechanism named),
**Fan out** (six subagent threads that cannot see each other), **Recursion fires** (the Security
Reviewer meets a dependency bump and dispatches a nested Skill in a fresh thread), **Verdicts
return** (one line each, dissent preserved rather than averaged), **Synthesise** (one comment, with
the request-changes surviving), and **the human reads one comment and acts**. Only then hand out the
canvas and ask them to substitute their own workflow into the same shape. Teams that fill the canvas
cold produce a box diagram of their current tooling; teams that have been walked through the exemplar
first produce a recursion.

Two things to keep saying while they fill. First, row 10 is not optional and not free text — see the
schema note. Second, the recursion is *invisible from above and inspectable from below*: row 16 has
exactly one entry, and row 18 is what makes that acceptable. A team that fills row 16 with three
artefacts has not built a panel, it has built a meeting.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **Exactly one workflow, and both columns are filled for every band.** Not a family of workflows,
   not "code review generally". A TARGET column with empty bands is a wish list; a TODAY column with
   empty bands means the canvas was filled from intent rather than from observation.
2. **Every context source in row 9 has an access mechanism in row 10, chosen from the closed list, in
   both columns.** No blanks and no free-text answers. A source whose mechanism nobody in the room
   can name is itself a finding and belongs in the GAP strip.
3. **MCP appears only as a value in row 10, never in rows 4, 19, 20 or 21.** If the TARGET column
   names an MCP catalogue as the harness, the governance layer or the substrate, the canvas has
   reproduced the chapter's most common architect error and must be redrawn before it is signed off.
4. **Every GAP entry has an owner and a delivery increment.** A gap with neither is an observation
   the room made and nobody will act on, and the strip's whole purpose is to be the place that cannot
   happen.
5. **Recursion is shown at least once in the TARGET column, or the canvas states in writing why this
   workflow is depth-1 in target as well as today.** Depth-1 is a legitimate answer; an unexamined
   depth-1 is the canvas failing to ask its own question.
6. **Rows 14 and 18 are filled for every level in the TARGET column** — one artefact per level, and a
   persisted-trail path. These are the two fields `WS-22-recursion-governance-bounds` consumes
   directly; a blank in either blocks that sheet, and a row 14 entry naming two artefacts makes the
   level unboundable in space.
7. **Reconciliation with `WS-04-five-layer-supply-chain-canvas`: rows 19-21 of the TARGET column
   match the outer canvas's lower three layers.** Where they diverge, the outer canvas wins and the
   difference is recorded as a GAP entry rather than silently decided here. Every Skill pinned in
   rows 5 and 12 of the TARGET column also resolves against the registry defined in
   `WS-21-primitive-governance-policy`; one that does not is a dependency on a bundle nobody governs.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** The content is locked in a rich mermaid figure and must be de-instantiated into a two-column canvas; the seven-step walkthrough supplies the facilitation script.
- **Fill (the organisation completing it): `L`.** L - needs the real repository, finance input or cross-team agreement

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> This answers the brief's anticipated target-versus-current comparison by making it TWO COLUMNS OF ONE CANVAS rather than two competing worksheets -- deliberate, and worth preserving in synthesis. Two locations: the recursion rule and @fig-recursion-maya at 15-95, and "A Panel, walked end to end" at 129-182, whose seven numbered steps (Trigger, Load, Fan out, Recursion fires, Verdicts return, Synthesise, human reads one comment and acts) are the facilitation SCRIPT for filling the canvas -- walk the room through Maya's PR #4711, then have them substitute their own workflow. The MCP caution at 188 belongs on the Context-source row and should be enforced by the fill: forcing the team to name the access mechanism per source directly defuses what the chapter calls "the most common shape of mistake an architect new to this substrate makes". The persisted-trail directory layout at 172-181 gives the target column a concrete artefact to aim at. Effort L -- honest completion needs cross-team input. The figure is rich; the canvas is a straightforward de-instantiation of it. NESTING, NOT DUPLICATION: WS-04-five-layer-supply-chain-canvas (Ch04, p1) is the outer canvas; this chapter states explicitly at 107-109 that its figure "opens one cell" of Ch04's five-layer picture. Ship them as a matched pair -- Ch04 canvas first, this one as the zoom into a single chosen workflow -- and make the target column of this one inherit from Ch04's.
