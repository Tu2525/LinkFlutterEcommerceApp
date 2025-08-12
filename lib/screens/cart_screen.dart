import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';

import 'package:link_flutter_ecommerce_app/providers/cart_item_provider.dart';
import 'package:link_flutter_ecommerce_app/providers/theme_provider.dart';
import 'package:link_flutter_ecommerce_app/widgets/CartWidgets/empty_cart.dart';
import 'package:link_flutter_ecommerce_app/widgets/CartWidgets/populated_cart.dart';
import 'package:link_flutter_ecommerce_app/widgets/ProductDetailsWidgets/top_bar.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final isDarkMode = ref.watch(isDarkModeProvider);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor(isDarkMode),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TopBar(showHeartIcon: false),
                  Text(
                    "Cart",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryColor(isDarkMode),
                    ),
                  ),
                  const TopBar(showHeartIcon: false),
                  Text(
                    AppLocalizations.of(context)!.cart,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // if (cartItems.isNotEmpty)
                  //   TextButton(
                  //     onPressed:
                  //         () => ref.read(cartProvider.notifier).clearCart(),
                  //     child: const Text(
                  //       'Remove All',
                  //       style: TextStyle(color: Colors.black54),
                  //     ),
                  //   )
                  // else
                  const SizedBox(
                    width: 80,
                  ), // Placeholder with approx. width of the button
                ],
              ),
            ),
            // Main content area that expands to fill the remaining space
            Expanded(
              child:
                  cartItems.isEmpty
                      ? const EmptyCart()
                      : PopulatedCart(cartItems: cartItems),
            ),
          ],
        ),
      ),
    );
  }
}
