# Definition of Done: Behavioural Checkpoint Assertions

`WS-CS-APM-checkpoint-assertions` &middot; **Pack Z - Second wave: the practitioner kit** &middot; fill order **22** &middot; type `checklist` &middot; audience **eng-leader** &middot; leadership priority **2**

> **Split back out in the re-opening pass.** A definition-of-done instrument -- observable behaviour, the command that observes it, expected output, signature -- signed per checkpoint by an eng-leader; folding it loses the decision that a green build is insufficient.
>
> Ships as: `facing:WS-18-wave-decomposition-plan`

## 1. Purpose

**Output artifact.** A definition-of-done checklist that makes "green build" insufficient on its own.

**Cluster.** `CL-CHECKPOINT-DOD` - Checkpoint Definition of Done: Behavioural Assertions

## 2. Book address

| Coordinate | Value |
|---|---|
| File | `case-study-apm-overhaul.qmd` |
| Chapter | The APM Auth + Logging Overhaul |
| Heading | 5. Verbose Logging Silent NameError |
| Stable anchor | `#sec-cs-apm-silent-error` |
| Lines | L183-212 |
| Published URL | <https://danielmeppiel.github.io/agentic-sdlc-handbook/case-study-apm-overhaul.html#sec-cs-apm-silent-error> |
| Locator quote | "`_rich_echo` was never imported in `install.py`. The `verbose_log` lambda" |

Resolve at any time with `python docs/resolve.py ws WS-CS-APM-checkpoint-assertions`.

## 3. Source extract - the scaffolding, verbatim

```text
  183 | `_rich_echo` was never imported in `install.py`. The `verbose_log` lambda
  184 | triggered a `NameError` caught by an outer `try/except`. Verbose mode
  185 | silently did nothing. No test caught it because the test suite never
  186 | asserted on verbose output.
  187 | 
  188 | ```{mermaid}
  189 | %%| fig-width: 4.5
  190 | %%| fig-cap: "Sequence showing how a NameError was silently swallowed"
  191 | %%| fig-alt: "Sequence diagram showing the silent NameError bug. The User calls CLI with 'apm install pkg --verbose'. The CLI calls verbose_log with 'Resolving...'. verbose_log calls _rich_echo with 'Resolving...'. _rich_echo throws a NameError because it is not defined. The exception is silently swallowed by verbose_log, which returns to CLI without error. The CLI shows silent failure to the User with no verbose output."
  192 | %%| label: fig-cs-silent-nameerror
  193 | sequenceDiagram
  194 |     participant User
  195 |     participant CLI as CLI (--verbose)
  196 |     participant VL as verbose_log
  197 |     participant RE as _rich_echo
  198 | 
  199 |     User->>CLI: apm install pkg --verbose
  200 |     CLI->>VL: verbose_log("Resolving...")
  201 |     VL->>RE: _rich_echo("Resolving...")
  202 |     RE-->>VL: NameError: not defined
  203 |     VL-->>CLI: Exception silently swallowed
  204 |     CLI->>User: (silent failure)
  205 | ```
  206 | 
  207 | This is why **checkpoint discipline** matters (Ch12) — and why it must
  208 | include *behavioural* assertions, not just "tests pass." The test suite
  209 | had 2,829 passing tests and none verified that verbose mode actually
  210 | produced output.
  211 | 
  212 | ---
```

## 4. What the user fills

For each checkpoint in the pilot, the team writes the observable behaviour that must be asserted - not just "tests pass". Columns: what the change is supposed to make observable, the command that observes it, the expected output, and who signs.

## 5. Field-level schema

One row per behavioural assertion, grouped into one printed page per checkpoint. A checkpoint is a
wave boundary taken from `WS-18-wave-decomposition-plan`; a wave with one assertion gets one row, a
wave with six gets six. The signature block sits per page, not per sheet, because the signature is
the act of verification at the checkpoint — not an act of planning in the session that designed it.

