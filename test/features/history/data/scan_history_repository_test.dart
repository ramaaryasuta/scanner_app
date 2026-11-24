import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scanner_app/core/database/app_database.dart';
import 'package:scanner_app/features/history/data/scan_history_repository.dart';

void main() {
  late AppDatabase db;
  late ScanHistoryRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = ScanHistoryRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  Future<int> addAndGetId(String content) async {
    await repo.addScanHistory(content);
    final items = await repo.watchAll().first;
    return items.first.id;
  }

  group('ScanHistoryRepository', () {
    test('addScanHistory menyimpan item baru yang belum disave', () async {
      await repo.addScanHistory('https://example.com');

      final items = await repo.watchAll().first;

      expect(items, hasLength(1));
      expect(items.first.content, 'https://example.com');
      expect(items.first.isSaved, isFalse);
      expect(items.first.title, isNull);
    });

    test('watchAll mengurutkan item terbaru di paling atas', () async {
      await repo.addScanHistory('pertama');
      await repo.addScanHistory('kedua');

      final items = await repo.watchAll().first;

      expect(items.map((e) => e.content), ['kedua', 'pertama']);
    });

    test('save dengan title masuk ke watchSaved', () async {
      final id = await addAndGetId('https://promo.com');

      await repo.save(id, title: 'Promo');

      final saved = await repo.watchSaved().first;
      expect(saved, hasLength(1));
      expect(saved.first.id, id);
      expect(saved.first.isSaved, isTrue);
      expect(saved.first.title, 'Promo');
    });

    test('watchSaved tidak berisi item yang belum disave', () async {
      await repo.addScanHistory('hanya riwayat');

      final saved = await repo.watchSaved().first;

      expect(saved, isEmpty);
    });

    test('unsave mengeluarkan dari watchSaved tapi title tetap ada', () async {
      final id = await addAndGetId('https://promo.com');
      await repo.save(id, title: 'Promo');

      await repo.unsave(id);

      final saved = await repo.watchSaved().first;
      expect(saved, isEmpty);

      final all = await repo.watchAll().first;
      expect(all.first.isSaved, isFalse);
      expect(all.first.title, 'Promo');
    });

    test('save dengan title kosong/spasi disimpan sebagai null', () async {
      final id = await addAndGetId('https://example.com');

      await repo.save(id, title: '   ');

      final saved = await repo.watchSaved().first;
      expect(saved.first.title, isNull);
    });

    test('deleteScanHistory menghapus item', () async {
      final id = await addAndGetId('akan dihapus');

      await repo.deleteScanHistory(id);

      final items = await repo.watchAll().first;
      expect(items, isEmpty);
    });

    test('deleteScanHistory hanya menghapus item dengan id tersebut', () async {
      final idA = await addAndGetId('A');
      await repo.addScanHistory('B');

      await repo.deleteScanHistory(idA);

      final items = await repo.watchAll().first;
      expect(items.map((e) => e.content), ['B']);
    });
  });
}
