import 'dart:async';

import 'package:link_flutter_ecommerce_app/models/notification_model.dart';

class OrderService {
  Future<NotificationModel> getOrderDetails() async {
    await Future.delayed(const Duration(seconds: 1)); 

    return NotificationModel(
      message: "Gilbert, you placed and order check your order history for full details",
      isImportant: true,
    );
  }
}