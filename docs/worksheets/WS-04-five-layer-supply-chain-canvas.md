# Five-Layer Supply Chain Instantiation Canvas

`WS-04-five-layer-supply-chain-canvas` &middot; **Pack D - Architecture and ownership** &middot; fill order **2** &middot; type `canvas` &middot; audience **architect** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A marked-up five-layer diagram of the organisation actual capability supply chain, showing owned layers, gap layers, and the named owner of each.

**Cluster.** `CL-STACK-OWNERSHIP` - The Five-Layer Stack: What We Run, and Who Owns Each Layer

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch04-the-reference-architecture.qmd` |
| Chapter | The Agentic SDLC Reference Architecture |
| Heading | The Five-Layer Landscape: the AI-capability supply chain |
| Stable anchor | `#sec-ref-arch-five-layer` |
| Lines | L126-158 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch04-the-reference-architecture.html#sec-ref-arch-five-layer> |
| Locator quote | "The previous section told you *who participates* in the agentic SDLC" |

Resolve at any time with `python docs/resolve.py ws WS-04-five-layer-supply-chain-canvas`.

## 3. Source extract - the scaffolding, verbatim

```text
  126 | The previous section told you *who participates* in the agentic SDLC. This section tells you *what supply chain you architect across them* once your organisation runs more than one team using AI capabilities. The Three-Layer model is fine for one team and one tool; the moment a second team adopts a different runtime against the same source-control platform, against the same identity provider, with overlapping but non-identical knowledge bundles, you have a supply-chain problem.
  127 | 
  128 | ```{mermaid}
  129 | %%| label: fig-five-layers
  130 | %%| fig-cap: "The Five-Layer landscape, drawn as a supply chain. Each edge is the relationship the lower layer carries to the layer above. Platform at the bottom; SDLC phases at the top."
  131 | %%| fig-alt: "A bottom-to-top flowchart with five stacked layers. From bottom to top: Platform (cloud, source control, identity, audit substrate); Context and Capabilities (the AI capabilities your organisation authors and reuses, expressed as text and version-controlled with the rest of your code); Governance and Distribution (agent dependencies, registry, package manager, ownership); Agent Harness (the runtime application your developers and business users actually run); SDLC phases (Plan, Spec, Build, Review, Test, Deploy, Operate). Edges are labelled per layer: Platform hosts Context and Capabilities; Context and Capabilities is declared into Governance and Distribution; Governance and Distribution resolves and ships to the Agent Harness; the Agent Harness executes as SDLC phases."
  132 | %%| fig-width: 5.5
  133 | %%| fig-height: 6
  134 | flowchart BT
  135 |     L1["<b>Platform</b><br/>Cloud, source control,<br/>identity, audit substrate"]
  136 |     L2["<b>Context &amp; Capabilities</b><br/>The AI capabilities your<br/>organisation authors and reuses"]
  137 |     L3["<b>Governance and Distribution</b><br/>agent dependencies, registry,<br/>package manager, ownership"]
  138 |     L4["<b>Agent Harness</b><br/>The runtime your developers<br/>and business users run"]
  139 |     L5["<b>SDLC phases</b><br/>Plan, Spec, Build, Review,<br/>Test, Deploy, Operate"]
  140 | 
  141 |     L1 -- "hosts" --> L2
  142 |     L2 -- "declared into" --> L3
  143 |     L3 -- "resolves and ships" --> L4
  144 |     L4 -- "executes as" --> L5
  145 | ```
  146 | 
  147 | Read the diagram bottom-to-top. **`Platform`** is the cloud, source-control, identity, and audit substrate your platform team already operates. There is nothing agent-specific about it. **`Context & Capabilities`** is where the AI capabilities your organisation authors and reuses live — the procedures (how to review a pull request, how to draft an architecture decision record), the lenses (security reviewer, accessibility reviewer), and the knowledge bundles your teams ground agents against, all expressed as text, version-controlled with the rest of your code. **`Governance and Distribution`** is the catalogue and approval rules that ship those capabilities between teams: the declared agent dependencies, the internal registry the platform team operates, the package manager that resolves and installs, and the ownership rules that say who is allowed to approve a change. **`Agent Harness`** (an "agent runtime") is the runtime application your developers — and increasingly your business users — actually run. Different vendors, same load contract. **`SDLC phases`** is the application output: the runtime executes as a Plan step, a Spec step, a Build step, a Review step.
  148 | 
  149 | This is a *supply chain*, not a stack. The artefact that flows up the layers is the AI capability itself, behaving the way a software dependency behaves in the supply chain you already operate: declared by a consuming team, resolved against a registry, installed at a known version into a runtime, and replaced when a new version is published. The reason the cold open's seven-tool sprawl does not compound is that today, in most organisations, this supply chain does not exist. Every team's capabilities live inside their chosen runtime and travel only within that runtime's vendor boundary. The supply chain is what your enterprise has to architect for capabilities to compound across teams, across runtimes, and across the second and third year of the programme.
  150 | 
  151 | The platform-governance plane your enterprise already bought — the identity and data-governance controls your security and compliance functions have standardised on, regardless of vendor — covers the Platform layer cleanly. It is *necessary but not sufficient*. It does not cover layers two and three, because those layers concern a class of artefact that did not exist when those controls were procured: an AI capability authored by a team, declared as a dependency by a consuming team, resolved against a catalogue, and loaded into a runtime. That is the new investment, and it decides whether the supply chain is one you operate or one each vendor operates inside their own boundary.
  152 | 
  153 | This is also where the audit conversation lands. When a regulator or an internal auditor asks which AI capabilities ran in production last quarter and at what versions, the answer comes from the third layer. The auditable record of which AI capabilities ran in production, at what version, and with whose approval, lives at the `Governance and Distribution` layer — not at the runtime, which can change quarterly, and not at the platform, which knows about identity and access but not about which procedure an agent executed. That is the sentence to put on a slide for the next conversation with your CISO.
  154 | 
  155 | Two capabilities make this layer usable in practice rather than on paper: *discoverability* and *rollout*. A catalogue backed by an internal developer platform (IDP) lets a consuming team find the right capability instead of rebuilding it; vendor harness-managed settings let a platform team push an approved set to thousands of users without a migration project. A working, Microsoft-maintained reference implementation — a central catalogue, an IDP front end, and a package-manager release pipeline — exists in the [`zava-agent-config`](https://github.com/DevExpGbb/zava-agent-config) project; treat it as a reference point, not a turnkey product. How this same layer becomes the control point for *cost* — gating spend and distributing cost-effective workflows so the whole organisation reuses them — is the subject of the chapter on the agentic SDLC bill.
  156 | 
  157 | This chapter draws the architecture; it does not yet draw the mechanics. How a capability is declared, how versions are pinned, how the registry resolves transitive dependencies, how a runtime materialises a bundle into the directory layout it parses — all of that belongs to the practitioner block, where the architectural mechanics of how the supply chain composes are catalogued in detail. The governance overlay that sits on top of the Five-Layer landscape — who approves which capabilities, what evidence is captured at each step, how risk tiers map to release controls — is the subject of the next chapter.[^ch4-rosetta]
  158 | 
```

