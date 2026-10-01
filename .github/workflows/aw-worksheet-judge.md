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
  contains(github.event.pull_request.labels.*.name, 'stage:judge')

permissions:
  # Copilot inference via the Actions token - no PAT, minted per run and
  # revoked automatically. Billing flows through the org Copilot plan.
  copilot-requests: write
  contents: read
  pull-requests: read
  issues: read

engine:
  id: copilot
  # The judge sees the artifact too. Same mechanism as the review stage: a
  # mid-session file read returns a PNG's dimensions, not its content, so the
  # image must be attached at launch. The capture step below re-renders the
  # worksheet from the pull request's CURRENT head, so the judge sees the
  # POST-FIX state — not whatever the review stage looked at before it pushed.
  args: ["--attachment", "/tmp/gh-aw/agent/worksheet-judge/full-page.png"]

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

  - name: Re-render the worksheet so the judge sees the current state
    env:
      GH_TOKEN: ${{ github.token }}
    run: |
      .github/skills/worksheet-build/scripts/capture-for-review.sh \
        "stage:judge" /tmp/gh-aw/agent/worksheet-judge

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

## What you have been given

**The rendered worksheet is attached to this conversation as an image.** It was
re-rendered from this pull request's current head immediately before you
started, so it is the state after every fix the earlier stages pushed — not
whatever the review stage looked at.

The pull request head is already checked out. Supporting facts:

```bash
cat /tmp/gh-aw/agent/worksheet-judge/capture.json        # pull request number, ws_id, gate result
cat /tmp/gh-aw/agent/worksheet-judge/layout-report.json  # per-sheet geometry and every defect
cat /tmp/gh-aw/agent/worksheet-judge/gate.log            # the gate's own output, run fresh for you
```

That gate output is **yours** — it was produced by this run, not pasted from a
comment. Quote its final line verbatim in your verdict.

Pass the pull request number from `capture.json` as `pull_request_number` on
every safe output.

A deterministic step has already confirmed the review stage attached a rendered
image to this pull request. If it had not, you would not be running.

You have **no edit tool and no push output**. That is deliberate. Report
findings with reproductions; you do not fix them.

## Run the gate yourself

The capture step already ran it for you, fresh, on this pull request's current
head. Read its output:

```bash
cat /tmp/gh-aw/agent/worksheet-judge/gate.log
cat /tmp/gh-aw/agent/worksheet-judge/layout-report.json
```

Quote its final line verbatim. If you want to re-run it yourself, you may:

```bash
.github/skills/worksheet-build/scripts/render-worksheet.sh <ws_id>
```

What you must never do is quote "the gate passed" from someone else's comment.
That is a claim, not evidence.

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
