import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/models/notification_model.dart';
import 'package:link_flutter_ecommerce_app/services/notification_service.dart';

final notificationDetailsProvider = Provider<NotificationService>((ref) => NotificationService());

final notificationProvider = FutureProvider<List<NotificationModel>>((ref) {
  final api = ref.watch(notificationDetailsProvider);
  log("${api.fetchNotificationData()}");
  return api.fetchNotificationData();
});
