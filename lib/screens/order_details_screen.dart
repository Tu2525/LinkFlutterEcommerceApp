import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/providers/order_provider.dart';
import 'package:link_flutter_ecommerce_app/utils/mock_product_data.dart';
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
    final order = ref.watch(selectedOrderProvider);
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xff1D182A) : Colors.white,
      body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrderHeader(orderId: order!.id),
                  SizedBox(height: 20.h),
                  OrderSteps(isDarkMode: isDarkMode, steps: order.steps),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Text(
                      'Order Items',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  OrderItemsCard(isDarkMode: isDarkMode, items: order.items),
                  SizedBox(height: 38.h),
                  ShippingDetails(
                    isDarkMode: isDarkMode,
                    shippingInfo: [order.shipping],
                  ),
                ],
              ),
            ),
    );
  }
}
