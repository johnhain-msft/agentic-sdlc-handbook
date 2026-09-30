---
# Stage 3 of the worksheet factory: usability review of the RENDERED artifact.
#
# Trigger: a pull request labelled `stage:review`.
# Output: the rendered sheet images uploaded and linked in a PR comment, any
#         layout fixes pushed, relabelled `stage:judge`.
#
# A review that attaches no image is void. worksheet-review-gate.yml enforces
# that deterministically when this stage hands on to the judge.

on:
  workflow_dispatch:
  pull_request:
    types: [labeled]

# workflow_dispatch is the real entry point — a `labeled` event raised by
# GITHUB_TOKEN does not create a workflow run. The labeled trigger is kept so a
# human can re-run this stage by hand.

if: >-
  github.event_name == 'workflow_dispatch' ||
  contains(github.event.pull_request.labels.*.name, 'stage:review')

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
  playwright:
    # CLI mode, not MCP. MCP mode runs the browser in a Docker container that
    # cannot reach the runner's localhost, which is precisely where the
    # rendered worksheet is served. CLI mode runs playwright-cli on the runner
    # itself and can reach http://localhost.
    mode: cli
  github:
    toolsets: [default]

imports:
  - shared/worksheet-toolchain.md
  - .github/agents/worksheet-review.agent.md

safe-outputs:
  upload-asset:
    branch: assets/worksheet-review
    allowed-exts: [.png]
    max-size: 10240
  add-comment:
    target: "*"
    max: 1
  push-to-pull-request-branch:
    target: "*"
    required-labels: [worksheet]
  add-labels:
    target: "*"
    allowed: ["stage:judge", "needs-human"]
    max: 2
  remove-labels:
    target: "*"
    allowed: ["stage:review"]
    max: 1
  dispatch-workflow:
    workflows: [aw-worksheet-judge]
    max: 1
  missing-tool:
---

# Review the rendered worksheet

## Find your work

This stage is woken by `dispatch_workflow`, so there may be no triggering pull
request in the event context. Find the work yourself:

```bash
gh pr list --state open --label worksheet --label stage:review \
  --json number --jq '.[0].number'
gh pr checkout <number>
git diff --name-only origin/main...HEAD
```

If there is no such pull request, call `noop` saying the queue is empty and
stop. Pass the number you found as `pull_request_number` on every safe output.

## You must look at the artifact

```bash
.github/skills/worksheet-build/scripts/render-worksheet.sh <ws_id> --serve --port 8977
```

That renders the sheet, runs the mechanical layout gate, writes one PNG per
sheet to `worksheets/_review/<ws_id>/`, and serves the page at
`http://localhost:8977/<ws_id>.html`.

`playwright-cli` runs on the runner, so `http://localhost:8977` is reachable
directly. Do not reach for MCP browser tools; this workflow uses Playwright in
CLI mode precisely so localhost works.

Then drive a real browser against that localhost URL with `playwright-cli` in
bash — emulate print media, screenshot each `.sheet` — and **open and look at
every image**, both the ones the render script wrote and any you take yourself.
Read `worksheets/_review/<ws_id>/layout-report.json` for the mechanical facts,
and spec §8 "Room format" for the physical format this sheet claims to be.

## Attaching the images is not optional

Upload every sheet PNG with the `upload_asset` tool, then post ONE comment that
embeds each uploaded image with markdown `![sheet N](<url>)` and carries your
`WORKSHEET REVIEW:` report.

**A review with no attached image is void.** A separate gate checks for an
embedded image on this pull request before the judge runs, and sends the PR
straight back here if there is none. Reviewing the `.qmd` source instead of the
render does not satisfy this stage and cannot pass it.

If you genuinely cannot render, serve, or screenshot the worksheet, post the
`VOID` form of the report saying exactly what failed, add `needs-human`, and do
not relabel to `stage:judge`.

## Then

Fix layout defects — sheet splits, column widths, field heights, block order,
canvas zone sizes, page geometry. Re-render, re-gate and **look again** after
every fix.

Do not change a field, label, option, number, `.prior`, `.hedge-text` or any of
the sheet's prose. Report those and let the judge route them.

When the artifact is sound, push any fixes, add `stage:judge`, remove
`stage:review`, and call `dispatch_workflow` for `aw-worksheet-judge`.

The judge workflow runs a deterministic check **before** its agent starts: if
no rendered image is embedded in a comment on this pull request, it fails and
sends the pull request straight back here. You cannot pass this stage by
reviewing source.

## Boundaries

Never edit `handbook/`, the book's root `.qmd` files, the root `_quarto.yml`, or
any spec in `docs/worksheets/`.

Never fix clipping by shrinking type below 7pt. Split the sheet.
