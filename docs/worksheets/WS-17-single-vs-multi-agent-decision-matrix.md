# Single Agent or Many? Scoping Decision Matrix

`WS-17-single-vs-multi-agent-decision-matrix` &middot; **Pack D - Architecture and ownership** &middot; fill order **9** &middot; type `decision` &middot; audience **practitioner** &middot; leadership priority **3**

> **Split back out in the re-opening pass.** A per-change scoping verdict with a local recalibration field that replaces the book's explicitly unmeasured 10-15 file boundary; used per change, whereas the topology standard is set once per organisation.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A one-page scoping verdict with the reasoning recorded, and over time a locally calibrated file-count threshold replacing the book's 10-15 default.

**Cluster.** `CL-AGENT-COUNT-DECISION` - Single Agent or Many: Per-Change Scoping Verdict

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch17-multi-agent-orchestration.qmd` |
| Chapter | Multi-Agent Orchestration |
| Heading | When One Agent Is Enough |
| Stable anchor | `#sec-multi-agent-when-one-agent` |
| Lines | L16-45 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch17-multi-agent-orchestration.html#sec-multi-agent-when-one-agent> |
| Locator quote | "Not every task requires multiple agents. The overhead of orchestration (partitioning work," |

Resolve at any time with `python docs/resolve.py ws WS-17-single-vs-multi-agent-decision-matrix`.

## 3. Source extract - the scaffolding, verbatim

```text
   16 | Not every task requires multiple agents. The overhead of orchestration (partitioning work, managing sessions, resolving conflicts, validating independently) is real. If the task fits comfortably in a single agent's context, the single agent is the better choice.
   17 | 
   18 | A single agent is sufficient when:
   19 | 
   20 | - **Scope is narrow.** The change touches fewer than 10 files in a single module.
   21 | - **Concern is singular.** One type of change (fix logging, update types, add tests), not three interleaved concerns.
   22 | - **Dependencies are linear.** Each file change follows naturally from the previous one, with no need for parallel work.
   23 | - **Context budget is adequate.** The agent can hold all relevant source files, instructions, and conversation history without exceeding roughly 60% of its window capacity, leaving room for reasoning.
   24 | 
   25 | A single agent breaks down when:
   26 | 
   27 | - **Multiple concerns intersect.** The change requires architectural knowledge and domain expertise and security awareness. One agent cannot hold all three specialization contexts simultaneously without dilution.
   28 | - **File count exceeds context capacity.** More than 15-20 files means the agent cannot see all the code it needs to modify.
   29 | - **Parallelism would reduce wall-clock time significantly.** Five independent file groups that could be modified simultaneously instead take five times as long sequentially.
   30 | 
   31 | The decision matrix:
   32 | 
   33 | | Dimension | Single agent | Multiple agents |
   34 | |---|---|---|
   35 | | Files changed | < 10 | > 15 |
   36 | | Concerns | 1 | 2+ |
   37 | | File dependencies | Linear | Graph (can parallelize) |
   38 | | Required expertise | One domain | Multiple domains |
   39 | | Time pressure | Low | Moderate to high |
   40 | | Risk of context overload | Low | High |
   41 | 
   42 | The boundary at 10-15 files is approximate and experience-derived, though not precisely measured. It reflects the practical limit where a single agent's conversation history — accumulated tool calls, file reads, edit confirmations, test output — begins consuming enough context to crowd out the instructions and source code that the agent needs to do its work well. Your mileage will vary by model, task complexity, and instruction file size.
   43 | 
   44 | When the decision is marginal, err toward a single agent. Coordination costs are real. Multi-agent orchestration is a tool for tasks that exceed single-agent capacity, not a default mode of operation.
   45 | 
```

## 4. What the user fills

For the change in hand, score each of the six dimensions from the book's matrix - files changed, number of concerns, file dependency shape (linear or graph), required expertise, time pressure, risk of context overload - then tick the sufficiency and breakdown criteria and record the verdict plus the reason. A calibration field captures the team's own file-count boundary once it has data.

## 5. Field-level schema

One side of A4 per change, kept with that change's plan; block E lives on the back of a **single
running sheet the team keeps**, not on each copy, because a calibration needs a series and
per-copy logging loses it. The book's indicator columns print **grey and italic**; the
organisation's own boundary at column 4 prints black and sits to their right, because as soon as
block D is filled it supersedes them and the layout has to say so.

