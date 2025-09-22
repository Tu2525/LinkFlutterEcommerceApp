import '../entities/order.dart';
import '../repositories/order_repository.dart';

class GetOrderDetailsUseCase {
  final OrderRepository repository;

  GetOrderDetailsUseCase(this.repository);

  Future<List<Order>> call() async {
    return repository.getOrderDetails();
  }
}