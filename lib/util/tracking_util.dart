import 'package:custom_bingo/util/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:state_beacon/state_beacon.dart';


extension BuildContextTrackingUtil on BuildContext {
  void trackEvent(String event, [Map<String, Object>? properties]) {
    logI('tracking event: $event');
    if (kDebugMode) {
      return;
    }
  }
}

extension BeaconTrackingUtil on BeaconController {
  void trackEvent(String event, [Map<String, Object>? properties]) {
    logI('tracking event: $event');
    if (kDebugMode) {
      return;
    }
  }
}

void trackEvent(String event, [Map<String, Object>? properties]) {
  logI('tracking event: $event');
  if (kDebugMode) {
    return;
  }
}

void trackEnumDifference<T extends Enum>(
  Set<T> oldSet,
  Set<T> newSet,
  String eventName,
) {
  // Track added food types
  for (final type in newSet) {
    if (!oldSet.contains(type)) {
      trackEvent(eventName, {'value': type.name, 'action': 'add'});
    }
  }

  // Track removed food types
  for (final type in oldSet) {
    if (!newSet.contains(type)) {
      trackEvent(eventName, {'value': type.name, 'action': 'remove'});
    }
  }
}
