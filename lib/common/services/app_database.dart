import 'package:drift/drift.dart';
import 'package:state_beacon/state_beacon.dart';

part 'app_database.g.dart';

final appDatabaseBeacon = Beacon.lazyWritable<AppDatabase>();

class PreMadeTiles extends Table {
  late final id = integer().autoIncrement()();
  late final tileText = text().named('text')();
  late final isSelected = boolean().withDefault(const Constant(true))();
  late final sortOrder = integer()();
  late final createdAt = dateTime()();
  late final updatedAt = dateTime()();
}

@DriftDatabase(tables: [PreMadeTiles])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
    },
    onUpgrade: (migrator, from, to) async {
      await transaction(() async {
        throw UnsupportedError(
          'No migration defined from schema version $from to $to',
        );
      });
    },
  );

  Stream<List<PreMadeTile>> watchPreMadeTiles() {
    final query = select(preMadeTiles)
      ..orderBy([
        (table) =>
            OrderingTerm(expression: table.sortOrder, mode: OrderingMode.asc),
        (table) => OrderingTerm(expression: table.id, mode: OrderingMode.asc),
      ]);
    return query.watch();
  }

  Future<PreMadeTile> createPreMadeTile({
    required String text,
    required bool isSelected,
    required int sortOrder,
  }) async {
    final normalizedText = text.trim();
    if (normalizedText.isEmpty) {
      throw ArgumentError.value(text, 'text', 'Must not be empty');
    }

    final now = DateTime.now();

    return into(preMadeTiles).insertReturning(
      PreMadeTilesCompanion.insert(
        tileText: normalizedText,
        isSelected: Value(isSelected),
        sortOrder: sortOrder,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<void> updatePreMadeTileText(int id, String text) async {
    final normalizedText = text.trim();
    if (normalizedText.isEmpty) {
      await deletePreMadeTile(id);
      return;
    }

    await (update(preMadeTiles)..where((table) => table.id.equals(id))).write(
      PreMadeTilesCompanion(
        tileText: Value(normalizedText),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> updatePreMadeTileSelection(int id, bool isSelected) async {
    await (update(preMadeTiles)..where((table) => table.id.equals(id))).write(
      PreMadeTilesCompanion(
        isSelected: Value(isSelected),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> updateAllPreMadeTileSelection(bool isSelected) async {
    await update(preMadeTiles).write(
      PreMadeTilesCompanion(
        isSelected: Value(isSelected),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deletePreMadeTile(int id) async {
    await (delete(preMadeTiles)..where((table) => table.id.equals(id))).go();
  }
}
