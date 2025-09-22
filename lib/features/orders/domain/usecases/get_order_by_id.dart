import '../entities/order.dart';
import '../repositories/order_repository.dart';

class GetOrderByIdUseCase {
  final OrderRepository repository;

  GetOrderByIdUseCase(this.repository);

  Future<Order> call(String orderId) {
    return repository.getOrderById(orderId);
  }
}