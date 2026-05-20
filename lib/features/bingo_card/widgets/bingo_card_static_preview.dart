import 'package:auto_size_text/auto_size_text.dart';
import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/features/bingo_card/bingo_item.dart';
import 'package:flutter/material.dart';

/// A read-only render of a bingo grid. Used on the import screen and anywhere
/// else we need to show a card without depending on the live controller.
class BingoCardStaticPreview extends StatelessWidget {
  const BingoCardStaticPreview({
    super.key,
    required this.gridItems,
    this.cellSize = 64,
  });

  final List<List<BingoItem>> gridItems;
  final double cellSize;

  @override
  Widget build(BuildContext context) {
    final size = gridItems.length;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(size, (row) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(size, (col) {
            final item = gridItems[row][col];
            final isCenterFree = size.isOdd &&
                row == size ~/ 2 &&
                col == size ~/ 2 &&
                item.text.isEmpty;
            return Container(
              width: cellSize,
              height: cellSize,
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: item.isDone
                    ? context.primary.withValues(alpha: 0.85)
                    : (isCenterFree ? kGrey6 : kWhite),
                border: Border.all(color: kGrey4),
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.all(4),
              alignment: Alignment.center,
              child: AutoSizeText(
                item.text,
                textAlign: TextAlign.center,
                maxLines: 4,
                minFontSize: 8,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: item.isDone ? kWhite : kGrey1,
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
