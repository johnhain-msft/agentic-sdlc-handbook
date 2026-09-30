# Review Loop Design Canvas

`WS-CS-HB-review-loop` &middot; **Pack Z - Second wave: the practitioner kit** &middot; fill order **13** &middot; type `canvas` &middot; audience **eng-leader** &middot; leadership priority **2**

> **Split back out in the re-opening pass.** Designs a draft-review-revise quality loop with a fixed verdict vocabulary, parallel reviewer proxies and a named synthesiser of conflicting fixes -- a process design, not a roster or a bundle definition.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A documented quality loop with named reviewer roles and a fixed verdict vocabulary, ready to encode as primitives.

**Cluster.** `CL-REVIEW-LOOP` - Review Loop Design: Reviewer Proxies and Verdict Vocabulary

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `case-study-handbook-writing.qmd` |
| Chapter | Writing a ~68,000-Word Book with Agent Fleets |
| Heading | The Draft→Review→Revise Cycle |
| Stable anchor | `#sec-cs-handbook-review-cycle` |
| Lines | L130-166 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/case-study-handbook-writing.html#sec-cs-handbook-review-cycle> |
| Locator quote | "Every chapter passed through an identical three-stage pipeline. This is the core quality loop" |

Resolve at any time with `python docs/resolve.py ws WS-CS-HB-review-loop`.

## 3. Source extract - the scaffolding, verbatim

```text
  130 | Every chapter passed through an identical three-stage pipeline. This is the core quality loop the book describes in Chapter 14.
  131 | 
  132 | ```{mermaid}
  133 | %%| fig-width: 5.0
  134 | %%| fig-cap: "The draft, review, revise cycle for each chapter"
  135 | %%| fig-alt: "Sequence diagram showing the chapter production cycle. The Orchestrator dispatches a chapter writing task with architecture spec and source material to the Draft Agent (Domain Specialist), who returns a 3,000 to 5,000 word draft. The Orchestrator then dispatches three parallel reviews: CTO Proxy reviews for executive audience, Dev Lead Proxy reviews for practitioner audience, and Chief Editor reviews for coherence and voice. All three return REVISE verdicts with fixes. The Orchestrator synthesizes consensus fixes, then dispatches the Revision Agent to apply the fixes. The Revision Agent returns the revised chapter, and the Orchestrator creates a checkpoint commit."
  136 | %%| label: fig-cs-draft-review-cycle
  137 | sequenceDiagram
  138 |     participant O as Orchestrator
  139 |     participant D as Draft Agent (Domain Specialist)
  140 |     participant R1 as CTO Proxy
  141 |     participant R2 as Dev Lead Proxy
  142 |     participant R3 as Chief Editor
  143 |     participant V as Revision Agent
  144 | 
  145 |     O->>D: Dispatch: Write chapter N<br/>(architecture spec + source material)
  146 |     D-->>O: Chapter draft (3,000-5,000 words)
  147 | 
  148 |     par Parallel Review
  149 |         O->>R1: Review for executive audience
  150 |         O->>R2: Review for practitioner audience
  151 |         O->>R3: Review for coherence + voice
  152 |     end
  153 | 
  154 |     R1-->>O: REVISE verdict + fixes
  155 |     R2-->>O: REVISE verdict + fixes
  156 |     R3-->>O: REVISE verdict + fixes
  157 | 
  158 |     O->>O: Synthesize consensus fixes
  159 |     O->>V: Dispatch: Apply N fixes to chapter
  160 |     V-->>O: Revised chapter
  161 |     O->>O: Checkpoint: commit draft + revision
  162 | ```
  163 | 
  164 | In later waves, the orchestrator batched reviews by persona rather than by chapter — sending one reviewer all 5 chapters at once rather than dispatching 15 separate reviews. This reduced dispatch overhead without sacrificing coverage, a practical application of *reduced scope* at the orchestration level.
  165 | 
  166 | ---
```

## 4. What the user fills

The team designs its own draft-review-revise loop: which reviewer proxies run in parallel (the case uses CTO Proxy, Dev Lead Proxy, Chief Editor), the verdict vocabulary each must return, who synthesises conflicting fixes into one instruction set, and where the checkpoint commit lands.

## 5. Field-level schema

Two regions. **Region A is the loop itself** — one row per design decision about the pipeline, filled
once. **Region B is the reviewer roster** — one row per reviewer proxy, and the rows are the proxies.
The case's own loop is pre-printed alongside as a worked exemplar (Draft Agent → three parallel
reviewer proxies → synthesis → Revision Agent → checkpoint commit), greyed and outside the fill area.
A3 landscape, one page, designed to be transcribed into primitives immediately afterwards.

**Region A — the loop design.**

