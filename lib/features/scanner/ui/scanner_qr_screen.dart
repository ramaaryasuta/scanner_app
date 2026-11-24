import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/theme/app_padding.dart';
import '../../history/provider/history_provider.dart';
import '../provider/camera_permission_provider.dart';
import '../provider/scanner_qr_provider.dart';
import 'camera_permission_view.dart';

class ScannerQrScreen extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<ScannerQrScreen> createState() => _ScannerQrScreenState();
}

class _ScannerQrScreenState extends ConsumerState<ScannerQrScreen> {
  final _scannerCtrl = MobileScannerController();
  late final AppLifecycleListener _lifecycleListener;

  @override
  void initState() {
    super.initState();
    _lifecycleListener = AppLifecycleListener(onResume: _onAppResumed);
  }

  @override
  void dispose() {
    _scannerCtrl.dispose();
    _lifecycleListener.dispose();
    super.dispose();
  }

  Future<void> _onAppResumed() async {
    final isPermissionError =
        _scannerCtrl.value.error?.errorCode ==
        MobileScannerErrorCode.permissionDenied;
    if (!isPermissionError) return;

    ref.invalidate(cameraPermanentlyDeniedProvider);

    if (await Permission.camera.isGranted) {
      if (!mounted) return;
      await _scannerCtrl.start();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<String?>(scannerQrProvider, (prev, data) async {
      if (data == null) return;

      try {
        await ref.read(scanHistoryRepositoryProvider).addScanHistory(data);
      } catch (e, s) {
        debugPrint('addScanHistory failed: $e\n$s');
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal menyimpan riwayat scan')),
        );
      }

      if (!context.mounted) return;
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
                SelectableText(data),
                ElevatedButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: data));
                  },
                  child: const Text('Salin Text'),
                ),
              ],
            ),
          );
        },
      );

      // execute after bottomsheet closed
      if (!context.mounted) return;

      // reset state
      ref.read(scannerQrProvider.notifier).resetValue();
      await _scannerCtrl.start();
    });

    return MobileScanner(
      controller: _scannerCtrl,
      placeholderBuilder: (context) =>
          const Center(child: Text('Memuat Kamera...')),
      errorBuilder: (context, error) => switch (error.errorCode) {
        MobileScannerErrorCode.permissionDenied => CameraPermissionView(
          onRequestPermission: () => _scannerCtrl.start(),
        ),
        _ => ColoredBox(
          color: Colors.black,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: AppPadding.md,
              children: [
                Text(
                  error.errorCode.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
                FilledButton(
                  onPressed: () => _scannerCtrl.start(),
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          ),
        ),
      },
      onDetect: (BarcodeCapture capture) async {
        final newValue = capture.barcodes.firstOrNull?.rawValue;

        if (newValue == null) return;

        final current = ref.read(scannerQrProvider);
        if (current == newValue) return;

        ref.read(scannerQrProvider.notifier).setValue(newValue);
        await _scannerCtrl.stop();
      },
      overlayBuilder: (context, constraints) {
        return _OverlayCameraContent(scannerCtrl: _scannerCtrl);
      },
    );
  }
}

class _OverlayCameraContent extends StatelessWidget {
  const new({required this._scannerCtrl});

  final MobileScannerController _scannerCtrl;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<MobileScannerState>(
      valueListenable: _scannerCtrl,
      builder: (context, state, _) {
        if (!state.isRunning) {
          return const Center(child: Text('Kamera dijeda'));
        }

        return Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.md),
                child: Builder(
                  builder: (context) {
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
