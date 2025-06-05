// ignore_for_file: require_trailing_commas

import 'dart:async';
import 'dart:developer';

import 'package:custom_bingo/common/services/shared_prefs.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:state_beacon/state_beacon.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  BeaconObserver.instance = LoggingObserver();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  // need to run the app for tests
  // MapperContainer.globals.use(const ColorMapper());

  final sharedPreferences = await SharedPreferences.getInstance();
  sharedPrefsBeacon.value = sharedPreferences;

  // Try to restore any missing recipe images
  // await restoreMissingImages();

  Future<void> run() async {
    return runApp(LiteRefScope(child: await builder()));
  }

  await run();
}
