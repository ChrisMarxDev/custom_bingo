import 'package:custom_bingo/common/services/shared_prefs.dart';
import 'package:custom_bingo/features/settings/app_locale_settings.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('app locale settings', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      sharedPrefsBeacon.value = await SharedPreferences.getInstance();
      appLocaleOverrideBeacon.value = getSavedAppLocale();
    });

    test('defaults to following the phone language', () {
      expect(getSavedAppLocale(), isNull);
      expect(appLocaleOverrideBeacon.value, isNull);
    });

    test('persists a manual app language override', () async {
      await setAppLocaleOverride(const Locale('fr'));

      expect(appLocaleOverrideBeacon.value, const Locale('fr'));
      expect(getSavedAppLocale(), const Locale('fr'));
    });

    test('clears override to return to phone language tracking', () async {
      await setAppLocaleOverride(const Locale('ja'));
      await setAppLocaleOverride(null);

      expect(appLocaleOverrideBeacon.value, isNull);
      expect(getSavedAppLocale(), isNull);
    });

    test('ignores unsupported saved language codes', () async {
      await sharedPrefsBeacon.value.setString('app_locale', 'it');

      expect(getSavedAppLocale(), isNull);
    });
  });
}
