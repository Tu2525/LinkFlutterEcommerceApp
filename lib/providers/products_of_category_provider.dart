import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/utils/mock_product_data.dart';
import '../models/product.dart';

// This provider will be ready to connect to Firebase in the future.
final productsOfCategoryProvider = StateNotifierProvider.family<
  ProductsOfCategoryNotifier,
  List<Product>,
  String
>((ref, category) {
  // For now, use mock data. Replace with Firebase fetch in the future.
  return ProductsOfCategoryNotifier(category);
});

class ProductsOfCategoryNotifier extends StateNotifier<List<Product>> {
  final String category;
  ProductsOfCategoryNotifier(this.category)
    : super(_mockProducts.where((p) => p.category == category).toList());

  // In the future, add methods to fetch from Firebase
}

// Mock data for now
final List<Product> _mockProducts = [
  Product(
    id: '1',
    name: "Men's Fleece Pullover Hoodie",
    price: 100.0,
    imageUrls: ['assets/images/hoodie1.png'],
    category: 'Hoodies', rating: 5, reviews: [placeHolderReview], description: 'test'
  ),
  Product(
    id: '2',
    name: "Fleece Pullover Skate Hoodie",
    price: 150.97,
    imageUrls: ['assets/images/hoodie2.png'],
    category: 'Hoodies', rating: 5, reviews: [placeHolderReview], description: 'test'
  ),
  Product(
    id: '1',
    name: "Men's Fleece Pullover Hoodie",
    price: 100.0,
    imageUrls: ['assets/images/hoodie1.png'],
    category: 'Hoodies', rating: 5, reviews: [placeHolderReview], description: 'test'
  ),
  Product(
    id: '2',
    name: "Fleece Pullover Skate Hoodie",
    price: 150.97,
    imageUrls: ['assets/images/hoodie2.png'],
    category: 'Hoodies', rating: 5, reviews: [placeHolderReview], description: 'test'
  ),
  Product(
    id: '3',
    name: "Fleece Skate Hoodie",
    price: 110.0,
    imageUrls: ['assets/images/hoodie3.png'],
    category: 'Hoodies', rating: 5, reviews: [placeHolderReview], description: 'test'
  ),
  Product(
    id: '4',
    name: "Men's Ice-Dye Pullover Hoodie",
    price: 128.97,
    imageUrls: ['assets/images/hoodie4.png'],
    category: 'Hoodies', rating: 5, reviews: [placeHolderReview], description: 'test'
  ),
];
