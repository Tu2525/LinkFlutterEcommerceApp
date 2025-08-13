import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/orders/widgets/order_detail_item_card.dart';
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
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
          
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surfaceColor(isDarkMode),
            ),
            child: IconButton(
              icon: Icon(
                size: 20,
                IconsaxPlusBroken.arrow_left_2,
                color: AppColors.backgroundColor(!isDarkMode),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        title: Text(
          'Order #${order.key}', // Display the order key/ID
          style: AppTextStyles.heading5(isDarkMode),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              // Display the number of items in the order.
              '${order.items.length} Items',
              style: AppTextStyles.subTitle1(isDarkMode),
            ),
            const SizedBox(height: 16),
            Expanded(
              child:
                  order.items.isEmpty
                      ? _buildEmptyState(isDarkMode)
                      : ListView.builder(
                        itemCount: order.items.length,
                        itemBuilder: (context, index) {
                          final orderItem = order.items[index];
                          return OrderDetailItemCard(item: orderItem);
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
          Text(
            'This order has no items',
            style: AppTextStyles.body1(isDarkMode),
          ),
        ],
      ),
    );
  }
}
