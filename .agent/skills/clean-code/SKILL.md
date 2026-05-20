---
name: clean-code
description: Review and refactor Dart or Flutter code for production quality. Use when tightening recent changes, removing verbosity, simplifying logic, or making code more idiomatic before commit.
---

# Clean Code

Use this skill for focused cleanup passes on Dart and Flutter code. Preserve behavior unless the task is explicitly to fix a bug.

## Workflow

1. Inspect the target files or recent changes.
2. Remove noise first: dead code, unused imports, obvious comments, redundant variables.
3. Simplify control flow and expressions without changing intent.
4. Apply Dart and Flutter idioms that improve clarity.
5. Stop when the code is materially cleaner. Do not churn unrelated code.

## Cleanup rules

### Remove verbosity

- Delete comments that restate the code.
- Prefer expression bodies when they stay readable.
- Prefer collection literals and spreads over stepwise mutation.
- Prefer `final` when values do not change.

### Simplify logic

- Prefer early returns over nested conditionals.
- Use null-aware operators when they reduce branching.
- Use switch expressions and pattern-friendly Dart features when they make the code clearer.
- Collapse temporary variables that do not add meaning.

### Stay idiomatic

- Use cascades when the same receiver is configured multiple times.
- Prefer clear constructors or factories over ambiguous helper code.
- Keep names short but explicit.
- Remove single-use abstractions that do not pay for themselves.

### Avoid over-engineering

- Do not add defensive layers that the code does not need.
- Do not extract helpers just to satisfy DRY mechanically.
- Do not rewrite stable code outside the requested scope.

## Review mode

If the user asked for a review, report findings first with file and line references, ordered by severity. If the user asked for cleanup or refactoring, apply the fixes directly and summarize the important changes.
