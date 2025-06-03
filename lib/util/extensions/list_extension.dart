import 'dart:collection';
import 'dart:math';

extension ListExtension<T> on List<T> {
  T random() {
    if (isEmpty) {
      throw Exception('List is empty');
    }
    return this[Random().nextInt(length)];
  }

  List<T> separatedBy(T separator) {
    final result = <T>[];
    for (var i = 0; i < length; i++) {
      result.add(this[i]);
      if (i != length - 1) {
        result.add(separator);
      }
    }
    return result;
  }

  List<List<T>> chunkedBy(int chunkSize, {bool includeDangling = false}) {
    final result = <List<T>>[];
    for (var i = 0; i < length; i += chunkSize) {
      if (length < i + chunkSize) {
        if (includeDangling) {
          result.add(sublist(i));
        }
      } else {
        result.add(sublist(i, i + chunkSize));
      }
    }
    return result;
  }

  T? getIndexOrNull(int index) {
    if (index < 0 || index >= length) {
      return null;
    }
    return this[index];
  }

  T? secondToLast() {
    if (length < 2) {
      return null;
    }
    return this[length - 2];
  }
}

extension MapEntryListExtension<K, V> on Iterable<MapEntry<K, V>> {
  Map<K, V> toMap() {
    return Map.fromEntries(this);
  }
}

extension IterableExtension<Item> on Iterable<Item> {
  Map<Key, Item> toMapAsValues<Key>(Key Function(Item) key) {
    return HashMap.fromEntries(map((e) => MapEntry(key(e), e)));
  }

  Map<Item, Value> toMapAsKeys<Value>(Value Function(Item) value) {
    return HashMap.fromEntries(map((e) => MapEntry(e, value(e))));
  }

  Iterable<Item> operator +(Iterable<Item> other) {
    return followedBy(other);
  }
}
