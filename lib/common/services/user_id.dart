import 'package:custom_bingo/common/services/shared_prefs.dart';
import 'package:state_beacon/state_beacon.dart';
import 'package:uuid/uuid.dart';

const sharedPrefsUserIdKey = 'user_id';

final userIdBeacon = Beacon.writable<String>(
  sharedPrefsBeacon.value.getStringOrWriteDefault(
    sharedPrefsUserIdKey,
    () => Uuid().v7(),
  ),
);
