import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';

import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';

import 'package:link_flutter_ecommerce_app/widgets/ProductDetailsWidgets/reviewItem.dart';
import 'package:link_flutter_ecommerce_app/providers/product_screen_providers.dart';

class ReviewsSection extends ConsumerWidget {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {



    final product = ref.watch(productProvider);

    final double totalRating =
        product.reviews.isEmpty
            ? 0.0
            : product.reviews.map((r) => r.rating).reduce((a, b) => a + b) /
                product.reviews.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.review,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text(

              '${totalRating.toStringAsFixed(1)} ${AppLocalizations.of(context)!.rating} ',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            Text(
              '${product.reviewCount} ${AppLocalizations.of(context)!.reviewers}',
              style: AppTextStyles.review,
     
            const SizedBox(width: 8),

            ),
          ],
        ),
        const SizedBox(height: 16),
        ...product.reviews.map((review) => ReviewItem(review: review)),
      ],
    );
  }
}
