import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scanner_app/features/generate/provider/generate_qr_provider.dart';

void main() {
  group('GenerateQrNotifier', () {
    test('Initial value is empty string', () {
      final container = ProviderContainer.test();

      expect(container.read(generateQrProvider), '');
    });

    test('Change state when set new value', () {
      final container = ProviderContainer.test();

      container.read(generateQrProvider.notifier).setText('Hello');

      expect(container.read(generateQrProvider), 'Hello');
    });

    test('Called set text 2 times, and return last new value', () {
      final container = ProviderContainer.test();

      container.read(generateQrProvider.notifier).setText('Hello');
      container.read(generateQrProvider.notifier).setText('World');

      expect(container.read(generateQrProvider), 'World');
    });
  });
}
