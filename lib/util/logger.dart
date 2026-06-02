import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

final Logger _logger = Logger('custom_bingo');
bool _loggingConfigured = false;

void configureLogging() {
  if (_loggingConfigured) return;
  _loggingConfigured = true;

  hierarchicalLoggingEnabled = true;
  Logger.root.level = kDebugMode ? Level.ALL : Level.INFO;
  Logger.root.onRecord.listen((record) {
    final buffer = StringBuffer()
      ..write(record.level.name.padRight(7))
      ..write(' ')
      ..write(record.time.toIso8601String());

    if (record.loggerName.isNotEmpty) {
      buffer
        ..write(' [')
        ..write(record.loggerName)
        ..write(']');
    }

    buffer
      ..write(' ')
      ..write(record.message);

    if (record.error != null) {
      buffer
        ..write('\nerror: ')
        ..write(record.error);
    }

    if (record.stackTrace != null) {
      buffer
        ..write('\n')
        ..write(record.stackTrace);
    }

    developer.log(
      record.message,
      time: record.time,
      level: record.level.value,
      name: record.loggerName,
      error: record.error,
      stackTrace: record.stackTrace,
    );
    debugPrintSynchronously(buffer.toString());
  });

  logI(
    'Logging configured: level=${Logger.root.level.name} debugMode=$kDebugMode '
    'sinks=dart_developer,debug_print_synchronous',
  );
}

void logD(String message) {
  _logger.fine(message);
}

void logI(String message) {
  _logger.info(message);
}

void logW(String message) {
  _logger.warning(message);
}

void logError(String message, [Object? error, StackTrace? stackTrace]) {
  _logger.severe(message, error, stackTrace);
}

void logE({
  required dynamic error,
  StackTrace? stackTrace,
  String? message,
  bool logToSentry = true,
}) {
  _logger.severe(message ?? error.toString(), error, stackTrace);
  if (logToSentry) {
    // unawaited(Sentry.captureException(error, stackTrace: stackTrace));
  }
}
