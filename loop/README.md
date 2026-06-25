# Hermes Issue Workflow

This directory contains the token-gated Hermes workflow for Custom Bingo.

- `fetch-issues.sh` fetches GitHub issues with workflow labels into `.hermes-task-loop/issues.json`.
- `run-hermes-task-loop.sh` runs the deterministic prefetch and only invokes Hermes when `inbox`, `plan`, or `open` issues exist.
- `skills/task-workflow/SKILL.md` is the local workflow contract used by the autonomous run.

Workflow labels:

- `inbox`: rough intake that needs sorting.
- `plan`: produce a technical plan only; leave the issue open as `pending` after posting the plan.
- `open`: ready implementation work.
- `pending`: blocked, waiting for user input, or waiting for user review after a plan.

The scheduled Hermes cron job runs this once per day. Empty/no-work runs are silent.
