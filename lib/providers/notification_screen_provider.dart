import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'notification_controller.dart';

final notificationProvider = ChangeNotifierProvider.autoDispose<NotificationController>((ref) {
  return NotificationController();
});
