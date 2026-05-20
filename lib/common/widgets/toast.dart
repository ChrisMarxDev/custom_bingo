import 'dart:async';
import 'dart:collection';

import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/l10n/l10n.dart';
import 'package:flutter/material.dart';

final ListQueue<_ToastRequest> _toastQueue = ListQueue<_ToastRequest>();
bool _isShowingToast = false;

OverlayState? _resolveOverlayState(BuildContext context) {
  return Overlay.maybeOf(context, rootOverlay: true) ??
      Navigator.maybeOf(context, rootNavigator: true)?.overlay;
}

void _showToast(
  BuildContext context, {
  required String title,
  required String message,
  required IconData icon,
  required Color iconColor,
  bool isDestructive = false,
}) {
  final overlay = _resolveOverlayState(context);
  if (overlay == null) return;

  _toastQueue.add(
    _ToastRequest(
      overlay: overlay,
      title: title,
      message: message,
      icon: icon,
      iconColor: iconColor,
      isDestructive: isDestructive,
      titleStyle: context.h6.copyWith(
        color: context.textColor,
        fontWeight: FontWeight.w700,
        decoration: TextDecoration.none,
      ),
      subtitleStyle: context.p2.copyWith(
        color: context.textColor,
        decoration: TextDecoration.none,
      ),
    ),
  );

  if (!_isShowingToast) {
    _showNextToast();
  }
}

void _showNextToast() {
  if (_toastQueue.isEmpty) {
    _isShowingToast = false;
    return;
  }

  _isShowingToast = true;
  final request = _toastQueue.removeFirst();

  late final OverlayEntry entry;
  entry = OverlayEntry(
    builder: (context) {
      return _ToastOverlay(
        request: request,
        onDismissed: () {
          entry.remove();
          _showNextToast();
        },
      );
    },
  );

  request.overlay.insert(entry);
}

Future<void> showNeutralToast(BuildContext context, String message) async {
  _showToast(
    context,
    title: context.l10n.toastInfo,
    message: message,
    icon: Icons.info,
    iconColor: context.primary,
  );
}

Future<void> showSuccessToast(BuildContext context, String message) async {
  _showToast(
    context,
    title: context.l10n.toastSuccess,
    message: message,
    icon: Icons.check_circle,
    iconColor: context.primary,
  );
}

Future<void> showErrorToast(BuildContext context, String message) async {
  _showToast(
    context,
    title: context.l10n.toastError,
    message: message,
    icon: Icons.error,
    iconColor: context.error,
    isDestructive: true,
  );
}

class _ToastRequest {
  const _ToastRequest({
    required this.overlay,
    required this.title,
    required this.message,
    required this.icon,
    required this.iconColor,
    required this.isDestructive,
    required this.titleStyle,
    required this.subtitleStyle,
  });

  final OverlayState overlay;
  final String title;
  final String message;
  final IconData icon;
  final Color iconColor;
  final bool isDestructive;
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;
}

class _ToastOverlay extends StatefulWidget {
  const _ToastOverlay({required this.request, required this.onDismissed});

  final _ToastRequest request;
  final VoidCallback onDismissed;

  @override
  State<_ToastOverlay> createState() => _ToastOverlayState();
}

class _ToastOverlayState extends State<_ToastOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _opacityAnimation;
  Timer? _dismissTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
      reverseDuration: const Duration(milliseconds: 180),
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _opacityAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    _controller.forward();
    _dismissTimer = Timer(const Duration(seconds: 3), _dismiss);
  }

  @override
  void dispose() {
    _dismissTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _dismiss() async {
    if (!mounted) return;
    await _controller.reverse();
    if (mounted) {
      widget.onDismissed();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Positioned.fill(
      child: IgnorePointer(
        child: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _opacityAnimation,
                  child: Material(
                    type: MaterialType.transparency,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 560),
                      child: Material(
                        color: theme.colorScheme.surface,
                        elevation: 12,
                        shadowColor: theme.colorScheme.shadow.withValues(
                          alpha: 0.18,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: widget.request.isDestructive
                                  ? widget.request.iconColor.withValues(
                                      alpha: 0.4,
                                    )
                                  : theme.colorScheme.outlineVariant,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Icon(
                                    widget.request.icon,
                                    color: widget.request.iconColor,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.request.title,
                                        style: widget.request.titleStyle,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        widget.request.message,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: widget.request.subtitleStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
