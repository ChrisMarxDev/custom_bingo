---
name: app-locales
description: Add or update locales for this Flutter app, including ARB files, generated AppLocalizations, localized screenshot copy, and English/German screenshot verification.
---

# App Locales

Use this skill when adding a new app language, updating app copy across locales,
or changing localized screenshot text in this repository.

## Workflow

1. Inspect `l10n.yaml`, `lib/l10n/arb/app_en.arb`, and the target
   `lib/l10n/arb/app_<locale>.arb`.
2. Add every new user-facing string to `app_en.arb` first with an `@key`
   description and placeholder metadata when needed.
3. Add the same keys to each existing locale ARB. Keep placeholder names and
   types identical to English.
4. For a new locale:
   - Create `lib/l10n/arb/app_<locale>.arb` with `@@locale`.
   - Translate every English key.
   - Do not leave keys missing unless the user explicitly asks for a partial
     locale.
5. Run `flutter gen-l10n`.
6. Update code to use `context.l10n` or generated `AppLocalizations` getters.
   Do not hard-code user-facing strings in widgets or screenshot tests.
7. If screenshot text changes, update
   `test/screenshots/screenshots_flow_test.dart` to read from
   `AppLocalizations`; only layout, deterministic sample state, and file-writing
   logic should stay in the test.

## Verification

Run these after locale work:

```sh
flutter gen-l10n
dart analyze test/screenshots/screenshots_flow_test.dart
SCREENSHOT_LOCALES=en,de task screenshots
```

If adding another screenshot locale, include it in `SCREENSHOT_LOCALES`, for
example:

```sh
SCREENSHOT_LOCALES=en,de,fr task screenshots
```

Check generated PNGs under `build/screenshots/<locale>/`.

## Notes

- `task screenshots` writes app-store-style PNGs through a widget-test harness,
  not a full app run.
- Widget tests need explicit font loading for readable text and icon glyphs;
  preserve the font-loader setup in the screenshot test.
- Keep generated localization Dart files from `lib/l10n/arb/` in sync with ARB
  changes.
