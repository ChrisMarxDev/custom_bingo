import 'package:custom_bingo/common/services/shared_prefs.dart';
import 'package:custom_bingo/features/bingo_card/widgets/edit_hint.dart';
import 'package:custom_bingo/util/extensions/list_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:state_beacon/state_beacon.dart';
import 'package:uuid/uuid.dart';

import 'bingo_item.dart';

final bingoCardControllerRef = Ref.scoped((ctx) => BingoCardController());

final bingoGridNamesBeacon = Beacon.writable<List<String>>(
  getBingoCardNames(),
);

final currentSelectedBingoCardName = Beacon.writable<String?>(
  getCurrentSelectedBingoCardName(),
);

// 	1.	📱 Phone comes out during vows
// 2.	🥂 Champagne gets spilled
// 3.	😢 Tears during a speech
// 4.	🎩 Someone makes a dramatic entrance
// 5.	💃 Kids take over the dance floor
// 6.	🍻 Impromptu toast from a guest
// 7.	👏 Crowd claps too early
// 8.	🎶 DJ plays a throwback hit
// 9.	📷 Someone takes a group photo and no one looks at the same camera
final exampleGridItems = [
  [
    BingoItem(id: '1', text: '📱 Phone comes out during vows'),
    BingoItem(id: '2', text: '🥂 Champagne gets spilled'),
    BingoItem(id: '3', text: '😢 Tears during a speech'),
  ],
  [
    BingoItem(id: '4', text: '🎩 Someone makes a dramatic entrance'),
    BingoItem(id: '5', text: '💃 Kids take over the dance floor'),
    BingoItem(id: '6', text: '🍻 Impromptu toast from a guest'),
  ],
  [
    BingoItem(id: '7', text: '👏 Crowd claps too early'),
    BingoItem(id: '8', text: '🎶 DJ plays a throwback hit'),
    BingoItem(
        id: '9',
        text:
            '📷 Someone takes a group photo and no one looks at the same camera'),
  ],
];

class BingoCardController extends BeaconController {
  BingoCardController() {
    loadBoard();
  }

  late final gridItems = Beacon.writable<List<List<BingoItem>>>([]);
  late final lastChangeDateTime = Beacon.writable<DateTime?>(null);
  late final isEditing = Beacon.writable<bool>(true);
  // late final hasToggledOnce = Beacon.writable<bool>(false);
  late final gridSize = Beacon.derived<int>(() {
    return gridItems.value.length;
  });

  late final hasBingoTime = Beacon.writable<DateTime?>(null);

  Future<void> loadBoard([String? selectedBingoCardName]) async {
    final name = selectedBingoCardName ?? currentSelectedBingoCardName.value;
    if (name == null) {
      return;
    }
    final bingoCard = loadBingoCard(sharedPrefsBeacon.value, name);
    gridItems.value = bingoCard?.gridItems ?? [];
    // gridItems.value = exampleGridItems;
    isEditing.value = bingoCard?.isEditing ?? true;
    lastChangeDateTime.value = bingoCard?.lastChangeDateTime ?? DateTime.now();
  }

  void updateItemText(String itemId, String newText) {
    final newGrid = gridItems.value.map((row) {
      return row.map((item) {
        if (item.id == itemId) {
          if (item.text != newText) {
            lastChangeDateTime.value = DateTime.now();
            return item.copyWith(text: newText);
          }
        }
        return item;
      }).toList();
    }).toList();
    gridItems.value = newGrid;
    _saveBingoCard();
  }

  void toggleDoneStatus(String itemId) {
    final newGrid = gridItems.value.map((row) {
      return row.map((item) {
        if (item.id == itemId) {
          return item.copyWith(
              fullfilledAt: item.isDone ? null : DateTime.now());
        }
        return item;
      }).toList();
    }).toList();
    gridItems.value = newGrid;
    // hasToggledOnce.value = true;
    if (showHintBeacon(toggleHintId).value) {
      setShowHint(toggleHintId);
    }

    _saveBingoCard();
    final hasBingo = checkForBingo();
    if (hasBingo) {
      hasBingoTime.value = DateTime.now();
    }
  }

