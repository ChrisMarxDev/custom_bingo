extension MapExtension<K, V> on Map<K, V> {
  Map<K, V> copyWithValues(Map<K, V> other) {
    return Map.fromEntries(entries.map((e) => MapEntry(e.key, e.value)));
  }

  Iterable<V> getAll(Iterable<K> keys) sync* {
    for (final key in keys) {
      if (!containsKey(key)) continue;
      yield this[key]!;
    }
  }
}
