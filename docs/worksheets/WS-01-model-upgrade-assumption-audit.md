# Tooling Assumption Audit: What a Better Model Will Not Fix

`WS-01-model-upgrade-assumption-audit` &middot; **Pack C - The case and the money** &middot; fill order **1** &middot; type `assessment` &middot; audience **exec** &middot; leadership priority **1**

> **Split back out in the re-opening pass.** An assumption register containing no cost arithmetic, filled by executives with no finance input; it is the opening exercise that pre-empts 'wait for the next model', not a block of a break-even model.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A one-page assumption register that pre-empts the "let's wait for the next model" objection before it reaches the steering committee.

**Cluster.** `CL-TOOLING-ASSUMPTION` - Tooling Assumption Audit: What a Better Model Will Not Fix

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch01-the-agentic-sdlc-thesis.qmd` |
| Chapter | The Agentic SDLC Thesis |
| Heading | Why Tools Aren't the Answer |
| Stable anchor | `#sec-thesis-tools-not-the-answer` |
| Lines | L37-49 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch01-the-agentic-sdlc-thesis.html#sec-thesis-tools-not-the-answer> |
| Locator quote | "The natural instinct is to blame the tools and wait for better ones." |

Resolve at any time with `python docs/resolve.py ws WS-01-model-upgrade-assumption-audit`.

## 3. Source extract - the scaffolding, verbatim

```text
   37 | The natural instinct is to blame the tools and wait for better ones. Next quarter's model will have a larger context window. Next year's agent will be smarter. The reasoning is intuitive: if the AI isn't good enough, get a better AI.
   38 | 
   39 | This reasoning is wrong, and understanding why it's wrong is the foundation of everything that follows.
   40 | 
   41 | Three properties of language models are structural. They hold regardless of model size, architecture, or provider. They will hold for the foreseeable future.
   42 | 
   43 | **Context is finite and fragile.** Every language model operates within a context window — a fixed capacity for the information it can consider at once. Attention within that window is not uniform; information competes for focus, and content far from the point of attention gets lost. A larger window does not solve this. Doubling the window and doubling the input leaves you in the same place, or worse, because the model now has more irrelevant material competing for attention. Context is a scarce resource that degrades under load.
   44 | 
   45 | **Context must be explicit.** Agents can only work with externalized knowledge. The architectural decision your team made in a meeting last month, the convention that "everyone knows" but no one documented, the implicit agreement about how modules interact — these are invisible to AI. Models are stateless. What isn't in the context window doesn't exist for the agent. Your codebase contains two kinds of knowledge: what's written in the code, and what's understood by the people who wrote it. AI has access to the first kind only.
   46 | 
   47 | **Output is probabilistic.** The same input can produce different outputs. Language models interpret rather than execute; variance is inherent, not a bug to be fixed. Determinism comes from constraints, structure, and grounding, not from the model itself. This means reliability must be *architected*, not assumed. Unlike a compiler that either accepts or rejects your code, a language model *always produces something* — making quality failures silent and insidious.
   48 | 
   49 | These three properties are why better models don't solve the Vibe Coding Cliff. A more powerful model working with unstructured, incomplete, or noisy context doesn't necessarily produce better results. It can produce more confident wrong answers, faster. The failure mode of a weak model is obvious: it can't do the task. The failure mode of a strong model with poor context is insidious: it often produces plausible output that looks correct and can silently violate your system's invariants. Context windows have grown roughly 100–1,000× in five years, from GPT-3's 2,048 tokens in 2020 to the 200K–2M tokens available in current frontier models[^ch1-context], yet satisfaction with AI on complex engineering tasks has not kept pace[^ch1-satisfaction]. The bottleneck was never raw capacity. It was the structure of what fills that capacity.
```

## 4. What the user fills

Against each of the three structural properties (context is finite and fragile, context must be explicit, output is probabilistic), leaders write where the current plan, budget or timeline silently assumes a future model release solves the problem - and what they will do instead.

## 5. Field-level schema

One row per structural property. The three property names, their one-line statements and their
failure modes are **pre-printed from ch01 L43-49**; the organisation supplies the assumption, the
evidence, the alternative action and the owner. One page, portrait, signed at the foot. The three
rows are fixed — the sheet does not accept a fourth, because a fourth invites the room to add the
property it wishes were structural.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Structural property | `select` (fixed 3 rows) | Context is finite and fragile / Context must be explicit / Output is probabilistic | — | ch01 L43-47 |
| 2 | What holds regardless of model | `free text` (read-only) | "Context is a scarce resource that degrades under load" / "What isn't in the context window doesn't exist for the agent" / "Determinism comes from constraints, structure, and grounding, not from the model itself" | — | ch01 L43-47 |
| 3 | Why a bigger or better model does not fix it | `free text` (read-only) | Doubling the window and doubling the input leaves you in the same place, or worse / Models are stateless; undocumented knowledge is invisible to them / A language model always produces something, which makes quality failures silent | — | ch01 L43-47 |
| 4 | Where our plan, budget or timeline assumes a future release fixes this | `free text` | — | The specific assumption, in one sentence | org |
| 5 | Evidence the assumption is being made | `free text` | — | The document, slide, budget line or sentence it lives in — locatable by someone else | org |
| 6 | Confidence a model release would actually fix it | `H/M/L` | — | Argued in the room, not scored by formula | derived |
| 7 | What we will do instead | `free text` | — | An action: a thing to build, document, decide or measure | ch01 L49 intent |
| 8 | Owner | `owner (named person)` | — | A named individual, never a function or a team | org |
| 9 | First review date | `date` | — | When the row is re-read, not when the work finishes | org |
| — | Failure-mode asymmetry acknowledged | `checkbox` | Printed verbatim: the failure mode of a weak model is obvious — it can't do the task; the failure mode of a strong model with poor context is insidious | Tick to confirm the room has read it | ch01 L49 |
| — | Sponsor signature + date | `signature` | — | The executive who will be asked "why aren't we waiting?" | org |

