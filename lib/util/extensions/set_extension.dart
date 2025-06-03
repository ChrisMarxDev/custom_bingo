import 'dart:math';

extension SetExtension<T> on Set<T> {
  T random() {
    if (isEmpty) {
      throw Exception('List is empty');
    }
    final index = Random().nextInt(length);
    return elementAt(index);
  }

  Set<T> toggle(T value) {
    if (contains(value)) {
      return Set.from(this)..remove(value);
    } else {
      return Set.from(this)..add(value);
    }
  }

  void addIfNotNull(T? value) {
    if (value != null) {
      add(value);
    }
  }

  Set<T> copyWithValues(Set<T> other) {
    return Set.from(this)..addAll(other);
  }

  bool containsAny(List<T> other) {
    return other.any(contains);
  }
}
