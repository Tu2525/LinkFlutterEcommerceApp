import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/screens/order_placed_successfully_screen.dart';
import 'package:link_flutter_ecommerce_app/widgets/continue_button.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(color: Colors.grey.shade600, fontSize: 14.sp);
    const valueStyle = TextStyle(fontWeight: FontWeight.bold);
    final totalStyle = valueStyle.copyWith(fontSize: 16.sp);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: labelStyle),
            const Text('\$200', style: valueStyle),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Cost', style: labelStyle),
            const Text('\$8.00', style: valueStyle),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax', style: labelStyle),
            const Text('\$0.00', style: valueStyle),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total', style: totalStyle),
            Text('\$208', style: totalStyle),
          ],
        ),
        SizedBox(height: 24.h),
        ContinueButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OrderPlacedSuccessfullyScreen(),
              ),
            );
          },
          text: '\$208${' ' * 60}Place Order',
        ),
      ],
    );
  }
}
