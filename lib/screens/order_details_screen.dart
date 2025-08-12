import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/providers/order_provider.dart';
import 'package:link_flutter_ecommerce_app/widgets/order_header.dart';
import 'package:link_flutter_ecommerce_app/widgets/order_items_card.dart';
import 'package:link_flutter_ecommerce_app/widgets/order_steps.dart';
import 'package:link_flutter_ecommerce_app/widgets/shipping_details.dart';

class OrderDetails extends ConsumerWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final order = ref.watch(selectedOrderProvider);

    final orderAsyncValue = ref.watch(orderProvider);

    return Scaffold(
      backgroundColor:
          isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,

      // Keep develop's async handling but also allow direct `order` usage if needed
      body: orderAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (orderData) {
          if (orderData.isEmpty && order == null) {
            return Center(child: Text(AppLocalizations.of(context)!.noOrders));
          }

          // Prefer selectedOrderProvider if available, otherwise fallback to first from orderProvider
          final activeOrder = order ?? orderData.first;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderHeader(orderIdd: activeOrder.key),
                SizedBox(height: 20.h),
                OrderSteps(isDarkMode: isDarkMode, steps: activeOrder.steps),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Text(
                    AppLocalizations.of(context)!.orderItems,
                    style: AppTextStyles.heading5(isDarkMode),
                  ),
                ),
                SizedBox(height: 20.h),
                OrderItemsCard(
                  isDarkMode: isDarkMode,
                  items: activeOrder.items,
                ),
                SizedBox(height: 38.h),
                ShippingDetails(
                  isDarkMode: isDarkMode,
                  shippingInfo: [activeOrder.shipping],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