## 4. What the user fills

One block per layer (Platform; Context and Capabilities; Governance and Distribution; Agent Harness; SDLC phases). Per layer: the systems we already run that satisfy it, the named owning team, what is missing, whether it is bought / built / absent, and the cost of the gap. Two mandatory answer lines at the Governance and Distribution layer: who can answer which AI capabilities ran in production last quarter, at what version and with whose approval, and where that record lives.

## 5. Field-level schema

This is a large-format wall canvas, not a form. **Physical layout:** A0 or A1 landscape,
five horizontal bands stacked **bottom-to-top** in the order of @fig-five-layers — Platform at
the foot, SDLC phases at the head — with the book's edge label printed in the gutter *between*
bands (`hosts` → `declared into` → `resolves and ships` → `executes as`). Bands 2 and 3 are
tinted a different colour from the other three and carry a printed strip reading **"net-new
investment"**; band 1 carries **"already covered by the platform-governance plane you bought"**.
That tint is the argument of ch04 L151 made visible before anyone writes on it. Two vertical
cross-cutting bands run up the right-hand edge across all five layers. A glossary strip runs
along the top margin and the audit block sits in a boxed panel beside band 3.

Rows in the main canvas are the five layers. Rows 16-21 below are the cross-cutting bands and
the two footer blocks; rows 22-27 are the top-margin glossary strip.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Layer | `select` (fixed 5 bands, bottom-to-top) | Platform / Context & Capabilities / Governance and Distribution / Agent Harness / SDLC phases | — | ch04 L135-139 |
| 2 | Edge to the layer above | `free text` | hosts / declared into / resolves and ships / executes as (printed in the gutter, band 5 has none) | — | ch04 L141-144 |
| 3 | The layer's job | `free text` | One pre-printed sentence per band, taken from the chapter's own definitions | Edit only if the org rejects the definition | ch04 L147; ch09 L27-59 |
| 4 | Artefact on disk that proves it exists | `free text` | — | The actual repo, path, registry or system of record — not a description of one | ch09 L27-59 |
| 5 | Systems we already run that satisfy it | `free text` | — | Named products and services in use today, including the unsanctioned ones | org |
| 6 | Current state | `select` Exists / Partial / Absent | — | One per band; Partial requires column 12 to be filled | ch09 L27-59 |
| 7 | Owning team today | `free text` | Platform team (band 1); Domain Specialist (WHAT) + Agentic Workflow Engineer (HOW) (band 2); Platform team + Security/Compliance (band 3); Platform team (band 4); stream-aligned teams (band 5) | The org's real team names, overwriting the book's role labels | ch06 L120-152 |
| 8 | Named accountable individual | `owner (named person)` | — | A person. Never a function, a team or a role label | ch06 L120-152 |
| 9 | Bought / Built / Composed / Absent | `select` | — | The procurement posture for this band today | derived |
| 10 | Covered by the platform-governance plane we already bought? | `checkbox` | Pre-ticked for band 1 only | Confirm or override | ch04 L151 |
| 11 | Net-new investment? | `checkbox` | Pre-ticked for bands 2 and 3 only | Confirm or override | ch04 L151 |
| 12 | The gap, named | `free text` | — | What is missing, stated as a thing, not as a feeling | ch09 L27-59 |
| 13 | What the gap costs us | `free text` | — | The consequence in the org's own terms — rework, audit exposure, a capability that cannot cross a team boundary | derived |
| 14 | Gap owner | `owner (named person)` | — | The person who will close it | ch06 L120-152 |
| 15 | Decision needed by | `date` | — | The date the gap stops being a plan | ch06 L120-152 |
| 16 | **Cross-cutting band** — name | `select` (fixed 2) | Composition across Skills / Identity and policy plane above the lockfile | — | ch06 L120-152 |
| 17 | **Cross-cutting band** — owner today | `free text` + `owner (named person)` | Agent Operations Specialist (composition); Platform team + Security/Compliance (identity and policy) | Real team, real person; mark "emerges only at scale" if not yet staffed | ch06 L120-152 |
| 18 | **Audit block** — who can answer *which AI capabilities ran in production last quarter, at what version, and with whose approval* | `owner (named person)` | — | One named person, or the word `NOBODY` | ch04 L153 |
| 19 | **Audit block** — where that record physically lives | `free text` | — | A lockfile path, registry or system of record; or the word `NOWHERE` | ch04 L153 |
| 20 | **Audit block** — probe result | `computed` Pass / Fail | — | Fail if either 18 or 19 is blank, `NOBODY` or `NOWHERE` | ch09 L27-59 |
| 21 | **Layer-3 usability** — discoverability mechanism / rollout mechanism | `free text` (two cells) | Catalogue backed by an internal developer platform; harness-managed settings pushed by the platform team | The org's actual IDP and its actual push mechanism, or `none` | ch04 L155 |
| 22 | **Glossary strip** — term | `select` (fixed 8) | primitive / manifest / lockfile / CODEOWNERS / harness / subagent / recursion bound / MCP | — | ch09 L12-23 |
| 23 | **Glossary strip** — the book's definition | `free text` | One pre-printed line per term | — | ch09 L12-23 |
| 24 | **Glossary strip** — our name for it today | `free text` | — | What this org calls the thing, if it calls it anything | ch09 L12-23 |
| 25 | **Glossary strip** — do we have one? | `select` Yes / Partial / No | — | — | ch09 L12-23 |
| 26 | **Glossary strip** — owning team | `free text` | — | — | ch09 L12-23 |
| 27 | **Glossary strip** — where it lives | `free text` | — | Repo, path or system of record | ch09 L12-23 |

