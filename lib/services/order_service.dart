import 'dart:async';
import 'package:link_flutter_ecommerce_app/models/order_model.dart';

class OrderService {
  Future<OrderModel> getOrderDetails() async {
    await Future.delayed(const Duration(seconds: 1)); 

    return OrderModel(
      id: '03545',
      items: [
        OrderItem(name: 'Shirt', quantity: 2),
        OrderItem(name: 'Jeans', quantity: 1),
        OrderItem(name: 'Sneakers', quantity: 1),
      ],
      steps: [
        OrderStep(title: 'Delivered', isChecked: false, date: '28 May'),
        OrderStep(title: 'Shipped', isChecked: true, date: '27 May'),
        OrderStep(title: 'Order confirmed', isChecked: true, date: '26 May'),
        OrderStep(title: 'Order placed', isChecked: true, date: '25 May'),
      ],
      shipping: ShippingInfo(
        name: 'Abdallah Atef',
        phone: '+20 1012345678',
        address: 'Nasr City, Cairo, Egypt',
      ),
    );
  }
}
