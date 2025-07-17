import 'package:flutter/material.dart';
import '../models/product.dart';
import 'top_selling_section.dart';

class HorizontalList extends StatelessWidget {
  final String title;
  final List<Product> products;
  final VoidCallback? onSeeAllTap;
  final Function(Product)? onProductTap;
  final Function(Product)? onFavoriteToggle;

  const HorizontalList({
    super.key,
    required this.title,
    required this.products,
    this.onSeeAllTap,
    this.onProductTap,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return TopSellingSection(
      products: products,
      title: title,
      onSeeAllTap:
          onSeeAllTap ??
          () {
            // Navigate to see all products page
            print('See all products tapped');
          },
      onProductTap:
          onProductTap ??
          (product) {
            // Navigate to product details page
            print('Product tapped: ${product.name}');
          },
      onFavoriteToggle:
          onFavoriteToggle ??
          (product) {
            // Handle favorite toggle - update API/database
            print('Favorite toggled for: ${product.name}');
          },
    );
  }
}
