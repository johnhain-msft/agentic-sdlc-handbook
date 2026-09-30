# Four-Part Runtime Inventory

`WS-11-runtime-machine-inventory` &middot; **Pack D - Architecture and ownership** &middot; fill order **4** &middot; type `inventory` &middot; audience **architect** &middot; leadership priority **2**

> **Split back out in the re-opening pass.** Inventories a different stack -- the four runtime parts (model, harness, agent source code, client) -- and the client row is the trust boundary almost no organisation has inventoried.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A current-state runtime inventory that converts "the AI behaves differently for us" complaints into a named part that differs.

**Cluster.** `CL-RUNTIME-INVENTORY` - The Four-Part Runtime Inventory

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch11-the-runtime-machine.qmd` |
| Chapter | The Agentic Runtime Machine |
| Heading | The four parts |
| Stable anchor | `#sec-runtime-four-parts` |
| Lines | L30-57 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch11-the-runtime-machine.html#sec-runtime-four-parts> |
| Locator quote | "Every agentic system you will ever touch is built from the same four parts" |

Resolve at any time with `python docs/resolve.py ws WS-11-runtime-machine-inventory`.

## 3. Source extract - the scaffolding, verbatim

```text
   30 | Every agentic system you will ever touch is built from the same four parts. They are not branding labels; they are functional roles, and any working setup must fill all four.
   31 | 
   32 | ```{mermaid}
   33 | %%| fig-width: 5.5
   34 | %%| label: fig-runtime-machine
   35 | %%| fig-cap: "The four parts of the agentic-system runtime machine"
   36 | %%| fig-alt: "A diagram with Client above, Harness in the middle (the compiler that drives inference), Tools on the left, Agent Source Code on the right, and Model below. Bidirectional arrows show prompt and output flowing between Client and Harness, tool invocations between Harness and Tools, file loading between Harness and Agent Source Code, and inference requests and responses between Harness and Model."
   37 | flowchart TB
   38 |     Client["Client<br/>(terminal, IDE, workflow,<br/>scheduler, webhook receiver)"]
   39 |     Tools["Tools<br/>(classical CPU code<br/>orchestrated by the harness)"]
   40 |     Harness["Harness<br/>(the compiler that<br/>drives inference)"]
   41 |     Source["Agent Source Code<br/>(files loaded at<br/>session start)"]
   42 |     Model["Model<br/>(inference engine)"]
   43 | 
   44 |     Client <-->|"prompt / output"| Harness
   45 |     Tools <-->|"invoke / result"| Harness
   46 |     Harness <-->|"load"| Source
   47 |     Harness <-->|"inference I/O"| Model
   48 | ```
   49 | 
   50 | **The model** is the inference engine — GPT-5, Claude Sonnet, Gemini, whatever serves the inference endpoint. It takes text in and produces text out. By itself it has no tools, no memory of yesterday, and no awareness of your codebase. Most developers think of "the AI" as the model. Most failures attributed to the model are not the model's fault.
   51 | 
   52 | **The harness** is the program that drives the model. It is what runs in your terminal when you type `gh copilot`, `claude`, `cursor`, `codex`, or `opencode`. The harness manages the conversation, calls tools on the model's behalf, decides which files to load into context and when, and decides what to do with the model's output. The harness is the part that varies the most across vendors, and it is the part developers most often confuse with the model.
   53 | 
   54 | **Agent source code** is the directory layout the harness consults to decide what context the model should see. It is not a passive store of documentation. It is *executable configuration*: a particular file at a particular path with a particular frontmatter shape causes the harness to inject text into the model's context at a particular moment. Move the file, rename it, change its frontmatter, and the behavior changes — even though the model and the harness are unchanged. This is the layer Maya was unknowingly programming against.
   55 | 
   56 | **The client** is the process that decides when a session runs and what bootstrap context it carries. Clients can be interactive — a developer typing in a terminal (Claude Code, Copilot CLI), an IDE plugin forwarding a selection (VS Code, Cursor) — or programmatic — GitHub Agentic Workflows running over GitHub Actions, a cron daemon, a webhook receiver, a CI runner invoking the harness on every pull request. The client is orthogonal to the harness: a single orchestrator like GitHub Agentic Workflows can spawn sessions in any of several harnesses inside the same run.[^ch9-substrate] The client is also the first layer that can rewrite what lower layers see — a system prompt injected at the client level reaches the harness before any agent source code does, and the harness may reshape it further before the model sees a single token. Each layer mutates the input for the layer below it.
   57 | 
```

