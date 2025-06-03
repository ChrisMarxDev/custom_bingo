import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class SnappingScrollPhysics extends ScrollPhysics {
  const SnappingScrollPhysics({required this.snapOffsets, super.parent});
  final List<double> snapOffsets;

  @override
  SnappingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    // print('SnappingScrollPhysics: applyTo called. Snap offsets count: ${snapOffsets.length}');
    return SnappingScrollPhysics(
      snapOffsets: snapOffsets,
      parent: buildParent(ancestor ?? const BouncingScrollPhysics()),
    );
  }

  double _getTargetPixels(
    ScrollMetrics position,
    Tolerance tolerance,
    double velocity,
  ) {
    if (snapOffsets.isEmpty) {
      // print('SnappingScrollPhysics: _getTargetPixels - No snap offsets, returning current pixels: ${position.pixels}');
      return position.pixels;
    }

    // print('SnappingScrollPhysics: _getTargetPixels - Current pixels: ${position.pixels}, Velocity: $velocity, Snap Offsets: $snapOffsets');

    var currentIndex = 0;
    if (position.pixels < snapOffsets.first) {
      currentIndex = 0;
    } else if (position.pixels > snapOffsets.last) {
      currentIndex = snapOffsets.length - 1;
    } else {
      var minDistance = double.infinity;
      for (var i = 0; i < snapOffsets.length; i++) {
        final distance = (snapOffsets[i] - position.pixels).abs();
        if (distance < minDistance) {
          minDistance = distance;
          currentIndex = i;
        }
      }
    }
    // print('SnappingScrollPhysics: _getTargetPixels - Closest snap index: $currentIndex (offset: ${snapOffsets[currentIndex]})');

    var targetIndex = currentIndex;

    if (velocity.abs() > tolerance.velocity) {
      if (velocity < -tolerance.velocity) {
        if (position.pixels <= snapOffsets[currentIndex] + tolerance.distance) {
          targetIndex = math.max(0, currentIndex - 1);
        }
      } else if (velocity > tolerance.velocity) {
        if (position.pixels >= snapOffsets[currentIndex] - tolerance.distance) {
          targetIndex = math.min(snapOffsets.length - 1, currentIndex + 1);
        }
      }
      // print('SnappingScrollPhysics: _getTargetPixels - Adjusted target index due to velocity: $targetIndex (offset: ${snapOffsets[targetIndex]})');
    }
    final targetPixel = snapOffsets[targetIndex].clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );
    // print('SnappingScrollPhysics: _getTargetPixels - Final target pixels: $targetPixel');
    return targetPixel;
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    // print('SnappingScrollPhysics: createBallisticSimulation called. Position: ${position.pixels}, Velocity: $velocity');
    if (snapOffsets.isEmpty ||
        (velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      // print('SnappingScrollPhysics: createBallisticSimulation - Bypassing snap (empty offsets or out of bounds).');
      return super.createBallisticSimulation(position, velocity);
    }

    final tolerance = this.tolerance;
    final target = _getTargetPixels(position, tolerance, velocity);

    if ((velocity.abs() < tolerance.velocity) &&
        (target - position.pixels).abs() < tolerance.distance) {
      // print('SnappingScrollPhysics: createBallisticSimulation - Already at target or close, no simulation needed. Target: $target, Current: ${position.pixels}');
      return null;
    }
    // print('SnappingScrollPhysics: createBallisticSimulation - Creating ScrollSpringSimulation. Target: $target, Current: ${position.pixels}, Velocity: $velocity');
    return ScrollSpringSimulation(
      spring,
      position.pixels,
      target,
      velocity,
      tolerance: tolerance,
    );
  }

  @override
  bool get allowImplicitScrolling => false;
}
