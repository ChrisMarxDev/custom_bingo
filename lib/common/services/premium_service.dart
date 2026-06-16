import 'package:custom_bingo/common/services/revenue_cat_service.dart';
import 'package:state_beacon/state_beacon.dart';

final isPremiumUserBeacon = Beacon.derived<bool>(() {
  return revenueCatStateBeacon.value.hasProAccess;
});
