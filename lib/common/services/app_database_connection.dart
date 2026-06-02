import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

const _appDatabaseName = 'custom_bingo';

QueryExecutor openAppDatabaseConnection() {
  return driftDatabase(
    name: _appDatabaseName,
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.dart.js'),
    ),
  );
}