  bool checkForBingo() {
    final grid = gridItems.value;
    final rowCount = grid.length;
    if (rowCount == 0) {
      return false;
    }
    final colCount = grid.first.length;
    if (colCount == 0) {
      return false;
    }

    // Determine if the center cell is a joker (only for odd-sized square grids)
    final isSquare =
        grid.every((row) => row.length == colCount) && rowCount == colCount;
    final hasCenter = isSquare && rowCount % 2 == 1;
    final centerIndex = rowCount ~/ 2;
    final isCenterJoker = hasCenter &&
        ((grid.getCenterOrNull()?.getCenterOrNull()?.text.isEmpty) ?? false);

    bool cellIsDone(int i, int j) {
      // Guard against ragged rows
      if (i < 0 || i >= rowCount || j < 0 || j >= grid[i].length) {
        return false;
      }
      if (isCenterJoker && i == centerIndex && j == centerIndex) {
        return true;
      }
      return grid[i][j].isDone;
    }

    // Check rows
    for (var i = 0; i < rowCount; i += 1) {
      final rowLength = grid[i].length;
      if (rowLength == 0) continue;
      var allDone = true;
      for (var j = 0; j < rowLength; j += 1) {
        if (!cellIsDone(i, j)) {
          allDone = false;
          break;
        }
      }
      if (allDone) {
        return true;
      }
    }

    // Determine max usable column count across ragged rows
    final minColCount = grid
        .map((r) => r.length)
        .fold<int>(colCount, (min, len) => len < min ? len : min);
    if (minColCount == 0) {
      return false;
    }

    // Check columns
    for (var j = 0; j < minColCount; j += 1) {
      var allDone = true;
      for (var i = 0; i < rowCount; i += 1) {
        if (!cellIsDone(i, j)) {
          allDone = false;
          break;
        }
      }
      if (allDone) {
        return true;
      }
    }

    // Check diagonals only if the grid is square
    if (isSquare) {
      var allDonePrimary = true;
      for (var i = 0; i < rowCount; i += 1) {
        if (!cellIsDone(i, i)) {
          allDonePrimary = false;
          break;
        }
      }
      if (allDonePrimary) {
        return true;
      }

      var allDoneSecondary = true;
      for (var i = 0; i < rowCount; i += 1) {
        final j = rowCount - 1 - i;
        if (!cellIsDone(i, j)) {
          allDoneSecondary = false;
          break;
        }
      }
      if (allDoneSecondary) {
        return true;
      }
    }

    return false;
  }

  void _saveBingoCard() async {
    final sharedPreferences = sharedPrefsBeacon.value;
    await saveBingoCard(
        sharedPreferences,
        BingoCardState(
          isEditing: isEditing.value,
          name: currentSelectedBingoCardName.value ?? '',
          gridItems: gridItems.value,
          lastChangeDateTime: lastChangeDateTime.value,
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void shuffleCard() {
    final grid = gridItems.value;
    final allItems = grid.expand((row) => row).toList();
    allItems.shuffle();
    final itemsPerRow = gridSize.value;

    // check for free space
    // check if grid is odd and if the center element is empty

    final isOdd = itemsPerRow % 2 == 1;
    final centerItem = grid.getCenterOrNull()?.getCenterOrNull();
    final hasCenter = isOdd && (centerItem?.text.isEmpty ?? true);

    if (hasCenter) {
      allItems.remove(centerItem);
    }

    final centerIndex = itemsPerRow ~/ 2;

    final result = <List<BingoItem>>[];
    for (var i = 0; i < itemsPerRow; i += 1) {
      final row = <BingoItem>[];
      for (var j = 0; j < itemsPerRow; j += 1) {
        if (i == centerIndex && j == centerIndex && hasCenter) {
          row.add(BingoItem(id: Uuid().v4(), text: ''));
          continue;
        } else {
          row.add(allItems.removeAt(0));
        }
      }
      result.add(row);
    }

    gridItems.value = result;
    lastChangeDateTime.value = DateTime.now();
    _saveBingoCard();
  }
}

Future<void> saveBingoCard(
    SharedPreferences sharedPreferences, BingoCardState state) async {
  final json = state.toJson();
  await sharedPreferences.setString('bingo_card_${state.name}', json);
}

BingoCardState? loadBingoCard(
    SharedPreferences sharedPreferences, String name) {
  final json = sharedPreferences.getString('bingo_card_$name');
  if (json == null) {
    return null;
  }
  return BingoCardStateMapper.fromJson(json);
}

Future<void> deleteBingoCard(String name) async {
  final sharedPreferences = sharedPrefsBeacon.value;
  await sharedPreferences.remove('bingo_card_$name');
}

String? getCurrentSelectedBingoCardName() {
  final sharedPreferences = sharedPrefsBeacon.value;
  return sharedPreferences.getString('current_selected_bingo_card');
}

Future<void> setCurrentSelectedBingoCard(String? name) async {
  final sharedPreferences = sharedPrefsBeacon.value;
  if (name == null) {
    await sharedPreferences.remove('current_selected_bingo_card');
  } else {
    await sharedPreferences.setString('current_selected_bingo_card', name);
  }
  currentSelectedBingoCardName.value = name;
}

List<String> getBingoCardNames() {
  final sharedPreferences = sharedPrefsBeacon.value;
  return sharedPreferences.getStringList('bingo_card_names') ?? [];
}

Future<void> setBingoCardNames(List<String> names) async {
  final sharedPreferences = sharedPrefsBeacon.value;
  await sharedPreferences.setStringList('bingo_card_names', names);
  bingoGridNamesBeacon.value = names;
}

Future<void> addBingoCardName(String name) async {
  final names = List<String>.from(getBingoCardNames());
  names.add(name);
  await setBingoCardNames(names);
}

Future<void> deleteBingoCardName(String name) async {
  final names = List<String>.from(getBingoCardNames());
  names.remove(name);
  await setBingoCardNames(names);
}
