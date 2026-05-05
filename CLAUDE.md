# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Custom Bingo — a Flutter app (iOS / Android / Web / Windows / macOS) for creating, editing, and sharing custom bingo cards. Generated from the Very Good CLI template.

## Toolchain

- Flutter pinned to **3.41.9** via FVM (`.fvmrc`, `.fvm/flutter_sdk`). Prefer `fvm flutter ...` if FVM is installed; plain `flutter` works if it matches.
- Dart SDK constraint: `^3.5.0` (actual SDK ships Dart 3.11.5).
- Lint config: stock Flutter analyzer (no `very_good_analysis` — the original include was broken and never enforced; if you want strict lints, add the package to `dev_dependencies` and bump the include to a real `analysis_options.X.Y.Z.yaml`).

## Common commands

Three flavors exist: `development`, `staging`, `production`, each with a separate `lib/main_*.dart` entrypoint. Always pass both `--flavor` and `--target` together.

```sh
# Run (most common: development)
flutter run --flavor development --target lib/main_development.dart

# Tests (all unit + widget tests, with coverage)
flutter test --coverage --test-randomize-ordering-seed random

# Single test file
flutter test test/app/view/app_test.dart

# Regenerate localization (ARB → Dart). Also runs automatically on `flutter run`.
flutter gen-l10n --arb-dir="lib/l10n/arb"

# Regenerate dart_mappable code (e.g. after editing bingo_item.dart)
dart run build_runner build --delete-conflicting-outputs

# Release builds (also in Taskfile.yml)
task build_android   # flutter build aab --release --flavor production -t lib/main_production.dart
task build_ios       # flutter build ios --release --flavor production --config-only
task launch_icons    # regenerate launcher icons
task native_splash   # regenerate native splash screen
```

## Architecture

### Entry / bootstrap
`lib/main_<flavor>.dart` calls `bootstrap(() => const App())` from `lib/bootstrap.dart`. `bootstrap` initializes Flutter binding, configures UserOrient, locks orientation to portrait, installs `LoggingObserver` for state_beacon, loads `SharedPreferences` into the global `sharedPrefsBeacon`, and runs the app inside a `LiteRefScope` (required for `Ref.scoped` DI to work).

The `App` widget (`lib/app/view/app.dart`) is a single `MaterialApp`. Routing is **not** go_router despite the dependency — it conditionally shows `NewCardScreen` or `BingoCardScreen` based on whether `currentSelectedBingoCardName.value` is set. Navigation between screens happens via direct `Navigator` pushes.

### State management — state_beacon

The app uses [`state_beacon`](https://pub.dev/packages/state_beacon) as its sole reactive primitive. Patterns to know:

- **Top-level beacons** for app-wide state, e.g. `sharedPrefsBeacon`, `currentSelectedBingoCardName`, `bingoGridNamesBeacon` in `lib/features/bingo_card/bingo_card_logic.dart`.
- **Scoped controllers** via `Ref.scoped` + `LiteRefScope` (from the `lite_ref` family bundled with state_beacon). Example: `bingoCardControllerRef = Ref.scoped((ctx) => BingoCardController())` — accessed in widgets as `bingoCardControllerRef.of(context)`.
- **`BeaconController`** subclasses (e.g. `BingoCardController`) own `Beacon.writable` / `Beacon.derived` fields; the controller's `dispose` is wired up automatically by the scope.
- Persisted state is hydrated from `SharedPreferences` in the controller's constructor (`loadBoard()`) and saved on every mutation via `_saveBingoCard()`.

Do not introduce a different state-management library — match the existing pattern.

### Persistence & serialization

- All persistence is `SharedPreferences` keyed by string. Bingo cards are stored as JSON under `bingo_card_<name>`; the list of names lives at `bingo_card_names`; the active card name at `current_selected_bingo_card`.
- JSON serialization uses **`dart_mappable`** (not `json_serializable`). Models annotate with `@MappableClass`, declare `with XMappable`, and add `part 'x.mapper.dart'`. Regenerate with `dart run build_runner build --delete-conflicting-outputs` after editing model classes.

### Code layout

```
lib/
  app/                  MaterialApp, theme, top-level shell
  bootstrap.dart        Flutter init, SharedPreferences, LiteRefScope wrapping
  main_{development,staging,production}.dart   flavor entrypoints
  features/
    bingo_card/         Core feature: model (bingo_item.dart), controller +
                        persistence (bingo_card_logic.dart), screens, widgets/
    settings/
  common/
    services/           Cross-feature singletons (sharedPrefsBeacon, share logic, user_id)
    widgets/            Shared UI primitives
  util/                 Pure helpers: extensions/, converter/, logger, theme_util,
                        shape_calculations, snapping_scroll_physics, etc.
  l10n/arb/             ARB source files; generated Dart in lib/l10n/arb/app_localizations.dart
```

`flutter: generate: true` in `pubspec.yaml` plus `l10n.yaml` drive l10n codegen. Access strings via `context.l10n` (extension defined in `lib/l10n/`). The template ARB is `app_en.arb`.

### Bingo logic notes

- Grids are `List<List<BingoItem>>` — possibly ragged, possibly even or odd-sized. `BingoCardController.checkForBingo` handles rows, columns, and (only for square grids) both diagonals. For odd-sized square grids, an empty-text center cell is treated as a free "joker" that is always done.
- `shuffleCard` preserves the joker center cell when the grid is odd-sized and the center is empty.

## Conventions

- Match the existing reactive style: prefer beacons + `BeaconController` over `setState`/`ChangeNotifier`/Provider/BLoC.
- Keep persistence calls confined to the controller / `*_logic.dart` layer; widgets read beacons.
- After editing any `@MappableClass` model, regenerate `*.mapper.dart` before committing.
- Localization: add new strings to `lib/l10n/arb/app_en.arb` (and any other locales) rather than hardcoding.
