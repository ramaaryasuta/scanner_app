import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';

class ScanHistoryRepository {
  ScanHistoryRepository(this._db);
  final AppDatabase _db;

  // INSERT: column has default value (id, isPinned, createdAt)
  Future<void> addScanHistory(String content) {
    return _db
        .into(_db.scanRecords)
        .insert(ScanRecordsCompanion.insert(content: content));
  }

  // SELECT + WATCH: create stream new emit everytime table change

  Stream<List<ScanRecord>> watchAll() {
    final query = _db.select(_db.scanRecords)
      ..orderBy([
        (t) => OrderingTerm.desc(t.createdAt),
        (t) => OrderingTerm.desc(t.id),
      ]);

    return query.watch();
  }

  Stream<List<ScanRecord>> watchSaved() {
    final query = _db.select(_db.scanRecords)
      ..where((t) => t.isSaved.equals(true))
      ..orderBy([
        (t) => OrderingTerm.desc(t.createdAt),
        (t) => OrderingTerm.desc(t.id),
      ]);

    return query.watch();
  }

  // UPDATE: only column has edit Value() changed
  Future<void> save(int id, {String? title}) {
    final normalizedTitle = title?.trim();
    final value = normalizedTitle == null || normalizedTitle.isEmpty
        ? null
        : normalizedTitle;

    return (_db.update(_db.scanRecords)..where((t) => t.id.equals(id))).write(
      ScanRecordsCompanion(isSaved: const Value(true), title: Value(value)),
    );
  }

  Future<void> unsave(int id) {
    return (_db.update(_db.scanRecords)..where((t) => t.id.equals(id))).write(
      const ScanRecordsCompanion(isSaved: Value(false)),
    );
  }

  // DELETE
  Future<void> deleteScanHistory(int id) {
    return (_db.delete(_db.scanRecords)..where((t) => t.id.equals(id))).go();
  }
}
