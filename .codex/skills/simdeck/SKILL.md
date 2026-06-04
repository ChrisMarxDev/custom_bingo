---
name: simdeck
description: Use when controlling, inspecting, or automating iOS Simulators or Android emulators with SimDeck, including Flutter widget-tree inspection through simdeck_flutter_inspector, CLI-driven screenshots/logs, and repo Taskfile wrappers that open or query SimDeck.
---

# SimDeck

Use SimDeck as the primary simulator/emulator control surface when a task needs live app inspection, UI automation, screenshots, logs, or a browser view of a mobile device.

## Command Selection

Prefer repo-provided Taskfile wrappers when present. In this repo, use:

```bash
task simdeck
task simdeck:list
task simdeck:status
task simdeck:describe:flutter
```

Outside this repo, use a globally installed `simdeck` binary when available. If it is not installed, use `npx --yes simdeck@latest` as the command prefix.

## Core Workflow

1. Start or open the service:

```bash
task simdeck
npx --yes simdeck@latest --open -p 4310
simdeck --open -p 4310
```

Use port `4310` when the Flutter app is configured with `startSimDeckFlutterInspector(port: 4310)`.

2. Check available devices and choose a default when needed:

```bash
task simdeck:list
npx --yes simdeck@latest list
simdeck use <udid>
```

The saved default is scoped to the current project directory. Use `SIMDECK_UDID` or `SIMDECK_DEVICE` for one-off targeting.

3. Run the Flutter app in a debug build when framework-level inspection is needed:

```bash
task dev
```

The Flutter inspector only starts in debug mode. Release/profile builds should fall back to native accessibility.

4. Inspect the UI before interacting:

```bash
task simdeck:describe:flutter
npx --yes simdeck@latest describe --source flutter --format agent --max-depth 3 --interactive
simdeck describe --source auto --format agent --max-depth 3 --interactive
simdeck describe --source native-ax --format agent --max-depth 3 --interactive
```

Prefer `--source flutter` for widget, render, semantics, and source-location detail in this Flutter repo. Use `--source auto` when any in-app inspector is acceptable, and `--source native-ax` when testing accessibility or when the app is not instrumented.

5. Act on stable refs from agent output:

```bash
simdeck press @e3
simdeck tap --label "Continue" --wait-timeout-ms 5000
simdeck type "hello"
simdeck back
simdeck screenshot --output /tmp/simdeck-screen.png
simdeck logs --seconds 30 --limit 200
```

Use selector-based commands over coordinates when possible. Re-run `describe` after navigation or state changes.

## Flutter Inspector Setup

For Flutter apps, add `simdeck_flutter_inspector` and start it after `WidgetsFlutterBinding.ensureInitialized()`:

```dart
if (kDebugMode) {
  startSimDeckFlutterInspector(port: 4310);
}
```

The port is the SimDeck service port. Keep app instrumentation debug-only so release builds do not expose an inspector.

## Troubleshooting

- `task simdeck:status`: confirm the service is running.
- If Flutter inspection falls back, foreground the app, confirm it is a debug build, and verify the inspector port matches the service port.
- Use `simdeck describe --source flutter --format agent` to see the fallback reason.
- If CoreSimulator hangs or devices do not attach, run `simdeck core-simulator restart`, then retry `simdeck list`.
- When the port is occupied, SimDeck may use the next available port; update the Flutter inspector port or restart SimDeck on `4310`.

## Safety

Avoid destructive device actions such as `erase`, `uninstall`, `shutdown`, `service killall`, or `service reset` unless the user explicitly asks. Capture screenshots and logs to `/tmp` unless the user requests an artifact in the repo.

## References

- https://simdeck.sh/guide/
- https://simdeck.sh/cli/
- https://simdeck.sh/inspector/
- https://simdeck.sh/inspector/flutter