**Block A — the six-dimension matrix.**

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Dimension | `select` (fixed 6) | Files changed / Concerns / File dependencies / Required expertise / Time pressure / Risk of context overload | — | ch17 L35-40 |
| 2 | *Prior — single agent* | `free text` (grey italic, read-only) | < 10 / 1 / Linear / One domain / Low / Low. **The file-count boundary is described in the book itself as "approximate and experience-derived, though not precisely measured".** | — | ch17 L35-40, L42 |
| 3 | *Prior — multiple agents* | `free text` (grey italic, read-only) | > 15 / 2+ / Graph (can parallelise) / Multiple domains / Moderate to high / High | — | ch17 L35-40 |
| 4 | **Our boundary in force** | `free text` | — | Carried from block D. Until block D is set this cell reads `using the book's prior` | ch17 L42 |
| 5 | This change | `free text` | — | The actual value, for the change in hand | derived |
| 6 | Points to | `select` Single / Multiple / Marginal | — | Scored against column 4 where it is filled, otherwise against columns 2-3 | ch17 L33 |
| 7 | Confidence | `H/M/L` | — | **H** — counted from the actual diff or file list. **M** — estimated from a similar recent change. **L** — a guess | derived |

**Block B — sufficiency and breakdown criteria.** Seven fixed rows.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 8 | Criterion | `select` (fixed 7, grouped) | *Sufficient when:* Scope is narrow / Concern is singular / Dependencies are linear / Context budget is adequate. *Breaks down when:* Multiple concerns intersect / File count exceeds context capacity / Parallelism would reduce wall-clock time significantly | — | ch17 L20-23, L27-29 |
| 9 | What the book says | `free text` (printed) | **Scope is narrow** — fewer than 10 files in a single module. **Concern is singular** — one type of change, not three interleaved concerns. **Dependencies are linear** — each file change follows naturally from the previous one, with no need for parallel work. **Context budget is adequate** — the agent can hold all relevant source files, instructions and conversation history without exceeding *roughly* 60% of its window capacity, leaving room for reasoning. **Multiple concerns intersect** — architectural knowledge and domain expertise and security awareness at once; one agent cannot hold three specialisation contexts without dilution. **File count exceeds context capacity** — more than 15-20 files and the agent cannot see all the code it needs to modify. **Parallelism would reduce wall-clock time significantly** — five independent file groups that could be modified simultaneously instead take five times as long sequentially | — | ch17 L20-23, L27-29 |
| 10 | Met? | `select` Yes / Partial / No | — | — | derived |
| 11 | Note | `free text` | — | One line where the answer is Partial | derived |

**Block C — verdict.**

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 12 | Verdict | `select` Single agent / Multiple agents | — | — | ch17 L16 |
| 13 | Reason, in one line | `free text` | — | The reasoning is the point of recording the verdict at all | derived |
| 14 | Was the decision marginal? | `checkbox` | — | Ticked where column 6 returned `Marginal` on two or more dimensions | ch17 L44 |
| 15 | Tie-break | `checkbox` + printed rule | Printed as the sheet's footer: **"When the decision is marginal, err toward a single agent. Coordination costs are real. Multi-agent orchestration is a tool for tasks that exceed single-agent capacity, not a default mode of operation."** | Tick to confirm the tie-break was applied, or write the override and who authorised it at column 13 | ch17 L44 |
| 16 | If multiple — topology chosen | `select` (from `WS-17-orchestration-topology-selector`) | — | Must be a sanctioned topology | derived |
| 17 | Decided by / date | `owner (named person)` + `date` | — | — | derived |