**Absorbed detail.** Nothing from the three folded candidates is dropped.
`WS-06-layer-ownership-map` contributes columns 7, 8, 14 and 15 (named team, named accountable
*individual*, gap owner, decision-needed-by date) and the two cross-cutting rows at 16-17 —
Composition across Skills and the identity/policy plane above the lockfile. Its
named-individual-not-role-label rule is enforced at column 8 and again at acceptance criterion 2.
`WS-09-five-layer-ownership-canvas` contributes columns 3, 4 and 7 — the layer's job, the artefact
on disk and the primary author the chapter hands over verbatim — plus the Exists / Partial / Absent
state at column 6, the named gap at 12, and the Governance-layer pass/fail probe now sitting at
columns 18-20. `WS-09-agentic-vocabulary-alignment` contributes the whole glossary strip at
columns 22-27; it is printed as a top-margin strip rather than a page of its own because its own
cluster note says it runs as a five-minute warm-up, not as a worksheet.

**Deliberate omission.** No maturity or readiness score per band. The canvas asks whether an
artefact exists and who owns it; a 1-5 maturity number invites the room to average five bands into
one comforting figure and lose the single finding that matters — which band is Absent. The related
omission is any pre-printed vendor or product name in column 5: ch04 is deliberately vendor-neutral
and the canvas stays that way, so the reference implementation named at L155 appears in the
facilitator notes, never on the canvas.

