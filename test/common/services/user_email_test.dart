import 'package:custom_bingo/common/services/shared_prefs.dart';
import 'package:custom_bingo/common/services/user_email.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    sharedPrefsBeacon.value = await SharedPreferences.getInstance();
  });

  test('asks before the first email prompt', () {
    expect(hasAskedForUserEmail(), isFalse);
    expect(getStoredUserEmail(), isNull);
    expect(shouldAskForUserEmail(), isTrue);
  });

  test('empty prompt result marks that the user has been asked', () async {
    await saveUserEmailPromptResult(email: null, dontAskAgain: false);

    expect(hasAskedForUserEmail(), isTrue);
    expect(getStoredUserEmail(), isNull);
    expect(shouldAskForUserEmail(), isTrue);
    expect(sharedPrefsBeacon.value.getString(sharedPrefsUserEmailKey), '');
  });

  test('stored email stops future prompts', () async {
    await saveUserEmailPromptResult(
      email: ' user@example.com ',
      dontAskAgain: false,
    );

    expect(getStoredUserEmail(), 'user@example.com');
    expect(shouldAskForUserEmail(), isFalse);
  });

  test('dont ask again flag stops future prompts', () async {
    await saveUserEmailPromptResult(email: null, dontAskAgain: true);

    expect(
      sharedPrefsBeacon.value.getBool(sharedPrefsDontAskUserEmailAgainKey),
      isTrue,
    );
    expect(shouldAskForUserEmail(), isFalse);
  });
}
