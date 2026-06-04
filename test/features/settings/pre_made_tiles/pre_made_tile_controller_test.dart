import 'package:custom_bingo/common/services/app_database.dart';
import 'package:custom_bingo/features/settings/pre_made_tiles/pre_made_tile_controller.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PreMadeTileController', () {
    late AppDatabase database;
    late PreMadeTileController controller;

    setUp(() {
      database = AppDatabase(NativeDatabase.memory());
      controller = PreMadeTileController(database: database);
    });

    tearDown(() async {
      controller.dispose();
      await database.close();
    });

    test('does not save the same draft twice concurrently', () async {
      controller.addDraft();
      final draftId = controller.drafts.value.single.id;
      controller.updateDraftText(draftId, 'Same content');

      await Future.wait([
        controller.saveDraftIfReady(draftId),
        controller.saveDraftIfReady(draftId),
      ]);

      final tiles = await database.watchPreMadeTiles().first;

      expect(tiles, hasLength(1));
      expect(tiles.single.tileText, 'Same content');
    });
  });
}
