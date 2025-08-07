import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/models/notification_model.dart';
import 'package:link_flutter_ecommerce_app/services/notification_service.dart';

final notificationDetailsProvider = Provider<NotificationService>(
  (ref) => NotificationService(),
);

// State notifier for manual refresh capability
class NotificationNotifier
    extends StateNotifier<AsyncValue<List<NotificationModel>>> {
  final NotificationService _notificationService;

  NotificationNotifier(this._notificationService)
    : super(const AsyncValue.loading()) {
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      state = const AsyncValue.loading();
      final notifications = await _notificationService.fetchNotificationData();
      state = AsyncValue.data(notifications);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await fetchNotifications();
  }
}

final notificationProvider = StateNotifierProvider<
  NotificationNotifier,
  AsyncValue<List<NotificationModel>>
>((ref) {
  final api = ref.watch(notificationDetailsProvider);
  return NotificationNotifier(api);
});

// Keep the old provider for backward compatibility if needed
final notificationFutureProvider = FutureProvider<List<NotificationModel>>((
  ref,
) {
  final api = ref.watch(notificationDetailsProvider);
  log("${api.fetchNotificationData()}");
  return api.fetchNotificationData();
});

// Real-time notification provider using Stream
final realTimeNotificationProvider = StreamProvider<List<NotificationModel>>((
  ref,
) {
  final api = ref.watch(notificationDetailsProvider);
  return api.notificationStream();
});
