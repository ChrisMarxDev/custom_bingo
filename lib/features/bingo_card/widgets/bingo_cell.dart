import 'package:custom_bingo/features/bingo_card/widgets/bingo_cell_overlay.dart';
import 'package:flutter/material.dart';

import '../bingo_item.dart';
import '../bingo_card_logic.dart';

/// A widget representing a single cell in the bingo card.

class BingoCell extends StatefulWidget {
  /// Creates a bingo cell.
  const BingoCell({
    super.key,
    required this.item,
    required this.cellWidth,
    required this.cellHeight,
  });

  /// The data for this bingo cell.
  final BingoItem item;

  /// The width of the cell.
  final double cellWidth;

  /// The height of the cell.
  final double cellHeight;

  @override
  State<BingoCell> createState() => _BingoCellState();
}

class _BingoCellState extends State<BingoCell> {
  late final FocusNode focusNode;
  final LayerLink _layerLink = LayerLink();
  late final TextEditingController _textEditingController;
  OverlayEntry? _overlayEntry;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.item.text);
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        // setState(() {
        //   _isEditing = false;
        // });
      }
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
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: () {
          _showOverlay(context, widget.item, _layerLink);
        },
        child: Container(
          width: widget.cellWidth,
          height: widget.cellHeight,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400, width: 0.5),
            color: widget.item.isDone
                ? Colors.green.withOpacity(0.3)
                : Colors.white,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  enabled: _isEditing,
                  controller: _textEditingController,
                  focusNode: focusNode,
                  textAlign: TextAlign.center,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    hintText: '...',
                  ),
                  onChanged: (newText) {
                    // controller.updateItemText(widget.item.id, newText);
                  },
                  onSubmitted: (newText) {
                    controller.updateItemText(widget.item.id, newText);
                    focusNode.unfocus();
                  },
                  onTapOutside: (event) {
                    if (focusNode.hasFocus) {
                      controller.updateItemText(
                          widget.item.id, _textEditingController.text);
                      focusNode.unfocus();
                    }
                  },
                ),
              ),
              if (widget.item.isDone)
                Positioned(
                  top: 2,
                  right: 2,
                  child: Icon(Icons.check_circle,
                      color: Colors.green.shade700, size: 18),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showOverlay(BuildContext context, BingoItem item, LayerLink link) {
    _removeOverlay();

    final controller = bingoCardControllerRef.of(context);

    final newOverlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // Dark Barrier & Dismissal GestureDetector
            Positioned.fill(
              child: GestureDetector(
                onTap: hideOverlay,
                behavior: HitTestBehavior.opaque,
                child: Container(
                    color: Colors.black.withOpacity(0.3)), // Dark barrier
              ),
            ),
            // The actual overlay content
            CompositedTransformFollower(
              link: link,
              showWhenUnlinked: false,
              offset: const Offset(0, 2), // Reduced Y offset to move menu up
              targetAnchor: Alignment.bottomCenter,
              followerAnchor: Alignment.topCenter,
              child: BingoCellOverlay(
                item: item,
                onEdit: () {
                  setState(() {
                    _isEditing = true;
                  });
                  hideOverlay();
                  Future.delayed(const Duration(milliseconds: 100), () {
                    focusNode.requestFocus();
                  });
                },
                onToggleDone: () {
                  controller.toggleDoneStatus(item.id);
                  hideOverlay();
                },
                onCancel: () {
                  hideOverlay();
                },
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(newOverlayEntry);
    _overlayEntry = newOverlayEntry;
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void hideOverlay() {
    _removeOverlay();
  }
}
