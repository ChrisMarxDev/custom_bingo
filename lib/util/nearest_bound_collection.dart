import 'dart:collection';

class NearestBoundsSet {
  final SplayTreeSet<double?> _numbers = SplayTreeSet<double?>();

  List<double?> get values => _numbers.toList();

  // Add a number to the collection
  void add(double number) {
    _numbers.add(number);
  }

  // Get the nearest bounds of a number
  List<double?> getNearestBounds(double target) {
    final lower = _numbers.lastWhere((n) => n! <= target, orElse: () => null);
    final higher = _numbers.firstWhere((n) => n! >= target, orElse: () => null);
    return [lower, higher];
  }

  double? nearestBound(double target, double maxDistance) {
    final bounds = getNearestBounds(target);
    late final double bound;

    if (bounds[0] == null && bounds[1] == null) {
      return null;
    } else if (bounds[0] == null) {
      bound = bounds[1]!;
    } else if (bounds[1] == null) {
      bound = bounds[0]!;
    } else {
      bound =
          (target - bounds[0]! < bounds[1]! - target) ? bounds[0]! : bounds[1]!;
    }

    if ((bound - target).abs() > maxDistance) {
      return null;
    }
    return bound;
  }

  void replaceBounds(Set<double> bounds) {
    _numbers
      ..clear()
      ..addAll(bounds);
  }

  @override
  String toString() {
    return _numbers.toString();
  }
}

class NearestBoundsMap<T> {
  final SplayTreeMap<int, T> _map = SplayTreeMap<int, T>();

  // Add a value with its associated key
  void add(int key, T value) {
    _map[key] = value;
  }

  // Get the nearest bounds of a key
  MapEntry<int, T>? getLowerBound(int target) {
    final lowerKey = _map.lastKeyBefore(target) ?? _map.lastKey();
    if (lowerKey != null && lowerKey <= target) {
      return MapEntry(lowerKey, _map[lowerKey] as T);
    }
    return null;
  }

  MapEntry<int, T>? getUpperBound(int target) {
    final higherKey = _map.firstKeyAfter(target) ?? _map.firstKey();
    if (higherKey != null && higherKey >= target) {
      return MapEntry(higherKey, _map[higherKey] as T);
    }
    return null;
  }

  // Get the nearest bounds of a key
  List<MapEntry<int, T>?> getNearestBounds(int target) {
    final lowerBound = getLowerBound(target);
    final upperBound = getUpperBound(target);
    return [lowerBound, upperBound];
  }

  void replaceBounds(Map<int, T> bounds) {
    _map
      ..clear()
      ..addAll(bounds);
  }
}
