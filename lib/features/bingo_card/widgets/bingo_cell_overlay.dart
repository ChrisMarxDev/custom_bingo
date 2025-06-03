import 'package:flutter/material.dart';
import '../bingo_card_logic.dart';
import '../bingo_item.dart';

enum SelectedItem {
  edit,
  markDone,
  cancel,
}

class BingoCellOverlay extends StatelessWidget {
  const BingoCellOverlay({
    super.key,
    required this.item,
    required this.onEdit,
    required this.onToggleDone,
    required this.onCancel,
  });

  final BingoItem item;
  final VoidCallback onEdit;
  final VoidCallback onToggleDone;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft,
                ),
                child:
                    const Text('Edit', style: TextStyle(color: Colors.black87)),
                onPressed: onEdit,
              ),
              const Divider(height: 1, thickness: 0.5),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft,
                ),
                child: Text(item.isDone ? 'Mark Not Done' : 'Mark Done',
                    style: TextStyle(color: Colors.black87)),
                onPressed: onToggleDone,
              ),
              const Divider(height: 1, thickness: 0.5),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft,
                ),
                child: const Text('Cancel',
                    style: TextStyle(color: Colors.redAccent)),
                onPressed: onCancel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