| # | Field | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| A1 | What goes through the loop | `free text` | Exemplar: a chapter | Our artefact type, named precisely | case-study L130 |
| A2 | Draft stage — who drafts | `free text` | Exemplar: a Draft Agent acting as domain specialist | Our drafting persona | case-study L139 |
| A3 | What the draft stage receives | `free text` | Exemplar: an architecture spec plus source material | Our dispatch packet | case-study L145 |
| A4 | What the draft stage returns | `free text` | — | The artefact, and its expected shape | case-study L146 |
| A5 | Are reviews parallel? | `checkbox` | Pre-ticked — the case runs three reviews in parallel | Untick only with a reason in A6 | case-study L148-152 |
| A6 | Why, if not parallel | `free text` | — | — | derived |
| A7 | Batching unit | `select` — `by artefact` / `by reviewer` | The case moved to batching by reviewer in later waves — one reviewer receives several artefacts at once — to cut dispatch overhead without losing coverage | Our choice, and the reason for it | case-study L164 |
| A8 | **Verdict vocabulary** | `free text`, a closed list | Exemplar: the case's reviewers return a `REVISE` verdict plus fixes | The complete, closed set of verdicts a reviewer may return. Free-text verdicts are prohibited by construction | case-study L154-156 |
| A9 | Who synthesises conflicting fixes | `owner (named person)` or named agent | Exemplar: the orchestrator synthesises consensus fixes | Ours, named. Never "the team" | case-study L158 |
| A10 | Tie-break rule | `free text` | — | What happens when two proxies return incompatible fixes. A rule, written down, not a judgement made each time | derived from case-study L158 |
| A11 | Who applies the fixes | `free text` | Exemplar: a separate Revision Agent, not the drafter | Our revision stage | case-study L159-160 |
| A12 | Checkpoint commit — where | `free text` | Exemplar: a commit containing draft and revision together | Branch or path | case-study L161 |
| A13 | Checkpoint commit — what it contains | `free text` | — | Enough to reconstruct the round | case-study L161 |
| A14 | Loop ceiling | `free text` (integer) | — | How many draft-review-revise rounds before this escalates to a human decision. The organisation's own number | derived |
| A15 | Who the escalation goes to | `owner (named person)` | — | — | derived |
| A16 | Loop owner | `owner (named person)` | — | Who maintains the loop and its personas | org |

**Region B — the reviewer roster. One row per reviewer proxy.**

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Proxy name | `free text` | Exemplar names three: CTO Proxy, Dev Lead Proxy, Chief Editor | Ours | case-study L140-142 |
| 2 | Whose lens it reads as | `free text` | — | A named real role whose reading this proxy stands in for. "Reviewer 2" fails | case-study L140-142 |
| 3 | What it reviews for | `free text` | Exemplar: executive audience; practitioner audience; coherence and voice | Ours, in one line | case-study L149-151 |
| 4 | Persona file | `free text` | — | The path. Must resolve to a roster entry — see below | `WS-12-agent-persona-design-canvas` |
| 5 | Context it receives | `free text` | — | Its own slice. Proxies that receive identical context are one proxy | case-study L149-151 |
| 6 | Verdicts it may return | `select` from A8 | — | A subset of the closed vocabulary, or all of it | case-study L154-156 |
| 7 | Can it block? | `checkbox` | — | Does a change-requested verdict from this lens hold the checkpoint | derived from case-study L158 |
| 8 | Precedence when it conflicts | `select` — rank order across the roster | — | Feeds A10. Two proxies at the same rank need an explicit rule | derived |
| 9 | Human owner | `owner (named person)` | — | Who maintains this proxy and reads its output when it misfires | org |

**Absorbed detail.** None — this sheet absorbed no other candidate. It hands off in two directions
and the vocabularies must match: A10's tie-break rule is the input to
`WS-18-plan-charter-and-principles`, which is where a reviewer tie is ultimately broken at the
project level, and A12-A13 are the checkpoint contract that `WS-CS-APM-checkpoint-assertions`
asserts against. Use the same words for the same things in all three.

**Deliberate omission.** No artefact-size, word-count or draft-length figure appears on the sheet.
The case records a three-to-five-thousand-word chapter draft per dispatch; that is one project's
chapter length, and printing it beside a blank would read as a recommended dispatch size for work
that is not a book. A4 asks for the artefact's expected *shape*, not its length. Equally no quality
score, reviewer-agreement rate or first-pass-acceptance metric: the loop's output is a revised
artefact and a checkpoint, and counting rounds is A14's job as a ceiling, not a KPI.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-12-agent-persona-design-canvas` - Specialist Agent Roster and Persona Canvas (Pack Z - Second wave: the practitioner kit, fill order 1)

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** WS-18-plan-charter-and-principles (what breaks a reviewer tie) and WS-CS-APM-checkpoint-assertions

## 8. Facilitation

