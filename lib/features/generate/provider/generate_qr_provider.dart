import 'package:flutter_riverpod/flutter_riverpod.dart';

final generateQrProvider = NotifierProvider<GenerateQrNotifier, String>(
  GenerateQrNotifier.new,
);

class GenerateQrNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setText(String newText) {
    state = newText;
  }
}
