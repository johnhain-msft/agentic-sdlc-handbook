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
  # gh-aw gates activation on the ACTOR's repository role, defaulting to
  # [admin, maintainer, write]. When one stage wakes the next with
  # dispatch_workflow the actor is github-actions[bot], whose repository
  # permission level is `none`, so every hand-off was denied at pre_activation:
  #
  #   Required permissions: admin, maintainer, write
  #   Repository permission level: none
  #
  # `bots:` does not solve this. The docs are explicit that the allowlist is
  # verified through the repository collaborator API, that App identities are
  # not collaborators, and that the check is only relaxed for
  # repository_dispatch.
  #
  # `roles: all` is safe HERE because it is not what gates this workflow.
  # Every trigger it has is already gated by GitHub itself: dispatching a
  # workflow requires write access, and labelling a pull request requires at
  # least triage. Removing gh-aw's additional actor check therefore does not
  # widen who can start a run — it only stops the machine-to-machine chain
  # being rejected.
  roles: all

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

# This stage works on an EXISTING pull request, so its head branch must be in
# the workspace. gh-aw's checkout is shallow and credentials are stripped
# afterwards, so gh pr checkout cannot fetch it at run time. This is the
# documented pattern for the case.
checkout:
  - fetch: ["refs/pulls/open/*"]
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
# Credentials are stripped after checkout, so `gh pr checkout` cannot fetch.
# The PR head was fetched for you already — check it out from the local ref:
git checkout -B "pr-<number>" "refs/remotes/origin/pull/<number>/head"
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

**Upload and embed the images even if you cannot see them yourself.** If the
image viewer returns nothing you can read, that is a limitation of this
substrate, not a reason to leave the pull request with no artifact on it. Attach
them anyway, say plainly that you could not view them, and hand the visual
judgement to a person. An unviewable image on the pull request is worth far more
than no image at all.

**A review with no attached image is void.** The judge workflow runs a
deterministic check before its agent starts and refuses to judge a pull request
that carries no embedded image, so a source-only review cannot pass. Reviewing
the `.qmd` instead of the render does not satisfy this stage.

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
