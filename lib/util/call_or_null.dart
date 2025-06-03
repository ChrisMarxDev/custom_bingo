import 'package:custom_bingo/util/logger.dart';

T? callOrNull<T>(T Function()? call) {
  try {
    return call?.call();
  } catch (e) {
    logE(error: e, message: 'Error calling function $call ${e.runtimeType}');
    return null;
  }
}
