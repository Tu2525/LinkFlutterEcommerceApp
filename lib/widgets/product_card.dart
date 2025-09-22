import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/providers/favourites_provider.dart';
import '../constants/app_colors.dart';
import '../models/product.dart';

class ProductCard extends ConsumerWidget {
  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;
  final double? width;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onFavoriteToggle,
    this.width,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final favorites = ref.watch(favoritesProvider);
    final isFav = favorites.contains(product.id);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 160,
        height: 250,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: AppColors.cardBackgroundColor(isDarkMode),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section with fixed height
            SizedBox(
              height: 160,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  color: AppColors.cardBackgroundColor(isDarkMode),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: product.imageUrls != null &&
                              product.imageUrls!.isNotEmpty
                          ? Image.network(
                              product.imageUrls![0],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return _buildPlaceholder(context);
                              },
                            )
                          : _buildPlaceholder(context),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: onFavoriteToggle,
                        child: Icon(
                          isFav
                              ? IconsaxPlusBold.heart
                              : IconsaxPlusBroken.heart,
                          color: isFav
                              ? Colors.red
                              : colorScheme.onSurface.withValues(alpha: 0.7),
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Content section with remaining space
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Product name with constrained height
                    Expanded(
                      child: Text(
                        product.name,
                        style: AppTextStyles.subTitle2(isDarkMode),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Price section with minimal space
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: AppTextStyles.heading6(isDarkMode),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (product.isOnSale) ...[
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              '\$${product.originalPrice!.toStringAsFixed(2)}',
                              style: AppTextStyles.faintGrey2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bool isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      color: AppColors.surfaceColor(isDarkMode),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              IconsaxPlusBroken.image,
              size: 48,
              color: colorScheme.onSurface.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 8),
            const Text('No Image', style: AppTextStyles.faintGrey2),
          ],
        ),
      ),
    );
  }
}