import 'package:flutter_riverpod/flutter_riverpod.dart';

final scannerQrProvider =
    NotifierProvider.autoDispose<ScannerQrNotifier, String?>(
      ScannerQrNotifier.new,
    );

class ScannerQrNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void setValue(String value) {
    state = value;
  }

  void resetValue() => state = null;
}
