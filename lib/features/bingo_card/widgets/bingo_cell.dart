import 'package:animated_to/animated_to.dart';
import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/common/widgets/inherited_provider.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_screen.dart';
import 'package:custom_bingo/l10n/l10n.dart';
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
    this.borderRadius = BorderRadius.zero,
  });

  /// The data for this bingo cell.
  final BingoItem item;

  /// The width of the cell.
  final double cellWidth;

  /// The height of the cell.
  final double cellHeight;

  /// Whether the cell is the middle item.
  final bool isMiddleItem;
  final BorderRadius borderRadius;

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
    final shouldAnimate =
        context.maybeReadProvided<ShouldAnimate>()?.shouldAnimate ?? false;
    final borderColor = context.outlineColor;

    focusNode.canRequestFocus = isEditing;
    if (!isEditing && focusNode.hasFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          focusNode.unfocus();
        }
      });
    }

    final backgroundColor = isDone
        ? context.primary
        : (widget.isMiddleItem
              ? context.surfaceContainerLow
              : context.cardColor);
    return AnimatedTo.spring(
      globalKey: shouldAnimate ? GlobalObjectKey(widget.item.id) : GlobalKey(),
      child: RawBingoCell(
        widget: widget,
        borderColor: borderColor,
        backgroundColor: backgroundColor,
        isDone: isDone,
        isEditing: isEditing,
        focusNode: focusNode,
        controller: controller,
        textEditingController: _textEditingController,
      ),
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: widget.cellWidth,
      height: widget.cellHeight,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        border: Border.all(
          color: borderColor,
          width: 0.5,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
      child: Material(
        color: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: widget.borderRadius),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: widget.borderRadius,
          splashColor: isDone ? context.onPrimary : context.primary,
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
                    color: context.weakestTextColor.withValues(alpha: 0.35),
                    size: widget.cellWidth * 0.8,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: IgnorePointer(
                  ignoring: !isEditing,
                  child: TextField(
                    controller: _textEditingController,
                    focusNode: focusNode,
                    readOnly: !isEditing,
                    showCursor: isEditing,
                    enableInteractiveSelection: isEditing,
                    textAlign: TextAlign.center,
                    maxLines: null,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isDone ? context.onPrimary : context.textColor,
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
                      hintText: context.l10n.cellHint,
                      hintStyle: TextStyle(color: context.weakTextColor),
                    ),
                    onChanged: isEditing
                        ? (newText) {
                            controller.updateItemText(widget.item.id, newText);
                          }
                        : null,
                    onSubmitted: isEditing
                        ? (newText) {
                            controller.updateItemText(widget.item.id, newText);
                            focusNode.unfocus();
                          }
                        : null,
                    onTapOutside: isEditing
                        ? (event) {
                            controller.updateItemText(
                              widget.item.id,
                              _textEditingController.text,
                            );
                          }
                        : null,
                  ),
                ),
              ),
              if (widget.item.isDone)
                Positioned(
                  top: 2,
                  right: 2,
                  child: Container(
                    width: 18,
                    height: 18,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: context.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      color: context.onSecondary,
                      size: 12,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
