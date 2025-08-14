import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/features/orders/presentation/providers/orders_provider.dart';
import 'package:link_flutter_ecommerce_app/features/orders/presentation/widgets/order_header.dart';
import 'package:link_flutter_ecommerce_app/features/orders/presentation/widgets/order_items_card.dart';
import 'package:link_flutter_ecommerce_app/features/orders/presentation/widgets/order_price_summary.dart';
import 'package:link_flutter_ecommerce_app/features/orders/presentation/widgets/order_steps.dart';
import 'package:link_flutter_ecommerce_app/features/orders/presentation/widgets/shipping_details.dart';

class OrderDetails extends ConsumerWidget {
  final String orderId;
  const OrderDetails({super.key, required this.orderId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final orderAsyncValue = ref.watch(orderByIdProvider(orderId));

    return Scaffold(
      backgroundColor: AppColors.backgroundColor(isDarkMode),
      body: orderAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (activeOrder) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 40.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OrderHeader(orderIdd: activeOrder.key),
                      SizedBox(height: 20.h),
                      OrderSteps(
                        isDarkMode: isDarkMode,
                        steps: activeOrder.steps,
                      ),
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
                        order: activeOrder,
                        items: activeOrder.items,
                      ),
                      SizedBox(height: 38.h),
                      ShippingDetails(
                        isDarkMode: isDarkMode,
                        shippingInfo: [activeOrder.shipping],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: AppColors.cardBackgroundColor(isDarkMode),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: OrderPriceSummary(order: activeOrder),
              ),
            ],
          );
        },
      ),
    );
  }
}