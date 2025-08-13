import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/orders/models/order_model.dart';
import 'package:link_flutter_ecommerce_app/orders/screens/order_details_product.dart';

class OrderItemsCard extends StatelessWidget {
  final bool isDarkMode;
  final List<OrderItem> items;
  final dynamic order;
  const OrderItemsCard({
    super.key,
    required this.isDarkMode,
    required this.items,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final totalQuantity = List<OrderItem>.from(order.items).fold<int>(0, (total, item) {
      return total + item.quantity;
    });
    final itemText =
        totalQuantity == 1 ? AppLocalizations.of(context)!.item : "Items";
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: SizedBox(
        height: 72.h,
        width: 342.w,
        child: Center(
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 8.h,
            ),
            tileColor: AppColors.cardBackgroundColor(isDarkMode),
            leading: const Icon(IconsaxPlusBroken.receipt_1),
            title: Text(
              '$totalQuantity $itemText',
              style: AppTextStyles.seeAll(isDarkMode),
            ),
            trailing: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetailsScreen(order: order),
                  ),
                );
              },
              child: Text(
                AppLocalizations.of(context)!.viewAll,
                style: AppTextStyles.viewAll(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
