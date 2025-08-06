import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/services/product_service.dart';
import '../models/product.dart';

final topSellingProductsProvider = StateNotifierProvider<
  TopSellingProductsNotifier,
  AsyncValue<List<Product>>
>((ref) {
  return TopSellingProductsNotifier();
});

class TopSellingProductsNotifier
    extends StateNotifier<AsyncValue<List<Product>>> {
  TopSellingProductsNotifier() : super(const AsyncValue.loading()) {
    _loadTopSellingProducts();
  }

  Future<void> _loadTopSellingProducts() async {
    try {
      state = const AsyncValue.loading();
      final products = await ProductService.getTopSellingProducts();
      state = AsyncValue.data(products);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await _loadTopSellingProducts();
  }
}

// final List<Product> _mockTopSellingProducts = [
//   Product(
//     id: '1',
//     name: "Men's Fleece Pullover Hoodie",
//     price: 100.0,
//     imageUrl: 'assets/images/hoodie1.png',
//     category: 'Hoodies',
//   ),
//   Product(
//     id: '2',
//     name: "Fleece Pullover Skate Hoodie",
//     price: 150.97,
//     imageUrl: 'assets/images/hoodie2.png',
//     category: 'Hoodies',
//   ),
//   Product(
//     id: '3',
//     name: "Fleece Skate Hoodie",
//     price: 110.0,
//     imageUrl: 'assets/images/hoodie3.png',
//     category: 'Hoodies',
//   ),
//   Product(
//     id: '4',
//     name: "Men's Ice-Dye Pullover Hoodie",
//     price: 128.97,
//     imageUrl: 'assets/images/hoodie4.png',
//     category: 'Hoodies',
//   ),
// ];
