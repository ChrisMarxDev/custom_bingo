import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/l10n/l10n.dart';
import 'package:flutter/material.dart';
import '../bingo_item.dart';

enum SelectedItem { edit, markDone, cancel }

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
          color: context.cardColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: context.shadowColor.withValues(alpha: 0.12),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
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
                child: Text(
                  context.l10n.edit,
                  style: TextStyle(color: context.textColor),
                ),
                onPressed: onEdit,
              ),
              Divider(height: 1, thickness: 0.5, color: context.outlineColor),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft,
                ),
                child: Text(
                  item.isDone
                      ? context.l10n.markNotDone
                      : context.l10n.markDone,
                  style: TextStyle(color: context.textColor),
                ),
                onPressed: onToggleDone,
              ),
              Divider(height: 1, thickness: 0.5, color: context.outlineColor),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft,
                ),
                child: Text(
                  context.l10n.cancel,
                  style: TextStyle(color: context.error),
                ),
                onPressed: onCancel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
