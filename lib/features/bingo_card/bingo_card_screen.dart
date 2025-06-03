import 'package:flutter/material.dart';
import 'package:state_beacon/state_beacon.dart';

import 'bingo_card_logic.dart';
import 'widgets/bingo_cell.dart';

class BingoCardScreen extends StatelessWidget {
  const BingoCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = bingoCardControllerRef.of(context);
    final gridItems = controller.gridItems
        .watch(context); // This should work with flutter_state_beacon
    final gridSize = controller.gridSize;

    final size = MediaQuery.sizeOf(context);
    final screenWidth = size.width;
    final totalPaddingAndBorder =
        (gridSize + 1) * 1.0; // Assuming 1px for border/padding between cells
    final cellWidth = (screenWidth - totalPaddingAndBorder) / gridSize;
    final cellHeight = cellWidth; // Square cells

    // InteractiveViewer creates its own controller if not provided.
    final transformationController = TransformationController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Bingo Card'),
        actions: [
          // Button to reset the view of the InteractiveViewer
          IconButton(
            icon: const Icon(Icons.center_focus_strong),
            tooltip: 'Reset View',
            onPressed: () {
              transformationController.value = Matrix4.identity();
            },
          ),
        ],
      ),
      body: InteractiveViewer(
        transformationController: transformationController,
        boundaryMargin: EdgeInsets.only(
          bottom: size.height * 0.5,
          top: size.height * 0.5,
          left: size.width * 0.5,
          right: size.width * 0.5,
        ),
        alignment: Alignment.center,
        minScale: 0.5,
        maxScale: 4.0,
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(
                0.5), // Half of the border to make grid lines look centered
            width: cellWidth * gridSize +
                gridSize * 1.0, // total width for cells and borders
            height: cellHeight * gridSize +
                gridSize * 1.0, // total height for cells and borders
            child: Column(
              children: List.generate(gridSize, (rowIndex) {
                return Row(
                  children: List.generate(gridSize, (colIndex) {
                    if (rowIndex >= gridItems.length ||
                        colIndex >= gridItems[rowIndex].length) {
                      // Should not happen if grid is initialized correctly
                      return SizedBox(width: cellWidth, height: cellHeight);
                    }
                    final item = gridItems[rowIndex][colIndex];
                    return BingoCell(
                      item: item,
                      cellWidth: cellWidth,
                      cellHeight: cellHeight,
                    );
                  }),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
