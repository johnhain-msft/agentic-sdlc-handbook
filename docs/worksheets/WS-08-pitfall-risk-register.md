# Transition Risk Register — Six Predictable Failure Modes

`WS-08-pitfall-risk-register` &middot; **Pack G - The plan we leave with** &middot; fill order **8** &middot; type `diagnostic` &middot; audience **mixed** &middot; leadership priority **1**

> **Split back out in the re-opening pass.** Pre-mortems the plan just drafted (six transition pitfalls with early-warning signals and watchers) rather than the technology; it depends on the roadmap, a dependency the merged position made unsatisfiable.
>
> Ships as: `standalone`

## 1. Purpose

**Output artifact.** A pre-mortem risk register completed before work starts, with an owner and a named early-warning signal per risk — the artifact that converts six known failure modes into six monitored ones.

**Cluster.** `CL-TRANSITION-RISK` - Transition Risk Register: Six Predictable Failure Modes

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `handbook\ch08-planning-the-transition.qmd` |
| Chapter | Planning the Transition |
| Heading | Common Transition Pitfalls |
| Stable anchor | `#sec-transition-pitfalls` |
| Lines | L240-252 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/handbook/ch08-planning-the-transition.html#sec-transition-pitfalls> |
| Locator quote | "Six patterns that derail transitions. Each is predictable and preventable." |

Resolve at any time with `python docs/resolve.py ws WS-08-pitfall-risk-register`.

## 3. Source extract - the scaffolding, verbatim

```text
  240 | Six patterns that derail transitions. Each is predictable and preventable.
  241 | 
  242 | **1. The premature rollout.** Scaling before the pilot has produced foundational lessons — a working context layer, a validated review process, metrics that show a trend. Premature acceleration typically costs multiples of the time saved in later remediation when unprepared teams have bad experiences.
  243 | **2. The mandate without infrastructure.** Leadership announces all teams will use agentic tools by Q3. No investment in context engineering. No training. No governance updates. Developers receive a tool and a deadline. Adoption is shallow and resentful.
  244 | 
  245 | **3. The wrong metric.** Measuring lines of code, PR volume, or tool usage frequency instead of quality and effectiveness metrics. Teams optimize for whatever is measured, and optimizing for volume with generative AI tools produces more code, not better software.
  246 | 
  247 | **4. The hero pilot.** The pilot team includes your three best developers and a greenfield project. The pilot succeeds brilliantly. Nothing learned transfers to a team of mixed seniority working on a legacy codebase. Select pilot teams that are representative, not exceptional.
  248 | 
  249 | **5. The missing middle.** Investing in executive strategy and practitioner tools but not in organizational connective tissue: shared context assets, coaching capacity, governance processes. The gap between "leadership approves" and "developers succeed" is filled by middle management, team leads, and staff engineers. If they are not equipped, the transition stalls.
  250 | 
  251 | **6. The permanence assumption.** Treating agentic development as a one-time transformation rather than an ongoing practice. Context goes stale. Tools evolve. Team composition changes. The transition is not a project with a completion date — it is the beginning of a continuous capability that requires continuous investment.
  252 | 
```

## 4. What the user fills

Six pre-written risk rows (premature rollout, mandate without infrastructure, the wrong metric, the hero pilot, the missing middle, the permanence assumption). Per row the group scores likelihood in THIS organization high/medium/low, writes the early-warning signal they would actually see, names the owner who watches for it, and writes the mitigation already funded in the plan. Blank rows at the bottom for organization-specific risks.

## 5. Field-level schema

Rows are the six named pitfalls, pre-printed in the chapter's order, followed by four blank rows
for organisation-specific risks. One page, A3 portrait, and it is read next to the roadmap it
pre-mortems — this sheet interrogates the plan the room has just drawn, not the technology.

**The kit's shared risk scale.** Identical wording to `WS-20-nineteen-failure-mode-premortem`, so
the two registers can be laid side by side and read as one view.

*Likelihood here* — `High` / `Medium` / `Low`:

- **High** — we have already seen it, or a named precondition for it is present in our environment today.
- **Medium** — no precedent here, but nothing in our current practice would prevent it.
- **Low** — a named, existing control would catch it before it did harm. Name the control or the rating is not Low.

*Impact here* — `Critical` / `High` / `Medium` / `Low`. The first three are the book's own printed
severity vocabulary (ch20 L169-289); `Low` is added as the floor so the scale has one.

- **Critical** — corrupts the codebase or crosses a trust boundary, and is discovered late or not at all.
- **High** — costs a wave or a sprint of rework, or loses the room's confidence in the programme.
- **Medium** — costs hours, and is visible at the next checkpoint.
- **Low** — an irritation absorbed inside the normal loop.

