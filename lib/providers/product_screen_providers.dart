// A provider to expose our product data.
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/models/product.dart';
import 'package:link_flutter_ecommerce_app/utils/mock_product_data.dart';


//Provider for our product data
final Product mockProduct = MockProductData.getTopSellingProducts()[0];
final productProvider = Provider<Product>((ref) => mockProduct);

// StateProvider for the selected size. >>Might be opted out
final sizeProvider = StateProvider<String>((ref) => 'S');

// StateProvider for the selected color. >>Might be opted out
final colorProvider = StateProvider<Color>((ref) => const Color(0xFFA3B18A));

// StateProvider for the quantity.
final quantityProvider = StateProvider<int>((ref) => 1);

// Provider to calculate the total price based on quantity.
final totalPriceProvider = Provider<double>((ref) {
  final product = ref.watch(productProvider);
  final quantity = ref.watch(quantityProvider);
  return product.price * quantity;
});
