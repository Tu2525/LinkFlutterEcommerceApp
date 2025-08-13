import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/orders/models/order_model.dart';

class OrderDetailItemCard extends StatelessWidget {
  final OrderItem item;

  const OrderDetailItemCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundColor(isDarkMode),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              item.imageUrl ?? 'https://placehold.co/100x100/eee/ccc?text=No+Image',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 80,
                height: 80,
                color: Colors.grey[200],
                child: const Icon(Icons.image_not_supported, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: AppTextStyles.body1(isDarkMode),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // Text(
                //   'Size: ${item.size ?? 'N/A'} | Color: ${item.color ?? 'N/A'}',
                //   style: AppTextStyles.body2(isDarkMode).copyWith(color: Colors.grey),
                // ),
                const SizedBox(height: 8),
                Text(
                  '\$${item.price.toStringAsFixed(2)}',
                  style: AppTextStyles.subTitle1(isDarkMode),
                ),
              ],
            ),
          ),
          // Quantity
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              'Qty: ${item.quantity}',
              style: AppTextStyles.body1(isDarkMode),
            ),
          ),
        ],
      ),
    );
  }
}