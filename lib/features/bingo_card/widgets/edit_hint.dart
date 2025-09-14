import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/common/services/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:state_beacon/state_beacon.dart';

late final showHintBeacon = Beacon.family<bool, String, WritableBeacon<bool>>(
    (id) => Beacon.writable(
        sharedPrefsBeacon.value.getBool('show_hint_$id') ?? true));

void setShowHint(String hintId, {bool show = false}) {
  sharedPrefsBeacon.value.setBool('show_hint_$hintId', show);
  showHintBeacon(hintId).set(show);
}

const toggleHintId = 'toggle_hint';
const editingHintId = 'editing_hint';

class HintWidget extends StatefulWidget {
  const HintWidget(
      {super.key, this.show, required this.child, this.hintId, this.onClose});

  final bool? show;
  final Widget child;
  final String? hintId;
  final VoidCallback? onClose;

  @override
  State<HintWidget> createState() => _HintWidgetState();
}

class _HintWidgetState extends State<HintWidget> {
  @override
  Widget build(BuildContext context) {
    final showByBeacon = widget.hintId != null
        ? showHintBeacon(widget.hintId!).watch(context)
        : true;

    final show = showByBeacon && (widget.show ?? true);
    return AnimatedSize(
      alignment: Alignment.topCenter,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        opacity: show ? 1 : 0.0,
        child: show
            ? Container(
                decoration: BoxDecoration(
                  color: context.bg,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16, bottom: 16, left: 16, right: 4),
                            child: widget.child)),
                    if (widget.hintId != null)
                      IconButton(
                        onPressed: () {
                          if (widget.hintId != null) {
                            setShowHint(widget.hintId!);
                          }
                          widget.onClose?.call();
                        },
                        icon: Icon(Icons.close),
                      ),
                  ],
                ),
              )
            : SizedBox(),
      ),
    );
  }
}
