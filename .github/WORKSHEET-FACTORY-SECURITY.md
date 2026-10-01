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
Branch protection is tracked separately and must require a code-owner review
and the GitHub Actions `isolation` check before changes reach `main`. The
`Worksheet isolation` workflow runs on every pull request because GitHub leaves
path-filtered required checks pending, which would otherwise block unrelated
pull requests.

Primary references:

- [Manually running a workflow](https://docs.github.com/en/actions/how-tos/manage-workflow-runs/manually-run-a-workflow)
- [Managing labels](https://docs.github.com/en/issues/using-labels-and-milestones-to-track-work/managing-labels)
- [Repository roles for an organization](https://docs.github.com/en/organizations/managing-user-access-to-your-organizations-repositories/managing-repository-roles/repository-roles-for-an-organization)
- [Triggering a workflow](https://docs.github.com/en/actions/how-tos/write-workflows/choose-when-workflows-run/trigger-a-workflow)
