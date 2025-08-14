import '../entities/order.dart';
import '../repositories/order_repository.dart';

class GetOrdersStreamUseCase {
  final OrderRepository repository;

  GetOrdersStreamUseCase(this.repository);

  Stream<List<Order>> call() {
    return repository.getOrdersStream();
  }
}