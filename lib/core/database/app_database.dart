import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../features/history/data/scan_records_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [ScanRecords])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  AppDatabase.defaults() : super(driftDatabase(name: 'scanner_app_db'));

  @override
  int get schemaVersion => 1;
}
