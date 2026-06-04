import 'package:custom_bingo/common/services/shared_prefs.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_logic.dart';
import 'package:custom_bingo/features/bingo_card/bingo_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:state_beacon/state_beacon.dart';

final homeScreenControllerRef = Ref.scoped((ctx) => HomeScreenController());

class HomeBoardPreview {
  const HomeBoardPreview({required this.name, required this.gridItems});

  final String name;
  final List<List<BingoItem>> gridItems;
}

class HomeScreenController extends BeaconController {
  HomeScreenController() {
    reloadBoards();
  }

  late final boards = Beacon.writable<List<HomeBoardPreview>>([]);

  void reloadBoards() {
    boards.value = _loadBoards();
  }

  Future<void> deleteBoard(String name) async {
    await deleteBingoCard(name);
    await deleteBingoCardName(name);
    if (currentSelectedBingoCardName.value == name) {
      await setCurrentSelectedBingoCard(null);
    }
    reloadBoards();
  }

  List<HomeBoardPreview> _loadBoards() {
    final sharedPreferences = sharedPrefsBeacon.value;
    return [
      for (final name in getBingoCardNames())
        _loadBoard(name, sharedPreferences),
    ];
  }

  HomeBoardPreview _loadBoard(
    String name,
    SharedPreferences sharedPreferences,
  ) {
    final state = loadBingoCard(sharedPreferences, name);
    return HomeBoardPreview(
      name: name,
      gridItems: state?.gridItems ?? const <List<BingoItem>>[],
    );
  }
}
