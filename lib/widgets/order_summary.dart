import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/providers/cart_item_provider.dart';
import 'package:link_flutter_ecommerce_app/screens/order_placed_successfully_screen.dart';
import 'package:link_flutter_ecommerce_app/widgets/continue_button.dart';

class OrderSummary extends ConsumerWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subtotal = ref.read(cartProvider.notifier).subtotal;
    final data = ref.watch(cartProvider);
    print(data);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: AppTextStyles.labelStyle),
            Text('\$$subtotal', style: AppTextStyles.valueStyle),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Cost', style:AppTextStyles.labelStyle),
            Text('\$8.00', style: AppTextStyles.valueStyle),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax', style: AppTextStyles.labelStyle),
            Text('\$0.00', style: AppTextStyles.valueStyle),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total', style: AppTextStyles.totalStyle),
            Text('\$208', style: AppTextStyles.totalStyle),
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
          text: '\$208${' ' * 40}Place Order',
        ),
      ],
    );
  }
}