## 6. Absorbed members (3)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-06-layer-ownership-map` - Who Owns Each Layer — Named Owners for the Five-Layer Stack

- **Address.** `handbook\ch06-team-structures.qmd` L120-152, Ownership Across the Five-Layer Reference Architecture (`#sec-team-layer-ownership`)
- **Why folded.** The same five layers with the owner column the canonical already carries; contributes the two cross-cutting rows (composition across Skills, identity and policy plane) and the named-individual-not-role-label requirement.
- **Fill detail to absorb.** One row per architecture layer (Platform, Context and Capabilities, Governance and Distribution, Agent Harness, SDLC phases) plus two cross-cutting rows (Composition across Skills, Identity and policy plane). Columns: named team today, named accountable individual, gap or unowned, decision needed by when. Reader writes real names, not role labels.
- **Its output was.** A layer-by-layer ownership map with every unowned layer flagged red — the single clearest picture of the org gap between the target architecture and the current organization.

### `WS-09-agentic-vocabulary-alignment` - Agentic Vocabulary Alignment Sheet

- **Address.** `handbook\ch09-part-iii-preface.qmd` L12-23, A Map for Part III (`#sec-part-iii-preface`)
- **Why folded.** The cluster rationale states outright that it runs as a five-minute warm-up, not as a worksheet; contributes the eight-term glossary block that opens the canonical's session.
- **Fill detail to absorb.** For each of the eight terms (primitive, manifest, lockfile, CODEOWNERS, harness, subagent, recursion bound, MCP): our name for it today, do we have one (Yes/Partial/No), owning team, and where it lives (repo, path, or system of record).
- **Its output was.** A one-page shared glossary mapping the book's eight terms onto the organisation's existing assets and owners — the common language for the rest of the workshop.

### `WS-09-five-layer-ownership-canvas` - Five-Layer Ownership and Gap Canvas

- **Address.** `handbook\ch09-part-iii-preface.qmd` L27-59, Five layers, one supply chain (`#sec-part-iii-preface-layers`)
- **Why folded.** An identical five-layer canvas; contributes the job / artefact-on-disk / primary-author columns the chapter hands over verbatim, and the Governance-layer pass/fail probe.
- **Fill detail to absorb.** One row per layer (Platform, Context and Capabilities, Governance and Distribution, Agent Harness, SDLC phases). Columns the chapter hands over verbatim: the layer's job, the artefact on disk, the primary author/owning team — plus two the reader supplies: current state (Exists / Partial / Absent) and the named gap with an owner.
- **Its output was.** A single-page reference-architecture canvas showing, per layer, who owns it today, which artefact proves it exists, and which layer is the organisation's weakest link.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- None. This sheet can be filled cold.

**Consumed by:**

- `WS-06-role-map-and-staffing-triggers` - The Role Map — Who Holds Each Hat, and When We Staff It (Pack F - People and operating model, fill order 3)
- `WS-11-runtime-machine-inventory` - Four-Part Runtime Inventory (Pack D - Architecture and ownership, fill order 4)

**Feeds into (prose, from the source scan).** WS-06-role-map-and-staffing-triggers and WS-05-decision-rights-gate-matrix

## 8. Facilitation

