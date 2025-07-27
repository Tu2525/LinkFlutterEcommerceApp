import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/models/notification_model.dart';

class NotificationNotifier extends Notifier<List<NotificationModel>> {
@override
List<NotificationModel> build() {
  state=[];
  Future.delayed(const Duration(seconds: 3), () {  
      addNotification(NotificationModel(
      message: "Gilbert, you placed an order. Check your order history for full details.",
      isImportant: true,
    ));
        addNotification(NotificationModel(
    message: "Gilbert, Thank you for shopping with us. We have canceled order #24568.",
    ));
    addNotification(NotificationModel(
      message: "Gilbert, your Order #24568 has been confirmed. check your order history for see ittttttttttttttttttt",
    ));
  });

  return state;
}

void addNotification(NotificationModel notification) {
    state = [...state, notification];
  }
}

final notificationProvider =
    NotifierProvider<NotificationNotifier, List<NotificationModel>>(() {
  return NotificationNotifier();
});