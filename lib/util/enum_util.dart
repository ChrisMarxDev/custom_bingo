/// Utility functions for working with enums
extension EnumUtil on Enum {
  /// Attempts to parse an enum value by name, returns null if not found
  static T? byNameOrNull<T extends Enum>(String name, List<T> values) {
    try {
      return values.firstWhere(
        (element) => element.name.toLowerCase() == name.toLowerCase(),
        orElse: () => throw Exception('No enum value found for name: $name'),
      );
    } catch (_) {
      return null;
    }
  }

  /// Converts a set of strings to a set of enum values, filtering out any invalid names
  static Set<T> fromStringSet<T extends Enum>(
    Iterable<String> names,
    List<T> values,
  ) {
    return names.map((e) => byNameOrNull(e, values)).nonNulls.toSet();
  }
}

extension EnumUtilFromNameUtil on Iterable<String> {
  Set<T> fromStringSet<T extends Enum>(List<T> values) {
    return map((e) => EnumUtil.byNameOrNull(e, values)).nonNulls.toSet();
  }

  Set<T>? fromStringSetOrNull<T extends Enum>(List<T> values) {
    final set = fromStringSet<T>(values);
    return set.isEmpty ? null : set;
  }
}
