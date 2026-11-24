import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/theme/app_padding.dart';
import '../provider/generate_qr_provider.dart';

class GenerateQrScreen extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<GenerateQrScreen> createState() => _GenerateQrScreenState();
}

class _GenerateQrScreenState extends ConsumerState<GenerateQrScreen> {
  late TextEditingController _textCtrl;

  @override
  void initState() {
    super.initState();

    _textCtrl = TextEditingController(text: ref.read(generateQrProvider));
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.lg),
        child: Column(
          spacing: AppPadding.md,
          children: [
            TextField(
              controller: _textCtrl,
              onChanged: (value) =>
                  ref.read(generateQrProvider.notifier).setText(value),
              decoration: const InputDecoration(hintText: 'Masukkan text'),
            ),

            Consumer(
              builder: (context, ref, child) {
                final qrData = ref.watch(generateQrProvider);

                if (qrData.isEmpty) {
                  return const Text('QR akan tampil di sini');
                }

                return QrImageView(
                  data: qrData,
                  version: QrVersions.auto,
                  size: 220,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
