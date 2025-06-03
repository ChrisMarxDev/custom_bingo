import 'package:flutter/material.dart';

extension ColorExtension on Color {
  Color get invertColor {
    return (computeLuminance() > 0.5) ? Colors.black : Colors.white;
  }

  Color blend(Color other, [double amount = 0.5]) {
    return Color.lerp(this, other, amount)!;
  }

  Color to(Color color, double amount) {
    return Color.lerp(this, color, amount)!;
  }
}
