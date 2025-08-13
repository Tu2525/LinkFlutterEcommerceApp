import 'package:firebase_auth/firebase_auth.dart';
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

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final ordersStreamProvider = StreamProvider<List<OrderModel>>((ref) {
  final authState = ref.watch(authStateChangesProvider);

  if (authState.asData?.value != null) {
    final api = ref.watch(orderDetailsProvider);
    return api.getOrdersStream();
  }

  return Stream.value([]);
});
