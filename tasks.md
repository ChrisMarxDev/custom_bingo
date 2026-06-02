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
| T-026 | [DONE] | 2026-06-02 | Design and implement randomized item pools for bingo boards | Added global "Pre-made tiles" settings library with Drift-backed persisted selection and passive watch updates; verified with build_runner, `dart analyze .`, `flutter test`, and production web build. Board creation integration remains intentionally out of scope for this pass. |
| T-027 | [OPEN] | 2026-06-02 | Explore image support for bingo squares | Candidate feature; needs a web-safe storage/share approach before implementation. |

## Feature Concepts

### Randomized Item Pool

User need:
Allow creators to enter more possible bingo items than the board has squares, then generate a board by randomly selecting from that pool. This covers repeated requests for bonus fields, extra entries, random placement, and a fresh board on each play without requiring a server.

MVP behavior:
- Store a flat pool of candidate text entries per board.
- Let users bulk-paste lines into the pool.
- Generate/refill the current grid by sampling without replacement from the pool.
- Clear existing marks when generating a new board from the pool.
- Preserve the current free-center behavior for odd grids: if the center is empty/free, keep it fixed and only fill the other squares.
- If the pool has fewer usable entries than required, either disable generation with a count hint or fill the remainder with blank cells. Prefer disabling at first so users understand the pool requirement.

Data model direction:
- Extend `BingoCardState` with an optional `poolItems` list so old saved cards continue loading without migration.
- Use a separate pool item model, such as `BingoPoolItem(id, text)`, instead of overloading `BingoItem.fullfilledAt`; pool entries are source material, while grid items are the playable generated board.
- Treat existing board cells as the implicit starter pool when opening the pool editor on older boards with no stored pool.

Controller direction:
- Add a `generateFromPool()` method near the existing `shuffleCard()` logic.
- Keep `shuffleCard()` as "shuffle the current board"; add pool generation as a separate command because it can replace items, not just reorder them.
- Generate fresh `BingoItem` IDs for selected pool entries so completion state cannot leak between generated boards.
- Add targeted tests for sampling size, mark clearing, insufficient pool handling, old-card loading, and free-center preservation.

Design direction:
- Add an "Item pool" action to the board menu or edit toolbar.
- Use a focused editor screen or bottom sheet with a list/multiline paste surface, item count, and a primary "Fill board" action.
- Show the required count based on grid size and free-center state, for example 24 needed for a 5x5 board with a free center.
- On the new-board screen, consider an optional "Start from list" flow so a pasted list can immediately create a generated board.

Sharing direction:
- Keep share links serverless.
- For the first implementation, share the generated board as today and keep the source pool local.
- If sharing pools later, add a v2 share payload with optional pool data and a clear size limit, because long lists can exceed practical URL lengths even with gzip.

### Image Support

User need:
Let users add images/photos to bingo squares, with one request specifically asking to reveal a random photo from a collection when a square is completed.

Initial direction:
- Treat this as a separate feature after item pools because storage and sharing are more complex without a server.
- Prefer square-level image attachments before photo-reveal behavior.
- Decide whether images are local-only, shareable, or both before implementation.
- Avoid putting large base64 images into existing share links by default; that would be fragile on web and in chat apps.
- Investigate a web-compatible local storage option before adding image files to `BingoCardState`.

Benched for now:
- Proper live multiplayer, collaboration, group scoring, and iMessage real-time play stay out of scope while the app remains serverless.

## Notes

- Keep exactly one task in `[DOING]` at a time unless the user explicitly asks for parallel work.
- Add new tasks here before starting substantial multi-step work.
- Record verification limits in the `Notes` column instead of silently marking uncertain work as done.
- Prune `[DONE]` and `[CANCELLED]` tasks once they are no longer useful context.
- Default pruning window: 14 days after the `Updated` date.
