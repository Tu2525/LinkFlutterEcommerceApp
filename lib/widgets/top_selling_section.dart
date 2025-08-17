import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/screens/product_details_screen.dart';
import 'package:link_flutter_ecommerce_app/screens/see_all_products_screen.dart';
import '../models/product.dart';
import 'product_card.dart';

class TopSellingSection extends ConsumerWidget {
  final String title;
  final VoidCallback? onSeeAllTap;
  final Function(Product)? onProductTap;
  final Function(Product)? onFavoriteToggle;
  final bool showSeeAll;
  final double? cardWidth;
  final StateNotifierProvider<
    StateNotifier<AsyncValue<List<Product>>>,
    AsyncValue<List<Product>>
  >
  provider;

  const TopSellingSection({
    super.key,
    this.title = 'Top Selling',
    this.onSeeAllTap,
    this.onProductTap,
    this.onFavoriteToggle,
    this.showSeeAll = true,
    this.cardWidth,
    required this.provider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final productsAsyncValue = ref.watch(provider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(title, style: AppTextStyles.subTitle1(isDarkMode)),
              ),
              if (showSeeAll)
                GestureDetector(
                  onTap:
                      onSeeAllTap ??
                      () {
                        final productType =
                            title.toLowerCase() ==
                                    AppLocalizations.of(context)!.newIn
                                ? AppLocalizations.of(context)!.newIn
                                : AppLocalizations.of(context)!.topSelling;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => SeeAllProductsScreen(
                                  productType: productType,
                                  title: title,
                                ),
                          ),
                        );
                      },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      AppLocalizations.of(context)!.seeAll,
                      style: AppTextStyles.seeAll(isDarkMode),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 260,
          child: productsAsyncValue.when(
            data:
                (products) =>
                    products.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: products.length > 4 ? 4 : products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return ProductCard(
                              product: product,
                              width: cardWidth,
                              onTap:
                                  () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => ProductDetailsScreen(
                                            product: product,
                                          ),
                                    ),
                                  ),
                              onFavoriteToggle:
                                  () => onFavoriteToggle?.call(product),
                            );
                          },
                        ),
            loading: () => _buildLoadingState(),
            error: (error, stackTrace) => _buildErrorState(error),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildErrorState(Object error) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.somethingWentWrong,
                style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        );
      },
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
                color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
              ),
              const SizedBox(height: 16),
              Text(
                'No products available',
                style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
