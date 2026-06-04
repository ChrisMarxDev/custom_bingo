import 'package:custom_bingo/common/services/shared_prefs.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_logic.dart';
import 'package:custom_bingo/features/bingo_card/bingo_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('BingoCardController', () {
    late BingoCardController controller;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      sharedPrefsBeacon.value = await SharedPreferences.getInstance();
      currentSelectedBingoCardName.value = 'Test board';
      controller = BingoCardController();
      controller.gridItems.value = _partiallyFilledGrid();
    });

    tearDown(() {
      controller.dispose();
      currentSelectedBingoCardName.value = null;
    });

    test(
      'does not fill empty cells with pre-made text already on the board',
      () {
        controller.fillEmptyItemsWithPreMade(['A', 'B']);

        final grid = controller.gridItems.value;

        expect(grid[0][0].text, 'A');
        expect(grid[0][1].text, 'B');
        expect(grid[1][0].text, isEmpty);
        expect(grid[1][1].text, isEmpty);
      },
    );

    test('fills only with pre-made text that is not already on the board', () {
      controller.fillEmptyItemsWithPreMade(['A', 'B', 'C']);

      final newTexts = controller.gridItems.value[1]
          .map((item) => item.text)
          .toList();

      expect(newTexts.where((text) => text == 'C'), hasLength(1));
      expect(newTexts.where((text) => text.isEmpty), hasLength(1));
      expect(newTexts, isNot(contains('A')));
      expect(newTexts, isNot(contains('B')));
    });
  });
}

List<List<BingoItem>> _partiallyFilledGrid() {
  return [
    [BingoItem(id: 'a', text: 'A'), BingoItem(id: 'b', text: 'B')],
    [BingoItem(id: 'c'), BingoItem(id: 'd')],
  ];
}
