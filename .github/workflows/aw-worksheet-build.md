---
# Stage 1 of the worksheet factory: build one worksheet from its spec.
#
# Trigger: an issue labelled `stage:build`. The issue title carries the ws_id.
# Output: a DRAFT pull request carrying worksheets/<ws_id>.qmd, labelled
#         `stage:voice` so the next stage picks it up in a FRESH run.

on:
  issues:
    types: [labeled]
  workflow_dispatch:
    inputs:
      ws_id:
        description: "Worksheet id, e.g. WS-06-team-readiness-scorecard"
        required: true
        type: string

# `issues` events always run the workflow file from the DEFAULT branch
# (docs: GITHUB_REF = default branch). `workflow_dispatch` runs the file from
# whichever ref received the dispatch, so this stage can be piloted on a
# feature branch before anything is merged:
#
#   gh workflow run aw-worksheet-build.lock.yml \
#     --ref chore/stable-anchors -f ws_id=WS-06-team-readiness-scorecard
#
# The later stages trigger on `pull_request`, which runs the file from the PR
# merge ref, so they are branch-runnable already.

if: >-
  github.event_name == 'workflow_dispatch' ||
  contains(github.event.issue.labels.*.name, 'stage:build')

permissions:
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
  add-comment:
    max: 1
  missing-tool:
---

# Build a worksheet from its spec

Identify the worksheet by its `ws_id` — an identifier of the form
`WS-NN-some-slug`.

- On `workflow_dispatch`, it is the `ws_id` input.
- On an `issues` trigger, take it from the issue title or body.

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
