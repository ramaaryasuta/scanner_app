import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../data/scan_history_repository.dart';

final scanHistoryRepositoryProvider = Provider<ScanHistoryRepository>((ref) {
  return ScanHistoryRepository(ref.watch(databaseProvider));
});

final scanHistoryProvider = StreamProvider<List<ScanRecord>>((ref) {
  return ref.watch(scanHistoryRepositoryProvider).watchAll();
});

final savedScanHistoryProvider = StreamProvider<List<ScanRecord>>((ref) {
  return ref.watch(scanHistoryRepositoryProvider).watchSaved();
});
