import 'package:flutter_riverpod/flutter_riverpod.dart';
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
final List<Product> _mockProducts = [];
