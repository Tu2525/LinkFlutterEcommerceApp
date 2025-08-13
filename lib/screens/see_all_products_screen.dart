import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_back_icon.dart';
import '../widgets/product_card.dart';
import '../providers/top_selling_products_provider.dart';
import '../providers/new_in_products_provider.dart';
import '../constants/app_colors.dart';
import 'product_details_screen.dart';

class SeeAllProductsScreen extends ConsumerWidget {
  final String productType;
  final String title;

  const SeeAllProductsScreen({
    super.key,
    required this.productType,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsyncValue = productType == 'topSelling'
        ? ref.watch(topSellingProductsProvider)
        : ref.watch(newInProductsProvider);

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
              SizedBox(height: 80.h),
              const CustomIcon(),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: productsAsyncValue.when(
                data: (products) => products.isEmpty
                    ? _buildEmptyState(isDarkMode)
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductCard(
                            product: product,
                            cardColor: isDarkMode
                                ? const Color(0xFF342F3F)
                                : (AppColors.grey ?? Colors.grey[200]!),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsScreen(
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

  Widget _buildEmptyState(bool isDarkMode) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            IconsaxPlusLinear.box,
            size: 64,
            color: isDarkMode ? Colors.white54 : Colors.black54,
          ),
          const SizedBox(height: 16),
          Text(
            'No products found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white70 : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Check back later for new products',
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? Colors.white54 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(bool isDarkMode, Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            IconsaxPlusLinear.warning_2,
            size: 64,
            color: isDarkMode ? Colors.red[300] : Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white70 : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please try again later',
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? Colors.white54 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}