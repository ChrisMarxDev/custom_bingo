import 'package:custom_bingo/common/services/shared_prefs.dart';
import 'package:state_beacon/state_beacon.dart';

const enableConfettiKey = 'enable_confetti';

final enableConfettiBeacon = Beacon.writable<bool>(getSavedEnableConfetti());

bool getSavedEnableConfetti() {
  return sharedPrefsBeacon.value.getBool(enableConfettiKey) ?? true;
}

Future<void> setEnableConfetti(bool enabled) async {
  await sharedPrefsBeacon.value.setBool(enableConfettiKey, enabled);
  enableConfettiBeacon.value = enabled;
}
