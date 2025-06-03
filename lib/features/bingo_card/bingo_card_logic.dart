import 'package:state_beacon/state_beacon.dart';
import 'package:uuid/uuid.dart';

import 'bingo_item.dart';

final bingoCardControllerRef = Ref.scoped((ctx) => BingoCardController());

class BingoCardController extends BeaconController {
  BingoCardController() {
    _initializeGrid();
  }

  final int gridSize = 5; // Hardcoded for now
  final gridItems = Beacon.writable<List<List<BingoItem>>>([]);

  void _initializeGrid() {
    final newGrid = List.generate(
      gridSize,
      (row) => List.generate(
        gridSize,
        (col) {
          final itemId = Uuid().v4();
          final item =
              BingoItem(id: itemId, text: 'Item ${row * gridSize + col + 1}');
          return item;
        },
      ),
    );
    gridItems.value = newGrid;
  }

  void updateItemText(String itemId, String newText) {
    final newGrid = gridItems.value.map((row) {
      return row.map((item) {
        if (item.id == itemId) {
          return item.copyWith(text: newText);
        }
        return item;
      }).toList();
    }).toList();
    gridItems.value = newGrid;
  }

  void toggleDoneStatus(String itemId) {
    final newGrid = gridItems.value.map((row) {
      return row.map((item) {
        if (item.id == itemId) {
          return item.copyWith(isDone: !item.isDone);
        }
        return item;
      }).toList();
    }).toList();
    gridItems.value = newGrid;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