**Block D — local calibration record.** The block the chapter's own caveat requires, and the
reason this sheet does not hard-code a number.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 18 | Our boundary — single agent below | `free text` | *Prior: fewer than 10 files* | Our own value, set from block E | ch17 L35, L42 |
| 19 | Our boundary — multiple agents above | `free text` | *Prior: more than 15 files* | Our own value | ch17 L35, L42 |
| 20 | Basis for our boundary | `free text` | — | How many logged outcomes it rests on, and which. Reads `insufficient data` until block E has entries | ch17 L42 |
| 21 | Conditions this boundary applies to | `free text` | Reference, printed: *"Your mileage will vary by model, task complexity, and instruction file size."* A boundary is valid only for the conditions it was observed under | Our model, our task type, our instruction-file size | ch17 L42 |
| 22 | Our context-budget headroom rule | `free text` | *Prior: roughly 60% of window capacity, leaving room for reasoning — a rule of thumb the book states without measuring* | Our own, once the harness reports usable numbers | ch17 L23 |
| 23 | Threshold inherited from the coordination-tax calculator | `free text` | — | The go/no-go threshold recorded at `WS-17-coordination-tax-calculator` column 33. Must not contradict columns 18-19 | derived |
| 24 | Calibration set by / on / review by | `owner (named person)` + `date` + `date` | — | A boundary with no review date will outlive the model it was measured against | ch17 L42 |

**Block E — outcome log.** On the back of the team's running sheet; filled after the change ships.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 25 | Change | `free text` | — | — | derived |
| 26 | Verdict taken | `select` Single / Multiple | — | — | derived |
| 27 | Files actually touched | `free text` (count) | — | The counted figure, not the estimate from column 5 | derived |
| 28 | Did the verdict hold? | `select` Held / Should have been single / Should have been multiple | — | — | derived |
| 29 | What told us | `free text` | — | Context degradation observed, rework cycles needed, file-ownership conflicts hit, or none of these | ch17 L42 |
| 30 | Boundary adjustment indicated? | `checkbox` | — | Feeds block D at the next review date | ch17 L42 |

**Absorbed detail.** This sheet absorbed no other candidate. It is the per-change counterpart to
`WS-17-orchestration-topology-selector`, which is set once for the organisation: this one decides
*whether* to orchestrate, that one decides *how*, and column 16 is the join between them.

**Deliberate omission.** No weighted score and no composite total across the six dimensions. The
book supplies a matrix to read, not a formula, and a total would manufacture exactly the precision
the source disclaims one paragraph later. More importantly, **no single operative file-count
number is printed anywhere in black.** The 10-15 boundary appears only in the grey prior columns,
superseded by column 4 the moment the organisation sets its own — because the chapter states
plainly that the boundary is approximate, experience-derived and not precisely measured, and a
number printed in the same weight as an instruction becomes a rule within one sprint.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-17-coordination-tax-calculator` - The Coordination Tax Calculator: When Does Orchestration Pay? (Pack D - Architecture and ownership, fill order 7)

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** WS-18-wave-decomposition-plan when the verdict is multi-agent; the tie-break rule feeds WS-17-coordination-tax-calculator.

## 8. Facilitation

| | |
|---|---|
| Who fills it | Whoever is about to do the change, with one other engineer to challenge the file count. This is a per-change instrument, not a workshop artefact — in steady state it is filled by one person in a few minutes at scoping time. Block D is different: it is set and reviewed by whoever owns the team's orchestration practice, and it needs the block E log in front of them. |
| When in the session | After `WS-17-coordination-tax-calculator`, its declared prerequisite, which supplies the threshold at column 23. In a workshop, run it once against a real recent change so the team sees the shape. In use, it runs **before any agent is dispatched** — a verdict recorded afterwards is a justification, not a decision. |
| Duration | 10-15 minutes per change once the team is familiar with it. Budget 30 minutes the first time, most of which goes on block D and on establishing that the honest entry there is `using the book's prior` and `insufficient data`. Block E is filled after the change ships, not during the sitting. |
| Data needed in advance | The file list, or a close estimate of it; the concerns in play; whether the files form a dependency chain or a graph; and the threshold recorded at column 33 of `WS-17-coordination-tax-calculator`. The file list is the input that most often turns out to be a guess, which is why column 7 records confidence separately. |
| Room format | Single side of A4 per change, filed with the change's plan. One running sheet per team carries block E on its back. Do not rebuild this as a spreadsheet without preserving the grey-versus-black distinction between the prior columns and column 4 — that typography is the sheet's only defence against the book's own unmeasured number hardening into a local rule. |

