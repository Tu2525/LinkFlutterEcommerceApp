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

final List<Product> _mockTopSellingProducts = [
  Product(
    id: '1',
    name: "Men's Fleece Pullover Hoodie",
    price: 100.0,
    imageUrl: 'assets/images/hoodie1.png',
    category: 'Hoodies',
  ),
  Product(
    id: '2',
    name: "Fleece Pullover Skate Hoodie",
    price: 150.97,
    imageUrl: 'assets/images/hoodie2.png',
    category: 'Hoodies',
  ),
  Product(
    id: '3',
    name: "Fleece Skate Hoodie",
    price: 110.0,
    imageUrl: 'assets/images/hoodie3.png',
    category: 'Hoodies',
  ),
  Product(
    id: '4',
    name: "Men's Ice-Dye Pullover Hoodie",
    price: 128.97,
    imageUrl: 'assets/images/hoodie4.png',
    category: 'Hoodies',
  ),
];