| | |
|---|---|
| Who fills it | The platform-engineering lead who already operates the organisation's npm / Maven / NuGet registry, a security and compliance representative, and one engineer from each stream-aligned team that has already adopted an agent runtime. Columns 8, 14 and 18 demand named individuals, so somebody with the authority to commit a person must be in the room. |
| When in the session | Opens Pack D. It has no prerequisites and fills cold, and every later Pack D sheet reads from it — `WS-11-runtime-machine-inventory` takes the Agent Harness band as its starting point, and Pack F's role map takes column 7. Run the glossary strip (columns 22-27) as the first five minutes, before anyone approaches the canvas; it was folded in precisely because it is a warm-up, not a worksheet, and it stops the next two hours being an argument about what "skill" means. |
| Duration | 90-120 minutes. Roughly 5 minutes on the glossary strip, 15 minutes per band, and 20 minutes on the two cross-cutting bands and the audit block. The audit block is the part that overruns, because the honest answer is usually a silence. |
| Data needed in advance | An inventory of agent runtimes in use, including the unsanctioned ones; which team operates the existing package registry; current CODEOWNERS practice; the identity and data-governance control set security has standardised on; and a list of repositories that already contain instruction, skill or persona files. Nothing here requires a survey — it requires somebody to have looked. |
| Room format | Printed A0 or A1 and hung on a wall, five horizontal bands bottom-to-top, one sticky colour per team. Bands 2 and 3 pre-tinted as net-new investment before the session starts. Do not run this as a slide and do not distribute it as pre-work: the disagreement about who owns the Governance and Distribution band is the output, and it only happens out loud. |

**Facilitation note carried from ch04.** Two sentences do most of the work in this room. The
first is L151: the platform-governance plane the enterprise already bought covers the Platform
band cleanly and is *necessary but not sufficient* — it does not reach bands 2 and 3, because
those concern a class of artefact that did not exist when those controls were procured. Say it
before the room starts scoring, or band 1's green will be read as coverage of the whole stack.
The second is L153, and it is the sentence to put on a slide for the next conversation with the
CISO: the auditable record of which AI capabilities ran in production, at what version, and with
whose approval lives at the Governance and Distribution band — not at the runtime, which can
change quarterly, and not at the platform, which knows about identity and access but not about
which procedure an agent executed. Hold the audit block open until somebody either names a person
or writes `NOBODY`. A hedged answer here is the most expensive thing the room can produce.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All five bands carry a current state (column 6) and an artefact on disk (column 4).** An
   `Absent` band must still name what would prove it exists. A band with a state but no artefact
   has been scored on intent rather than evidence, which is the failure this canvas exists to stop.
2. **Every band and both cross-cutting bands name a real individual in column 8** — a person, not
   a function, a team or a role label. Where the honest answer is that nobody owns it, the cell
   reads `UNOWNED` and columns 14 and 15 are filled instead.
3. **The audit block is closed.** Columns 18 and 19 both carry an entry, and column 20 computes
   Pass or Fail. A `Fail` is a legitimate and valuable result; a blank is not, and the sheet is
   not finished until it resolves one way or the other.
4. **The net-new-investment ticks (column 11) fall on exactly bands 2 and 3**, or the room has
   written down why it is overriding ch04 L151 and who signed off on that override.
5. **The glossary strip is complete for all eight terms**, each with a Yes / Partial / No in
   column 25. A `No` is an acceptable answer and is more useful than a guess.
6. **Reconciliation with the downstream sheets.** Every harness named in the Agent Harness band
   appears in `WS-11-runtime-machine-inventory`, and every owning team in column 7 appears in
   `WS-06-role-map-and-staffing-triggers`. A name that exists on this canvas and nowhere
   downstream is an ownership claim nobody has staffed.
7. **At least one band is marked Partial or Absent, or the room has justified a clean sweep in
   writing.** A canvas on which every band Exists almost always means the participants scored the
   architecture they intend to have rather than the one they run.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** Carried unchanged from _section-clusters.md section 7 for CL-STACK-OWNERSHIP.
- **Fill (the organisation completing it): `L`.** L - needs the real repository, finance input or cross-team agreement

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Strongest architecture instrument in the chapter and the one the chapter argues is the actual unit of standardisation (lines 11-13). Diagram at lines 128-145; the layer definitions the canvas needs are in the prose at line 147; the audit question at line 153 and the discoverability/rollout point at line 155 are the two fields that make it a leadership artefact rather than a drawing. Almost nothing fillable exists in the book - needs authoring. Layers two and three are explicitly named as the net-new investment (line 151), so the canvas must visually separate "already covered by the platform-governance plane you bought" from "new investment". Feeds ch05 directly: the Governance and Distribution layer is what the ch05 decision matrix overlays (ch05 line 295).
