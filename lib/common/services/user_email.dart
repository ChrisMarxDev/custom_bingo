import 'package:custom_bingo/common/services/shared_prefs.dart';

const sharedPrefsUserEmailKey = 'user_email';
const sharedPrefsDontAskUserEmailAgainKey = 'dont_ask_user_email_again';

String? getStoredUserEmail() {
  final email = sharedPrefsBeacon.value.getString(sharedPrefsUserEmailKey);
  final trimmedEmail = email?.trim();
  if (trimmedEmail == null || trimmedEmail.isEmpty) return null;
  return trimmedEmail;
}

bool hasAskedForUserEmail() {
  return sharedPrefsBeacon.value.containsKey(sharedPrefsUserEmailKey);
}

bool shouldAskForUserEmail() {
  final dontAskAgain =
      sharedPrefsBeacon.value.getBool(sharedPrefsDontAskUserEmailAgainKey) ??
      false;
  return !dontAskAgain && getStoredUserEmail() == null;
}

Future<void> saveUserEmailPromptResult({
  required String? email,
  required bool dontAskAgain,
}) async {
  final prefs = sharedPrefsBeacon.value;
  await prefs.setString(sharedPrefsUserEmailKey, email?.trim() ?? '');
  if (dontAskAgain) {
    await prefs.setBool(sharedPrefsDontAskUserEmailAgainKey, true);
  }
}
