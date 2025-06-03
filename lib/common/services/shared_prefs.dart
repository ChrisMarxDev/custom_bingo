import 'package:shared_preferences/shared_preferences.dart';
import 'package:state_beacon/state_beacon.dart';

final sharedPrefsBeacon = Beacon.lazyWritable<SharedPreferences>();

extension SharedPrefs on SharedPreferences {
  DateTime? getDateTime(String key) {
    final value = getString(key);
    return value != null ? DateTime.parse(value) : null;
  }

  void setDateTime(String key, DateTime value) {
    setString(key, value.toIso8601String());
  }
}
