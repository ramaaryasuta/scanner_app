import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scanner_app/core/database/app_database.dart';
import 'package:scanner_app/core/database/database_provider.dart';
import 'package:scanner_app/features/history/provider/history_provider.dart';

void main() {
  late AppDatabase db;
  late ProviderContainer container;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    container = ProviderContainer.test(
      overrides: [databaseProvider.overrideWithValue(db)],
    );
  });

  tearDown(() async {
    await db.close();
  });

  Future<List<ScanRecord>> readStream(
    StreamProvider<List<ScanRecord>> provider,
  ) {
    container.listen(provider, (_, _) {});
    return container.read(provider.future);
  }

  group('history providers', () {
    test('repository memakai database hasil override', () async {
      final repo = container.read(scanHistoryRepositoryProvider);

      await repo.addScanHistory('https://example.com');

      final rows = await db.select(db.scanRecords).get();
      expect(rows, hasLength(1));
    });

    test('database kosong menghasilkan list kosong', () async {
      final all = await readStream(scanHistoryProvider);
      final saved = await readStream(savedScanHistoryProvider);

      expect(all, isEmpty);
      expect(saved, isEmpty);
    });

    test('scanHistoryProvider berisi semua, savedScanHistoryProvider hanya yang disave', () async {
      final repo = container.read(scanHistoryRepositoryProvider);
      await repo.addScanHistory('hanya riwayat');
      await repo.addScanHistory('https://promo.com');

      final latest = (await repo.watchAll().first).first;
      await repo.save(latest.id, title: 'Promo');

      final all = await readStream(scanHistoryProvider);
      final saved = await readStream(savedScanHistoryProvider);

      expect(all, hasLength(2));
      expect(saved, hasLength(1));
      expect(saved.first.content, 'https://promo.com');
      expect(saved.first.title, 'Promo');
    });
  });
}
