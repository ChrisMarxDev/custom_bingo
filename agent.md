# agent.md

This file defines how coding agents should work in this repository.

## Required Workflow

For any task that is more than a single trivial change, the agent must keep
`tasks.md` up to date while working.

The agent must:

1. Read `tasks.md` before starting substantial work.
2. Add any new user-requested work as explicit task entries.
3. Keep exactly one task in `[DOING]` unless the user explicitly asks for
   parallel execution.
4. Move unclear work to `[NEEDS SPECIFICATION]` instead of guessing when the
   missing detail is important.
5. Use `[BLOCKED]` when progress depends on an external dependency, permission,
   failing environment, or user action.
6. Mark a task `[DONE]` only after the change is implemented and verified, or
   after explicitly recording what could not be verified.
7. Keep the final user response aligned with the current state of `tasks.md`.
8. Prune stale completed work from `tasks.md` so it does not become an
   ever-growing archive.

## Task States

Use only these states in `tasks.md`:

- `[OPEN]` Ready to be worked on.
- `[DOING]` Currently being worked on.
- `[NEEDS SPECIFICATION]` Cannot proceed safely without more detail.
- `[BLOCKED]` Waiting on an external dependency, permission, or environment.
- `[DONE]` Implemented and verified, or implemented with verification limits
  clearly recorded.
- `[CANCELLED]` No longer needed.

## Tracking Rules

- Each task must be a concrete deliverable, not a vague topic.
- Break multi-part requests into separate tasks.
- If one request depends on another, order them top to bottom.
- Keep task wording implementation-oriented.
- Update task state before and after meaningful work, not only at the end.
- If a task uncovers follow-up work, add a new task instead of silently
  expanding the existing one.
- Every task entry should include a date column so the file can be pruned
  intentionally.
- Done and cancelled tasks may be deleted once they are no longer useful
  context. By default, prune them when they are older than 14 days.

## Verification Rules

- Prefer `task lint`, targeted tests, or other relevant verification commands.
- If verification cannot be run, record that in `tasks.md`.
- Do not describe a task as complete if it still needs manual confirmation.

## Web Compatibility Rules

- This repository now has a live web target at
  `https://bingogrid.web.app`.
- Future features must consider web compatibility by default, not as an
  afterthought.
- Before introducing platform-specific code or dependencies, check whether the
  change affects Flutter web builds, the hosted app at `bingogrid.web.app`, or
  the hosted import-link flow at `/import?d=...`.
- Avoid unguarded use of `dart:io`, native-only plugins, local temp-file
  assumptions, or custom URL-scheme-only behavior in shared code paths.
- If a feature is intentionally mobile-only, document that decision in
  `tasks.md` and keep the web behavior explicit instead of letting it fail
  implicitly.

## Expected `tasks.md` Format

`tasks.md` should contain a task list in this form:

```md
# tasks.md

## Active Tasks

| ID | State | Updated | Task | Notes |
| --- | --- | --- | --- | --- |
| T-001 | [DOING] | 2026-05-20 | Update splash asset wiring | Switched config; regenerate outputs next. |
| T-002 | [OPEN] | 2026-05-20 | Fix board corner rounding | Waiting for T-001. |
```

The exact wording can change, but every task entry must include:

- An ID
- A state
- A date
- A concrete task description
- Notes, blockers, or verification status
