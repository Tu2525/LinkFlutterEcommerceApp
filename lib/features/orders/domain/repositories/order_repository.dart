import '../entities/order.dart';

abstract class OrderRepository {
  Stream<List<Order>> getOrdersStream();

  Future<void> createOrder(Order order);

  Future<void> updateOrderStatus(String orderId, String newStatus);

  Future<List<Order>> getOrderDetails();

  Future<Order> getOrderById(String orderId);

  Future<void> updateOrderStep({
    required String orderId,
    required int stepIndex,
    required bool isChecked,
    required String date,
  });
}
