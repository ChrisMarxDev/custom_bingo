import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

// util class for mutliple values
@immutable
class MultiValue<T> {
  MultiValue(List<T> values) : _values = values.toSet();

  static MultiValue<T> builder<T, S>(
    List<S> values,
    T Function(S value) builder,
  ) {
    return MultiValue<T>(values.map(builder).toList());
  }

  final Set<T> _values;

  bool get mixed => _values.length > 1;

  bool get isEmpty => _values.isEmpty;

  @override
  String toString() {
    return _values.toString();
  }

  List<T> get allValues => _values.toList();

  T? get singleOrNull => _values.length == 1 ? _values.first : null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MultiValue<T> &&
        SetEquality<T>().equals(_values, other._values);
  }

  @override
  int get hashCode => _values.hashCode;
}

class MultiListValue<T> extends MultiValue<Iterable<T>> {
  MultiListValue(super.values);

  static MultiListValue<T> builder<T, S>(
    List<S> values,
    Iterable<T> Function(S value) builder,
  ) {
    return MultiListValue<T>(values.map((e) => builder(e)).toList());
  }

  Set<T> allValuesExpanded() {
    return _values.expand((element) => element).toSet();
  }
}
