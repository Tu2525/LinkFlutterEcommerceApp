import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/models/cartitem_model.dart';
import 'package:link_flutter_ecommerce_app/models/order_model.dart';
import 'package:link_flutter_ecommerce_app/providers/cart_item_provider.dart';
import 'package:link_flutter_ecommerce_app/providers/controller_providors.dart';
import 'package:link_flutter_ecommerce_app/providers/order_provider.dart';
import 'package:link_flutter_ecommerce_app/screens/paymentscreen.dart';
import 'package:link_flutter_ecommerce_app/services/order_service.dart';
import 'package:link_flutter_ecommerce_app/widgets/CartWidgets/cart_item_card.dart';
import 'package:link_flutter_ecommerce_app/widgets/CartWidgets/coupon_code_input.dart';
import 'package:link_flutter_ecommerce_app/widgets/order_summary.dart';

class PopulatedCart extends ConsumerWidget {
  final List<CartItem> cartItems;
  const PopulatedCart({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final subtotal = ref.watch(subtotalProvider);
    final total = ref.watch(totalProvider);
    final addressController = ref.watch(addressControllerProvider);

    return Column(
      children: [
        const Padding(padding: EdgeInsets.symmetric(horizontal: 16.0)),
        Expanded(
          child: ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              return CartItemCard(item: cartItems[index]);
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: AppColors.cardBackgroundColor(isDarkMode),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: .1),
                spreadRadius: 0,
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              OrderSummary(subtotal: subtotal, total: total),
              const CouponCodeInput(),
              const SizedBox(height: 20),
              ElevatedButton(
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

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Paymentscreen(),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.checkout,
                  style: AppTextStyles.heading4(isDarkMode),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
