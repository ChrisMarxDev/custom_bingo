import 'dart:ui';

import 'package:custom_bingo/common/services/shared_prefs.dart';
import 'package:custom_bingo/l10n/arb/app_localizations.dart';
import 'package:state_beacon/state_beacon.dart';

const _appLocaleKey = 'app_locale';

/// Null means "follow the device". Non-null values force the app locale.
final appLocaleOverrideBeacon = Beacon.writable<Locale?>(getSavedAppLocale());

/// Tracks the platform locale so widgets can describe the current system choice
/// and rebuild when the phone language changes while the app is alive.
final phoneLocaleBeacon = Beacon.writable<Locale>(
  PlatformDispatcher.instance.locale,
);

Locale? getSavedAppLocale() {
  final rawCode = sharedPrefsBeacon.value.getString(_appLocaleKey);
  if (rawCode == null || rawCode.isEmpty) return null;
  return supportedAppLanguageByCode(rawCode)?.locale;
}

Future<void> setAppLocaleOverride(Locale? locale) async {
  if (locale == null) {
    await sharedPrefsBeacon.value.remove(_appLocaleKey);
  } else {
    await sharedPrefsBeacon.value.setString(_appLocaleKey, locale.languageCode);
  }
  appLocaleOverrideBeacon.value = locale;
}

void setPhoneLocale(Locale locale) {
  phoneLocaleBeacon.value = _supportedLocaleFor(locale) ?? locale;
}

Locale? _supportedLocaleFor(Locale locale) {
  for (final supportedLocale in AppLocalizations.supportedLocales) {
    if (supportedLocale.languageCode == locale.languageCode) {
      return supportedLocale;
    }
  }
  return null;
}

AppLanguage? supportedAppLanguageByCode(String languageCode) {
  for (final language in supportedAppLanguages) {
    if (language.locale.languageCode == languageCode) return language;
  }
  return null;
}

AppLanguage? appLanguageFor(Locale locale) {
  return supportedAppLanguageByCode(locale.languageCode);
}

const supportedAppLanguages = <AppLanguage>[
  AppLanguage(Locale('en'), 'English'),
  AppLanguage(Locale('de'), 'Deutsch'),
  AppLanguage(Locale('fr'), 'Français'),
  AppLanguage(Locale('es'), 'Español'),
  AppLanguage(Locale('pt'), 'Português'),
  AppLanguage(Locale('zh'), '中文'),
  AppLanguage(Locale('ja'), '日本語'),
  AppLanguage(Locale('ar'), 'العربية'),
];

class AppLanguage {
  const AppLanguage(this.locale, this.nativeName);

  final Locale locale;
  final String nativeName;
}
