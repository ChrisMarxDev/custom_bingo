import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PopupMenu extends StatefulWidget {
  const PopupMenu({
    required this.popupMenuBuilder,
    this.child,
    super.key,
    this.padding = const EdgeInsets.all(8),
    this.targetAnchor = Alignment.topLeft,
    this.followerAnchor = Alignment.topLeft,
    this.offset = Offset.zero,
    this.childBuilder,
    this.useCard = true,
    this.flipVerticallyToFit = false,
    this.preferredMenuHeight = 320,
    this.viewportMargin = 16,
  }) : assert(
         child != null || childBuilder != null,
         'child or childBuilder must be provided',
       );

  final Widget? child;
  final Widget Function(BuildContext context, VoidCallback onTap)? childBuilder;
  final Widget Function(BuildContext context, void Function() hideOverlay)
  popupMenuBuilder;
  final EdgeInsets padding;
  final Alignment targetAnchor;
  final Alignment followerAnchor;
  final Offset offset;
  final bool useCard;
  final bool flipVerticallyToFit;
  final double preferredMenuHeight;
  final double viewportMargin;

  @override
  State<PopupMenu> createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  void _showOverlay() {
    if (_isOpen) return;

    final placement = _resolvePlacement();

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Overlay background
          Positioned.fill(
            child: GestureDetector(
              onTap: _hideOverlay,
              child: Container(
                color: Theme.of(
                  context,
                ).colorScheme.shadow.withValues(alpha: .3),
              ),
            ),
          ).animate().fadeIn(duration: 200.ms),
          // Popup menu
          CompositedTransformFollower(
            link: _layerLink,
            offset: placement.offset,
            targetAnchor: placement.targetAnchor,
            followerAnchor: placement.followerAnchor,
            child:
                Material(
                      type: MaterialType.transparency,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: placement.maxHeight,
                        ),
                        child: _PopupMenuSurface(
                          useCard: widget.useCard,
                          padding: widget.padding,
                          child: widget.popupMenuBuilder(context, _hideOverlay),
                        ),
                      ),
                    )
                    .animate()
                    .scale(
                      begin: const Offset(0.8, 0.8),
                      duration: 200.ms,
                      curve: Curves.easeOutCubic,
                    )
                    .fadeIn(duration: 200.ms),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  _PopupMenuPlacement _resolvePlacement() {
    final fallback = _PopupMenuPlacement(
      targetAnchor: widget.targetAnchor,
      followerAnchor: widget.followerAnchor,
      offset: widget.offset,
      maxHeight: double.infinity,
    );

    if (!widget.flipVerticallyToFit) return fallback;

    final targetRenderObject = context.findRenderObject();
    final overlayRenderObject = Overlay.of(context).context.findRenderObject();
    if (targetRenderObject is! RenderBox || overlayRenderObject is! RenderBox) {
      return fallback;
    }

    final targetOffset = targetRenderObject.localToGlobal(
      Offset.zero,
      ancestor: overlayRenderObject,
    );
    final targetSize = targetRenderObject.size;
    final overlaySize = overlayRenderObject.size;
    final gap = widget.offset.dy.abs();
    final spaceBelow =
        overlaySize.height -
        targetOffset.dy -
        targetSize.height -
        gap -
        widget.viewportMargin;
    final spaceAbove = targetOffset.dy - gap - widget.viewportMargin;
    final opensDown = widget.targetAnchor.y > widget.followerAnchor.y;
    final shouldFlipUp =
        opensDown &&
        spaceBelow < widget.preferredMenuHeight &&
        spaceAbove > spaceBelow;

    if (shouldFlipUp) {
      return _PopupMenuPlacement(
        targetAnchor: Alignment(widget.targetAnchor.x, -1),
        followerAnchor: Alignment(widget.followerAnchor.x, 1),
        offset: Offset(widget.offset.dx, -gap),
        maxHeight: math.max(0, spaceAbove),
      );
    }

    return _PopupMenuPlacement(
      targetAnchor: widget.targetAnchor,
      followerAnchor: widget.followerAnchor,
      offset: widget.offset,
      maxHeight: math.max(0, spaceBelow),
    );
  }

  void _hideOverlay() {
    _removeOverlay(updateState: true);
  }

  void _removeOverlay({required bool updateState}) {
    final overlayEntry = _overlayEntry;
    if (overlayEntry == null) return;

    overlayEntry.remove();
    _overlayEntry = null;
    if (updateState && mounted) {
      setState(() => _isOpen = false);
    } else {
      _isOpen = false;
    }
  }

  @override
  void dispose() {
    _removeOverlay(updateState: false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: widget.childBuilder != null
          ? widget.childBuilder!(context, _showOverlay)
          : GestureDetector(onTap: _showOverlay, child: widget.child),
    );
  }
}

class _PopupMenuPlacement {
  const _PopupMenuPlacement({
    required this.targetAnchor,
    required this.followerAnchor,
    required this.offset,
    required this.maxHeight,
  });

  final Alignment targetAnchor;
  final Alignment followerAnchor;
  final Offset offset;
  final double maxHeight;
}

class _PopupMenuSurface extends StatelessWidget {
  const _PopupMenuSurface({
    required this.useCard,
    required this.padding,
    required this.child,
  });

  final bool useCard;
  final EdgeInsets padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final paddedChild = Padding(padding: padding, child: child);

    if (!useCard) return paddedChild;

    return Card(elevation: 4, margin: EdgeInsets.zero, child: paddedChild);
  }
}
