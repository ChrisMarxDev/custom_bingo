import 'dart:convert';

import 'package:collection/collection.dart';

extension StringExtension on String {
  String removeQuotes() {
    return replaceAll('"', '').replaceAll("'", '');
  }

  Map<String, dynamic>? tryDecodeJson() {
    final trimmed = trim();
    if (trimmed.startsWith('{') && trimmed.endsWith('}')) {
      try {
        final json = jsonDecode(trimmed);
        if (json is Map<String, dynamic>) {
          return json;
        }
        return null;
      } catch (e) {
        return null;
      }
    } else {
      // try to trim content to json
      try {
        final start = trimmed.indexOf('{');
        final end = trimmed.lastIndexOf('}');
        if (start != -1 && end != -1) {
          final json = jsonDecode(trimmed.substring(start, end + 1));
          if (json is Map<String, dynamic>) {
            return json;
          }
        }
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  T? tryParseEnum<T extends Enum>(List<T> values) {
    return values.firstWhereOrNull((e) => e.name == this);
  }

  String capitalize() {
    return this[0].toUpperCase() + substring(1);
  }
}

extension StringNullableExtension on String? {
  bool get isEmptyOrNull => this == null || this!.isEmpty;
  bool get isNotEmptyOrNull => this != null && this!.trim().isNotEmpty;
}
