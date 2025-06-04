import 'dart:async';

import 'package:custom_bingo/common/widgets/swap_y_animation.dart';
import 'package:custom_bingo/common/widgets/toast.dart';
import 'package:flutter/material.dart';

class AsyncFilledButton extends StatefulWidget {
  const AsyncFilledButton({
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    this.showErrorToast = true,
    super.key,
  });

  final Widget child;
  final Future<void> Function()? onPressed;
  final bool isLoading;
  final bool showErrorToast;
  @override
  State<AsyncFilledButton> createState() => _AsyncFilledButtonState();
}

class _AsyncFilledButtonState extends State<AsyncFilledButton> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = widget.isLoading;
  }

  @override
  void didUpdateWidget(AsyncFilledButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isLoading = widget.isLoading;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: widget.onPressed != null && !_isLoading
          ? () async {
              setState(() => _isLoading = true);
              await widget.onPressed!.call().onError((error, stackTrace) {
                setState(() {
                  _isLoading = false;
                  if (widget.showErrorToast) {
                    showErrorToast(context, error.toString());
                  }
                });
              });
              setState(() {
                _isLoading = false;
              });
            }
          : null,
      child: MoveSwapAnimation(
        child: _isLoading
            ? Stack(
                key: ValueKey('loading${widget.child.key}'),
                children: [
                  Opacity(opacity: 0, child: widget.child),
                  Positioned.fill(
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.onPrimary,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : widget.child,
      ),
    );
  }
}

class AsyncTextButton extends StatefulWidget {
  const AsyncTextButton({
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    this.showErrorToast = true,
    this.color,
    super.key,
  });

  final Widget child;
  final Future<void> Function()? onPressed;
  final bool isLoading;
  final bool showErrorToast;
  final Color? color;
  @override
  State<AsyncTextButton> createState() => _AsyncTextButtonState();
}

class _AsyncTextButtonState extends State<AsyncTextButton> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = widget.isLoading;
  }

  @override
  void didUpdateWidget(AsyncTextButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isLoading = widget.isLoading;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).colorScheme.primary;
    return TextButton(
      onPressed: widget.onPressed != null && !_isLoading
          ? () async {
              setState(() => _isLoading = true);
              await widget.onPressed!.call().onError((error, stackTrace) {
                setState(() {
                  _isLoading = false;
                  if (widget.showErrorToast) {
                    showErrorToast(context, error.toString());
                  }
                });
              });
              setState(() {
                _isLoading = false;
              });
            }
          : null,
      child: DefaultTextStyle(
        style: TextStyle(color: color),
        child: MoveSwapAnimation(
          child: _isLoading
              ? Stack(
                  key: ValueKey('loading${widget.child.key}'),
                  children: [
                    Opacity(opacity: 0, child: widget.child),
                    Positioned.fill(
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: CircularProgressIndicator(
                            color: color,
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : widget.child,
        ),
      ),
    );
  }
}
