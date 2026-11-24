import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scanner_app/features/home/provider/home_provider.dart';

void main() {
  group('TabIndexNotifier', () {
    test('Initial value is 0', () {
      final container = ProviderContainer.test();

      expect(container.read(tabIndexProvider), 0);
    });

    test('Change value index', () {
      final container = ProviderContainer.test();

      container.read(tabIndexProvider.notifier).setActiveIndex(1);

      expect(container.read(tabIndexProvider), 1);
    });
  });
}
