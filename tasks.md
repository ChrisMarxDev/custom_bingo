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
| T-015 | [DONE] | 2026-05-21 | Make shared invite links clickable in WhatsApp | Invite generation now emits `https://bingogrid.web.app/import?d=...`, which chat apps can parse as a normal web URL. |
| T-016 | [DONE] | 2026-05-21 | Remove current web build blockers from the app | Replaced `dart:io` share paths and gzip usage with web-safe implementations. |
| T-017 | [DONE] | 2026-05-21 | Support importing shared boards from hosted web URLs | `decodeShareLink` and app startup now accept hosted `/import?d=...` links in addition to `custombingo://...`. |
| T-018 | [DONE] | 2026-05-21 | Verify web readiness with an actual web build | `flutter build web --target lib/main_development.dart` passed; browser runtime still needs manual testing. |
| T-019 | [DONE] | 2026-05-21 | Add Firebase Hosting configuration for the web app | Added `firebase.json` and `.firebaserc` for project/site `bingogrid` with SPA rewrites to `index.html`. |
| T-020 | [DONE] | 2026-05-21 | Add repeatable web build and deploy tasks | Added `task build:web` and `task deploy:web`. |
| T-021 | [DONE] | 2026-05-21 | Deploy the current web app to Firebase Hosting | Deployed successfully to `https://bingogrid.web.app` and verified `200` on `/` and `/import?...`. |
| T-022 | [DONE] | 2026-05-21 | Fix serving of hosted app/universal-link association files | Adjusted Firebase Hosting header paths and verified `200` plus `application/json` for both `/.well-known/assetlinks.json` and `/.well-known/apple-app-site-association`. |
| T-023 | [DONE] | 2026-05-21 | Make installed mobile apps claim hosted HTTPS import links directly | Added Android `https` App Links and iOS associated domains for `bingogrid.web.app`; verified with `task lint` and an iOS simulator build for the development flavor. |
| T-024 | [DONE] | 2026-05-21 | Skip the import confirmation dialog on web-hosted share links | Web now auto-imports hosted links directly; verified with `task lint`, `flutter test test/features/bingo_card/share_link_test.dart`, web builds, and a fresh Hosting deploy. |
| T-025 | [DONE] | 2026-05-21 | Update repository instructions for the live web app target | Added explicit web-compatibility and hosted-import-link guidance to `agent.md` and `CLAUDE.md`. |

## Notes

- Keep exactly one task in `[DOING]` at a time unless the user explicitly asks for parallel work.
- Add new tasks here before starting substantial multi-step work.
- Record verification limits in the `Notes` column instead of silently marking uncertain work as done.
- Prune `[DONE]` and `[CANCELLED]` tasks once they are no longer useful context.
- Default pruning window: 14 days after the `Updated` date.