## 4. What the user fills

One row per part — model, harness, agent source code, client — with the product and version in use today, the owning team, whether it is standardised or left to individual developer choice, and the known variation between teams.

## 5. Field-level schema

Rows in block A are the four runtime parts, in the order the chapter introduces them. The sheet
is landscape, one page per block, with @fig-runtime-machine reproduced beside block A so that
placement arguments are settled by the picture rather than by memory. Where teams differ, block A
takes **one column group per team** — the variation between them is the finding, not noise to be
averaged away.

**Block A — the four-part runtime inventory.**

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Part | `select` (fixed 4) | Model / Harness / Agent source code / Client | — | ch11 L30, L50-56 |
| 2 | What it is | `free text` (printed) | Model — the inference engine; text in, text out; by itself no tools, no memory of yesterday, no awareness of your codebase. Harness — the program that drives the model, manages the conversation, calls tools on its behalf, decides which files to load and when. Agent source code — the directory layout the harness consults; *executable configuration*, not passive documentation. Client — the process that decides when a session runs and what bootstrap context it carries | Edit only if the org rejects the definition | ch11 L50-56 |
| 3 | Edge to the harness | `free text` (printed) | Model ↔ harness: inference I/O. Agent source code ↔ harness: load. Client ↔ harness: prompt / output. The harness row is the hub and has no edge of its own | — | ch11 L44-47 |
| 4 | Product and version in use today | `free text` | — | Real product names and real versions. More than one entry per row is the expected answer | org |
| 5 | Owning team | `free text` | — | — | org |
| 6 | Named accountable individual | `owner (named person)` | — | A person, not a function | derived |
| 7 | Standardised or left to choice | `select` Standardised / Recommended / Developer choice / Unknown | — | `Unknown` is a legitimate entry and a useful one | org |
| 8 | Known variation between teams | `free text` | — | The actual differences, named. This column is what turns "the AI behaves differently for us" into a part that differs | org |
| 9 | Who can inject or rewrite context at this layer | `free text` | Reference, printed: the client is the first layer that can rewrite what lower layers see — a system prompt injected at the client level reaches the harness before any agent source code does, and the harness may reshape it further before the model sees a single token. Each layer mutates the input for the layer below it | Which people, teams or systems can do this here, in this organisation | ch11 L56 |
| 10 | Trust boundary inventoried? | `select` Yes / Partial / No | — | — | ch11 L56 |
| 11 | **Client row only** — programmatic clients enumerated | `free text` | Reference, printed: interactive — a developer typing in a terminal, an IDE plugin forwarding a selection. Programmatic — agentic workflows running over CI, a cron daemon, a webhook receiver, a CI runner invoking the harness on every pull request | The org's actual list. Each entry is a separate trust boundary and gets its own line | ch11 L56 |
| 12 | **Harness row only** — tools the harness may orchestrate | `free text` | @fig-runtime-machine draws a fifth node the prose does not count as a part: **Tools**, "classical CPU code orchestrated by the harness", on an invoke/result edge | The org's actual tool and MCP-server list | ch11 L39, L45 |

