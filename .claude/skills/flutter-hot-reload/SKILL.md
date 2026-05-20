---
name: flutter-hot-reload
description: Trigger a Flutter hot reload after editing Dart code in lib/. Use after any meaningful edit to lib/**/*.dart, test/**/*.dart, or pubspec.yaml while `task dev` (or another `task`-managed flutter run) is active, so the simulator reflects the change without a manual `r` press. The running flutter process must have been started via the project's Taskfile (_run_with_pid), which writes its PID to /tmp/flutter.pid.
---

# Flutter Hot Reload

Flutter's `flutter run` does not watch files. To apply code changes to the running app, a reload must be triggered explicitly. This skill wraps the project's PID-based reload script so Claude Code can fire a reload after edits.

## How it works

1. `task dev` (and all other `_run_with_pid`-based tasks in `Taskfile.yml`) write the running Flutter process PID to `/tmp/flutter.pid` (or `$FLUTTER_PID` if set).
2. The reload script reads that PID and sends `SIGUSR1` to it, which `flutter run` interprets as a hot reload.
3. Flutter logs `Performing hot reload...` followed by `Reloaded N libraries in ...ms` in `flutter.log`.

## When to run

Run the script **once per edit batch**, after all related edits for a task are complete:

- Single focused edit → run immediately after the Edit/Write.
- Multi-file refactor → run once at the end of the batch.
- Purely cosmetic changes (comments, docstrings) → skip; nothing to reload.

## How to run

```bash
.claude/skills/flutter-hot-reload/scripts/hot_reload_from_pid.sh --verbose
```

Expected success output:
```
Read Flutter PID '<pid>' from '/tmp/flutter.pid'
Hot reload signal sent to PID <pid>.
```

Then tail `flutter.log` to confirm:
```bash
tail -5 flutter.log
```

Look for `Reloaded N libraries in Xms` (success) or `Reloaded 0 libraries` (signal received but nothing to reload, usually because edits haven't saved or were already reloaded).

## Failure modes — report, don't hide

- **PID file missing** (`PID file not found at '/tmp/flutter.pid'`): the app isn't running via `task dev`. Tell the user to start it.
- **Stale PID** (`process 'N' is not running`): the previous flutter run was killed. Tell the user to restart it.
- **Signal failure** (`unable to send USR1`): permission issue or wrong user. Uncommon — surface the raw error.
- **`Reloaded 0 libraries`** is not a failure per se but means no code changed since the last reload. If you just edited a file and get this, double-check the edit actually wrote to disk.

Do NOT silently ignore reload failures. If the reload did not run, say so in the user-facing summary of the change.

## When NOT to run

- Changes that are not reloadable:
  - `pubspec.yaml` dependency changes (needs full restart or `flutter pub get` + restart)
  - Native iOS/Android code changes (`ios/`, `android/`)
  - `main*.dart` or top-level `runApp` logic changes (often need hot RESTART, not reload)
  - Widget state that's only set in `initState` — a reload won't re-run it; needs a hot restart
  - Localization ARB changes — `flutter gen-l10n` must run first to regenerate Dart
- When the user explicitly says "don't reload".

## Notes

- For a full restart (resets state), the user can press `R` manually in the terminal running `task dev`; there is no automated equivalent in this skill.
