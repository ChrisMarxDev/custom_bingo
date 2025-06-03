
import 'package:logger/logger.dart';

Logger logger = Logger(filter: CustomLogFilter());

class CustomLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    var shouldLog = false;
    if (event.level.value >= level!.value) {
      shouldLog = true;
    }
    return shouldLog;
  }
}

void logI(String message) {
  logger.i(message);
}

void logError(String message, [dynamic error, StackTrace? stackTrace]) {
  logger.e(message, error: error, stackTrace: stackTrace);
}

void logE({
  required dynamic error,
  StackTrace? stackTrace,
  String? message,
  bool logToSentry = true,
}) {
  logger.e(message ?? error.toString(), error: error, stackTrace: stackTrace);
  if (logToSentry) {
    // unawaited(Sentry.captureException(error, stackTrace: stackTrace));
  }
}
