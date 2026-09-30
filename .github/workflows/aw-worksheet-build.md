---
# Stage 1 of the worksheet factory: build one worksheet from its spec.
#
# Trigger: an issue labelled `stage:build`. The issue title carries the ws_id.
# Output: a DRAFT pull request carrying worksheets/<ws_id>.qmd, labelled
#         `stage:voice` so the next stage picks it up in a FRESH run.

on:
  issues:
    types: [labeled]
  push:
    branches: ['**']
    paths:
      - 'worksheets/_build-request.txt'
  workflow_dispatch:
    inputs:
      ws_id:
        description: "Worksheet id, e.g. WS-06-team-readiness-scorecard"
        required: true
        type: string

# Three ways in, because GitHub scopes triggers differently:
#
#   issues: labeled    - the production path. Runs the workflow file from the
#                        DEFAULT branch, so it only works once this is on main.
#   workflow_dispatch  - also requires the workflow to exist on the default
#                        branch before the API will accept a dispatch
#                        (verified: HTTP 404 "not found on the default branch").
#   push               - runs the workflow file from the PUSHED ref, so this is
#                        the only trigger that works while the factory is still
#                        on a feature branch.
#
# To build a worksheet from a feature branch, write its ws_id into
# worksheets/_build-request.txt and push:
#
#   echo WS-06-team-readiness-scorecard > worksheets/_build-request.txt
#   git commit -am "build: WS-06" && git push
#
# One ws_id per push. That is deliberate — one worksheet per run, one fresh
# context window per stage, which is the whole point of the four-stage split.
#
# The later stages trigger on pull_request, which runs from the PR merge ref,
# so they are branch-runnable already and need none of this.

if: >-
  github.event_name == 'workflow_dispatch' ||
  github.event_name == 'push' ||
  contains(github.event.issue.labels.*.name, 'stage:build')

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
  - .github/agents/worksheet-builder.agent.md

safe-outputs:
  create-pull-request:
    draft: true
    title-prefix: "[worksheet] "
    labels: [worksheet, stage:voice, "cycles:0"]
    if-no-changes: error
    # Target the branch this run happened on. Without this the patch is
    # computed against the repository default branch, so a build running on a
    # feature branch sweeps that branch's entire history into the pull request
    # — the first pilot produced a 158-file patch and was refused.
    base-branch: ${{ github.ref_name }}
    # The builder changes exactly one file: worksheets/<ws_id>.qmd. This is set
    # LOW on purpose. A runaway diff should fail loudly and immediately rather
    # than open a pull request nobody can review; raising the limit would only
    # hide the bug that produced the extra files.
    max-patch-files: 3
  add-comment:
    max: 1
  missing-tool:
---

# Build a worksheet from its spec

Identify the worksheet by its `ws_id` — an identifier of the form
`WS-NN-some-slug`. Where it comes from depends on how this run was triggered:

- **push** — read `worksheets/_build-request.txt`. It carries a single
  `ws_id:` line naming exactly one worksheet. Use that value and ignore the
  `requested:` line, which exists only to make a re-request produce a diff.
- **workflow_dispatch** — the `ws_id` input.
- **issues** — the issue title or body.

If you cannot determine a single `ws_id`, stop and say so. Do not guess, and do
not build more than one worksheet in this run.

The toolchain (Quarto, Node, Chromium, the layout gate's dependencies) is
already installed. Do not install it again.

## What to do

1. Read `.github/skills/worksheet-build/SKILL.md` in full. It carries the
   template, the page-geometry table, the input-type mapping, the three house
   rules and three Quarto behaviours that will silently break your page.
2. Read `worksheets/specimen.qmd` as the worked example of the exact markup.
3. Read the build spec at `docs/worksheets/<ws_id>.md` end to end.
4. Open the chapter file named in spec §2 and read the source range directly.
   Do not rely on §3 alone for context — §3 is the extract, the surrounding
   lines tell you what the scaffolding is for.
5. Build `worksheets/<ws_id>.qmd` following your agent instructions above.
6. Render and gate it until it passes:

   ```bash
   .github/skills/worksheet-build/scripts/render-worksheet.sh <ws_id>
   ```

7. Create the pull request. Its body must carry your `BUILT:` report in full —
   the next three stages read it, and the judge reads it only to find what it
   omitted.

## Boundaries

Change exactly one file: `worksheets/<ws_id>.qmd`.

Never edit anything under `handbook/`, the book's root `.qmd` files, the root
`_quarto.yml`, or any spec in `docs/worksheets/`.

If the spec is unbuildable as written, do not guess. Create no pull request;
instead report exactly which section and row you cannot satisfy, and why.

## If nothing is needed

If the worksheet already exists and matches its spec, call the `noop` tool with
a message saying so rather than opening an empty pull request.
