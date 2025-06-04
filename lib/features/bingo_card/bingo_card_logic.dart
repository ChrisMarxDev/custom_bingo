import 'package:custom_bingo/common/services/shared_prefs.dart';
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

class BingoCardController extends BeaconController {
  BingoCardController() {
    loadBoard();
  }

  final int gridSize = 5; // Hardcoded for now
  final gridItems = Beacon.writable<List<List<BingoItem>>>([]);
  final lastChangeDateTime = Beacon.writable<DateTime?>(null);
  final isEditing = Beacon.writable<bool>(true);
  final hasToggledOnce = Beacon.writable<bool>(false);

  Future<void> loadBoard() async {
    final name = currentSelectedBingoCardName.value;
    if (name == null) {
      return;
    }
    final bingoCard = loadBingoCard(sharedPrefsBeacon.value, name);
    gridItems.value = bingoCard?.gridItems ?? [];
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
    hasToggledOnce.value = true;
    _saveBingoCard();
  }

  void _saveBingoCard() async {
    final sharedPreferences = sharedPrefsBeacon.value;
    await saveBingoCard(
        sharedPreferences,
        BingoCardState(
          name: currentSelectedBingoCardName.value ?? '',
          gridItems: gridItems.value,
          lastChangeDateTime: lastChangeDateTime.value,
        ));
  }

  @override
  void dispose() {
    super.dispose();
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

String? getCurrentSelectedBingoCardName() {
  final sharedPreferences = sharedPrefsBeacon.value;
  return sharedPreferences.getString('current_selected_bingo_card');
}

Future<void> setCurrentSelectedBingoCard(String name) async {
  final sharedPreferences = sharedPrefsBeacon.value;
  await sharedPreferences.setString('current_selected_bingo_card', name);
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
