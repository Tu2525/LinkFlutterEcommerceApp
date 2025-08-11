import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final textColor = isDarkMode ? Colors.white : Colors.black;
    // This 'orderAsyncValue' is an AsyncValue object

    final orderAsyncValue = ref.watch(orderProvider);

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xff1D182A) : Colors.white,

      // Use .when to handle loading, error, and data states
      body: orderAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (orderData) {
          if (orderData.isEmpty) {
            return Center(child: Text(AppLocalizations.of(context)!.noOrders));
          }
          final singleOrder = orderData.first;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderHeader(orderId: singleOrder.id),
                SizedBox(height: 20.h),
                OrderSteps(isDarkMode: isDarkMode, steps: singleOrder.steps),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Text(
                    AppLocalizations.of(context)!.orderItems,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                OrderItemsCard(
                  isDarkMode: isDarkMode,
                  items: singleOrder.items,
                ),
                SizedBox(height: 38.h),
                ShippingDetails(
                  isDarkMode: isDarkMode,
                  shippingInfo: [singleOrder.shipping],
                ),
                SizedBox(height: 20.h),
                OrderItemsCard(
                  isDarkMode: isDarkMode,
                  items: singleOrder.items,
                ),
                SizedBox(height: 38.h),
                ShippingDetails(
                  isDarkMode: isDarkMode,
                  shippingInfo: [singleOrder.shipping],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
