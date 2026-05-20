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

    debugPrint(buffer.toString());
  });
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
