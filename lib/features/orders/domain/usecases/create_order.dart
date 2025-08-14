// lib/features/orders/domain/usecases/create_order.dart

import 'dart:math';
import 'package:intl/intl.dart';
import 'package:link_flutter_ecommerce_app/models/cartitem_model.dart';
import '../entities/order.dart';
import '../repositories/order_repository.dart';

class CreateOrderUseCase {
  final OrderRepository repository;

  CreateOrderUseCase(this.repository);

  // CHANGE: This now returns the created Order object
  Future<Order> call({
    required List<CartItem> cartItems,
    required ShippingInfo shipping,
    required String userId,
  }) async {
    final orderItems =
        cartItems.map((item) => OrderItem(
          name: item.name,
          quantity: item.quantity,
          price: item.price,
          imageUrl: item.imageUrl,
          productId: item.id,
        )).toList();

    final totalAmount = cartItems.fold<double>(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    final orderSteps = [
      OrderStep(title: 'Order Placed', isChecked: true, date: DateFormat('dMMM').format(DateTime.now())),
      OrderStep(title: 'Processing', isChecked: false, date: DateFormat('dMMM').format(DateTime.now())),
      OrderStep(title: 'Shipped', isChecked: false, date: DateFormat('dMMM').format(DateTime.now())),
      OrderStep(title: 'Delivered', isChecked: false, date: DateFormat('dMMM').format(DateTime.now())),
    ];

    final order = Order(
      key: Random().nextInt(999999).toString(),
      items: orderItems,
      steps: orderSteps,
      shipping: shipping,
      status: 'Processing',
      userId: userId,
      createdAt: DateTime.now(),
      totalAmount: totalAmount,
    );
    
    await repository.createOrder(order);

    return order;
  }
}