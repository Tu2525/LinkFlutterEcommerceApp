import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/widgets/ProductDetailsWidgets/reviewItem.dart';
import 'package:link_flutter_ecommerce_app/providers/product_screen_providers.dart';
class ReviewsSection extends ConsumerWidget {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final product = ref.watch(productProvider);

    final double totalRating = product.reviews.isEmpty
        ? 0.0
        : product.reviews.map((r) => r.rating).reduce((a, b) => a + b) /
            product.reviews.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reviews',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text(
              '${totalRating.toStringAsFixed(1)} Ratings',
              style: AppTextStyles.heading4(isDarkMode),
            ),
            const SizedBox(width: 8),
            Text(
              '${product.reviewCount} Reviews',
              style: AppTextStyles.review,
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...product.reviews.map((review) => ReviewItem(review: review)),
      ],
    );
  }
}