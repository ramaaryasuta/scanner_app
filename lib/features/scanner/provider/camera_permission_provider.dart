import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final cameraPermanentlyDeniedProvider = FutureProvider.autoDispose<bool>((
  ref,
) async {
  final status = await Permission.camera.status;
  return status.isPermanentlyDenied;
});
