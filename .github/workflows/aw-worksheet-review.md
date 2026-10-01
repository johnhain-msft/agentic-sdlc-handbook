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

engine:
  id: copilot
  # THE POINT OF THIS STAGE. Copilot's mid-session file read loads a PNG and
  # reports its MIME type and dimensions but does NOT send the bytes to the
  # model — measured: six screenshots would cost ~22,600 image tokens and the
  # whole run's input was 8,857. `--attachment` DOES send the image, but it is
  # applied at launch, so the capture pre-step below must produce the file
  # first. Verified locally: a fresh Copilot CLI given only this attachment
  # read the column headers, distinguished the tinted serif prior column from
  # the hairline blank column, and read "† PRIOR — NOT A TARGET" off the page.
  args:
    - "--attachment"
    - "/tmp/gh-aw/agent/worksheet-review/full-page.png"   # every sheet at once — overflow and overall shape
    - "--attachment"
    - "/tmp/gh-aw/agent/worksheet-review/sheet-01.png"    # full resolution — readable detail
    - "--attachment"
    - "/tmp/gh-aw/agent/worksheet-review/sheet-02.png"
    - "--attachment"
    - "/tmp/gh-aw/agent/worksheet-review/sheet-03.png"

network: defaults

# This stage works on an EXISTING pull request, so its head branch must be in
# the workspace. gh-aw's checkout is shallow and credentials are stripped
# afterwards, so gh pr checkout cannot fetch it at run time. This is the
# documented pattern for the case.
checkout:
  - fetch: ["refs/pulls/open/*"]

# Render the worksheet and put the screenshot where --attachment expects it,
# BEFORE the agent launches. Deterministic work in a deterministic step; the
# agent is left with the judgement. The script always leaves a readable PNG at
# that path — a rendered failure card if anything goes wrong — so the agent
# sees why rather than hitting a missing-file launch error.
steps:
  - name: Render the worksheet and capture it for the reviewer to SEE
    env:
      GH_TOKEN: ${{ github.token }}
    run: |
      bash .github/skills/worksheet-build/scripts/capture-for-review.sh \
        "stage:review" /tmp/gh-aw/agent/worksheet-review

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

## You are looking at the worksheet right now

**The rendered worksheet is attached to this conversation as four images.** They
were rendered, gated and screenshotted before you started:

| Attachment | What it is | Use it for |
|---|---|---|
| `full-page.png` | every sheet at once, on the grey review background | overflow, overall shape, whether anything spills past a paper edge |
| `sheet-01.png` … `sheet-03.png` | the first three sheets at full resolution | **detail** — prior vs blank at arm's length, field writability, option labels, type size |

Look at them. Describe what you actually see before you judge anything.

The full page is deliberately small — it is the overview. **Judge house rule 1
from the per-sheet images, not from the full page**, and say which image a
finding came from. If a card says a slot is unused, that worksheet simply has
fewer than three sheets.

Supporting facts, already produced for you:

```bash
cat /tmp/gh-aw/agent/worksheet-review/capture.json        # pull request number, ws_id, gate result
cat /tmp/gh-aw/agent/worksheet-review/layout-report.json  # per-sheet geometry and every defect
cat /tmp/gh-aw/agent/worksheet-review/gate.log            # the gate's own output
```

The pull request head is already checked out. Its number is in `capture.json`
— pass it as `pull_request_number` on every safe output.

**If the attached images are red "WORKSHEET CAPTURE FAILED" cards**, the render
did not happen. Report `VOID` with the reason from the card, add `needs-human`,
and do not relabel to `stage:judge`.

The mechanical gate is the **floor of your review, never the ceiling.** It
measures geometry. It cannot see that a table is unreadable, that the fill order
makes no sense to a human, that two zones look identical, or that a printed
figure sits invitingly beside a blank cell. That is what you are for.

## If you need a closer look

The capture gave you the whole page at once. For detail on one sheet, the
per-sheet PNGs are already on disk at
`worksheets/_review/<ws_id>/sheet-NN.png`, and you can re-render or serve the
worksheet yourself:

```bash
bash .github/skills/worksheet-build/scripts/render-worksheet.sh <ws_id> --serve --port 8977
```

`playwright-cli` runs on the runner, so `http://localhost:8977/<ws_id>.html` is
reachable directly — this workflow uses Playwright in CLI mode precisely so
localhost works. Use it to measure, probe the DOM, or re-shoot after a fix.

**Be honest about what a second look can and cannot give you.** Only the image
attached at launch reached your eyes. A PNG you read mid-session returns its
dimensions and MIME type, not its content. So: describe the page from the
attached image, use the DOM and the layout report for anything finer, and never
write a visual observation you cannot source from one of those two.

## Attach the images to the pull request

Upload every sheet PNG with the `upload_asset` tool, then post ONE comment that
embeds each uploaded image with markdown `![sheet N](<url>)` and carries your
`WORKSHEET REVIEW:` report.

This is how a human sees the artifact, and it is also the judge's gate: a
deterministic step refuses to judge a pull request that carries no embedded
image, so a source-only review cannot pass. **Attach them even if a re-render
failed and all you have is what you were shown at launch.**

## When to advance, and when to stop

**Advance in almost every case.** A finding that belongs to another stage is
not a reason to stop the pipeline — it is a reason to write it down. Push any
layout fixes, add `stage:judge`, remove `stage:review`, and call
`dispatch_workflow` for `aw-worksheet-judge`. The judge reads your findings and
routes them to the stage that owns them. That is its job, not yours.

**Use `needs-human` only when you genuinely could not run**, meaning the
attached capture was a failure card and there is no artifact to review. In that
case post the `VOID` report, add `needs-human`, and do not relabel or dispatch.

Stopping the pipeline on a finding you could have handed to the judge costs a
full cycle and a human's attention for nothing.

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
