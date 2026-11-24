import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../core/theme/app_padding.dart';
import '../provider/scanner_qr_provider.dart';

class ScannerQrScreen extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<ScannerQrScreen> createState() => _ScannerQrScreenState();
}

class _ScannerQrScreenState extends ConsumerState<ScannerQrScreen> {
  final _scannerCtrl = MobileScannerController();

  @override
  void dispose() {
    _scannerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<String?>(scannerQrProvider, (prev, next) async {
      if (next == null) return;

      await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(AppPadding.md),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: AppPadding.sm,
              children: [
                SelectableText(next),
                ElevatedButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: next));
                  },
                  child: const Text('Salin Text'),
                ),
              ],
            ),
          );
        },
      );

      // execute after bottomsheet closed
      if (!mounted) return;

      // reset state
      ref.read(scannerQrProvider.notifier).resetValue();
      await _scannerCtrl.start();
    });

    return MobileScanner(
      controller: _scannerCtrl,
      onDetect: (BarcodeCapture capture) async {
        final newValue = capture.barcodes.firstOrNull?.rawValue;

        if (newValue == null) return;

        final current = ref.read(scannerQrProvider);
        if (current == newValue) return;

        ref.read(scannerQrProvider.notifier).setValue(newValue);
        await _scannerCtrl.stop();
      },
      overlayBuilder: (context, constraints) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.md),
                child: ValueListenableBuilder<MobileScannerState>(
                  valueListenable: _scannerCtrl,
                  builder: (context, state, child) {
                    final (icon, color, isEnabled) = switch (state.torchState) {
                      TorchState.off => (
                        Icons.flash_off_rounded,
                        Colors.white,
                        true,
                      ),
                      TorchState.on => (
                        Icons.flash_on_rounded,
                        Colors.amber,
                        true,
                      ),
                      TorchState.auto => (
                        Icons.flash_auto_rounded,
                        Colors.white,
                        true,
                      ),
                      TorchState.unavailable => (
                        Icons.no_flash_rounded,
                        Colors.white38,
                        false,
                      ),
                    };

                    return IconButton(
                      tooltip: 'Senter',
                      color: color,
                      disabledColor: color,
                      onPressed: isEnabled
                          ? () => _scannerCtrl.toggleTorch()
                          : null,
                      icon: Icon(icon),
                    );
                  },
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.md,
                  vertical: AppPadding.sm,
                ),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(AppPadding.xl),
                ),
                child: const Text(
                  'Arahkan ke QR',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
