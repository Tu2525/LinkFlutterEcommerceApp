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

final List<Product> _mockNewInProducts = [];
