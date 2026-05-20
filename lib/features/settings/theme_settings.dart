import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/common/services/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:state_beacon/state_beacon.dart';

const _themeModeKey = 'theme_mode';
const _themePaletteKey = 'theme_palette';

final appThemeModeBeacon = Beacon.writable<ThemeMode>(getSavedThemeMode());
final appThemePaletteBeacon = Beacon.writable<AppThemePalette>(
  getSavedThemePalette(),
);

ThemeMode getSavedThemeMode() {
  final rawMode = sharedPrefsBeacon.value.getString(_themeModeKey);
  return switch (rawMode) {
    'dark' => ThemeMode.dark,
    _ => ThemeMode.light,
  };
}

AppThemePalette getSavedThemePalette() {
  final rawPaletteId = sharedPrefsBeacon.value.getString(_themePaletteKey);
  return appThemePalettes.firstWhere(
    (palette) => palette.id == rawPaletteId,
    orElse: () => defaultThemePalette,
  );
}

Future<void> setAppThemeMode(ThemeMode mode) async {
  await sharedPrefsBeacon.value.setString(_themeModeKey, mode.name);
  appThemeModeBeacon.value = mode;
}

Future<void> setAppThemePalette(AppThemePalette palette) async {
  await sharedPrefsBeacon.value.setString(_themePaletteKey, palette.id);
  appThemePaletteBeacon.value = palette;
}
