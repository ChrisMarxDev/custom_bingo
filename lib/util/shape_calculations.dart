import 'dart:math';

import 'package:flutter/material.dart';

Rect getRectangleFromPoints(Offset start, Offset end) {
  final left = min(start.dx, end.dx);
  final top = min(start.dy, end.dy);
  final right = max(start.dx, end.dx);
  final bottom = max(start.dy, end.dy);
  return Rect.fromLTRB(left, top, right, bottom);
}

double distance(Offset a, Offset b) {
  return (a - b).distance;
}

extension RectExtension on Rect {
  Offset get center => Offset(left + width / 2, top + height / 2);
}

extension OffsetExtension on Offset {
  double distanceTo(Offset other) {
    return (this - other).distance;
  }
}

// get a simple polygone path that outlines a line
Path getLineOutline(
  Offset start,
  Offset end, [
  double straightLineHitTestTolerance = 16.0,
]) {
  final polygonPath = Path();

  // check if its a straight line and add a rectangle if so
  if ((start.dx - end.dx).abs() < 2 * straightLineHitTestTolerance ||
      (start.dy - end.dy).abs() < 2 * straightLineHitTestTolerance) {
    final paddedRectStart =
        start -
        Offset(straightLineHitTestTolerance, straightLineHitTestTolerance);
    final paddedRectEnd =
        end +
        Offset(straightLineHitTestTolerance, straightLineHitTestTolerance);

    polygonPath
      ..moveTo(paddedRectStart.dx, paddedRectStart.dy)
      ..lineTo(paddedRectEnd.dx, paddedRectStart.dy)
      ..lineTo(paddedRectEnd.dx, paddedRectEnd.dy)
      ..lineTo(paddedRectStart.dx, paddedRectEnd.dy)
      ..close();
  } else {
    final bezierPoint1 = Offset(start.dx + (end.dx - start.dx) / 2, start.dy);
    polygonPath
      ..moveTo(start.dx, start.dy)
      ..lineTo(end.dx, end.dy)
      ..lineTo(bezierPoint1.dx, bezierPoint1.dy)
      ..lineTo(start.dx, start.dy)
      ..close();
  }
  return polygonPath;
}
