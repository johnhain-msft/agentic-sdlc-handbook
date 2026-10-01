---
# Stage 1 of the worksheet factory: build one worksheet from its spec.
#
# Trigger: an issue labelled `stage:build` (its `ws_id:` line, or its title,
#          names the worksheet), a workflow_dispatch with a ws_id input, or a
#          push of worksheets/_build-request.txt.
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
# To build a worksheet from a feature branch, set the ws_id line of
# worksheets/_build-request.txt and push:
#
#   printf 'ws_id: WS-06-team-readiness-scorecard\nrequested: %s\n' \
#     "$(date -u +%FT%RZ)" > worksheets/_build-request.txt
#   git commit -am "build: WS-06" && git push
#
# One ws_id per push. That is deliberate — one worksheet per run, one fresh
# context window per stage, which is the whole point of the four-stage split.
#
# Whichever way in, the resolve step below decides the ws_id from the trigger
# that actually fired. The agent never works it out for itself.
#
# The later stages trigger on pull_request, which runs from the PR merge ref,
# so they are branch-runnable already and need none of this.

if: >-
  github.event_name == 'workflow_dispatch' ||
  github.event_name == 'push' ||
  github.event.label.name == 'stage:build'

permissions:
  # Copilot inference via the Actions token - no PAT, minted per run and
  # revoked automatically. Billing flows through the org Copilot plan.
  copilot-requests: write
  contents: read
  issues: read
  pull-requests: read

engine: copilot

network: defaults

# Decide which worksheet this run builds BEFORE the agent starts, from the
# trigger that actually fired. The agent cannot see a workflow_dispatch input:
# left to work the ws_id out for itself, it read the push-path request file
# instead, found a worksheet that had already shipped, and spent the run on a
# no-op. This step fails the run, before any model call, unless it finds
# exactly one ws_id with a build spec. Untrusted text reaches it only through
# env, never through the script body.
steps:
  - name: Resolve which worksheet this run builds
    env:
      EVENT_NAME: ${{ github.event_name }}
      INPUT_WS_ID: ${{ github.event.inputs.ws_id }}
      ISSUE_TITLE: ${{ github.event.issue.title }}
      ISSUE_BODY: ${{ github.event.issue.body }}
    run: |
      bash .github/skills/worksheet-build/scripts/resolve-build-request.sh \
        /tmp/gh-aw/agent/worksheet-build

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
    # Do NOT set base-branch here. Setting it triggers github/gh-aw#39404:
    # the value is resolved through a GitHub API call that 404s, the failure is
    # stringified into the ref name, and every create_pull_request then dies
    # with "No remote refs available for merge-base calculation" — even when
    # the value is simply the default branch. Left unset, gh-aw defaults to
    # github.base_ref || github.ref_name, which is what we want anyway.
    #
    # The builder changes exactly one file: worksheets/<ws_id>.qmd. This limit
    # is set LOW on purpose, so a runaway diff fails loudly and immediately.
    # Raising it — which is what the E003 error message suggests — would hide
    # the bug that produced the extra files rather than fix it.
    max-patch-files: 3
  # The doorbell for stage 2. A label alone cannot wake the next stage:
  # GitHub does not create a workflow run for a `pull_request` `labeled` event
  # raised by GITHUB_TOKEN. workflow_dispatch is a documented exception that
  # always creates a run, so the chain is driven by dispatch and the labels
  # remain the visible work queue.
  dispatch-workflow:
    workflows: [aw-worksheet-voice]
    max: 1
  add-comment:
    max: 1
  # Disabled so that a build which produces nothing can never look like
  # success. The no-op is how a build of the wrong worksheet once finished
  # green with no trace: gh-aw reports an undeclared noop nowhere. Declaring
  # `noop: {report-as-issue: true}` instead was tried and rejected, because in
  # gh-aw v0.86.2 it also generates a daily agentics-maintenance workflow with
  # write permissions and sets every failure issue to expire. With no noop, an
  # unneeded build calls report_incomplete, which opens an issue.
  noop: false
  missing-tool:
---

# Build a worksheet from its spec

## Your worksheet is already chosen

A deterministic step resolved it from this run's trigger before you started,
and checked that its build spec exists:

```bash
cat /tmp/gh-aw/agent/worksheet-build/ws_id          # the one worksheet to build
cat /tmp/gh-aw/agent/worksheet-build/request.json   # its trigger and source
```

Build that worksheet and no other. **Never work the `ws_id` out for
yourself** — not from `worksheets/_build-request.txt`, not from an issue, and
not from what is already in `worksheets/`. Those go stale: a build that read
the request file instead of its own dispatch input picked a worksheet that had
already shipped and spent the run on a no-op. If the file is missing, call
`missing_data` naming `/tmp/gh-aw/agent/worksheet-build/ws_id`, and stop.

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
   bash .github/skills/worksheet-build/scripts/render-worksheet.sh <ws_id>
   ```

7. Create the pull request. Its body must carry your `BUILT:` report in full —
   the next three stages read it, and the judge reads it only to find what it
   omitted.
8. Ring the doorbell for stage 2: call `dispatch_workflow` for
   `aw-worksheet-voice`. Do this **after** `create_pull_request`, and only if
   the pull request was created. The `stage:voice` label marks the work; the
   dispatch is what actually wakes the next run, because GitHub does not raise
   a workflow run for a label applied by `GITHUB_TOKEN`.

## Boundaries

Change exactly one file: `worksheets/<ws_id>.qmd`.

Never edit anything under `handbook/`, the book's root `.qmd` files, the root
`_quarto.yml`, or any spec in `docs/worksheets/`.

If the spec is unbuildable as written, do not guess. Create no pull request;
instead report exactly which section and row you cannot satisfy, and why.

## If nothing is needed

If the worksheet already exists and matches its spec, call `report_incomplete`
saying so, rather than opening an empty pull request. Somebody asked for a
build that was not needed, and they should see that. This workflow has no
`noop` on purpose: a build that produces nothing must never look like success.