*Watch band* is derived by rule, not by arithmetic: **Band 1** = `High` likelihood with `Critical`
or `High` impact; **Band 2** = any other pairing containing a `Critical` or `High`; **Band 3** =
everything else. No weighting, no multiplication, no index.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Pitfall number | `computed` (fixed) | 1–6, then 7+ for org-specific rows | — | ch08 L242-251 |
| 2 | Pitfall | `free text` (locked on rows 1–6) | The premature rollout · The mandate without infrastructure · The wrong metric · The hero pilot · The missing middle · The permanence assumption | The name, on org-specific rows only | ch08 L242-251 |
| 3 | What it looks like | `free text` (locked on rows 1–6) | The chapter's description, abridged to two lines per row | — | ch08 L242-251 |
| 4 | Likelihood here | `H/M/L` | — | Scored silently and individually first | derived (scale above) |
| 5 | Impact here | `select` Critical / High / Medium / Low | — | Our own rating | derived (scale above) |
| 6 | The early-warning signal we would actually see | `free text` | Prompts printed per row: *rollout announced before the pilot has a context layer* (1) · *a dated mandate with no context-engineering or training line in the budget* (2) · *a dashboard reporting PR volume, lines of code or tool usage frequency* (3) · *the pilot roster is the three best engineers on a greenfield project* (4) · *no named owner for shared context assets or coaching capacity* (5) · *no re-read date on any context asset* (6) | The signal as we would actually observe it here, in our words | ch08 L242-251 |
| 7 | Where that signal is visible | `free text` | — | The named dashboard, meeting, report or repository where a watcher would actually see it. "We'd notice" is not an answer | derived |
| 8 | Watcher | `owner (named person)` | — | A named individual who has agreed to watch. Never a function, never a committee | ch08 L240 |
| 9 | Review cadence | `select` weekly / monthly / at each phase gate | — | — | org |
| 10 | Mitigation already funded in the plan | `free text` | — | The mitigation that is *already in the roadmap we just drew* — not one invented in this session | ch08 L240 |
| 11 | Where in the plan it lives | `free text` | — | The exact phase, checklist task or budget line in `WS-08-transition-roadmap` / `WS-08-transition-planning-checklist`. A mitigation with no location is an intention | derived |
| 12 | Cross-reference: the sheet that owns this | `free text` | Pre-printed for rows 3 and 4: pitfall 3 is owned by `WS-08-baseline-measurement-plan`; pitfall 4 is the framing rule of `WS-08-pilot-selection-and-scope`; pitfall 6 is owned by the `Ongoing` block of `WS-08-transition-planning-checklist` | Confirm or redirect | ch08 L245, L247, L251 |
| 13 | Watch band | `computed` | — | Derived from columns 4 and 5 by the rule above | derived |
| 14 | Unmitigated Band 1 | `computed` | — | Set automatically where band is 1 and column 10 or 11 is blank. These rows block the go/no-go | derived |
| — | Next re-read date | `date` | — | Pitfall 6 applies to this register too. A risk register with no re-read date is itself the permanence assumption | ch08 L251 |

**Absorbed detail.** This sheet absorbed no other candidate. It is one half of a matched pair:
`WS-20-nineteen-failure-mode-premortem` covers technical delivery failure modes and is filled
cold; this covers transition failure modes and is filled *against a drafted plan*. Columns 4, 5
and 13 carry identical vocabulary to that sheet so the two registers read side by side. Column 12
is the anti-duplication control the source scan asked for: rows 3, 4 and 6 are diagnosed here and
mitigated elsewhere, and the cross-reference is printed rather than left to memory.

