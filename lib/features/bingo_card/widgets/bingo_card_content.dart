import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_logic.dart';
import 'package:custom_bingo/features/bingo_card/bingo_item.dart';
import 'package:custom_bingo/features/bingo_card/widgets/bingo_cell.dart';
import 'package:flutter/material.dart';
import 'package:state_beacon/state_beacon.dart';

const double _cellSize = 128.0;

class BingoCardContentWrapper extends StatelessWidget {
  const BingoCardContentWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = bingoCardControllerRef.of(context);
    final gridItems = controller.gridItems.watch(context);
    final lastChangeDateTime = controller.lastChangeDateTime.watch(context);
    final currentSelectedBingoCardNameString =
        currentSelectedBingoCardName.watch(context);
    return BingoCardContent(
      gridItems: gridItems,
      lastChangeDateTime: lastChangeDateTime,
      currentSelectedBingoCardName: currentSelectedBingoCardNameString,
    );
  }
}

class BingoCardContent extends StatelessWidget {
  const BingoCardContent({
    super.key,
    required this.gridItems,
    required this.lastChangeDateTime,
    required this.currentSelectedBingoCardName,
  });

  final List<List<BingoItem>> gridItems;
  final DateTime? lastChangeDateTime;
  final String? currentSelectedBingoCardName;

  @override
  Widget build(BuildContext context) {
    // The extracted column will go here
    final gridSize = gridItems.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          currentSelectedBingoCardName ?? 'Bingo Card',
          style: context.h2,
        ),
        SizedBox(height: 16),
        ...List.generate(gridSize, (rowIndex) {
          return Row(
            children: List.generate(gridSize, (colIndex) {
              if (rowIndex >= gridItems.length ||
                  colIndex >= gridItems[rowIndex].length) {
                // Should not happen if grid is initialized correctly
                return SizedBox(width: _cellSize, height: _cellSize);
              }
              final item = gridItems[rowIndex][colIndex];

              final isMiddleItem = gridSize % 2 == 0
                  ? false
                  : gridSize ~/ 2 == rowIndex && gridSize ~/ 2 == colIndex;

              return BingoCell(
                item: item,
                isMiddleItem: isMiddleItem,
                cellWidth: _cellSize,
                cellHeight: _cellSize,
              );
            }),
          );
        }),
        SizedBox(height: 16),
        LastChange(lastChangeDateTime: lastChangeDateTime),
      ],
    );
  }
}

class LastChange extends StatelessWidget {
  const LastChange({
    required this.lastChangeDateTime,
    super.key,
  });

  final DateTime? lastChangeDateTime;

  @override
  Widget build(BuildContext context) {
    final date =
        '${lastChangeDateTime?.toLocal().day}.${lastChangeDateTime?.toLocal().month}.${lastChangeDateTime?.toLocal().year}';
    final time =
        '${lastChangeDateTime?.toLocal().hour}:${lastChangeDateTime?.toLocal().minute.toString().padLeft(2, '0')}';
    final text = lastChangeDateTime == null
        ? 'Last change: Never'
        : 'Last change: $date $time';
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        text,
        style: context.h5.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}