| # | Column | Input type | Pre-filled from the book | Blank - org supplies | Source |
|---|---|---|---|---|---|
| 1 | Checkpoint / wave | `select` | Populated from the wave names in `WS-18-wave-decomposition-plan` | — | ch18 L142; cs-apm L105-111 |
| 2 | Assertion ID | `free text` | Shape only: `W2-A1`, `W2-A2`, … | — | derived |
| 3 | Observable behaviour this change is supposed to produce | `free text` | Worked instance: "`--verbose` produces informational output to the user" | The behaviour, stated as something a user or an operator can see | cs-apm L183-186 |
| 4 | Command that observes it | `free text` (runnable) | Worked instances: `apm install pkg --verbose`; `git diff --stat`; a recursive grep for the glyphs the change was supposed to remove — printed verbatim below | The actual command, with its arguments | cs-apm L199, L218-220 |
| 5 | Expected output | `free text` | Worked instance: at least one line matching `Resolving` on stdout | A concrete string, or a concrete checkable property of the output | cs-apm L200-204 |
| 6 | Observed output | `free text` | — | Filled at the checkpoint, not in the planning session | org |
| 7 | Verdict | `computed` pass / fail | — | Column 5 against column 6 | derived |
| 8 | Assertion class | `select` behavioural / filesystem / test-suite | Pre-printed rule beside the column: a checkpoint may not consist of `test-suite` assertions alone | The class of each assertion | cs-apm L207-210 |
| 9 | Failure mode this assertion would have caught | `free text` | Worked instance: a helper never imported, the resulting `NameError` swallowed by an outer `try/except`, the feature silently doing nothing | The specific failure, named | cs-apm L183-186 |
| 10 | Already covered by an existing test? | `select` yes / partially / no | — | `no` is not a defect in the sheet — it is the test to write | cs-apm L185-186, L208-210 |
| 11 | Silent-failure check: does any path between command and output swallow exceptions? | `checkbox` + `free text` | Pre-printed: the reference bug was invisible because an outer `try/except` caught it | The answer, and where the swallowing happens | cs-apm L184-185, L202-204 |
| 12 | Filesystem verification performed | `checkbox` + `free text` | Pre-printed rule: "Agent success messages are probabilistic output. The `diff` command is deterministic." Commands: `git diff --stat`, then a grep for the strings the change was supposed to remove | The diff and grep output actually seen | cs-apm L214-226 |
| 13 | Signer | `owner (named person)` | — | Must not be the author of the change under test | derived from cs-apm L214-226 |
| 14 | Signature + date | `signature` | — | Signed at the checkpoint | org |
| — | Checkpoint verdict | `computed` | — | The page passes only when every row's column 7 reads pass and column 12 is ticked | derived |

**The worked verification pair, printed on the reverse.** Column 12 expects both of the book's
post-dispatch commands, not one, and they are printed on the sheet exactly as the chapter gives
them so that nobody retypes them from memory at a checkpoint:

```bash
# After an agent claims "all replacements complete":
git diff --stat            # did any files actually change?
grep -rn "✓\|✗\|⚠" src/   # are the old glyphs still there?
```

**Deliberate omission.** No test-count field, and no place to record a suite total. The case's own
figures — a suite climbing from 2,829 to 2,897 across five waves — are printed in this book as the
*evidence that counting is insufficient*, not as a measure to carry forward. A cell inviting a team
to write a test count next to a blank behaviour column would invert the entire argument the sheet
exists to make. If the organisation tracks suite size, it belongs in the wave plan as context beside
the checkpoint, never inside the assertion. Equally omitted: any pass-rate or coverage percentage.
The reference failure occurred at a 100% pass rate.

## 6. Absorbed members (0)

None - this worksheet absorbed no other candidate.

## 7. Dependencies

**Prerequisites** (must be complete before this sheet can be filled):

- `WS-18-wave-decomposition-plan` - Wave Decomposition Plan and Self-Sufficiency Check (Pack Z - Second wave: the practitioner kit, fill order 21)

**Consumed by:**

- No other worksheet declares this as a prerequisite.

