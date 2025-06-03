import 'package:flutter/cupertino.dart';

extension WidgetsExtension on Widget {
  Widget operator *(int times) =>
      Column(children: List.generate(times >= 1 ? times : 1, (index) => this));
}

extension ShadowExtension on BoxShadow {
  // ignore: avoid_positional_boolean_parameters
  BoxShadow pressed(bool pressed, double height) {
    if (!pressed) return this;

    return copyWith(offset: Offset(offset.dx - height, offset.dy - height));
  }

  BoxShadow copyWith({
    Color? color,
    Offset? offset,
    double? blurRadius,
    double? spreadRadius,
  }) {
    return BoxShadow(
      color: color ?? this.color,
      offset: offset ?? this.offset,
      blurRadius: blurRadius ?? this.blurRadius,
      spreadRadius: spreadRadius ?? this.spreadRadius,
    );
  }
}

extension WidgetListExtension on List<Widget> {
  List<Widget> padding(EdgeInsetsGeometry padding) {
    return map((e) => Padding(padding: padding, child: e)).toList();
  }
}
