import 'package:flutter/material.dart';

Size textSize(
  String text,
  TextStyle style, {
  double maxWidth = double.infinity,
  int maxLines = 1,
}) {
  final textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: maxLines,
    textDirection: TextDirection.ltr,
  )..layout(maxWidth: maxWidth);
  return textPainter.size;
}
