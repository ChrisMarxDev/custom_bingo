---
name: task-workflow
description: Coordinate autonomous repository work through GitHub Issues for custom_bingo. Use when Hermes starts, continues, loops through, blocks, completes, plans, refines, sorts, closes, or implements tasks/issues from GitHub Issues.
---

# Git Task Workflow

Use this skill to run the custom_bingo repo task loop from GitHub Issues. GitHub Issues are the source of truth.

The loop sorts rough intake, produces implementation-ready issues, writes technical plans when requested, implements ready work, commits directly to `main`, and leaves every touched issue with either a comment, label transition, closure, or commit reference so nothing dangles.

## Authentication

Use `GH_TOKEN`/`GITHUB_TOKEN` from `/root/.hermes/.env` when GitHub access is needed. Do not print the token.

Examples:

```sh
set -a
. /root/.hermes/.env
set +a
export GH_TOKEN="$GITHUB_TOKEN"
gh issue list --repo ChrisMarxDev/custom_bingo
```

If the token is missing or invalid, stop the GitHub portion and tell the user exactly what is blocked.

## Labels As State

Only one of these state labels should be present on a workflow issue:

- `inbox`: raw idea, bug mention, feature wish, rough requirement, or mixed note. It is not ready to implement.
- `open`: refined, scoped, and ready to implement.
- `pending`: blocked on critical user input, credentials, external systems, or a dependency. It must have a comment with explicit questions or blockers.
- `plan`: the desired output is a technical implementation plan, not code.

If an issue has multiple state labels, normalize it before acting and leave a comment describing the chosen state.

## Loop Order

When this skill is invoked, run the loop until there are no actionable issues, the user explicitly limits the work, or all remaining work is blocked.

1. Confirm the working tree is suitable for new work. Do not overwrite or revert unrelated user changes.
2. Confirm GitHub authentication is available.
3. Use any prefetched issue snapshot provided by the loop runner, then refresh GitHub state as work is completed.
4. Sort every `inbox` issue before starting implementation work.
5. Complete every actionable `plan` issue by posting the technical plan, then leave it open for user review. Remove `plan`, add `pending`, and make clear in the comment that the issue is awaiting a user implementation decision.
6. Implement one `open` issue at a time.
7. After each issue is sorted, planned, implemented, split, closed, or blocked, re-fetch issues so concurrent changes are respected.

Do not wait for user input when other independent `inbox`, `plan`, or `open` issues can be processed.

## Sorting Inbox Issues

For each `inbox` issue, autonomously choose the correct outcome:

- Convert to `open` when the issue has enough scope and acceptance criteria to implement responsibly. Remove `inbox`, add `open`, and comment with the refined requirement and acceptance criteria.
- Convert to `pending` when critical questions block useful progress. Remove `inbox`, add `pending`, and comment with concise questions or blockers. The user can later add information and move it back to `inbox`.
- Convert to `plan` when the useful deliverable is a technical plan rather than code. Remove `inbox`, add `plan`, and comment with the planning scope if helpful.
- Close as duplicate, already completed, invalid, or redundant when no new work should be created. Remove workflow labels only if useful for clarity, comment with the reason, and close the issue.
- Split broad or mixed intake into multiple issues. Create one or more new `open`, `pending`, or `plan` issues with clear titles and bodies, then comment on and close the original `inbox` issue with links to the new issues.

Preserve user intent. When refining, include the user's important wording in the issue body or comment when it carries nuance.

## Planning Issues

For each `plan` issue:

1. Inspect the codebase and relevant project constraints.
2. Write a concrete technical plan as an issue comment. Include target files, behavioral changes, risks, validation, and any sequencing decisions.
3. Do not create implementation `open` issues from the plan unless the user has explicitly requested that. The user reviews plans first and decides what to implement.
4. After posting the plan, keep the issue open, remove `plan`, add `pending`, and state that it is awaiting user review/implementation decision. Do not close a plan issue just because the planning artifact is complete; closed issues are treated as implemented.
5. If a responsible plan cannot be completed, remove `plan`, add `pending`, and comment with explicit questions or blockers.

Do not implement code as part of a `plan`/planning-complete `pending` issue unless the user explicitly changes the issue state to `open` or asks for implementation.

## Implementing Open Issues

Handle one `open` issue at a time:

1. Re-read the issue body and comments.
2. Confirm it is still `open` and not blocked by another active issue.
3. Pull or fetch latest `main` when appropriate, then work directly on `main` for now.
4. Make the smallest responsible code/docs/test changes for the issue.
5. Run validation scaled to risk. Use the repo's normal test, lint, format, or build commands; prefer targeted validation only when it is clearly enough.
6. Commit the changes directly on `main`. The commit message should reference the issue, for example `Implement onboarding polish (#123)`.
7. Comment on the issue with the commit hash, what changed, and validation result.
8. Close the issue.

If implementation discovers a blocker, do not leave partial state ambiguous: commit any useful non-breaking preparatory work or revert your own partial edits, remove `open`, add `pending`, and comment with the blocker and current status. Never revert unrelated user changes.

## Custom Bingo Validation Hints

This repo is a Flutter app with routine commands defined in `Taskfile.yml`. Prefer validation scaled to the change, such as:

```sh
task lint
task test
flutter test test/features/bingo_card
task build:web
```

If FVM is available and the pinned SDK is needed, prefer `fvm flutter ...`; otherwise use the installed `flutter` if it matches the project. If a tool is unavailable on the VPS, run the closest cheap validation and report the limitation in the issue comment.

## GitHub Command Pattern

Use `gh` with `GH_TOKEN` loaded, and always include `--repo ChrisMarxDev/custom_bingo`. Prefer JSON output for parsing:

```sh
set -a; . /root/.hermes/.env; set +a; export GH_TOKEN="$GITHUB_TOKEN"
gh issue list --repo ChrisMarxDev/custom_bingo --state open --label inbox --json number,title,body,labels,url
gh issue edit 123 --repo ChrisMarxDev/custom_bingo --remove-label inbox --add-label open
gh issue comment 123 --repo ChrisMarxDev/custom_bingo --body-file /tmp/comment.md
gh issue close 123 --repo ChrisMarxDev/custom_bingo --comment "Completed in <hash>."
```

Avoid exposing secrets in logs or final responses. When a command fails because GitHub labels are missing, create the required labels if permissions allow; otherwise report the exact missing labels.

## Commit Discipline

- Every implemented `open` issue gets a commit.
- Every sorted, planned, blocked, split, duplicate, invalid, or completed issue gets a comment or closure explaining the outcome.
- Keep commits scoped to one issue unless a split or dependency makes a shared preparatory commit clearly cleaner.
- Do not commit unrelated local changes.
- If the worktree is dirty before starting, identify whether those changes are relevant. Work with relevant changes, ignore unrelated changes, and do not overwrite user work.

## Project Instructions

Follow project-local instructions such as `AGENTS.md`, `CLAUDE.md`, `.agents/skills/*`, README files, and any issue-specific constraints. If project instructions conflict with this loop, prefer the project instruction for code implementation details and preserve this loop for issue state management.

## Final Response

Keep the final response short and concrete. Include:

- Issues sorted, planned, implemented, closed, split, or moved to pending.
- Commit hashes created.
- Validation run and result.
- Remaining blockers or pending questions.
