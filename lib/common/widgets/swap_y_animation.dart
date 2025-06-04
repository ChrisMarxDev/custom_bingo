import 'package:flutter/material.dart';

class MoveSwapAnimation extends StatelessWidget {
  const MoveSwapAnimation({
    required this.child,
    super.key,
    this.duration = const Duration(milliseconds: 300),
  });

  final Widget child;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      child: child,
      transitionBuilder: (animationChild, animation) {
        final isCurrent = animationChild.key == child.key;
        return FadeTransition(
          opacity: Tween<double>(
            begin: isCurrent ? 0.1 : 0,
            end: 1,
          ).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: isCurrent ? const Offset(0, -1) : const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: animationChild,
          ),
        );
      },
    );
  }
}
