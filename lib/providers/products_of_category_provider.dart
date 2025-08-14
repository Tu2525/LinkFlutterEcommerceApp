import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/services/product_service.dart';
import '../models/product.dart';

// Provider for products by category using Firebase
final productsOfCategoryProvider = StateNotifierProvider.family<
  ProductsOfCategoryNotifier,
  AsyncValue<List<Product>>,
  String
>((ref, categoryId) {
  return ProductsOfCategoryNotifier(categoryId);
});

class ProductsOfCategoryNotifier
    extends StateNotifier<AsyncValue<List<Product>>> {
  final String categoryId;

  ProductsOfCategoryNotifier(this.categoryId)
    : super(const AsyncValue.loading()) {
    _loadProductsByCategory();
  }

  Future<void> _loadProductsByCategory() async {
    try {
      state = const AsyncValue.loading();
      print(
        '🔍 ProductsOfCategoryProvider: Loading products for categoryId: "$categoryId"',
      );
      final products = await ProductService.getProductsByCategory(categoryId);
      print(
        '🔍 ProductsOfCategoryProvider: Found ${products.length} products for categoryId: "$categoryId"',
      );
      state = AsyncValue.data(products);
    } catch (error, stackTrace) {
      print(
        '❌ ProductsOfCategoryProvider: Error loading products for categoryId: "$categoryId" - $error',
      );
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await _loadProductsByCategory();
  }
}
