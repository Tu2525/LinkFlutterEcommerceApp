import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/utils/mock_product_data.dart';
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
    imageUrls: ['assets/images/hoodie5.png'],
    category: 'Hoodies',
    rating: 5,
    reviews: [placeHolderReview],
    description: 'test',
  ),
  Product(
    id: '6',
    name: "Women's Trendy Hoodie",
    price: 135.50,
    imageUrls: ['assets/images/hoodie6.png'],
    category: 'Hoodies',
    rating: 5,
    reviews: [placeHolderReview],
    description: 'test',
  ),
  Product(
    id: '7',
    name: "Kids' Colorful Hoodie",
    price: 90.0,
    imageUrls: ['assets/images/hoodie7.png'],
    category: 'Hoodies',
    rating: 5,
    reviews: [placeHolderReview],
    description: 'test',
  ),
  Product(
    id: '8',
    name: "Unisex Modern Hoodie",
    price: 140.0,
    imageUrls: ['assets/images/hoodie8.png'],
    category: 'Hoodies',
    rating: 5,
    reviews: [placeHolderReview],
    description: 'test',
  ),
];
