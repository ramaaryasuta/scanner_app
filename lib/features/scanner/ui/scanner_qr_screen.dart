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
          return SizedBox(
            width: 440,
            child: Column(
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
    );
  }
}
