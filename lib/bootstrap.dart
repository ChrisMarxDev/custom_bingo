// ignore_for_file: require_trailing_commas

import 'dart:async';
import 'dart:ui';

import 'package:custom_bingo/common/services/shared_prefs.dart';
import 'package:custom_bingo/util/logger.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:state_beacon/state_beacon.dart';
import 'package:userorient_flutter/userorient_flutter.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      configureLogging();

      FlutterError.onError = (details) {
        FlutterError.presentError(details);
        logError('Flutter framework error', details.exception, details.stack);
      };

      PlatformDispatcher.instance.onError = (error, stackTrace) {
        logError('Unhandled platform error', error, stackTrace);
        return true;
      };

      UserOrient.configure(
        apiKey: 'bdd8a7b8-04dc-4780-862f-d052f74e86e1',
        languageCode: 'en',
      );

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      final sharedPreferences = await SharedPreferences.getInstance();
      sharedPrefsBeacon.value = sharedPreferences;

      runApp(LiteRefScope(child: await builder()));
    },
    (error, stackTrace) {
      logError('Uncaught async error', error, stackTrace);
    },
  );
}
