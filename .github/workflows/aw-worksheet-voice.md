---
# Stage 2 of the worksheet factory: voice pass over a built worksheet.
#
# Trigger: a pull request labelled `stage:voice`.
# Output: prose-only edits pushed to the PR branch, relabelled `stage:review`
#         so the next stage picks it up in a FRESH run.

on:
  pull_request:
    types: [labeled]

if: contains(github.event.pull_request.labels.*.name, 'stage:voice')

permissions:
  # Copilot inference via the Actions token - no PAT, minted per run and
  # revoked automatically. Billing flows through the org Copilot plan.
  copilot-requests: write
  contents: read
  issues: read
  pull-requests: read

engine: copilot

network: defaults

tools:
  bash:
    - "*"
  edit:
  github:
    toolsets: [default]

imports:
  - shared/worksheet-toolchain.md
  - .github/agents/worksheet-voice.agent.md

safe-outputs:
  push-to-pull-request-branch:
    target: triggering
    required-labels: [worksheet]
  add-labels:
    target: triggering
    allowed: ["stage:review", "needs-human"]
    max: 2
  remove-labels:
    target: triggering
    allowed: ["stage:voice"]
    max: 1
  add-comment:
    target: triggering
    max: 1
  missing-tool:
---

# Voice pass over a worksheet

This pull request carries exactly one worksheet at `worksheets/<ws_id>.qmd`.
Find it with `git diff --name-only origin/main...HEAD`.

## What to do

1. Read `.github/skills/worksheet-build/SKILL.md` so you know which elements
   carry the book's words and are therefore off limits.
2. Read the build spec at `docs/worksheets/<ws_id>.md`, especially §5, so you
   know the field vocabulary you must not drift from.
3. Record the gate's counts before you start:

   ```bash
   .github/skills/worksheet-build/scripts/render-worksheet.sh <ws_id>
   ```

   Note `writable fields`, `printed priors` and `hedged figures`.
4. Edit only the four elements your agent instructions allow.
5. Re-render, re-run the gate, and confirm **those three counts are unchanged**.
   If any of them moved, you changed structure — revert that hunk.
6. Read your own diff (`git diff -- worksheets/<ws_id>.qmd`). Every hunk must be
   prose inside an allowed element.
7. Push to the pull request branch, then add `stage:review` and remove
   `stage:voice`.
8. Post your `VOICE PASS:` report as a comment.

## If nothing needs changing

That is a normal and good outcome. Push nothing, post the report saying so, and
still relabel to `stage:review`. An unnecessary rewrite costs a review cycle and
drifts the sheet away from its spec.

## Boundaries

Prose only. Never a field, column, option, label, number, `.prior`,
`.hedge-text`, `.ws-foot-quote`, `.ws-source`, class or stylesheet.

Never edit `handbook/`, the book's root `.qmd` files, the root `_quarto.yml`, or
any spec in `docs/worksheets/`.

If the sheet has a problem outside your scope, report it and relabel anyway —
the judge will route it to the right stage.
