import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/order_remote_data_source.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../../domain/usecases/create_order.dart';
import '../../domain/usecases/get_order_by_id.dart';
import '../../domain/usecases/get_order_details.dart';
import '../../domain/usecases/get_orders_stream.dart';

final orderRemoteDataSourceProvider = Provider<OrderRemoteDataSource>((ref) {
  return OrderRemoteDataSourceImpl();
});

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final remoteDataSource = ref.watch(orderRemoteDataSourceProvider);
  return OrderRepositoryImpl(remoteDataSource: remoteDataSource);
});

final createOrderUseCaseProvider = Provider<CreateOrderUseCase>((ref) {
  final repository = ref.watch(orderRepositoryProvider);
  return CreateOrderUseCase(repository);
});

final getOrdersStreamUseCaseProvider = Provider<GetOrdersStreamUseCase>((ref) {
  final repository = ref.watch(orderRepositoryProvider);
  return GetOrdersStreamUseCase(repository);
});

final getOrderDetailsUseCaseProvider = Provider<GetOrderDetailsUseCase>((ref) {
  final repository = ref.watch(orderRepositoryProvider);
  return GetOrderDetailsUseCase(repository);
});

final getOrderByIdUseCaseProvider = Provider<GetOrderByIdUseCase>((ref) {
  final repository = ref.watch(orderRepositoryProvider);
  return GetOrderByIdUseCase(repository);
});

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final selectedStatusProvider = StateProvider<String>((ref) => 'Processing');

final selectedOrderProvider = StateProvider<Order?>((ref) => null);

final orderDetailsProvider = FutureProvider<List<Order>>((ref) {
  final getOrderDetails = ref.watch(getOrderDetailsUseCaseProvider);
  return getOrderDetails();
});

final orderByIdProvider =
    FutureProvider.family<Order, String>((ref, orderId) {
  final getOrderByIdUseCase = ref.watch(getOrderByIdUseCaseProvider);
  return getOrderByIdUseCase(orderId);
});

final ordersStreamProvider = StreamProvider<List<Order>>((ref) {
  final authState = ref.watch(authStateChangesProvider);

  if (authState.asData?.value != null) {
    final getOrdersStream = ref.watch(getOrdersStreamUseCaseProvider);
    return getOrdersStream();
  }

  return Stream.value([]);
});