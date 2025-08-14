import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_remote_data_source.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<List<Order>> getOrdersStream() {
    return remoteDataSource.getOrdersStream().map((orderModels) {
      return orderModels.map((model) => model as Order).toList();
    });
  }
  
  @override
  Future<List<Order>> getOrderDetails() async {
    final orderModels = await remoteDataSource.getOrderDetails();
    return orderModels.map((model) => model as Order).toList();
  }

  @override
  Future<Order> getOrderById(String orderId) async {
    final orderModel = await remoteDataSource.getOrderById(orderId);
    return orderModel as Order;
  }

  @override
  Future<void> createOrder(Order order) async {
    final orderModel = OrderModel(
      key: order.key,
      userId: order.userId,
      createdAt: order.createdAt,
      status: order.status,
      totalAmount: order.totalAmount,
      items: order.items
          .map((item) => OrderItemModel(
                name: item.name,
                quantity: item.quantity,
                price: item.price,
                imageUrl: item.imageUrl,
                productId: item.productId,
              ))
          .toList(),
      steps: order.steps
          .map((step) => OrderStepModel(
                title: step.title,
                isChecked: step.isChecked,
                date: step.date,
              ))
          .toList(),
      shipping: ShippingInfoModel(address: order.shipping.address),
    );
    await remoteDataSource.createOrder(orderModel);
  }

  @override
  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    await remoteDataSource.updateOrderStatus(orderId, newStatus);
  }

  @override
  Future<void> updateOrderStep(
      {required String orderId,
      required int stepIndex,
      required bool isChecked,
      required String date}) async {
    await remoteDataSource.updateOrderStep(
        orderId: orderId,
        stepIndex: stepIndex,
        isChecked: isChecked,
        date: date);
  }
}