**Facilitation note carried from ch17.** Read the caveat before the matrix, not after it. The
chapter says of its own boundary: *"The boundary at 10-15 files is approximate and
experience-derived, though not precisely measured. It reflects the practical limit where a single
agent's conversation history — accumulated tool calls, file reads, edit confirmations, test output
— begins consuming enough context to crowd out the instructions and source code that the agent
needs to do its work well. Your mileage will vary by model, task complexity, and instruction file
size."* That is why block D exists and why it is the first block a team should fill in, even if
the only honest entry is that there is no local data yet.

Then the tie-break, which is the footer and the closing instruction: when the decision is
marginal, err toward a single agent. Coordination costs are real, and multi-agent orchestration
is a tool for tasks that exceed single-agent capacity, not a default mode of operation. Teams new
to orchestration reach for it because it is interesting; this sheet exists to make that reach
visible and to bias it the other way.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All six dimensions carry a value at column 5, a direction at column 6 and a confidence at
   column 7.** A dimension scored `L` on confidence is not a defect, but two or more of them mean
   the verdict rests on guesses and the file list should be produced before dispatching anything.
2. **Once block D is set, every dimension is scored against column 4 and not against the grey
   prior columns**, and the printed artefact keeps the two visually distinct. If a completed sheet
   shows scoring against columns 2-3 while block D holds local values, the calibration exists on
   paper only.
3. **Block D either carries the organisation's own boundary with a stated basis at column 20, or
   reads `using the book's prior` with `insufficient data`, and column 21 names the model, task
   type and instruction-file size the boundary applies to.** A local boundary presented without a
   basis and without its conditions is the book's explicitly unmeasured figure wearing the
   organisation's name, which is precisely the laundering this sheet is built to prevent.
4. **Where the decision was marginal (column 14), the verdict at column 12 is single agent** — or
   the override is written at column 13 with the name of whoever authorised it.
5. **Reconciliation with `WS-17-coordination-tax-calculator`.** Column 23 carries that sheet's
   threshold, and it does not contradict columns 18-19. Where it does, one of the two sheets is
   working from stale data and the conflict is resolved before the change is dispatched.
6. **Where the verdict is multiple agents, column 16 names a topology sanctioned in
   `WS-17-orchestration-topology-selector`.** An unsanctioned topology is out of bounds whatever
   this sheet scores; the organisation-wide standard is not overridden by a per-change verdict.
7. **Block D's review date at column 24 is set, and at least one block E outcome exists before
   columns 18-19 hold anything other than the book's prior.** Calibration without a logged series
   is substitution, not measurement.

## 10. Integrity constraint

**Named rule for this sheet.** The 10-15 file boundary is 'approximate and experience-derived, though not precisely measured'. The sheet must carry a recalibration field rather than hard-coding it.

**Hedged figures reachable from this source range.** Each is listed with the book's own hedge, verbatim, and where that hedge lives. Present the figure as a pre-filled prior the organisation overwrites, or as a facilitation prompt - never as a benchmark, target or acceptance threshold. **Carry the hedge onto the sheet with the number; do not restate it in your own words.**

- **The single-versus-multi-agent boundary at 10-15 files, the >15-20 breakdown signal, and the 60%-of-window context budget guideline.**
  - *Appears at* `handbook\ch17-multi-agent-orchestration.qmd` L14-46
  - *The book's hedge (ch17 L42):* 'The boundary at 10-15 files is approximate and experience-derived, though not precisely measured.' Note the chapter gives three different boundaries (L35 '<10 / >15', L28 '15-20', L373 'exceeds 20') and never reconciles them.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** The six-dimension decision matrix needs only a 'your score' column, exactly like the ch02 seed table.
- **Fill (the organisation completing it): `S`.** S - one sitting, data already in the room

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Already near-worksheet: the decision matrix at lines 33-40 needs only a "your score" column, exactly like the ch02 seed. Practitioner-facing per-change instrument, so priority 3 - but it is the cheapest sheet in the chapter to produce and the one a team will use most often. IMPORTANT CAVEAT to carry onto the sheet: the book says at line 42 that the 10-15 file boundary is "approximate and experience-derived, though not precisely measured" and that mileage varies by model, task and instruction size - so the worksheet must include the recalibration field rather than hard-coding the number. The tie-break rule at line 44 ("When the decision is marginal, err toward a single agent") is the footer.
