import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import '../models/product.dart';
import 'product_card.dart';

class TopSellingSection extends StatelessWidget {
  final List<Product> products;
  final String title;
  final VoidCallback? onSeeAllTap;
  final Function(Product)? onProductTap;
  final Function(Product)? onFavoriteToggle;
  final bool showSeeAll;
  final double? cardWidth;
  final double? cardHeight;
  final double? sectionHeight;

  const TopSellingSection({
    super.key,
    required this.products,
    this.title = 'Top Selling',
    this.onSeeAllTap,
    this.onProductTap,
    this.onFavoriteToggle,
    this.showSeeAll = true,
    this.cardWidth,
    this.cardHeight,
    this.sectionHeight,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  title,
                  style: AppTextStyles.sectionTitle(isDarkMode),
                ),
              ),
              if (showSeeAll)
                GestureDetector(
                  onTap: onSeeAllTap,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'See All',
                      style: AppTextStyles.seeAll(isDarkMode),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Products List
        SizedBox(
          height: sectionHeight ?? 281,
          child:
              products.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(
                        cardColor:
                            theme.brightness == Brightness.dark
                                ? const Color(0xFF342F3F)
                                : const Color(0xFFF4F4F4),
                        product: product,
                        width: cardWidth,
                        height: cardHeight,
                        onTap: () => onProductTap?.call(product),
                        onFavoriteToggle: () => onFavoriteToggle?.call(product),
                      );
                    },
                  ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_bag_outlined,
                size: 48,
                color: theme.colorScheme.onSurface.withOpacity(0.4),
              ),
              const SizedBox(height: 16),
              Text(
                'No products available',
                style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Check back later for new items',
                style: TextStyle(
                  fontSize: 14,
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
