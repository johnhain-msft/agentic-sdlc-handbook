# Worksheet factory security posture

Last reviewed: 2026-10-01

The repository is public. Public visibility does not, by itself, let an
unprivileged actor start any of the four agentic worksheet workflows.

| Workflow | Trigger | Activation boundary |
|---|---|---|
| Build | `issues: labeled` | Applying `stage:build` requires repository triage access or higher. |
| Build | `push` of `worksheets/_build-request.txt` | Pushing a branch in this repository requires write access or higher. A fork push is not a push to this repository. |
| All four stages | `workflow_dispatch` | GitHub requires write access to dispatch a workflow. |
| Voice, review, judge | `pull_request: labeled` | Applying a stage label requires triage access or higher. The compiled activation condition also requires `github.event.pull_request.head.repo.id == github.repository_id`, so a labelled fork pull request cannot activate the agent job. |

`roles: all` removes gh-aw's additional actor-role check so
`github-actions[bot]` can dispatch the next stage. It does not remove the
GitHub permission boundaries above. On the audited triggers and compiled
activation conditions, no read-only public user can start an agentic run.

This conclusion depends on those boundaries remaining intact. Re-audit before
adding a trigger driven directly by public input, changing the same-repository
pull-request guard, or widening permissions or safe outputs. The factory
workflows, agents, and skills are explicitly covered by `.github/CODEOWNERS`.

Pull request comments are public input too. When the judge returns a pull
request to voice or review, a pre-agent step hands that stage the judge's
verdict from a comment. It accepts a comment only if `github-actions[bot]`
posted it and its last gh-aw footer marker names this repository's
`aw-worksheet-judge` workflow, so a commenter cannot forge instructions to a
stage that can push to the branch (`fetch-judge-verdict.sh`, `verdict.test.sh`).

The plain `Worksheet queue` workflow holds `actions: write`, so it can dispatch
the build. Its triggers stay behind the same kind of boundary: a label needs
triage, a push to `main` needs write access (or a merge, which needs
code-owner review), and a dispatch needs write. Closing an issue starts it only
when the issue carries `stage:build`, which only someone with triage access or
the queue itself can have applied; closing needs triage access or authorship
of the issue. The label boundary holds only while no issue template applies
`worksheet-queued`: a template's labels are applied whoever opens the issue. It
has no `pull_request` trigger, so no fork, and no pull request's stale merge
ref, can run it. The queue takes nothing from the triggering event except the
default branch's name; every run re-reads the repository's state.
It only dispatches a ws_id that the build's own resolver has checked against an
existing build spec, and only one worksheet at a time: an open `stage:build`
issue, an open worksheet pull request, and every build run not yet completed
each hold the slot. Runs are counted by status, so newer runs cannot hide one.

Primary references for this section:

- [Manually running a workflow](https://docs.github.com/en/actions/how-tos/manage-workflow-runs/manually-run-a-workflow)
- [Managing labels](https://docs.github.com/en/issues/using-labels-and-milestones-to-track-work/managing-labels)
- [Repository roles for an organization](https://docs.github.com/en/organizations/managing-user-access-to-your-organizations-repositories/managing-repository-roles/repository-roles-for-an-organization)
- [Triggering a workflow](https://docs.github.com/en/actions/how-tos/write-workflows/choose-when-workflows-run/trigger-a-workflow)

## Branch protection on `main`

Applied 2026-10-01:

| Setting | Value |
|---|---|
| Required approving reviews | 1 |
| Require review from code owners | yes |
| Dismiss stale reviews on new commits | yes |
| Required status checks | none - see below |
| Enforce for administrators | no, the owner keeps a bypass |
| Force pushes / deletions | blocked |

Code-owner review is the control that matters. `can_approve_pull_request_reviews`
is `true` on this repository, so a workflow holding `pull-requests: write` can
file an approving review. `github-actions[bot]` is not listed in CODEOWNERS, so
such an approval cannot satisfy the code-owner requirement, and nothing the
factory produces reaches `main` unread.

## Why the isolation check is not required

Workflow runs on pull requests opened by `github-actions[bot]` land in
`action_required` and wait for a human with write access to approve them.

**This is not the first-time-contributor rule, and merging does not clear it.**
That was the working theory: the repository's policy, *Require approval for
first-time contributors*, covers users "who have never had a commit or pull
request merged into this repository". So after the first agentic pull request
(#8) merged, later ones were expected to run unattended. They did not. With
`github-actions[bot]` listed as a contributor, the next agentic pull request's
`isolation` run (#13, run 36917525343) was still `action_required`. The gate
follows the bot's identity, as GitHub's changelog describes - bot-created pull
requests "are now able to run your CI/CD workflows with user approval" - and no
setting was found that exempts them. Loosening the fork-approval policy would
widen the public surface without removing it, so it stays as it is.

So `isolation` is **not** a required check: requiring it would hold every
agentic pull request behind a manual "Approve and run". Nothing is lost that
matters:

- It runs on every push to `main` that touches a worksheet, the book's
  `_quarto.yml`, a root `.qmd` or the layout gate - its push trigger is
  path-filtered to exactly those - so a merged worksheet that broke the
  book-isolation invariant is caught immediately after the merge.
- It runs, without approval, on every pull request a person opens. Those are
  the ones that change the factory - workflows, agents, the gate and its tests -
  and they are where its suites earn their keep.
- An agentic pull request changes one file, `worksheets/<ws_id>.qmd`, and the
  layout gate runs inside the build, review and judge stages themselves.

If GitHub later documents an exemption for workflow-created pull requests,
revisit this. The required check would be named `isolation` - the job id, not
the workflow name `Worksheet isolation`, which would never match. Never require
`build-deploy`: it fails on every run because this fork has never published
`gh-pages`. The workflow has no `pull_request` path filter, because GitHub
leaves a path-skipped required check pending and blocks the merge.

Primary references for this section:

- [Managing GitHub Actions settings for a repository](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-github-actions-settings-for-a-repository#controlling-changes-from-forks-to-workflows-in-public-repositories)
- [Approving workflow runs from forks](https://docs.github.com/en/actions/how-tos/manage-workflow-runs/approve-runs-from-forks)
- [Troubleshooting required status checks](https://docs.github.com/en/pull-requests/how-tos/merge-and-close-pull-requests/troubleshooting-required-status-checks)
- [Bot-created pull requests can run workflows if approved](https://github.blog/changelog/2026-06-11-bot-created-pull-requests-can-run-workflows-if-approved/)

## Content audit

Reviewed and signed off 2026-10-01.

Every path flagged as confidential in `.gitignore` was confirmed absent from
`HEAD`: `handbook/architecture*.md`, `audit-csuite-strategist`,
`audit-synthesis`, `reviews/publishing-strategy`,
`reviews/monetization-reassessment` and `reviews/apm-audit-publishing`.
`career/` and `.private-backup/` were never committed.

`handbook/reviews/` and two `audit-*` files are present in history, but they are
inherited from the upstream repository, which is itself public and already
publishes all of them. This fork exposes nothing new.

The 72 build specs in `docs/worksheets/` are tracked and public, and each
carries a verbatim extract from the book in its section 3. No Microsoft or
customer material is involved - the specs derive only from the published book -
so this is a CC BY-NC-ND licensing question about the author's content rather
than a confidentiality one. The repository owner has accepted this and the
specs stay tracked. Revisit if the upstream licence changes, or at the author's
request; untracking them would break the build stage, which reads a spec from
the working tree.
