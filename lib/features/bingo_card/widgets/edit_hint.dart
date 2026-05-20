import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/common/services/shared_prefs.dart';
import 'package:cue/cue.dart';
import 'package:flutter/material.dart';
import 'package:state_beacon/state_beacon.dart';

late final showHintBeacon = Beacon.family<bool, String, WritableBeacon<bool>>(
  (id) =>
      Beacon.writable(sharedPrefsBeacon.value.getBool('show_hint_$id') ?? true),
);

void setShowHint(String hintId, {bool show = false}) {
  sharedPrefsBeacon.value.setBool('show_hint_$hintId', show);
  showHintBeacon(hintId).set(show);
}

const toggleHintId = 'toggle_hint';
const editingHintId = 'editing_hint';

class HintWidget extends StatefulWidget {
  const HintWidget({
    super.key,
    this.show,
    required this.child,
    this.hintId,
    this.onClose,
  });

  final bool? show;
  final Widget child;
  final String? hintId;
  final VoidCallback? onClose;

  @override
  State<HintWidget> createState() => _HintWidgetState();
}

class _HintWidgetState extends State<HintWidget> {
  late bool _renderHint;

  @override
  void initState() {
    super.initState();
    _renderHint = _currentShowValue();
  }

  bool _currentShowValue() {
    final showByBeacon = widget.hintId != null
        ? showHintBeacon(widget.hintId!).value
        : true;
    return showByBeacon && (widget.show ?? true);
  }

  void _ensureHintIsMounted(bool show) {
    if (!show || _renderHint) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _renderHint) return;
      setState(() {
        _renderHint = true;
      });
    });
  }

  Widget _buildHintCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: context.textColor.withValues(alpha: 0.14),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 16,
                left: 16,
                right: 4,
              ),
              child: widget.child,
            ),
          ),
          if (widget.hintId != null)
            IconButton(
              onPressed: () {
                if (widget.hintId != null) {
                  setShowHint(widget.hintId!);
                }
                widget.onClose?.call();
              },
              icon: const Icon(Icons.close),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final showByBeacon = widget.hintId != null
        ? showHintBeacon(widget.hintId!).watch(context)
        : true;

    final show = showByBeacon && (widget.show ?? true);
    _ensureHintIsMounted(show);

    return AnimatedSize(
      alignment: Alignment.topCenter,
      curve: Curves.easeInOutCubic,
      duration: const Duration(milliseconds: 320),
      child: _renderHint
          ? Cue.onToggle(
              toggled: show,
              motion: const Spring.smooth(),
              reverseMotion: const Spring.smooth(),
              acts: const [
                Act.fadeIn(),
                Act.slideY(from: -0.08),
                Act.scale(from: 0.96, alignment: Alignment.topCenter),
              ],
              onEnd: (isVisible) {
                if (isVisible || !mounted || _currentShowValue()) return;
                setState(() {
                  _renderHint = false;
                });
              },
              child: _buildHintCard(context),
            )
          : const SizedBox.shrink(),
    );
  }
}
