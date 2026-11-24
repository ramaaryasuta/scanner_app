import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/theme/app_padding.dart';
import '../provider/camera_permission_provider.dart';

class CameraPermissionView extends ConsumerWidget {
  const new({super.key, required this.onRequestPermission});

  final VoidCallback onRequestPermission;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permanentlyDeniedAsync = ref.watch(cameraPermanentlyDeniedProvider);

    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: AppPadding.md,
            children: [
              const Icon(
                Icons.no_photography_rounded,
                color: Colors.white,
                size: 48,
              ),
              const Text(
                'Akses kamera dibutuhkan untuk memindai QR',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              switch (permanentlyDeniedAsync) {
                AsyncLoading() => const CircularProgressIndicator(
                  color: Colors.white,
                ),
                AsyncData(value: true) => FilledButton(
                  onPressed: () => openAppSettings(),
                  child: const Text('Buka Pengaturan'),
                ),
                _ => FilledButton(
                  onPressed: onRequestPermission,
                  child: const Text('Izinkan Kamera'),
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}
