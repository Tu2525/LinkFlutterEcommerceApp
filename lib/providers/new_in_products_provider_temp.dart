import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/services/product_service.dart';
import '../models/product.dart';

final newInProductsProvider =
    StateNotifierProvider<NewInProductsNotifier, AsyncValue<List<Product>>>((
      ref,
    ) {
      return NewInProductsNotifier();
    });

class NewInProductsNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  NewInProductsNotifier() : super(const AsyncValue.loading()) {
    _loadNewInProducts();
  }

  Future<void> _loadNewInProducts() async {
    try {
      state = const AsyncValue.loading();
      final products = await ProductService.getNewInProducts();
      state = AsyncValue.data(products);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await _loadNewInProducts();
  }
}
