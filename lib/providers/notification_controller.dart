import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/models/notification_model.dart';

class NotificationController extends ChangeNotifier {
  final List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications => List.unmodifiable(_notifications);

  NotificationController() {
    _getNotificationData();
  }

  void _getNotificationData() {
    Future.delayed(const Duration(seconds: 3), () {
      addNotification(NotificationModel(
        message: "Gilbert, you placed an order. Check your order history for full details.",
        isImportant: true,
      ));
      addNotification(NotificationModel(
        message: "Gilbert, Thank you for shopping with us. We have canceled order #24568.",
      ));
      addNotification(NotificationModel(
        message: "Gilbert, your Order #24568 has been confirmed. Check your order history to see it.",
      ));
    });
  }

  void addNotification(NotificationModel notification) {
    _notifications.add(notification);
    notifyListeners();
  }

  void clearNotifications() {
    _notifications.clear();
    notifyListeners();
  }
}
