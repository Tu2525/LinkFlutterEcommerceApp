// A provider to expose our product data.
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/models/product.dart';

// 1. MODIFIED: This provider is now a placeholder.
// It must be overridden in the UI to provide the actual product.
final productProvider = Provider<Product>((ref) {
  // This error ensures that you don't forget to provide a product
  // on your details screen.
  throw UnimplementedError('productProvider must be overridden');
});

// 2. The rest of your providers stay the same.
// They will now work with whatever product is given to productProvider.

// StateProvider for the selected size.
final sizeProvider = StateProvider<String>((ref) => 'S');

// StateProvider for the selected color.
final colorProvider = StateProvider<Color>((ref) => const Color(0xFFA3B18A));

// StateProvider for the quantity.
final quantityProvider = StateProvider<int>((ref) => 1);

// Provider to calculate the total price based on quantity.
// Provider to calculate the total price based on quantity.
final totalPriceProvider = Provider<double>((ref) {
  final product = ref.watch(productProvider);
  final quantity = ref.watch(quantityProvider);
  return product.price * quantity;
},
// FIX: Add this dependencies array
dependencies: [productProvider, quantityProvider]);