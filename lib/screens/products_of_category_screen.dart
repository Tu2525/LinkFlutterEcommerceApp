import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import '../widgets/product_card.dart';
import '../providers/products_of_category_provider.dart';
import '../constants/app_colors.dart';
import 'product_details_screen.dart';

class ProductsOfCategoryScreen extends ConsumerWidget {
  final String categoryName;
  final String categoryId;
  const ProductsOfCategoryScreen({
    super.key,
    required this.categoryName,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsyncValue = ref.watch(
      productsOfCategoryProvider(
        categoryId, // Use categoryId instead of categoryName
      ), // Use categoryId instead of categoryName
    );
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          color: isDarkMode ? Colors.black : Colors.white,
          padding: const EdgeInsets.only(
            top: 32,
            left: 16,
            right: 16,
            bottom: 8,
          ),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                alignment: Alignment.centerLeft,
                child: Material(
                  color:
                      isDarkMode
                          ? const Color(0xFF342F3F)
                          : const Color(0xFFF4F4F4),
                  shape: const CircleBorder(),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () => Navigator.of(context).pop(),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(
                        IconsaxPlusBroken.arrow_left_2,
                        color: isDarkMode ? Colors.white : Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            productsAsyncValue.when(
              data:
                  (products) => Text(
                    '$categoryName (${products.length})',
                    style: AppTextStyles.heading5(isDarkMode),
                  ),
              loading:
                  () => Text(
                    '$categoryName (...)',
                    style: AppTextStyles.heading5(isDarkMode),
                  ),
              error:
                  (error, stack) => Text(
                    '$categoryName (0)',
                    style: AppTextStyles.heading5(isDarkMode),
                  ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: productsAsyncValue.when(
                data:
                    (products) =>
                        products.isEmpty
                            ? _buildEmptyState(isDarkMode)
                            : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 16,
                                    crossAxisSpacing: 12,
                                    childAspectRatio: 161 / 281,
                                  ),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                final product = products[index];
                                return ProductCard(
                                  product: product,
                                  cardColor:
                                      isDarkMode
                                          ? const Color(0xFF342F3F)
                                          : (AppColors.grey ??
                                              Colors.grey[200]!),
                                  width: 161,
                                  height: 281,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => ProductDetailsScreen(
                                              product: product,
                                            ),
                                      ),
                                    );
                                  },
                                  onFavoriteToggle: () {},
                                );
                              },
                            ),
                loading: () => _buildLoadingState(),
                error: (error, stack) => _buildErrorState(isDarkMode, error),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildErrorState(bool isDarkMode, Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: isDarkMode ? Colors.white54 : Colors.black54,
          ),
          const SizedBox(height: 16),
          Text(
            'Failed to load products',
            style: AppTextStyles.body1(isDarkMode),
          ),
          const SizedBox(height: 8),
          Text(
            'Please try again later',
            style: AppTextStyles.body2(isDarkMode),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool isDarkMode) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 48,
            color: isDarkMode ? Colors.white54 : Colors.black54,
          ),
          const SizedBox(height: 16),
          Text('No products found', style: AppTextStyles.body1(isDarkMode)),
          const SizedBox(height: 8),
          Text(
            'Check back later for new items',
            style: AppTextStyles.body2(isDarkMode),
          ),
        ],
      ),
    );
  }
}
