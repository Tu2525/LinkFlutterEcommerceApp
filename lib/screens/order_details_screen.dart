import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_back_icon.dart';
import 'package:link_flutter_ecommerce_app/widgets/order_status_card.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xff1D182A) : const Color(0xffFFFFFF),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
        child: Column(
          children: [
            Row(
              children: [
                const CustomIcon(),
                SizedBox(width: 80.w),
                Text(
                  'Order #00545',
                  style: TextStyle(
                    fontFamily: 'Circular',
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Column(
                children: [
                  const OrderStatusCard(text: 'Delivered', isChecked: false),
                  SizedBox(height: 14.h),
                  const OrderStatusCard(text: 'Shipped', isChecked: true),
                  SizedBox(height: 14.h),
                  const OrderStatusCard(
                    text: 'Order confirmed',
                    isChecked: true,
                  ),
                  SizedBox(height: 14.h),
                  const OrderStatusCard(text: 'Order placed', isChecked: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
