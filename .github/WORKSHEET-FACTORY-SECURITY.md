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
| Required status checks | none, for now - see below |
| Enforce for administrators | no, the owner keeps a bypass |
| Force pushes / deletions | blocked |

Code-owner review is the control that matters. `can_approve_pull_request_reviews`
is `true` on this repository, so a workflow holding `pull-requests: write` can
file an approving review. `github-actions[bot]` is not listed in CODEOWNERS, so
such an approval cannot satisfy the code-owner requirement, and nothing the
factory produces reaches `main` unread.

## Why the isolation check is not yet required

Workflow runs on pull requests opened by `github-actions[bot]` currently land in
`action_required` and wait for a human to approve them. That is the documented
behaviour of **Require approval for first-time contributors**, the repository's
current setting, which GitHub defines as applying to users "who have never had a
commit or pull request merged into this repository". Both the pull request
author and the triggering actor are checked, so this turns on the bot's identity
and *not* on whether the pull request came from a fork - the observed runs were
on a same-repository branch.

It is therefore expected to be a first-contribution condition rather than a
standing one: GitHub states that "a user that has had any commit or pull request
merged into the repository will not require approval". Once the first agentic
pull request merges, later ones should start their checks unattended.

That is unconfirmed for an App identity - the documentation says "users", and
`github-actions[bot]` is an App. Until it is observed, requiring the `isolation`
check would leave every agentic pull request blocked behind a manual approval.

The sequence to close this out:

1. Merge the first agentic pull request after a code-owner review.
2. Run the next worksheet and observe whether `isolation` starts unattended.
3. If it does, add `isolation` to the required checks.
4. If it does not, fall back to **Require approval for first-time contributors
   who are new to GitHub**, which the bot is not. Do not disable fork approval
   wholesale on a public repository.

The required check is named `isolation` - the job id, not the workflow name
`Worksheet isolation`. Requiring the workflow name would never match and would
block every pull request. Note also that `build-deploy` fails on every run
because this fork has never published `gh-pages`; it must never be required.

The `Worksheet isolation` workflow has no `pull_request` path filter so that it
can be required later. GitHub's guidance on required checks is that a workflow
skipped by path filtering leaves its check pending and blocks the merge, so
"avoid requiring workflows that can be skipped".

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
