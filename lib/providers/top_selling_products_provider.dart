import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

final topSellingProductsProvider =
    StateNotifierProvider<TopSellingProductsNotifier, List<Product>>((ref) {
      // Replace with real fetch logic or Firebase integration in the future
      return TopSellingProductsNotifier();
    });

class TopSellingProductsNotifier extends StateNotifier<List<Product>> {
  TopSellingProductsNotifier() : super(_mockTopSellingProducts);

  // Add methods for fetching, filtering, etc. as needed
}

final List<Product> _mockTopSellingProducts = [];
