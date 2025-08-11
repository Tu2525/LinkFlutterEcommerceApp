import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';

import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';

import 'package:link_flutter_ecommerce_app/models/cartitem_model.dart';
import 'package:link_flutter_ecommerce_app/providers/cart_item_provider.dart';
import 'package:link_flutter_ecommerce_app/providers/product_screen_providers.dart';
import 'package:link_flutter_ecommerce_app/screens/cart_screen.dart';

class AddToBagButton extends ConsumerWidget {
  final double totalPrice;
  const AddToBagButton({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 0,
            blurRadius: 20,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '\$${totalPrice.toStringAsFixed(2)}',
            style: AppTextStyles.price,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8A2BE2),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: AppTextStyles.heading5(isDarkMode),
              ),
              onPressed: () {
                // 1. Read the necessary providers to get the current selections.
                // Use the correct provider for the live product state.
                final product = ref.read(productProvider);
                final quantity = ref.read(quantityProvider);
                final color = ref.read(colorProvider);
                final size = ref.read(sizeProvider);

                // 2. Create a new CartItem instance.
                final newItem = CartItem(
                  id: product.id,
                  name: product.name,
                  // Correctly populate the image URL.
                  imageUrl: product.imageUrls!.first,
                  price: product.price,
                  quantity: quantity,
                  size: size,
                  // Convert the Color object to a hex String for the model.
                  color:
                      '#${color.value.toRadixString(16).substring(2).toUpperCase()}',
                );

                // 3. Call the addItem method with the single CartItem object.
                ref
                    .read(cartProvider.notifier)
                    .addItem(
                      newItem,
                      productId: product.id,
                      productName: product.name,
                    );

                // 4. Show a confirmation message.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${AppLocalizations.of(context)!.addedToBag}!',
                    ),
                    duration: const Duration(seconds: 2),
                    backgroundColor: Colors.green,
                    action: SnackBarAction(
                      label: AppLocalizations.of(context)!.proceedToCheckout,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },

              child: Text(AppLocalizations.of(context)!.addToBag),
            ),
          ),
        ],
      ),
    );
  }
}
