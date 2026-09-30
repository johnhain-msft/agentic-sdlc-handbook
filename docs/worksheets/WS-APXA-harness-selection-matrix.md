# Harness Selection and Portability Matrix: What We Standardise On, and What It Costs Us

`WS-APXA-harness-selection-matrix` &middot; **Pack D - Architecture and ownership** &middot; fill order **5** &middot; type `matrix` &middot; audience **mixed** &middot; leadership priority **1**

## 1. Purpose

**Output artifact.** A procurement-grade harness decision: one standard, the sanctioned exceptions, the primitive concepts we forfeit, and the estimated migration cost if we switch.

**Cluster.** `CL-HARNESS` - Harness Standardisation and Portability

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\appendix-a-cross-harness-reference.qmd` |
| Chapter | The Cross-Harness Reference |
| Heading | At a glance — the substrate matrix |
| Stable anchor | `#sec-harness-substrate-matrix` |
| Lines | L21-44 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/appendix-a-cross-harness-reference.html#sec-harness-substrate-matrix> |
| Locator quote | "The first table is the one most readers come here for." |

Resolve at any time with `python docs/resolve.py ws WS-APXA-harness-selection-matrix`.

## 3. Source extract - the scaffolding, verbatim

```text
   21 | The first table is the one most readers come here for. Rows are the primitive concepts the handbook teaches; columns are the five harnesses; each cell is the path or file convention the harness uses to materialize that concept. Empty cells (`—`) are real: they mean the harness does not have a native binding for that primitive type, and the concept must be approximated through one of the cells that does exist (typically a project-wide rule file). The path conventions for the APM-side translations are taken from the APM CLI's `KNOWN_TARGETS` registry,[^appx-a-apm] which is the single source of truth for the `apm install --target` mappings.
   22 | 
   23 | | APM primitive concept     | GitHub Copilot[^appx-a-copilot] | Claude Code[^appx-a-claude] | Cursor[^appx-a-cursor] | Codex CLI[^appx-a-codex] | OpenCode[^appx-a-opencode] |
   24 | |---------------------------|---------------------------------|------------------------------|------------------------|--------------------------|----------------------------|
   25 | | Project-wide rules        | `.github/copilot-instructions.md` | `CLAUDE.md` (repo root)    | `.cursor/rules/*.mdc` (`alwaysApply: true`) | `AGENTS.md` (repo root) | `AGENTS.md` (repo root)    |
   26 | | Scope-attached rules      | `.github/instructions/*.instructions.md` with `applyTo:` glob | Nested `CLAUDE.md` per subtree | `.cursor/rules/*.mdc` with `globs:` | Nested `AGENTS.md` per subtree | Nested `AGENTS.md` per subtree |
   27 | | User-scope rules          | `~/.copilot/instructions/` (partial) | `~/.claude/CLAUDE.md`     | Cursor Settings UI (not file-based) | (no file convention)   | `~/.config/opencode/AGENTS.md` |
   28 | | Persona / specialist agent| `.github/agents/<name>.agent.md` | `.claude/agents/<name>.md` (Task tool) | `.cursor/agents/<name>.md` (modes) | `.codex/agents/<name>.toml` | `.opencode/agents/<name>.md` |
   29 | | Skill (module entrypoint) | `.github/skills/<name>/SKILL.md` | `.claude/skills/<name>/SKILL.md` | `.cursor/skills/<name>/SKILL.md` (partial) | `.agents/<name>/SKILL.md` (cross-tool dir)[^appx-a-skills] | `.opencode/skills/<name>/SKILL.md` |
   30 | | Prompt / repeatable workflow | `.github/prompts/*.prompt.md` | (use slash commands)         | (none — partial via rules) | (none)                | `.opencode/commands/*.md`  |
   31 | | Memory (cross-session)    | (use scoped instructions)       | `CLAUDE.md` + `@path` imports | `.cursor/rules/*.mdc` (`alwaysApply`) | `AGENTS.md`           | `AGENTS.md`                |
   32 | | Hooks (event-driven)      | `.github/hooks/*.json`          | `.claude/hooks/*.json` (merge into `settings.json`) | `.cursor/hooks/*.json` | `.codex/hooks.json` (single file) | (no native hooks)          |
   33 | | MCP server config         | `.github/mcp.json` or VS Code settings | `.claude/settings.json` (`mcpServers` block) | `.cursor/mcp.json` | `.codex/config.toml` (`[mcp_servers]`) | `.opencode/mcp.json`     |
   34 | | Session compaction / restart[^appx-a-compact] | `/compact` (Copilot CLI session compaction) | `/compact` (Claude Code) | (manual: new chat / "Reset context" in chat header) | `/new` (Codex CLI session refresh) | `/compact` (OpenCode) |
   35 | 
   36 | A few conventions in the matrix above are worth flagging up front, because they trip readers who scan the table without reading the per-harness sections:
   37 | 
   38 | - **AGENTS.md is one file in two roles.** Codex and OpenCode both read `AGENTS.md` at the project root as project-wide rules and walk nested `AGENTS.md` files for scope-attached rules. The same file convention covers two primitive concepts because hierarchy *is* the scope predicate. Cursor, Claude Code, and a growing list of harnesses also load `AGENTS.md` if present.[^appx-a-agentsmd]
   39 | - **`SKILL.md` is the only file name that ports cleanly.** Every harness in the matrix that has a skills concept uses the same file name and substantially the same activation contract. This is the agentskills.io convergence (@sec-skills-convergence below).
   40 | - **Persona files are convention, not standard.** `.agent.md` (Copilot), plain `.md` under `.claude/agents/` (Claude Code), and `.toml` under `.codex/agents/` (Codex) all express the same primitive — a specialist persona with a name, a description, and tool boundaries — but the surface syntax does not port. Persona portability is a manual translation, not a `cp` away.
   41 | - **Hooks are the least standardized cell.** Every harness that has hooks uses JSON, but the schema, the event names, and the merge semantics differ. OpenCode has no native hooks at all. A hook bundle is the row most likely to break across harnesses without warning.
   42 | 
   43 | ---
   44 | 
```

## 4. What the user fills

First tick which of the five harnesses are actually in use today, including the unsanctioned ones. Then, per primitive-concept row (project-wide rules, scope-attached rules, user-scope rules, persona, skill, prompt, memory, hooks, MCP config, session compaction): do we depend on it, does our chosen harness support it natively, what is the workaround where the book's cell is empty, and which named gotcha are we accepting.

## 5. Field-level schema

Six blocks on A3, printed double-sided. The pre-filled cells throughout are transcribed from a
**dated** appendix — verified-on 2026-04-26 — and every block that carries them prints that date
in its header alongside a blank **re-verified by us on** field. The appendix's own warning is
printed once at the head of the sheet: harnesses ship breaking changes on quarterly cadences and
sometimes faster; the substrate vocabulary is durable, the file names are not.

**Block A — which harnesses are actually in use.** Five fixed rows, filled before anything else.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Harness | `select` (fixed 5) + free rows | GitHub Copilot / Claude Code / Cursor / Codex CLI / OpenCode | Add rows for any harness in use that the appendix does not cover | appx-A L23 |
| 2 | In use today | `checkbox` | — | Tick honestly, including the unsanctioned installs | derived |
| 3 | Sanctioned? | `select` Sanctioned / Tolerated / Unsanctioned / Unknown | — | The gap between columns 2 and 3 is the first finding | derived |
| 4 | Teams using it | `free text` | — | — | org |
| 5 | Decision | `select` Standardise / Support via shim / Decline | — | One per harness. Exactly one `Standardise` unless the org is deliberately running two | ch11 L99-107 |
| 6 | Estimated port cost if we reverse this | `free text` | — | Qualitative and named — which primitive families would need manual translation, and who would do it. Not a number the room does not have | ch11 L149 |

**Block B — primitive-concept dependency and gap register.** Ten fixed rows: the appendix's
primitive concepts, in its order.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 7 | Primitive concept | `select` (fixed 10) | Project-wide rules / Scope-attached rules / User-scope rules / Persona or specialist agent / Skill (module entrypoint) / Prompt or repeatable workflow / Memory (cross-session) / Hooks (event-driven) / MCP server config / Session compaction or restart | — | appx-A L25-34 |
| 8 | Our chosen harness's binding | `free text` | The path or file convention for the standardised harness, transcribed from the matrix — e.g. `.github/instructions/*.instructions.md` with `applyTo:` glob, or nested `AGENTS.md` per subtree | Confirm against the live vendor doc before relying on it | appx-A L25-34 |
| 9 | Do we depend on it? | `select` Yes / Not yet / No | — | — | derived |
| 10 | Native, or a real gap? | `select` Native / Partial / None (`—` in the book) | Pre-marked from the matrix. The dashes are honest capability gaps, not omissions: user-scope rules have no Codex file convention and live outside version control in Cursor; prompts are absent in Claude Code, Cursor and Codex; memory is approximated in Copilot via scoped instructions; skills are partial in Cursor; OpenCode has no hooks at all | Confirm or correct | appx-A L21, L25-34 |
| 11 | Workaround where the cell is empty | `free text` | Reference: approximate the concept through a cell that does exist, typically a project-wide rule file | The actual workaround, written down and owned | appx-A L21 |
| 12 | Named gotcha we are accepting | `free text` | Printed per harness: **Copilot** — an over-eager `applyTo: "**"` matches every path and consumes the eager-preload budget so completely that lazy skills are never selected. **Claude Code** — closest-wins shadowing means a rule that should always apply must live at the root, and the appendix warns that a root file grown large pulls into every session and crowds out the skill activation budget. **Cursor** — user-scope rules live in IDE settings, not the filesystem, so they do not version-control with the project: hidden per-developer state, the silent-onboarding failure. Skills activation is partial. **Codex CLI** — skills materialise to the cross-tool `.agents/` directory rather than under `.codex/`, and there is no separate prompts primitive. **OpenCode** — no native hooks concept at all, and the youngest convention set in the matrix | Tick the ones this org is knowingly accepting, and name the mitigation | appx-A L47-99 |
| 13 | Owner of the workaround | `owner (named person)` | — | — | derived |

**Block C — binding-surface detail per candidate harness (absorbed).** Seven fixed rows, one
column per harness under consideration. This is the page that makes block A column 5 defensible.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 14 | Binding surface | `select` (fixed 7) | File name / Folder / Scope predicate / Multiple-file resolution / External references / User-scope variant / Loaded when | — | ch11 L99-107 |
| 15 | Value per harness | `free text` | Worked example printed for two harnesses: Copilot — any stem `.instructions.md`, in `.github/instructions/`, `applyTo:` glob predicate, many files glob-matched and all composing, plain markdown links, user-home `.copilot/instructions/`, loaded when a thread touches a matching path. Claude Code — `CLAUDE.md` exact name, nested in the subtree, implicit hierarchy predicate, one closest file wins, `@path` inlining, `~/.claude/CLAUDE.md`, loaded when a thread starts work in that subtree | The same seven rows for every harness on the shortlist | ch11 L99-107 |
| 16 | Shim we would write | `free text` | Reference: a thin shim file at the harness's expected path that re-exports the canonical primitives — the port is mechanical, not heroic | The actual shim paths this org would create | ch11 L145 |

**Block D — target-harness support matrix (absorbed).** Five fixed rows by the harnesses the org
declares it must support.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 17 | Primitive concept | `select` (fixed 5) | Project-wide rules / Scope-attached rules / Skill entrypoint / Persona or specialist / User-scope override | — | ch14 L55-59 |
| 18 | Must support on this harness? | `checkbox` per harness column | — | The declared target set | ch14 L51-65 |
| 19 | Cell status | `select` Supported / Translated / Not supported | Pre-marked from the materialisation table, including the gaps the org must consciously accept — Cursor and Codex/OpenCode have no native skill entrypoint or persona convention in that table | Confirm or correct | ch14 L55-59 |
| 20 | Owner of the translation step | `owner (named person)` | — | Every `Translated` cell needs a person, or it will not be maintained | ch14 L63 |
| 21 | Cost of maintaining this extra layout | `free text` | Reference: a monorepo shipping for three harnesses pays the translation cost once, at install time, by emitting three layouts side by side | Qualitative statement of the burden accepted | ch14 L63 |
| 22 | Gap we accept | `free text` | — | Written, not assumed | ch14 L63 |

**Block E — portability policy (absorbed).** One row per primitive the org intends to author.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 23 | Primitive we intend to author | `free text` | — | — | org |
| 24 | Activation test | `select` DESCRIPTION-deterministic / PATH-deterministic | The test, printed: if the primitive activates because its *description* matches the task, express it as a Skill — `SKILL.md` is the one file name that ports cleanly across every harness in the matrix. If it activates because of *where the work is happening*, it must be a scope-attached rule, and the port is manual translation | Apply the test and record the answer | appx-A L39, L105-109 |
| 25 | Expressed as | `select` Skill / Scope-attached rule | — | Must follow from column 24. A PATH-deterministic primitive forced into a Skill will be silent | appx-A L105-109 |
| 26 | Translation cost per target harness | `free text` | Reference: `applyTo: "src/api/**"` cannot become a single Claude Code file without choosing a directory to nest it in — the two encodings do not translate losslessly | Named per target harness | appx-A L107 |
| 27 | Non-portable exception accepted? | `checkbox` + `free text` justification | — | Portable by default; every exception carries a written reason | appx-A L109 |

**Block F — convention drift watch (absorbed).** One row per harness ticked in block A.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 28 | Harness | `select` | From block A | — | derived |
| 29 | Vendor documentation URL we watch | `free text` | The appendix's own per-harness footnote is the starting point | The URL, pasted in full | appx-A L47-99 |
| 30 | Named owner of the re-verification | `owner (named person)` | — | A person. An unowned watch is not a watch | appx-A L12-14 |
| 31 | Review cadence | `select` + `free text` | Reference: the appendix refreshes annually, or on a major release of any listed harness | The org's own cadence, which may be tighter | appx-A L12-14 |
| 32 | Book cells verified-on | `date` (printed, read-only) | **2026-04-26** | — | appx-A L12-14 |
| 33 | We last verified on | `date` | — | Mandatory. Until this is filled the sheet is quoting someone else's snapshot | appx-A L12-14 |
| 34 | Off-cycle trigger events | `free text` | Reference: a major release, or a published breaking-change notice, forces re-verification before the cadence falls due | The org's trigger list and who raises it | appx-A L12-14 |
| 35 | Rows changed since our last check | `free text` | — | The diff is the deliverable of each review | appx-A L14 |

**Absorbed detail.** All four folded candidates land whole.
`WS-11-harness-standardisation-decision` is block C plus block A columns 5-6: the seven binding
surfaces per candidate harness, the standardise / shim / decline decision, the explicit shim paths
at column 16, and the stated cost of reversing the choice at column 6.
`WS-14-harness-target-matrix` is block D: five primitive concepts, the declared target harness set
at column 18, Supported / Translated / Not supported at 19, the named translation-step owner at 20,
the maintenance cost of each extra layout at 21, and the accepted gaps at 22.
`WS-APXA-harness-convention-drift-watch` is block F: vendor doc URL, named owner, cadence, the
book's verified-on date printed as provenance, the org's own last-verified date, and the off-cycle
triggers.
`WS-APXA-primitive-portability-policy` is block E: the description-versus-path activation test, the
resulting expression, the per-harness translation cost, and the justified non-portable exceptions.

**Deliberate omission.** No weighted harness score and no recommended harness. The appendix is a
reference, not a ranking, and a composite score would let the sheet appear to make a procurement
decision the organisation has to make for itself against block B column 9. The sheet also does not
reprint the five-harness × ten-primitive grid as a durable constant: the cells appear only in
column 8, for the harness actually chosen, and only under the printed verified-on date at column
32. A full grid printed without that date is precisely the artefact the appendix warns against.

## 6. Absorbed members (4)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-11-harness-standardisation-decision` - Harness Standardisation and Portability Assessment

- **Address.** `handbook\ch11-the-runtime-machine.qmd` L93-151, The harness is the compiler (`#sec-runtime-harness-compiler`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** One column per candidate harness and one row per binding surface the chapter tabulates — file name, folder, scope predicate, multiple-file resolution, external references, user-scope variant, load trigger — then a decision row per harness (standardise / support via shim / decline) and an estimated port cost if the choice is later reversed.
- **Its output was.** A harness decision record with an explicit portability plan — which shim files get written at which paths — and a stated lock-in cost.

### `WS-14-harness-target-matrix` - Which Agent Harnesses Will We Standardise On?

- **Address.** `handbook\ch14-the-load-lifecycle.qmd` L51-65, Materialize (`#sec-load-materialize`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** For each of the five primitive concepts in the book's cross-harness table (project-wide rules, scope-attached rules, skill entrypoint, persona/specialist, user-scope override), the team ticks which harnesses it must support (Copilot / Claude Code / Cursor / Codex-OpenCode / other), marks each cell Supported / Translated / Not supported, and records the owner of the translation step plus the estimated cost of maintaining each extra layout.
- **Its output was.** A signed harness support matrix: the declared set of target harnesses, the translation obligations that follow, and the gaps the org accepts (e.g. Cursor and Codex have no native skill entrypoint).

### `WS-APXA-harness-convention-drift-watch` - Harness Convention Drift Watch: Who Re-Verifies, and When

- **Address.** `handbook\appendix-a-cross-harness-reference.qmd` L12-14, Verified-on date — 2026-04-26 (`#sec-harness-verified-on`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Per harness in use: the vendor documentation URL we watch, the named owner, the review cadence, the last-verified date, and the trigger events (major release, breaking-change notice) that force an off-cycle re-verification.
- **Its output was.** A standing maintenance commitment with named owners and dates, attached to the harness selection matrix so it cannot silently rot.

### `WS-APXA-primitive-portability-policy` - Skill or Scope-Attached Rule? Our Portability Policy

- **Address.** `handbook\appendix-a-cross-harness-reference.qmd` L105-109, agentskills.io as the cross-harness convergence (`#sec-skills-convergence`)
- **Why folded.** Merged in the original consolidation pass.
- **Fill detail to absorb.** Per primitive the team intends to author, apply the chapter's test and record the answer: is activation DESCRIPTION-deterministic (express it as a Skill -- it ports across every harness) or PATH-deterministic (it must be a scope-attached rule, and the port is manual translation)? Then the translation cost per target harness and whether we accept it.
- **Its output was.** An authoring policy that keeps the primitive set portable by default, with an explicit and justified list of the non-portable exceptions.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-11-runtime-machine-inventory` - Four-Part Runtime Inventory (Pack D - Architecture and ownership, fill order 4)

**Consumed by:**

- `WS-17-orchestration-topology-selector` - Orchestration Topology Selector: Which Patterns Do We Sanction? (Pack D - Architecture and ownership, fill order 6)

**Feeds into (prose, from the source scan).** WS-APXA-harness-selection-matrix and the tooling/procurement section of the transformation plan

## 8. Facilitation

| | |
|---|---|
| Who fills it | The platform-engineering lead who will operate the standard, one developer from each team already running a harness (block A column 2 fails without them), whoever owns developer onboarding — because Cursor's unversioned user-scope rules are an onboarding failure before they are a tooling one — and procurement for the reversal-cost question at column 6. |
| When in the session | After `WS-11-runtime-machine-inventory`, its declared prerequisite: block A column 2 is that sheet's harness row, and filling it here from scratch produces a wish list rather than an inventory. It must close before `WS-17-orchestration-topology-selector`, which cannot set recursion and fan-out bounds until it knows which harness is expected to enforce them. |
| Duration | 2-3 hours, and it is better split. Blocks A and B take about 75 minutes together. Block C is desk work for one engineer with the vendor docs open, brought back to the room. Blocks D, E and F take a second 60-minute sitting once the standard is chosen. |
| Data needed in advance | The output of `WS-11-runtime-machine-inventory`; the live vendor documentation pages for every harness in play, opened rather than remembered; a list of primitives the org has already authored, and where they live; and the current onboarding runbook, because block B column 12 will find things in it that only work on one developer's machine. |
| Room format | A3 double-sided, filled live for blocks A, B, D and E, with block C completed offline and block F pinned somewhere it will be seen again — a team page or the repository README, not a slide deck. Print the verified-on date large. |

**Facilitator caveat carried from Appendix A.** Everything pre-filled on this sheet was verified
against vendor documentation on **2026-04-26** and the appendix itself warns that harnesses ship
breaking changes quarterly and sometimes faster. Say so before the first cell is filled, and do
not let the room treat column 8 as current until somebody has opened the vendor doc and written a
date into column 33. Three observations from the appendix are worth reading aloud, because they
are the ones that change a decision rather than describe it. `SKILL.md` is the only file name that
ports cleanly, which is why block E pushes as much as is honest into skills. Persona files are
convention, not standard — the same primitive expressed three ways, so persona portability is a
manual translation, not a `cp` away. And hooks are the least standardised row in the matrix and the
one most likely to break a governance bundle without warning, with OpenCode having no hooks
primitive at all: if a compliance control is implemented as a hook, block D column 19 is where the
organisation finds out it does not travel.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **Block A distinguishes what is in use (column 2) from what is sanctioned (column 3), and the
   discrepancy is written down rather than tidied away.** A sheet on which those two columns match
   perfectly has almost certainly been filled from the policy instead of the estate.
2. **Exactly one harness carries `Standardise` at column 5**, or the sheet records a deliberate
   two-harness decision with the reason. Every other harness carries `Support via shim` or
   `Decline`, and every `Support via shim` has shim paths named at column 16.
3. **Every primitive concept the org depends on (column 9 = Yes) that is not natively supported
   (column 10 = Partial or None) carries both a written workaround at column 11 and a named owner
   at column 13.** A dependency with a gap and no owner is the row that will fail silently.
4. **Every gotcha the organisation is knowingly accepting is ticked and mitigated at column 12.**
   In particular, if Cursor appears in block A, the unversioned user-scope rules gotcha is either
   mitigated or explicitly accepted with the onboarding consequence stated.
5. **Every `Translated` cell in block D names a translation owner (column 20)**, and every
   accepted gap at column 22 is written as a sentence, not implied by an empty cell.
6. **Every primitive in block E has an activation test result (column 24) and an expression
   (column 25) that follows from it**, with any non-portable exception justified in writing at
   column 27.
7. **Block F is complete for every harness ticked in block A, and column 33 carries a date this
   organisation put there.** Until that cell is filled the sheet is quoting a snapshot taken on
   2026-04-26 as though it were current, which is the one failure mode the source appendix
   explicitly warns about.
8. **Reconciliation with `WS-11-runtime-machine-inventory`.** Every harness in block A column 2
   appears in that sheet's harness row, and the chosen standard at column 5 is carried forward as
   the enforcing harness named in `WS-17-orchestration-topology-selector`.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Carried unchanged from _section-clusters.md section 7 for CL-HARNESS.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> The most procurement-ready table in any of my chapters -- ten primitive concepts by five harnesses (GitHub Copilot, Claude Code, Cursor, Codex CLI, OpenCode) with REAL empty cells that are honest capability gaps, not omissions. Second location: the per-harness sections at 47-99 supply load order, scope rules, override semantics and one named gotcha each, which become the "gotcha we accept" column -- Copilot's over-eager applyTo:"**" starving lazy skills, Claude Code's closest-wins shadowing making a root rule the only always-on rule, Cursor's user-scope rules living in IDE settings rather than version control (hidden per-developer state, the silent-onboarding failure) and its partial skills activation, Codex materialising skills to the cross-tool .agents/ directory, OpenCode having no hooks primitive at all. Three cells that matter most to a leader: hooks are the least standardised row and the one most likely to break a governance bundle silently; SKILL.md is the only file name that ports cleanly; persona files are convention not standard, so persona portability is manual translation. FACILITATOR CAVEAT: the appendix is explicitly dated (verified 2026-04-26) and warns harnesses ship breaking changes quarterly, so the worksheet must carry a re-verify date field -- see WS-APXA-harness-convention-drift-watch. CONFIRMED DE-DUP CLUSTER -- three candidates now exist for one harness decision: WS-11-harness-standardisation-decision (Ch11, p1), WS-14-harness-target-matrix (Ch14, p1) and this one. RECOMMENDATION: ONE instrument. Ch11/Ch14 supply the runtime and load-lifecycle reasoning for WHY a harness choice matters; this appendix supplies the only actual DATA TABLE (ten primitive concepts by five named harnesses, with real capability gaps and a per-harness gotcha). Make this the data page of whichever Ch11/Ch14 candidate survives.
