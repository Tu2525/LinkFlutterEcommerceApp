import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/models/product.dart';
import 'package:link_flutter_ecommerce_app/widgets/product_card.dart';
import 'package:link_flutter_ecommerce_app/screens/product_details_screen.dart';
import 'package:link_flutter_ecommerce_app/orders/models/order_model.dart';

class OrderDetailsScreen extends ConsumerWidget {
  final OrderModel order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor(isDarkMode),
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor(isDarkMode),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            IconsaxPlusBroken.arrow_left_2,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Order #${order.key}',
          style: AppTextStyles.heading5(isDarkMode),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, bottom: 12.0),
              child: Text(
                '${order.items.length} Items',
                style: AppTextStyles.subTitle1(isDarkMode),
              ),
            ),
            Expanded(
              child: order.items.isEmpty
                  ? _buildEmptyState(isDarkMode)
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: order.items.length,
                      itemBuilder: (context, index) {
                        final orderItem = order.items[index];
                        final product = Product(
                          id: orderItem.productId ?? '',
                          name: orderItem.name,
                          price: orderItem.price,
                          imageUrls: orderItem.imageUrl != null 
                              ? [orderItem.imageUrl!] 
                              : [],
                          description: '', 
                          rating: 0.0, 
                          reviews: [], 
                          originalPrice: orderItem.price,
                          isFavorite: false,
                          category: null,
                          reviewCount: 0,
                        );

                        return ProductCard(
                          product: product,
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isDarkMode) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            IconsaxPlusBroken.receipt_2,
            size: 48,
            color: AppColors.surfaceColor(isDarkMode),
          ),
          const SizedBox(height: 16),
          Text('This order has no items',
              style: AppTextStyles.body1(isDarkMode)),
        ],
      ),
    );
  }
}
