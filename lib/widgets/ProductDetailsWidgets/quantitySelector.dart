import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/providers/product_screen_providers.dart';

class QuantitySelector extends ConsumerWidget {
  const QuantitySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = ref.watch(quantityProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Quantity", style: TextStyle(fontSize: 16)),
          Row(
            children: [
              buildQuantityButton(
                icon: IconsaxPlusBroken.minus,
                onPressed: () {
                  if (quantity > 1) {
                    ref.read(quantityProvider.notifier).state--;
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  quantity.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              buildQuantityButton(
                icon: IconsaxPlusBroken.add,
                onPressed: () {
                  ref.read(quantityProvider.notifier).state++;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget buildQuantityButton({
  required IconData icon,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      shape: const CircleBorder(),
      padding: const EdgeInsets.all(12),
      backgroundColor: const Color(0xFF8A2BE2),
      foregroundColor: Colors.white,
    ),
    child: Icon(icon, size: 20),
  );
}
