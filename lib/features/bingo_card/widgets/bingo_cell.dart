import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/features/bingo_card/widgets/bingo_cell_overlay.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:state_beacon/state_beacon.dart';

import '../bingo_item.dart';
import '../bingo_card_logic.dart';

/// A widget representing a single cell in the bingo card.

class BingoCell extends StatefulWidget {
  /// Creates a bingo cell.
  const BingoCell({
    super.key,
    required this.item,
    required this.cellWidth,
    required this.isMiddleItem,
    required this.cellHeight,
  });

  /// The data for this bingo cell.
  final BingoItem item;

  /// The width of the cell.
  final double cellWidth;

  /// The height of the cell.
  final double cellHeight;

  /// Whether the cell is the middle item.
  final bool isMiddleItem;

  @override
  State<BingoCell> createState() => _BingoCellState();
}

class _BingoCellState extends State<BingoCell> {
  late final FocusNode focusNode;
  final LayerLink _layerLink = LayerLink();
  late final TextEditingController _textEditingController;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.item.text);
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant BingoCell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_textEditingController.text != widget.item.text) {
      _textEditingController.text = widget.item.text;
    }
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = bingoCardControllerRef.of(context);
    final isEditing = controller.isEditing.watch(context);
    final isDone = widget.item.isDone;
    Color borderColor = Colors.black;

    Color backgroundColor = Colors.transparent;
    if (widget.isMiddleItem) {
      // backgroundColor = Colors.blue.withOpacity(0.3);
    }
    if (isDone) {
      backgroundColor = Colors.black.withValues(alpha: 0.8);
    }
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        width: widget.cellWidth,
        height: widget.cellHeight,
        decoration: BoxDecoration(
          border: Border.all(
              color: borderColor,
              width: 0.5,
              strokeAlign: BorderSide.strokeAlignCenter),
          // backgroundColor is now applied to the Material widget below
        ),
        child: Material(
          color:
              backgroundColor, // Material widget now holds the background color
          child: InkWell(
            splashColor: isDone ? Colors.white : Colors.black,
            onTap: isEditing
                ? () {
                    focusNode.requestFocus();
                  }
                : null,
            onLongPress: () {
              controller.toggleDoneStatus(widget.item.id);
            },
            child: Stack(
              // Stack is now the direct child of InkWell
              alignment: Alignment.center,
              children: [
                if (widget.isMiddleItem)
                  Center(
                    child: Icon(
                      PhosphorIcons.asterisk(),
                      color: Colors.grey.withValues(alpha: 0.1),
                      size: widget.cellWidth * 0.8,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    enabled: isEditing,
                    controller: _textEditingController,
                    focusNode: focusNode,
                    textAlign: TextAlign.center,
                    maxLines: null,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isDone ? Colors.white : Colors.black,
                    ),
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      isDense: true,
                      hintText: 'Enter text...',
                    ),
                    onChanged: (newText) {
                      controller.updateItemText(widget.item.id, newText);
                    },
                    onSubmitted: (newText) {
                      controller.updateItemText(widget.item.id, newText);
                      focusNode.unfocus();
                    },
                    onTapOutside: (event) {
                      controller.updateItemText(
                          widget.item.id, _textEditingController.text);
                    },
                  ),
                ),
                if (widget.item.isDone)
                  Positioned(
                    top: 2,
                    right: 2,
                    child:
                        Icon(Icons.check_circle, color: Colors.white, size: 18),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void _showOverlay(BuildContext context, BingoItem item, LayerLink link) {
  //   _removeOverlay();

  //   final controller = bingoCardControllerRef.of(context);

  //   final newOverlayEntry = OverlayEntry(
  //     builder: (context) {
  //       return Stack(
  //         children: [
  //           // Dark Barrier & Dismissal GestureDetector
  //           Positioned.fill(
  //             child: GestureDetector(
  //               onTap: hideOverlay,
  //               behavior: HitTestBehavior.opaque,
  //               child: Container(
  //                   color: Colors.black.withOpacity(0.3)), // Dark barrier
  //             ),
  //           ),
  //           // The actual overlay content
  //           CompositedTransformFollower(
  //             link: link,
  //             showWhenUnlinked: false,
  //             offset: const Offset(0, 0), // Reduced Y offset to move menu up
  //             targetAnchor: Alignment.bottomCenter,
  //             followerAnchor: Alignment.topCenter,
  //             child: BingoCellOverlay(
  //               item: item,
  //               onEdit: () {
  //                 setState(() {
  //                   _isEditing = true;
  //                 });
  //                 hideOverlay();
  //                 Future.delayed(const Duration(milliseconds: 100), () {
  //                   focusNode.requestFocus();
  //                 });
  //               },
  //               onToggleDone: () {
  //                 controller.toggleDoneStatus(item.id);
  //                 hideOverlay();
  //               },
  //               onCancel: () {
  //                 hideOverlay();
  //               },
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );

  //   Overlay.of(context).insert(newOverlayEntry);
  //   _overlayEntry = newOverlayEntry;
  // }

  // void _removeOverlay() {
  //   _overlayEntry?.remove();
  //   _overlayEntry = null;
  // }

  // void hideOverlay() {
  //   _removeOverlay();
  // }
}
