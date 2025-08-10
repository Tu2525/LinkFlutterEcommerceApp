import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/models/notification_model.dart';
import 'package:link_flutter_ecommerce_app/services/notification_service.dart';

final notificationDetailsProvider = Provider<NotificationService>(
  (ref) => NotificationService(),
);

// Use StreamProvider for real-time updates
final notificationProvider = StreamProvider<List<NotificationModel>>((ref) {
  final api = ref.watch(notificationDetailsProvider);
  log("Setting up real-time notification stream");
  return api.getNotificationStreamWithAuth();
});

// Keep the old provider as backup for one-time fetching if needed
final notificationFutureProvider = FutureProvider<List<NotificationModel>>((
  ref,
) {
  final api = ref.watch(notificationDetailsProvider);
  log("${api.fetchNotificationData()}");
  return api.fetchNotificationData();
});

// Provider for marking notification as read
final markNotificationAsReadProvider = FutureProvider.family<void, String>((
  ref,
  notificationId,
) {
  final api = ref.watch(notificationDetailsProvider);
  return api.markNotificationAsRead(notificationId);
});

// Provider for deleting notification
final deleteNotificationProvider = FutureProvider.family<void, String>((
  ref,
  notificationId,
) {
  final api = ref.watch(notificationDetailsProvider);
  return api.deleteNotification(notificationId);
});
