import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

final newInProductsProvider =
    StateNotifierProvider<NewInProductsNotifier, List<Product>>((ref) {
      // Replace with real fetch logic or Firebase integration in the future
      return NewInProductsNotifier();
    });

class NewInProductsNotifier extends StateNotifier<List<Product>> {
  NewInProductsNotifier() : super(_mockNewInProducts);

  // Add methods for fetching, filtering, etc. as needed
}

final List<Product> _mockNewInProducts = [
  Product(
    id: '5',
    name: "Men's New Arrival Hoodie",
    price: 120.0,
    imageUrl: 'assets/images/hoodie5.png',
    category: 'Hoodies',
  ),
  Product(
    id: '6',
    name: "Women's Trendy Hoodie",
    price: 135.50,
    imageUrl: 'assets/images/hoodie6.png',
    category: 'Hoodies',
  ),
  Product(
    id: '7',
    name: "Kids' Colorful Hoodie",
    price: 90.0,
    imageUrl: 'assets/images/hoodie7.png',
    category: 'Hoodies',
  ),
  Product(
    id: '8',
    name: "Unisex Modern Hoodie",
    price: 140.0,
    imageUrl: 'assets/images/hoodie8.png',
    category: 'Hoodies',
  ),
];
