---
# Stage 2 of the worksheet factory: voice pass over a built worksheet.
#
# Trigger: a pull request labelled `stage:voice`.
# Output: prose-only edits pushed to the PR branch, relabelled `stage:review`
#         so the next stage picks it up in a FRESH run.

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

# workflow_dispatch is the real entry point. A `pull_request` `labeled` event
# raised by GITHUB_TOKEN does NOT create a workflow run (GitHub docs), so the
# previous stage wakes this one with dispatch_workflow instead. The labeled
# trigger is kept so a human can re-run a stage by applying the label by hand,
# which does create a run.

if: >-
  github.event_name == 'workflow_dispatch' ||
  contains(github.event.pull_request.labels.*.name, 'stage:voice')

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
  github:
    toolsets: [default]

imports:
  - shared/worksheet-toolchain.md
  - .github/agents/worksheet-voice.agent.md

safe-outputs:
  push-to-pull-request-branch:
    target: "*"
    required-labels: [worksheet]
  add-labels:
    target: "*"
    allowed: ["stage:review", "needs-human"]
    max: 2
  remove-labels:
    target: "*"
    allowed: ["stage:voice"]
    max: 1
  add-comment:
    target: "*"
    max: 1
  dispatch-workflow:
    workflows: [aw-worksheet-review]
    max: 1
  missing-tool:
---

# Voice pass over a worksheet

## Find your work

This stage is woken by `dispatch_workflow`, so there may be no triggering pull
request in the event context. Find the work yourself:

```bash
gh pr list --state open --label worksheet --label stage:voice \
  --json number,headRefName,files --jq '.[0]'
```

- **No such pull request** — call `noop` with a message saying the queue is
  empty, and stop. Do not invent work.
- **More than one** — take the lowest-numbered one. The queue is capped at
  three, and the others will be picked up by their own dispatches.

Check that pull request out, and read the one worksheet it changes:

```bash
# Credentials are stripped after checkout, so `gh pr checkout` cannot fetch.
# The PR head was fetched for you already — check it out from the local ref:
git checkout -B "pr-<number>" "refs/remotes/origin/pull/<number>/head"
git diff --name-only origin/main...HEAD
```

Every safe output below takes an explicit `pull_request_number` — pass the
number you found.

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
9. Ring the doorbell for stage 3: call `dispatch_workflow` for
   `aw-worksheet-review`. The label marks the work; the dispatch is what wakes
   the run.

## If nothing needs changing

That is a normal and good outcome. Push nothing, post the report saying so, and
still relabel to `stage:review` and dispatch stage 3. An unnecessary rewrite
costs a review cycle and drifts the sheet away from its spec.

## Boundaries

Prose only. Never a field, column, option, label, number, `.prior`,
`.hedge-text`, `.ws-foot-quote`, `.ws-source`, class or stylesheet.

Never edit `handbook/`, the book's root `.qmd` files, the root `_quarto.yml`, or
any spec in `docs/worksheets/`.

If the sheet has a problem outside your scope, report it and relabel anyway —
the judge will route it to the right stage.
