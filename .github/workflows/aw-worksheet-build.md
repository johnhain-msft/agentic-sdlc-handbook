---
# Stage 1 of the worksheet factory: build one worksheet from its spec.
#
# Trigger: an issue labelled `stage:build`. The issue title carries the ws_id.
# Output: a DRAFT pull request carrying worksheets/<ws_id>.qmd, labelled
#         `stage:voice` so the next stage picks it up in a FRESH run.

on:
  issues:
    types: [labeled]

if: contains(github.event.issue.labels.*.name, 'stage:build')

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

The triggering issue names one worksheet by its `ws_id` — an identifier of the
form `WS-NN-some-slug`. Take it from the issue title or body.

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
   cd .github/skills/worksheet-build && npm install --no-audit --no-fund && cd -
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
instead comment on the issue explaining exactly which section and row you
cannot satisfy, and why.

## If nothing is needed

If the worksheet already exists and matches its spec, call the `noop` tool with
a message saying so rather than opening an empty pull request.
