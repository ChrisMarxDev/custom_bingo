import 'package:flutter/material.dart';

class HintWidget extends StatefulWidget {
  const HintWidget({super.key, this.show = false, required this.child});

  final bool show;
  final Widget child;

  @override
  State<HintWidget> createState() => _HintWidgetState();
}

class _HintWidgetState extends State<HintWidget> {
  @override
  Widget build(BuildContext context) {
    final show = widget.show;
    return AnimatedScale(
      alignment: Alignment.topCenter,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
      scale: show ? 1.0 : 0.0,
      child: AnimatedSize(
        alignment: Alignment.topCenter,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 300),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          opacity: show ? 1 : 0.0,
          child: show
              ? Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: widget.child,
                )
              : SizedBox(),
        ),
      ),
    );
  }
}
