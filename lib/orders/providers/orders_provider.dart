import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/orders/models/order_model.dart';
import 'package:link_flutter_ecommerce_app/orders/services/order_service.dart';

final orderDetailsProvider = Provider<OrderService>((ref) => OrderService());

final selectedOrderProvider = StateProvider<OrderModel?>((ref) => null);

final selectedStatusProvider = StateProvider<String>((ref) => 'Processing');

final orderProvider = FutureProvider<List<OrderModel>>((ref) {
  final api = ref.watch(orderDetailsProvider);
  return api.getOrderDetails();
});

final ordersStreamProvider = StreamProvider<List<OrderModel>>((ref) {
  final api = ref.watch(orderDetailsProvider);
  return api.getOrdersStream();
});
