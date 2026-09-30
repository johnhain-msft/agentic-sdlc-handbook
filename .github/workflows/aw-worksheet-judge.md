---
# Stage 4 and the gate of the worksheet factory: independent adversarial verdict.
#
# Trigger: a pull request labelled `stage:judge`.
# Output: PASS  -> mark ready for review, label `ready-for-human`
#         FAIL  -> label exactly ONE of stage:build|stage:voice|stage:review
#                  and bump cycles:N. At cycles:3 label `needs-human` and stop.
#
# The agent runs READ-ONLY: it has no edit tool and no push safe-output, so it
# structurally cannot fix what it reviewed.

on:
  workflow_dispatch:
  pull_request:
    types: [labeled]

# workflow_dispatch is the real entry point — a `labeled` event raised by
# GITHUB_TOKEN does not create a workflow run. The labeled trigger is kept so a
# human can re-run this stage by hand.

if: >-
  github.event_name == 'workflow_dispatch' ||
  contains(github.event.pull_request.labels.*.name, 'stage:judge')

permissions:
  # Copilot inference via the Actions token - no PAT, minted per run and
  # revoked automatically. Billing flows through the org Copilot plan.
  copilot-requests: write
  contents: read
  pull-requests: read
  issues: read

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
  github:
    toolsets: [default]

imports:
  - shared/worksheet-toolchain.md
  - .github/agents/worksheet-judge.agent.md

# Deterministic enforcement of the review stage's defining rule, run BEFORE the
# agent starts. "A review that does not attach the rendered image is void" is an
# instruction to an agent; an instruction is not a control. This step is.
#
# It lives here rather than in its own workflow because a separate workflow
# would have to trigger on `pull_request: labeled`, and GitHub does not create
# a workflow run for a label applied by GITHUB_TOKEN — the gate would be inert
# exactly when it mattered.
steps:
  - name: Require a rendered image from the review stage
    env:
      GH_TOKEN: ${{ github.token }}
      REPO: ${{ github.repository }}
    run: |
      set -euo pipefail

      pr="$(gh pr list --repo "$REPO" --state open \
              --label worksheet --label stage:judge \
              --json number --jq '.[0].number // empty')"

      if [ -z "$pr" ]; then
        echo "No pull request is waiting at stage:judge. Nothing to gate."
        exit 0
      fi

      bodies="$(gh api "repos/$REPO/issues/$pr/comments" --paginate --jq '.[].body')"

      if printf '%s' "$bodies" | grep -qiE '!\[[^]]*\]\([^)]+\.png[^)]*\)'; then
        echo "OK: PR #$pr carries a rendered sheet image."
        exit 0
      fi

      echo "::error::PR #$pr reached stage:judge with no rendered worksheet image."
      echo "The review stage is VOID without one. The judge will not run."
      echo "worksheet-review must render the sheet, drive playwright-cli against"
      echo "it on localhost, and attach the PNGs with markdown image syntax."
      exit 1

safe-outputs:
  add-comment:
    target: "*"
    max: 1
  add-labels:
    target: "*"
    allowed:
      - "stage:build"
      - "stage:voice"
      - "stage:review"
      - "ready-for-human"
      - "needs-human"
      - "cycles:1"
      - "cycles:2"
      - "cycles:3"
    max: 3
  remove-labels:
    target: "*"
    allowed:
      - "stage:judge"
      - "cycles:0"
      - "cycles:1"
      - "cycles:2"
    max: 2
  mark-pull-request-as-ready-for-review:
    target: "*"
  dispatch-workflow:
    workflows: [aw-worksheet-build, aw-worksheet-voice, aw-worksheet-review]
    max: 1
  missing-tool:
---

# Judge the worksheet

## Find your work

This stage is woken by `dispatch_workflow`, so there may be no triggering pull
request in the event context. Find the work yourself:

```bash
gh pr list --state open --label worksheet --label stage:judge \
  --json number,labels --jq '.[0]'
# Credentials are stripped after checkout, so `gh pr checkout` cannot fetch.
# The PR head was fetched for you already — check it out from the local ref:
git checkout -B "pr-<number>" "refs/remotes/origin/pull/<number>/head"
git diff --name-only origin/main...HEAD
```

If there is no such pull request, call `noop` saying the queue is empty and
stop. Pass the number you found as `pull_request_number` on every safe output.

A deterministic step has already run before you and confirmed a rendered image
is attached to this pull request. If it had not been, you would not be running.

You have **no edit tool and no push output**. That is deliberate. Report
findings with reproductions; you do not fix them.

## Run the gate yourself

```bash
.github/skills/worksheet-build/scripts/render-worksheet.sh <ws_id>
cat worksheets/_review/<ws_id>/layout-report.json
```

Quote its final line verbatim. "The gate passed" in someone else's comment is a
claim, not evidence.

## Derive acceptance from the spec, not from the reports

Read `docs/worksheets/<ws_id>.md` — §9, §5, §3, §10, §6 — and the chapter file
named in §2, directly. Run probes W1 to W6 from your agent instructions.

The build, voice and review comments on this PR are claims. Read them **after**
you have formed your own view, and only to note what they omitted.

## Emit the verdict and route it

Post your `WORKSHEET JUDGE:` report as a comment, then:

**On PASS** — add `ready-for-human`, remove `stage:judge`, and mark the pull
request ready for review. Do not add a stage label.

**On FAIL** — remove `stage:judge` and add **exactly one** of `stage:build`,
`stage:voice` or `stage:review`, chosen by the routing table in your agent
instructions. Where findings span stages, return to the earliest one and list
the downstream findings so they are not lost. Then call `dispatch_workflow` for
the matching workflow — `aw-worksheet-build`, `aw-worksheet-voice` or
`aw-worksheet-review` — because a label alone will not wake it.

Then bump the cycle counter: read the current `cycles:N` label on this pull
request, remove it, and add `cycles:N+1`.

## The cycle bound

If this pull request already carries `cycles:3`, **do not route it back**.
Add `needs-human`, remove `stage:judge`, add no stage label, dispatch nothing,
and state plainly in your report what a person has to decide. Three passes that
have not fixed a problem mean the problem is the spec, the substrate or a
genuine judgement call, and a fourth automated round will not fix any of those.

## Boundaries

Never edit anything. Never grade against another stage's checklist. Never
dismiss a class of gate warnings in one line — adjudicate each individually with
a stated reason. Never name more than one return stage.