**Deliberate omission.** No mitigation-detail column beyond a single line. Three of the six
pitfalls already have a dedicated instrument in the kit, and writing the mitigation out twice
guarantees the two copies drift. This sheet's job is to notice, name a watcher and point at the
owner — not to solve.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-08-transition-roadmap` - The Transition Roadmap — Three Phases, Named Teams, Dated Gates (Pack G - The plan we leave with, fill order 5)

**Consumed by:**

- `WS-08-pilot-selection-and-scope` - Pilot Selection and Scope Contract (Pack G - The plan we leave with, fill order 9)

**Feeds into (prose, from the source scan).** WS-08-phase-gate-exit-rollback (several early-warning signals are the same observations as the rollback triggers) and WS-08-pilot-selection-and-scope.

## 8. Facilitation

| | |
|---|---|
| Who fills it | The same room that drew the roadmap, plus at least one person from the middle layer the register is about: a team lead, an engineering manager or a staff engineer. Pitfall 5, the missing middle, cannot be honestly scored by a room composed only of executives and practitioners — the layer being assessed must be present. |
| When in the session | After `WS-08-transition-roadmap` and before `WS-08-pilot-selection-and-scope`. The ordering is load-bearing: the register pre-mortems the plan that now exists, and its Band 1 rows are inputs to the pilot contract that follows it. Running it before the roadmap produces generic risks rather than an interrogation of a specific plan. |
| Duration | 45–60 minutes. Ten minutes of silent individual scoring across the six rows, twenty-five to thirty-five minutes on the rows where the room disagrees, and ten minutes to place watchers and cadences. The four blank org-specific rows usually fill themselves during the discussion. |
| Data needed in advance | The completed `WS-08-transition-roadmap`; the current dashboards and reports the organisation already uses to track engineering (for column 7); the draft budget lines for context engineering, training and governance (column 10 for pitfall 2); the names and current workloads of the people who would act as coaches (pitfalls 2 and 5). |
| Room format | A3 portrait, one copy per person for silent scoring, plus a wall copy pinned directly beside the roadmap. Keep the roadmap visible throughout — column 11 requires the group to point at a place on it, and pointing is easier than remembering. |

**Facilitation note.** Score silently first, then discuss only the rows where the room disagrees;
disagreement is the signal, and unanimity is not worth the airtime. Two rows deserve deliberate
extra time with this audience. **Pitfall 2, the mandate without infrastructure**, is the exact
failure a leadership planning kit exists to prevent — ask directly whether a date has already
been promised somewhere, and whether the context-engineering, training and governance lines exist
in the budget yet. **Pitfall 5, the missing middle**, is the risk most likely to be live in the
very engagement that commissioned this delivery; name it out loud, and score it with the middle
layer in the room rather than about them.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **All six rows carry a likelihood and an impact.** No blanks. A pitfall the room believes
   cannot happen here is scored `Low` with the preventing control named — a claim the register can
   be held to later, which a blank is not.
2. **Every row names a watcher who is an individual (column 8) and a place the signal is visible
   (column 7).** "We'd notice" fails. If no system of record shows the signal, the gap is itself a
   finding and belongs in the transition plan as a task.
3. **Every mitigation in column 10 is locatable in column 11** — a named phase, checklist task or
   budget line in `WS-08-transition-roadmap` or `WS-08-transition-planning-checklist`. A mitigation
   that exists only on this sheet has not been funded and will not happen.
4. **Column 14 is empty.** Every Band 1 row has both a mitigation and a location. Any that does not
   is carried, unresolved and named, into `WS-03-go-no-go-readiness-gate` as an explicit risk
   acceptance rather than being quietly downgraded.
5. **Rows 3, 4 and 6 cross-reference rather than restate.** Column 12 points at
   `WS-08-baseline-measurement-plan`, `WS-08-pilot-selection-and-scope` and the `Ongoing` block of
   `WS-08-transition-planning-checklist` respectively, and this sheet does not carry a second,
   divergent copy of their mitigations.
6. **The likelihood and impact vocabulary is identical to
   `WS-20-nineteen-failure-mode-premortem`.** Laid side by side, a Band 1 row here and a Band 1 row
   there must be comparable without translation.
7. **Pitfall 4's score reconciles with `WS-08-pilot-selection-and-scope`.** If the hero pilot is
   scored `High` here, the pilot contract's representativeness justification must address it
   directly; a `High` here and an unqualified pilot roster there is a contradiction the room has
   not resolved.
8. **A next re-read date is set.** An undated register is pitfall 6 enacted on itself.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `near-free`.** Six named, self-contained, diagnosable failure modes in thirteen lines - the rows are pre-written; the sheet adds likelihood, signal, owner and mitigation.
- **Fill (the organisation completing it): `M`.** M - needs preparation or a second person

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> Exceptionally high yield per line of source: six named, self-contained, diagnosable failure modes in thirteen lines. Ideal as a facilitated pre-mortem — run it with the room voting on likelihood, because the honest answers surface fast when the failure mode is already named. Two pitfalls are worth extra facilitation time for this audience: the mandate without infrastructure (leadership announces a Q3 deadline with no context engineering, training, or governance investment) is the exact risk a leadership planning kit exists to prevent, and the missing middle (investment in exec strategy and practitioner tools but not in the connective tissue of shared context assets, coaching capacity, and governance) is the risk most likely to be present in the very engagement that commissions this delivery — name it out loud. CROSS-CHECK: pitfall 4 the hero pilot is already the framing rule inside WS-08-pilot-selection-and-scope and pitfall 3 the wrong metric duplicates WS-08-baseline-measurement-plan; keep the rows here as the diagnostic and cross-reference rather than duplicating the mitigation content.
