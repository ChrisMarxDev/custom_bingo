import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/common/services/premium_service.dart';
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
  final savedPalette = appThemePalettes.firstWhere(
    (palette) => palette.id == rawPaletteId,
    orElse: () => defaultThemePalette,
  );
  return isAppThemePaletteAvailable(savedPalette)
      ? savedPalette
      : defaultThemePalette;
}

Future<void> setAppThemeMode(ThemeMode mode) async {
  await sharedPrefsBeacon.value.setString(_themeModeKey, mode.name);
  appThemeModeBeacon.value = mode;
}

Future<void> setAppThemePalette(AppThemePalette palette) async {
  if (!isAppThemePaletteAvailable(palette)) return;

  await sharedPrefsBeacon.value.setString(_themePaletteKey, palette.id);
  appThemePaletteBeacon.value = palette;
}

bool isAppThemePaletteAvailable(
  AppThemePalette palette, {
  bool? isPremiumUser,
}) {
  return !palette.isPremium || (isPremiumUser ?? isPremiumUserBeacon.value);
}

AppThemePalette availableAppThemePalette(
  AppThemePalette palette, {
  bool? isPremiumUser,
}) {
  return isAppThemePaletteAvailable(palette, isPremiumUser: isPremiumUser)
      ? palette
      : defaultThemePalette;
}
