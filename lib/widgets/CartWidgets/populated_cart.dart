import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/models/cartitem_model.dart';
import 'package:link_flutter_ecommerce_app/providers/cart_item_provider.dart';
import 'package:link_flutter_ecommerce_app/screens/paymentscreen.dart';
import 'package:link_flutter_ecommerce_app/widgets/CartWidgets/cart_item_card.dart';
import 'package:link_flutter_ecommerce_app/widgets/CartWidgets/coupon_code_input.dart';
import 'package:link_flutter_ecommerce_app/widgets/order_summary.dart';

class PopulatedCart extends ConsumerWidget {
  final List<CartItem> cartItems;
  const PopulatedCart({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final subtotal = ref.read(cartProvider.notifier).subtotal;
    final total = ref.watch(totalProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => ref.read(cartProvider.notifier).clearCart(),
              child: Text(
                AppLocalizations.of(context)!.removeAll,
                style: const TextStyle(color: Colors.black54),
              child: const Text(
                'Remove All',
                style: AppTextStyles.faintGrey,
              ),
            ),
          ),
        ),
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
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Paymentscreen(),
                    ),
                  );
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
               
                  style: AppTextStyles.heading4(!isDarkMode),

                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
