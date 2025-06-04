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

  @override
  State<PopupMenu> createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  void _showOverlay() {
    if (_isOpen) return;

    _overlayEntry = OverlayEntry(
      builder:
          (context) => Stack(
            children: [
              // Overlay background
              Positioned.fill(
                child: GestureDetector(
                  onTap: _hideOverlay,
                  child: Container(color: Colors.black.withValues(alpha: .3)),
                ),
              ).animate().fadeIn(duration: 200.ms),
              // Popup menu
              CompositedTransformFollower(
                link: _layerLink,
                offset: widget.offset,
                targetAnchor: widget.targetAnchor,
                followerAnchor: widget.followerAnchor,
                child: Material(
                      color: Colors.transparent,
                      child: Card(
                        elevation: 4,
                        margin: EdgeInsets.zero,
                        child: Padding(
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

  void _hideOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.markNeedsBuild();
      Future.delayed(200.ms, () {
        _overlayEntry?.remove();
        _overlayEntry = null;
        setState(() => _isOpen = false);
      });
    }
  }

  @override
  void dispose() {
    _hideOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child:
          widget.childBuilder != null
              ? widget.childBuilder!(context, _showOverlay)
              : GestureDetector(onTap: _showOverlay, child: widget.child),
    );
  }
}