**Block B — substrate layers (absorbed).** Four fixed rows, read as a second lens on the same
runtime rather than a second inventory.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 13 | Layer | `select` (fixed 4) | Foundation / Assembly / Composition / Execution | — | ch19 L19, L42-48 |
| 14 | What the layer covers | `free text` (printed) | Foundation — the model and the harness that hosts it. Assembly — the agent source code convention and the binding modes the harness applies (eager preload, lazy on-demand, dispatcher-mediated). Composition — primitives, skills, bundles, dependency edges, override mechanisms. Execution — threading topology, plan persistence, client integration, triggers | — | ch19 L42-48 |
| 15 | What we run today | `free text` | — | — | ch19 L19-49 |
| 16 | Who owns it | `owner (named person)` | — | — | ch19 L19-49 |
| 17 | Our decision or the vendor's? | `select` Ours / Vendor's / Shared | Pre-marked **Vendor's** on Foundation: the chapter states Foundation-layer patterns are "mostly out of the architect's control — they are vendor decisions" | Confirm or override; fill the other three | ch19 L42 |
| 18 | What is still undecided | `free text` | — | The open questions at this layer, named | ch19 L19-49 |
| 19 | Where the bill gets decided here | `free text` | Reference, printed: the model selected at Foundation is the cost function; the prefix laid out at Assembly decides how much of each turn is cacheable; the dispatch chosen at Execution governs how many calls happen and on which model class. Composition carries no direct cost lever | Our answer, or `n/a` for Composition | ch19 L50 |

**Block C — the diagnostic footer.** The chapter's own question, made operable.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 20 | The complaint being diagnosed | `free text` | — | The actual words the team used, e.g. "the AI got worse this week" | ch11 L50 |
| 21 | Which of the four parts changed? | `select` Model / Harness / Agent source code / Client / Unknown | — | Not *what is wrong with the AI* but *which of the four parts changed* | ch11 L50-56 |
| 22 | Evidence for that answer | `free text` | — | A version bump, a moved file, a changed frontmatter, a new CI invocation | ch11 L54 |
| 23 | Inventory taken on / re-inventory by | `date` + `date` | — | Harnesses and clients change faster than the architecture does | derived |

**Absorbed detail.** `WS-19-runtime-substrate-inventory` is block B in full: the four layers at
column 13, what-we-run at 15, the owner at 16, the load-bearing lock-in question at column 17 —
pre-marked **Vendor's** on Foundation exactly as the chapter states — and the still-undecided
column at 18. Column 19 additionally carries the chapter's cost overlay, which is what makes the
lock-in column a money question and not just an architecture one.

**Deliberate omission.** Block A holds four rows, not five, even though @fig-runtime-machine draws
five nodes. The chapter is explicit that the machine has four *parts*; Tools is the classical CPU
code the harness orchestrates, so it is inventoried as an attribute of the harness at column 12
rather than promoted to a row of its own. Flagging that the diagram and the prose differ is worth
doing out loud in the room — it is the kind of detail participants notice and then quietly assume
they have misread. There is also no quality or maturity score per part: the chapter's argument is
that most failures attributed to the model are not the model's fault, and a score column invites
exactly the misattribution the sheet exists to stop.

## 6. Absorbed members (1)

Every row below was merged into this worksheet. Its field detail must appear in section 5 - absorbed, not discarded.

### `WS-19-runtime-substrate-inventory` - Our Agentic Runtime: Four-Layer Substrate Inventory