| | |
|---|---|
| Who fills it | The engineering leader who owns the quality bar for the artefact in A1, with the person who will actually run the orchestration. Bring one of the humans whose lens a proxy will stand in for — the real dev lead, or the real editor — because row 2 of Region B is a claim about how that person reads, and it is cheaper to check it with them than to discover the proxy has been reviewing for the wrong thing after a fortnight. |
| When in the session | Pack Z, after `WS-12-agent-persona-design-canvas`. The roster comes first: reviewer proxies are drawn from it, and column 4 of Region B has to resolve to real persona entries rather than inventing them here. The condition that makes this worth running: **the pilot domain is chosen and there is a real, recurring artefact going through review today**. This is an execution instrument, not a strategy one — designing a review loop for work the organisation has not started producing yields a diagram nobody can falsify. |
| Duration | 90 minutes to two hours. Region B goes quickly once the roster exists. The time goes to A8 and A10: agreeing a closed verdict vocabulary takes longer than anyone expects, and the tie-break rule is where the room discovers it has never actually decided who wins when the security lens and the delivery lens disagree. |
| Data needed in advance | The completed `WS-12-agent-persona-design-canvas`; two or three real examples of the artefact in A1, including one that went badly; a description of how this artefact is reviewed by humans today and who currently signs it off, because that is what A9 and Region B column 8 are formalising rather than inventing; and the team's existing checkpoint or commit conventions for A12. |
| Room format | A board or canvas with Region A down the left and the roster as a grid on the right, with the case's exemplar loop pinned beside it. Draft on the board, then encode as primitives the same week — a review loop that stays a diagram decays into an informal habit, which is the state it was supposed to replace. |

**Facilitation note.** The transferable insight here is the reviewer proxy itself, and it deserves
foregrounding rather than being left implicit in the diagram: an agent configured to read as the CTO
would, another to read as the dev lead would, a third for coherence and voice — three readings of the
same artefact, produced in parallel, that cannot contaminate one another because they cannot see one
another. Say it that way. Teams that hear "three reviews" build one reviewer with three checklists,
which is the thing the parallel structure exists to prevent.

One practical point worth passing on from the case: it moved in later waves from batching **by
artefact** to batching **by reviewer** — sending one proxy several artefacts at once instead of
dispatching a separate review per artefact per lens — and found this cut dispatch overhead without
sacrificing coverage. A7 exists so the room makes that choice deliberately rather than discovering it
months later. It is the same reduced-scope instinct applied one level up, at the orchestration layer.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **At least three reviewer proxies, each reading as a named real role in Region B column 2.**
   "Reviewer 1", "Technical review" and "General QA" all fail: a proxy that does not stand in for a
   specific person's reading is a second opinion, not a lens, and adds cost without adding coverage.
2. **A8 contains a closed verdict vocabulary, written out in full**, and every proxy's column 6 draws
   from it. If a reviewer can return prose where a verdict belongs, A9 is synthesising opinions
   rather than verdicts and the synthesis step cannot be automated or audited.
3. **A9 names an individual or a specific agent, and A10 states a rule.** "The orchestrator decides",
   "we'd discuss it" and "consensus" are not tie-break rules. The test: given two proxies returning
   incompatible fixes, could someone who was not in this session apply A10 and get the same answer
   twice?
4. **Every proxy declares whether it can block (column 7) and its precedence (column 8)**, with no
   two proxies sharing a rank unless A10 explicitly covers that case. A roster where every proxy
   blocks is a loop that never closes; one where none blocks is advisory and should be labelled so.
5. **A12 and A13 are both filled.** A checkpoint whose contents are unspecified cannot be asserted
   against, and `WS-CS-APM-checkpoint-assertions` consumes exactly these two fields.
6. **A14 and A15 are filled.** A draft-review-revise loop with no round ceiling and no named
   escalation is an unbounded loop, and the cost of discovering that is a fortnight of rounds that
   each improved something and settled nothing.
7. **Reconciliation with `WS-12-agent-persona-design-canvas`: every persona path in Region B column 4
   resolves to an entry on that roster.** A proxy with no persona file behind it is a prompt in a
   review loop's clothing. Conversely, a roster entry the loop uses but which the canvas does not
   carry means the roster is out of date and goes back for amendment.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** The source is a full sequence diagram with parallel review, explicit verdicts, a synthesis step and a checkpoint commit, so the canvas is mostly relabelling.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Source is a full sequence diagram with parallel review, explicit REVISE verdicts, a synthesis step and a checkpoint commit - structured enough that the canvas is mostly relabelling. The reviewer-proxy idea (an agent that reads as the CTO would, another as the dev lead would) is the transferable insight and deserves foregrounding. Priority 2: valuable, but it is an execution instrument the org designs once the pilot domain is chosen.
