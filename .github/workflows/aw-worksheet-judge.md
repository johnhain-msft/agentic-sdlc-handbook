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
  pull_request:
    types: [labeled]

if: contains(github.event.pull_request.labels.*.name, 'stage:judge')

permissions:
  contents: read
  pull-requests: read
  issues: read

engine: copilot

network: defaults

tools:
  bash:
    - "*"
  github:
    toolsets: [default]

imports:
  - .github/agents/worksheet-judge.agent.md

safe-outputs:
  add-comment:
    target: triggering
    max: 1
  add-labels:
    target: triggering
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
    target: triggering
    allowed:
      - "stage:judge"
      - "cycles:0"
      - "cycles:1"
      - "cycles:2"
    max: 2
  mark-pull-request-as-ready-for-review:
  missing-tool:
---

# Judge the worksheet

This pull request carries exactly one worksheet at `worksheets/<ws_id>.qmd`.
Find it with `git diff --name-only origin/main...HEAD`.

You have **no edit tool and no push output**. That is deliberate. Report
findings with reproductions; you do not fix them.

## Run the gate yourself

```bash
cd .github/skills/worksheet-build && npm install --no-audit --no-fund && cd -
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
the downstream findings so they are not lost.

Then bump the cycle counter: read the current `cycles:N` label on this pull
request, remove it, and add `cycles:N+1`.

## The cycle bound

If this pull request already carries `cycles:3`, **do not route it back**.
Add `needs-human`, remove `stage:judge`, add no stage label, and state plainly
in your report what a person has to decide. Three passes that have not fixed a
problem mean the problem is the spec, the substrate or a genuine judgement
call, and a fourth automated round will not fix any of those.

## Boundaries

Never edit anything. Never grade against another stage's checklist. Never
dismiss a class of gate warnings in one line — adjudicate each individually with
a stated reason. Never name more than one return stage.
