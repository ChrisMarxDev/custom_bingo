extension ObjectExtension on Object {
  T? asOrNull<T>() {
    if (this is T) {
      return this as T;
    }
    return null;
  }
}
