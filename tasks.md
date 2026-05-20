# tasks.md

## Status Legend

- `[OPEN]` Ready to be worked on.
- `[DOING]` Currently in progress.
- `[NEEDS SPECIFICATION]` Waiting for required detail.
- `[BLOCKED]` Waiting on an external dependency, permission, or environment.
- `[DONE]` Implemented and verified, or implemented with verification limits noted.
- `[CANCELLED]` No longer needed.

## Active Tasks

| ID | State | Updated | Task | Notes |
| --- | --- | --- | --- | --- |
| T-001 | [DONE] | 2026-05-20 | Wire `flutter_native_splash` to `assets/app_icon_splash.png` | Updated [`pubspec.yaml`](pubspec.yaml). |
| T-002 | [DONE] | 2026-05-20 | Regenerate native and web splash assets from the new splash image | Ran `dart run flutter_native_splash:create`. |
| T-003 | [DONE] | 2026-05-20 | Apply rounded corners to the live bingo board corner cells | Added corner radii and clipping in the live board cell path. |
| T-004 | [DONE] | 2026-05-20 | Add repository agent workflow documentation | Added `agent.md` and updated `CLAUDE.md`. |
| T-005 | [DONE] | 2026-05-20 | Add a base black/white theme palette | Added a brightness-aware `base` palette and verified with `task lint`. |
| T-006 | [DONE] | 2026-05-20 | Change the small done-check circle color to the theme secondary color | Done badge now uses `secondary` and `onSecondary`; verified with `task lint`. |
| T-007 | [DONE] | 2026-05-20 | Add task-pruning and date rules to the agent workflow docs | Added dated task entries plus a 14-day default prune rule. |
| T-008 | [DONE] | 2026-05-20 | Remove the 1px cell text jump when toggling edit mode | Reused one `TextField` layout for both states and verified with `task lint`. |
| T-009 | [DONE] | 2026-05-20 | Fix board switching so it does not create duplicate animated board routes | Reused the current board screen on board-to-board switches and verified with `task lint`. |
| T-010 | [DONE] | 2026-05-20 | Let long press reach the locked bingo cell even when pressing on text | Wrapped the locked `TextField` in `IgnorePointer` and verified with `task lint`. |
| T-011 | [DONE] | 2026-05-20 | Remove animation from the new-card grid preview | Switched the preview cells to static containers and verified with `dart analyze`. |
| T-012 | [DONE] | 2026-05-20 | Make the share dialog close action part of the scrollable content and add a title-bar dismiss icon | Moved the text close action into the scroll area and added a title-bar `X`; verified with `dart analyze`. |
| T-013 | [DONE] | 2026-05-20 | Limit new bingo board grid size to 24 | Reduced the creation-screen maximum grid size from 99 to 24 and verified with `dart analyze`. |
| T-014 | [DONE] | 2026-05-20 | Commit and push the full current worktree | Verified with `task lint`, then staged, committed, and pushed all changes on `main`. |

## Notes

- Keep exactly one task in `[DOING]` at a time unless the user explicitly asks for parallel work.
- Add new tasks here before starting substantial multi-step work.
- Record verification limits in the `Notes` column instead of silently marking uncertain work as done.
- Prune `[DONE]` and `[CANCELLED]` tasks once they are no longer useful context.
- Default pruning window: 14 days after the `Updated` date.
