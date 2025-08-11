import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/models/order_model.dart';
import 'package:link_flutter_ecommerce_app/providers/cart_item_provider.dart';
import 'package:link_flutter_ecommerce_app/providers/controller_providors.dart';
import 'package:link_flutter_ecommerce_app/providers/order_provider.dart';
import 'package:link_flutter_ecommerce_app/screens/order_placed_successfully_screen.dart';
import 'package:link_flutter_ecommerce_app/services/order_service.dart';
import 'package:link_flutter_ecommerce_app/widgets/continue_button.dart';

class OrderSummary extends ConsumerWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subtotal = ref.read(cartProvider.notifier).subtotal;
    final total = ref.watch(totalProvider);
    final cartItems = ref.watch(cartProvider);
    final addressController = ref.read(addressControllerProvider);
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;

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
            Text('Shipping Cost', style: AppTextStyles.labelStyle),
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
            Text('\$$total', style: AppTextStyles.totalStyle),
          ],
        ),
        SizedBox(height: 24.h),
        ContinueButton(
          onPressed: () async {
            if (cartItems.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Your cart is empty'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            try {
              final shippingInfo = ShippingInfo(
                address:
                    addressController.text.isNotEmpty
                        ? addressController.text
                        : 'No address provided',
              );

              showDialog(
                context: context,
                barrierDismissible: false,
                builder:
                    (context) =>
                        const Center(child: CircularProgressIndicator()),
              );

              final order = await OrderService().saveOrderToFirebase(
                cartItems: cartItems,
                shipping: shippingInfo,
                status: 'Processing',
              );
              ref.read(selectedOrderProvider.notifier).state = order;
              Navigator.of(context).pop();
              ref.read(cartProvider.notifier).clearCart();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrderPlacedSuccessfullyScreen(),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Order placed successfully! Order ID: ${order.key}',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            } catch (e) {
              // Hide loading indicator if showing
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              }

              // Show error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to place order: $e'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          text: '\$$total${' ' * 40}Place Order',
        ),
      ],
    );
  }
}
