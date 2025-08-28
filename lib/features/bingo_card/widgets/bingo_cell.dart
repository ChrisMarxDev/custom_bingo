import 'package:animated_to/animated_to.dart';
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
  late final TextEditingController _textEditingController;

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
    return AnimatedTo.spring(
      globalKey: GlobalObjectKey(widget.item.id),
      child: RawBingoCell(
          widget: widget,
          borderColor: borderColor,
          backgroundColor: backgroundColor,
          isDone: isDone,
          isEditing: isEditing,
          focusNode: focusNode,
          controller: controller,
          textEditingController: _textEditingController),
    );
  }
}

class RawBingoCell extends StatelessWidget {
  const RawBingoCell({
    super.key,
    required this.widget,
    required this.borderColor,
    required this.backgroundColor,
    required this.isDone,
    required this.isEditing,
    required this.focusNode,
    required this.controller,
    required TextEditingController textEditingController,
  }) : _textEditingController = textEditingController;

  final BingoCell widget;
  final Color borderColor;
  final Color backgroundColor;
  final bool isDone;
  final bool isEditing;
  final FocusNode focusNode;
  final BingoCardController controller;
  final TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