- **Address.** `handbook\ch19-architectural-patterns-rosetta-stone.qmd` L19-49, 1. The layered model of an agentic runtime (`#sec-layered-model`)
- **Why folded.** The same runtime at pattern-layer resolution; contributes the lock-in / 'our decision or the vendor's' column and the three-lens reconciliation table as the facilitation aid.
- **Fill detail to absorb.** For each of the four layers (Foundation, Assembly, Composition, Execution) the team writes: what we run today, who owns it, is this our decision or the vendor's, and what is still undecided. The chapter states Foundation-layer patterns are "mostly out of the architect's control", so the lock-in column is the load-bearing one.
- **Its output was.** A one-page substrate map showing, per layer, the incumbent choice, the owner, the lock-in exposure and the open decisions.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-04-five-layer-supply-chain-canvas` - Five-Layer Supply Chain Instantiation Canvas (Pack D - Architecture and ownership, fill order 2)

**Consumed by:**

- `WS-APXA-harness-selection-matrix` - Harness Selection and Portability Matrix: What We Standardise On, and What It Costs Us (Pack D - Architecture and ownership, fill order 5)

**Feeds into (prose, from the source scan).** WS-APXA-harness-selection-matrix

## 8. Facilitation

| | |
|---|---|
| Who fills it | The platform engineer who operates the harness rollout, one developer from each team known to run a different setup — the variation between them is the output — and whoever owns CI. The CI owner is not optional: a CI runner invoking a harness on every pull request is a client, and it is the client almost nobody has counted. |
| When in the session | After `WS-04-five-layer-supply-chain-canvas`, which is its declared prerequisite. The canvas's Agent Harness band is this sheet's harness row at a coarser resolution; open by putting the two side by side and reconciling them. It must finish before `WS-APXA-harness-selection-matrix`, which cannot choose a standard without the current-state list this sheet produces. |
| Duration | 45-60 minutes. The model, harness and agent-source-code rows go quickly because somebody in the room knows them. The client row is where the session runs long, and it should — programmatic clients have to be counted, not recalled. |
| Data needed in advance | An installed-harness inventory across the estate, taken from package or endpoint data rather than a survey; the CI workflow files that invoke an agent; any webhook receivers, schedulers or bots that start a session; a list of repositories containing instruction, skill or persona files; and the model endpoints actually billed last month. The billing data is the fastest honest answer to the model row. |
| Room format | Projected and filled live, with @fig-runtime-machine printed and visible beside it, plus one column group per team where setups differ. Do not collapse the teams into a single consensus column before the differences have been written down — the differences are the deliverable. |

**Facilitation note carried from ch11.** Use the chapter's diagnostic reframe as the opening line
and as the closing exercise. The question is not *what is wrong with the AI?* It is *which of the
four parts changed?* Most developers think of "the AI" as the model, and most failures attributed
to the model are not the model's fault — a moved file, a renamed frontmatter key or a different
harness version changes the behaviour while model and prompt are unchanged. Close the session by
running one live complaint through block C. A team that can name a part instead of naming the
vendor has got the value of this sheet on the day.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All four parts carry a product and version (column 4), an owning team (5) and a named
   individual (6).** Where a part genuinely varies by developer, column 7 reads `Developer choice`
   and column 8 names the actual variation. A blank in column 8 next to `Developer choice` means
   the variation was asserted rather than looked at.
2. **The client row enumerates programmatic clients as well as interactive ones (column 11), and
   the CI path is either listed or explicitly confirmed absent.** A client inventory containing
   only terminals and IDE plugins is incomplete by construction, and it is the most common way
   this sheet is filled in wrongly.
3. **Column 9 is answered for all four parts and column 10 records Yes, Partial or No.** At least
   one `No` or `Partial` here is normal and is the sheet's headline finding: an uninventoried
   layer that can rewrite what lower layers see is an ungoverned trust boundary.
4. **Reconciliation with `WS-04-five-layer-supply-chain-canvas`.** Every harness named at column 4
   appears in that canvas's Agent Harness band, and every agent-source-code location appears in
   its Context & Capabilities band. A harness on this inventory and not on the canvas means the
   canvas was filled from the intended architecture rather than the running one.
5. **All four rows of block B carry an Ours / Vendor's / Shared mark at column 17**, with the
   pre-marked Foundation row either confirmed or overridden in writing.
6. **The sheet carries both an inventory date and a re-inventory date (column 23).** Harness and
   client populations change faster than the architecture around them; an undated inventory will
   be quoted next quarter as current.
7. **At least one real complaint has been run through block C**, ending in a named part at column
   21 with evidence at column 22 — not in the word "Unknown" and not in the name of a vendor.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Four named parts with a definitional paragraph each; the sheet adds product/version, owner, standardised-or-not and known-variation columns.
- **Fill (the organisation completing it): `S`.** S - one sitting, data already in the room

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Already well structured — four named parts with one definitional paragraph each at lines 50-57 — so authoring cost is low. The CLIENT row is the one almost no organisation has inventoried: interactive terminals and IDE plugins plus programmatic clients (CI runners, webhook receivers, schedulers, agentic-workflow orchestrators) all count, and each is a separate trust boundary. The chapter also notes each layer can rewrite what lower layers see, which is worth a "who can inject a system prompt here?" column. Use the chapter's diagnostic question as the worksheet's purpose statement: not "what is wrong with the AI?" but "which of the four parts changed?"