**Feeds into (prose, from the source scan).** WS-18-wave-decomposition-plan (supplies each wave's checkpoint cell)

## 8. Facilitation

| | |
|---|---|
| Who fills it | The engineering leader who signs off "done", working with the engineer who wrote the change and the person who will run the checkpoint. The signer at column 13 must not be the change's author. The book's failure mode is an unverified self-report, and a signature from the author is a self-report with a pen. |
| When in the session | Last in Pack Z, immediately after `WS-18-wave-decomposition-plan`, whose checkpoint column this sheet fills. It is the only sheet in the pack that genuinely cannot be brought forward: an assertion cannot be written until the wave's scope is fixed, because the assertion is a statement about what that specific wave is supposed to make observable. |
| Duration | 30-45 minutes for a four- or five-wave plan; roughly five to eight minutes per assertion once the room has the habit. The first two take noticeably longer, because the room's opening instinct is to write "tests pass" and it has to be talked out of it twice before the pattern sticks. |
| Data needed in advance | The wave plan with its scope column filled. The repository's existing test suite and the exact command that invokes it. And — the item that makes or breaks the session — at least one named user-visible behaviour the pilot is supposed to preserve or introduce, identified before the room sits down. Teams that arrive without one spend the first twenty minutes discovering they cannot describe their own change in observable terms. |
| Room format | Filled live, projected, one page per checkpoint. It then leaves the room as a set of per-checkpoint pages that live with the wave plan and are signed at the checkpoint itself. Do not bind it into a single document: a bound sheet gets signed once, at the end, which defeats the instrument. |

**Facilitation note carried from the source scan.** Open by projecting the case study's own wave
table (cs-apm L105-111), whose checkpoint column reads "2,839 tests", "2,846 tests", "2,874 tests".
Then read cs-apm L207-210 from the same document: a suite of 2,829 passing tests, and none of them
verified that verbose mode produced any output. The room needs to watch one document do both things.
Then ask for one behaviour in the current pilot that could break silently — no exception, no failing
test, no alert. The exercise has not landed if nobody can name one. It has landed when somebody
names one and the room goes quiet. The Try This block at cs-apm L214-226 ships as the worked example
for column 12 and should be printed on the reverse.

## 9. Acceptance criteria

A well-completed sheet satisfies all of:

1. **No entry reads "tests pass", "green build", or any paraphrase.** Every assertion fills three
   separate cells — an observable behaviour (3), the command that observes it (4) and the expected
   output (5). An assertion missing any one of the three is not an assertion; it is a hope.
2. **Every command at column 4 runs as written, with its arguments, for someone who was not in the
   room.** A command that needs a person to explain it cannot be executed at a checkpoint by
   whoever happens to be on duty, which is the only circumstance in which it will ever matter.
3. **Every expected output at column 5 is a concrete string or a concrete checkable property.**
   "Succeeds", "works" and "no errors" are rejected outright: the reference bug produced no error,
   exited cleanly, and would have satisfied all three.
4. **Every checkpoint carries at least one assertion whose class (8) is not `test-suite`.** A
   checkpoint composed entirely of test-suite assertions is the exact configuration that let a
   2,829-test suite miss a feature that did nothing at all.
5. **Column 9 is filled for every row.** An assertion that cannot name the failure it would catch is
   decoration. This column is the cheapest defect filter on the sheet — it is where assertions that
   assert nothing become visible during planning rather than after release.
6. **The signer at column 13 is not the author of the change under test**, and the signature at
   column 14 is dated at the checkpoint rather than at the planning session.
7. **Column 12 is ticked, with its diff and grep output recorded, for every checkpoint that followed
   an agent's self-reported success.** Agent success messages are probabilistic output; the diff is
   deterministic. A checkpoint that trusted the report is unverified regardless of what rows 1-11
   say.

## 10. Integrity constraint

No registered hedged figure falls inside this worksheet's source range or that of any member it absorbed. The standing rule still applies to anything introduced during authoring.

**Book-wide convention.** ch01 L140 states the book's own convention: *"Where this book makes predictions or presents projected figures, these are explicitly distinguished from measured evidence. Tables containing author estimates are marked †."* A worksheet that strips the dagger strips the disclosure.

> A printed sheet launders a hedged anecdote faster than prose does, because a blank cell next to a printed number reads as a target by layout alone.

## 11. Build effort

- **Build (authoring the sheet): `authoring`.** A case narrative. The four columns (observable behaviour, observing command, expected output, signer) must be designed from prose.
- **Fill (the organisation completing it): `S`.** S - one sitting, data already in the room

## 12. Source-scan notes

Carried verbatim from the scanning agent that found this location; often contains the exact line numbers of the sub-tables and worked examples the sheet needs.

> The passage is the sharpest evidence in the whole book for this instrument: 2,829 passing tests and none asserted that verbose mode produced output. Pairs naturally with the Try This block at lines 214-226 (filesystem verification after dispatch: git diff --stat, grep for old characters) which can ship as the worked example. Leadership relevance is real - this is what "done" means when agents write the code - but it is executed by practitioners, hence priority 2.
