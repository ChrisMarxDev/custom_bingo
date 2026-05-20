---
name: flutter-hot-reload
description: Trigger a Flutter hot reload after meaningful edits to `lib/**/*.dart` or `test/**/*.dart` while `task dev` or another Taskfile `_run_with_pid` flutter task is active, so the running app reflects the change without a manual `r` press. Requires `/tmp/flutter.pid` or `FLUTTER_PID`.
---

# Flutter Hot Reload

Use this skill after a batch of Dart edits when the app is already running through the project's Taskfile.

## How it works

1. `task dev` and the other `_run_with_pid` tasks write the running Flutter PID to `/tmp/flutter.pid` or the path in `FLUTTER_PID`.
2. The reload script reads that PID and sends `SIGUSR1`.
3. `flutter run` treats that signal as a hot reload.

## Run it

Run once per edit batch:

```bash
.agent/skills/flutter-hot-reload/scripts/hot_reload_from_pid.sh --verbose
```

Expected success output:

```text
Read Flutter PID '<pid>' from '/tmp/flutter.pid'
Hot reload signal sent to PID <pid>.
```

Then confirm in `flutter.log`:

```bash
tail -5 flutter.log
```

Look for `Performing hot reload...` followed by `Reloaded N libraries in ...ms`.

## When to run

- Single focused Dart edit: run after the write is finished.
- Multi-file refactor: run once after the batch.
- Comment-only changes: skip it.

## Failure modes

Surface failures clearly instead of hiding them:

- `PID file not found`: the app is not running through `task dev` or another `_run_with_pid` task.
- `process '<pid>' is not running`: the PID file is stale.
- `unable to send USR1`: permission issue or wrong process owner.
- `Reloaded 0 libraries`: signal worked, but Flutter had nothing new to reload.

## Do not run it for

- `pubspec.yaml` dependency changes
- native `ios/` or `android/` edits
- localization ARB changes before `task locale`
- changes that need a hot restart instead of reload, such as some `main_*.dart` or `initState`-driven behavior
- cases where the user explicitly said not to reload

Report in the final summary if the reload did not run or did not succeed.
