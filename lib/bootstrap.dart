// ignore_for_file: require_trailing_commas

import 'dart:async';

import 'package:custom_bingo/common/services/app_database.dart';
import 'package:custom_bingo/common/services/app_database_connection.dart';
import 'package:custom_bingo/common/services/revenue_cat_service.dart';
import 'package:custom_bingo/common/services/shared_prefs.dart';
import 'package:custom_bingo/common/services/userorient_service.dart';
import 'package:custom_bingo/util/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simdeck_flutter_inspector/simdeck_flutter_inspector.dart';
import 'package:state_beacon/state_beacon.dart';
import 'package:userorient_flutter/userorient_flutter.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      if (kDebugMode) {
        startSimDeckFlutterInspector(port: 4310);
      }

      configureLogging();

      FlutterError.onError = (details) {
        FlutterError.presentError(details);
        logError('Flutter framework error', details.exception, details.stack);
      };

      PlatformDispatcher.instance.onError = (error, stackTrace) {
        logError('Unhandled platform error', error, stackTrace);
        return true;
      };

      UserOrient.configure(apiKey: userOrientApiKey, languageCode: 'en');

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      final sharedPreferences = await SharedPreferences.getInstance();
      sharedPrefsBeacon.value = sharedPreferences;

      final appDatabase = AppDatabase(openAppDatabaseConnection());
      appDatabaseBeacon.value = appDatabase;

      unawaited(configureRevenueCat());

      runApp(LiteRefScope(child: await builder()));
    },
    (error, stackTrace) {
      logError('Uncaught async error', error, stackTrace);
    },
  );
}
