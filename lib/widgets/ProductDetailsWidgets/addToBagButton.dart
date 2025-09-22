import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';

import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';

import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';

import 'package:link_flutter_ecommerce_app/models/cartitem_model.dart';
import 'package:link_flutter_ecommerce_app/providers/cart_item_provider.dart';
import 'package:link_flutter_ecommerce_app/providers/product_screen_providers.dart';
import 'package:link_flutter_ecommerce_app/screens/cart_screen.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_button.dart';

class AddToBagButton extends ConsumerWidget {
  final double totalPrice;
  const AddToBagButton({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundColor(isDarkMode),
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
            child: CustomButton(
              // The text for the button is now passed to the 'text' parameter.
              text: AppLocalizations.of(context)!.addToBag,
              // The entire logic from the old button is moved to the 'onPressed' callback.
              onPressed: () {
                final product = ref.read(productProvider);
                final quantity = ref.read(quantityProvider);
                final color = ref.read(colorProvider);
                final size = ref.read(sizeProvider);

                // Ensure product images are available before creating the item
                if (product.imageUrls == null || product.imageUrls!.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Product image not available.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                final newItem = CartItem(
                  id: product.id,
                  name: product.name,
                  imageUrl: product.imageUrls!.first,
                  price: product.price,
                  quantity: quantity,
                  size: size,
                  color:
                      '#${color.value.toRadixString(16).substring(2).toUpperCase()}',
                );

                ref
                    .read(cartProvider.notifier)
                    .addItem(
                      newItem,
                      productId: product.id,
                      productName: product.name,
                    );

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
            ),
          ),
        ],
      ),
    );
  }
}
