import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:flutter/material.dart';

class AnimatedNumberSelector extends StatelessWidget {
  const AnimatedNumberSelector({
    required this.value,
    required this.onChanged,
    this.minValue = 1,
    this.maxValue = 999,
    super.key,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final int minValue;
  final int maxValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _CircleButton(
          icon: Icons.remove,
          onPressed: value > minValue ? () => onChanged(value - 1) : null,
        ),
        const SizedBox(width: 24),
        AnimatedNumber(value: value),
        const SizedBox(width: 24),
        _CircleButton(
          icon: Icons.add,
          onPressed: value < maxValue ? () => onChanged(value + 1) : null,
        ),
      ],
    );
  }
}

class AnimatedNumber extends StatefulWidget {
  const AnimatedNumber({required this.value, this.textStyle, super.key});

  final num value;
  final TextStyle? textStyle;

  @override
  State<AnimatedNumber> createState() => _AnimatedNumberState();
}

class _AnimatedNumberState extends State<AnimatedNumber> {
  late num _value;
  late num _lastValue;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
    _lastValue = _value;
  }

  @override
  void didUpdateWidget(AnimatedNumber oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _lastValue = oldWidget.value;
      _value = widget.value;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            transitionBuilder: (child, animation) {
              late Offset begin;

              final childValue = (child.key! as ValueKey<num>).value;
              final isCurrent = widget.value == childValue;

              if (_value == _lastValue) {
                begin = Offset.zero;
              } else if (_value > _lastValue) {
                begin = isCurrent ? const Offset(0, 1) : const Offset(0, -1);
              } else {
                begin = isCurrent ? const Offset(0, -1) : const Offset(0, 1);
              }

              return FadeTransition(
                opacity: Tween<double>(
                  begin: isCurrent ? 0.1 : 0,
                  end: 1,
                ).animate(animation),
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: begin,
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: Text(
              widget.value.toString(),
              key: ValueKey<num>(widget.value),
              style: widget.textStyle ?? context.h1.copyWith(fontSize: 42),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    final active = onPressed != null;
    return Material(
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 56,
          height: 56,
          child: Center(
            child: Icon(
              icon,
              size: 36,
              color: context.primary.withValues(alpha: active ? 1 : 0.3),
            ),
          ),
        ),
      ),
    );
  }
}
