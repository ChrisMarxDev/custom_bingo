// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

class CustomError {
  CustomError({required this.message, required this.timestamp, this.code});
  final String message;
  final String? code;
  final DateTime timestamp;

  @override
  String toString() {
    return 'Error(message: $message, code: $code, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return other is CustomError &&
        other.message == message &&
        other.code == code &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode => message.hashCode ^ code.hashCode ^ timestamp.hashCode;
}
