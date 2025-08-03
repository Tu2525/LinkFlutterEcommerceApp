import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/models/cartitem_model.dart';
import 'package:link_flutter_ecommerce_app/providers/cart_item_provider.dart';
import 'package:link_flutter_ecommerce_app/widgets/CartWidgets/quantity_button.dart';

class CartItemCard extends ConsumerWidget {
  final CartItem item;
  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.08),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              item.imageUrl,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Icon(Icons.error, size: 70),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Size - ${item.size}   Color - ${item.color}',
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  QuantityButton(
                    icon: IconsaxPlusBroken.minus,
                    onPressed:
                        () =>
                            ref.read(cartProvider.notifier).decrement(item.id),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      item.quantity.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  QuantityButton(
                    icon: IconsaxPlusBroken.add,
                    onPressed:
                        () =>
                            ref.read(cartProvider.notifier).increment(item.id),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
