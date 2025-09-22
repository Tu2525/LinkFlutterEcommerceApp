import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/services/product_service.dart';
import '../models/product.dart';

// Provider for products by category
final productsByCategoryProvider = StateNotifierProvider.family<
  ProductsByCategoryNotifier,
  AsyncValue<List<Product>>,
  String
>((ref, categoryId) {
  return ProductsByCategoryNotifier(categoryId);
});

class ProductsByCategoryNotifier
    extends StateNotifier<AsyncValue<List<Product>>> {
  final String categoryId;

  ProductsByCategoryNotifier(this.categoryId)
    : super(const AsyncValue.loading()) {
    _loadProductsByCategory();
  }

  Future<void> _loadProductsByCategory() async {
    try {
      state = const AsyncValue.loading();
      final products = await ProductService.getProductsByCategory(categoryId);
      state = AsyncValue.data(products);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await _loadProductsByCategory();
  }
}
