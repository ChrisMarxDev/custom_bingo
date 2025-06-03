import 'dart:async';

import 'package:state_beacon/state_beacon.dart';

final clockBeacon = Beacon.stream(
  () => Stream.periodic(const Duration(minutes: 5), (_) => DateTime.now()),
);

DateTime today() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}

final dateClockBeacon = Stream.periodic(
  const Duration(minutes: 5),
  (_) => today(),
).toRawBeacon(isLazy: true, initialValue: today());
