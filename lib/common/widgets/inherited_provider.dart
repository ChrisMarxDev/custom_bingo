import 'package:flutter/material.dart';

/// A minimal generic provider based on InheritedWidget.
///
/// Usage:
///   InheritedProvider<Foo>(value: foo, child: ...)
///   final foo = InheritedProvider.of<Foo>(context); // listen
///   final foo = InheritedProvider.of<Foo>(context, listen: false); // read
class InheritedProvider<T> extends InheritedWidget {
  const InheritedProvider({
    super.key,
    required this.value,
    this.shouldNotify,
    required super.child,
  });

  final T value;
  final bool Function(T previous, T current)? shouldNotify;

  static T of<T>(BuildContext context, {bool listen = true}) {
    final result = maybeOf<T>(context, listen: listen);
    if (result == null) {
      throw FlutterError(
        'InheritedProvider<$T> not found above the given context.\n'
        'Ensure that an InheritedProvider<$T> is placed above in the widget tree.',
      );
    }
    return result;
  }

  static T? maybeOf<T>(BuildContext context, {bool listen = true}) {
    if (listen) {
      final widget =
          context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();
      return widget?.value;
    }
    final element =
        context.getElementForInheritedWidgetOfExactType<InheritedProvider<T>>();
    final widget = element?.widget as InheritedProvider<T>?;
    return widget?.value;
  }

  @override
  bool updateShouldNotify(covariant InheritedProvider<T> oldWidget) {
    if (identical(oldWidget.value, value)) return false;
    if (shouldNotify != null) return shouldNotify!(oldWidget.value, value);
    return oldWidget.value != value;
  }
}

extension InheritedProviderBuildContextX on BuildContext {
  T watchProvided<T>() => InheritedProvider.of<T>(this, listen: true);
  T readProvided<T>() => InheritedProvider.of<T>(this, listen: false);
  T? maybeWatchProvided<T>() => InheritedProvider.maybeOf<T>(this, listen: true);
  T? maybeReadProvided<T>() => InheritedProvider.maybeOf<T>(this, listen: false);
}