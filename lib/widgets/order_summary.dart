import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/models/order_model.dart';
import 'package:link_flutter_ecommerce_app/providers/cart_item_provider.dart';
import 'package:link_flutter_ecommerce_app/providers/controller_providors.dart';
import 'package:link_flutter_ecommerce_app/providers/order_provider.dart';
import 'package:link_flutter_ecommerce_app/screens/order_placed_successfully_screen.dart';
import 'package:link_flutter_ecommerce_app/services/order_service.dart';
import 'package:link_flutter_ecommerce_app/widgets/continue_button.dart';
import 'package:link_flutter_ecommerce_app/widgets/CartWidgets/price_summary_row.dart';

class OrderSummary extends ConsumerWidget {
  const OrderSummary({required this.subtotal, required this.total, super.key});
  final double subtotal;
  final double total;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subtotal = ref.read(cartProvider.notifier).subtotal;

    // feature branch vars
    final totalFromProvider = ref.watch(totalProvider);
    final cartItems = ref.watch(cartProvider);
    final addressController = ref.read(addressControllerProvider);
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;

    // develop branch constants
    const shippingCost = 8.00;
    const tax = 0.00;
    final totalFromDevelop = subtotal + shippingCost + tax;

    // decide which total to use (prefer provider if available)
    final total = totalFromProvider != 0 ? totalFromProvider : totalFromDevelop;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Subtotal
        PriceSummaryRow(
          label: AppLocalizations.of(context)!.subtotal,
          amount: subtotal,
        ),
        SizedBox(height: 8.h),

        // Shipping cost
        PriceSummaryRow(
          label: AppLocalizations.of(context)!.shippingCost,
          amount: shippingCost,
        ),
        SizedBox(height: 8.h),
        PriceSummaryRow(label: AppLocalizations.of(context)!.tax, amount: tax),
        const Divider(height: 30),

        // Total
        PriceSummaryRow(
          label: AppLocalizations.of(context)!.total,
          amount: total,
          isTotal: true,
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
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              }
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

        SizedBox(height: 20.h),
      ],
    );
  }
}