**Printed on the sheet as a prior, not a target.** A footer strip carries the book's historical
exhibit with its citation intact: context windows have grown roughly 100–1,000× in five years,
from GPT-3's 2,048 tokens in 2020 to the 200K–2M available in current frontier models, yet
satisfaction with AI on complex engineering tasks has not kept pace (ch01 L49, with the chapter's
two footnotes reproduced). It sits in a boxed strip below the table with no adjacent blank cell,
because it is evidence for the sheet's premise and there is nothing for the organisation to fill
in against it.

**Deliberate omission.** No column naming a model, vendor or expected release. Naming a SKU dates
the sheet and, worse, reopens the exact wait the instrument exists to close — the room starts
debating whether *that* release would have fixed the row. Also no quantitative context-window
column: the properties are structural, so a token count is not the variable under discussion.

**Deliberate omission.** No cost or benefit column anywhere on the sheet. This is the one Pack C
instrument that carries no arithmetic; the money starts at `WS-03-tco-calculator`.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- None. This sheet can be filled cold.

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** WS-02-cost-of-delay-case

## 8. Facilitation

| | |
|---|---|
| Who fills it | The CTO or VP Engineering, the executive sponsor, and whoever currently holds the tooling budget line. **Finance is deliberately not in the room.** This is the only sheet in Pack C that carries no arithmetic, and inviting the CFO to an assumption audit converts it into a budget conversation before the assumptions have been written down. The CFO arrives at `WS-03-tco-calculator`. |
| When in the session | First. Fill order 1, no prerequisites, filled cold. It is the opening exercise of the pack precisely because it pre-empts the "let's wait for the next model" objection before the money sheets make that objection expensive to answer. Running it after the ROI model means the room is defending a number instead of examining a belief. |
| Duration | 30–40 minutes. Three rows. Columns 1–3 are pre-printed, so all the time goes into column 4 — and the first honest answer usually arrives about fifteen minutes in, after the room has finished saying that it makes no such assumption. |
| Data needed in advance | The current adoption plan or budget deck, in whatever form exists; any roadmap slide that defers a decision to a future tool, model or vendor release; the current annual spend on AI tooling; and any written business case already circulating. The facilitator should read these beforehand and arrive with two or three candidate assumptions already underlined, because the room will not volunteer them. |
| Room format | Three flip-chart sheets on the wall, one per property, or a single projected table filled live. Not pre-work: the value is in one executive hearing another say out loud that the plan is waiting on something. Keep the completed sheet visible on the wall for the rest of Pack C. |

**Facilitation note.** This is the natural opening exercise for the executive block and it pairs
directly with ch02's "Inaction Is a Decision" — the same argument, run forwards here and backwards
on `WS-02-cost-of-delay-case`. Carry column 7 across: what the room writes as "what we will do
instead" is the input to the 90-day mitigation column of the delay case, and the two sheets should
be legible against each other at the end of the pack. If the room genuinely produces three empty
column-4 cells, do not accept it and move on; ask instead which decision the organisation has
deferred in the last six months and why, and the assumption will surface in the answer.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All three properties carry a named assumption in column 4**, or an explicit written statement
   that the plan makes no such assumption — with the evidence in column 5 that was examined to
   reach that conclusion. A blank cell is not an answer; it records that nobody looked.
2. **Every column-4 entry cites a locatable artefact in column 5.** A document, a slide number, a
   budget line, a sentence someone else can go and read. An assumption nobody can point at cannot
   be challenged, which makes it exactly the kind that survives a steering committee.
3. **Every "what we will do instead" is an action, not a posture.** It names something to build,
   document, decide or measure. "Monitor the market", "stay close to the vendor" and "revisit next
   quarter" are struck and re-written.
4. **No row's mitigation is a model upgrade, a tool purchase or a vendor change.** That is the
   assumption the sheet exists to surface; if one appears in column 7, the row has not been
   completed — it has been restated. Re-run it.
5. **Every row names an individual owner and a first review date.** Not a function, not a team, not
   "the architecture group". The register is unowned otherwise.
6. **The failure-mode asymmetry has been read aloud and ticked.** The room should be able to say,
   unprompted, why a stronger model with poor context is a worse problem than a weaker one — that
   sentence is the entire argument for everything Pack C spends money on afterwards.
7. **The sheet is signed, dated, and column 7 is carried forward** into the 90-day mitigation
   column of `WS-02-cost-of-delay-case`. An unsigned copy is a discussion, not a register.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** Pure prose with zero structure; the three-property row set and the 'what we will do instead' column are net-new.
- **Fill (the organisation completing it): `S`.** S - one sitting, data already in the room

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Pure prose (lines 41-47), zero structure - needs authoring. High value per minute: it converts a passive wait-and-see posture into a written, challengeable assumption, which is exactly the move the pre-groundbreaking session needs early. Natural opening exercise for the exec block. Pairs directly with ch02 "Inaction Is a Decision".
