import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scanner_app/features/scanner/provider/scanner_qr_provider.dart';

void main() {
  group('ScannerQrNotifier', () {
    test('Initial value is null', () {
      final container = ProviderContainer.test();

      expect(container.read(scannerQrProvider), null);
    });

    test('Set new value to variable', () {
      final container = ProviderContainer.test();

      container.read(scannerQrProvider.notifier).setValue('youtube');

      expect(container.read(scannerQrProvider), 'youtube');
    });

    test('Reset to null after set new value to variable', () {
      final container = ProviderContainer.test();

      container.read(scannerQrProvider.notifier).setValue('youtube');
      container.read(scannerQrProvider.notifier).resetValue();

      expect(container.read(scannerQrProvider), null);
    });

    test('Listener received every changes', () {
      final container = ProviderContainer.test();
      final calls = <(String?, String?)>[];

      container.listen<String?>(
        scannerQrProvider,
        (prev, next) => calls.add((prev, next)),
      );

      container.read(scannerQrProvider.notifier).setValue('google');
      container.read(scannerQrProvider.notifier).setValue('facebook');

      expect(calls, [(null, 'google'), ('google', 'facebook')]);
    });

    test('Check autodispose', () {
      final container = ProviderContainer.test();
      container.listen(scannerQrProvider, (_, _) {});

      container.read(scannerQrProvider.notifier).setValue('youtube');

      expect(container.read(scannerQrProvider), 'youtube');
    });
  });
}
