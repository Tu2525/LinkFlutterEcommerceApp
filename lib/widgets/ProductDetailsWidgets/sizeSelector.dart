import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/providers/product_screen_providers.dart';

class SizeSelector extends ConsumerWidget {
  const SizeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSize = ref.watch(sizeProvider);
    final sizes = [
      AppLocalizations.of(context)!.s,
      AppLocalizations.of(context)!.m,
      AppLocalizations.of(context)!.l,
      AppLocalizations.of(context)!.xl,
    ];

    final safeSelectedSize = sizes.contains(selectedSize) ? selectedSize : null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: safeSelectedSize,
          icon: const Icon(IconsaxPlusBroken.arrow_down_2),
          items:
              sizes.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              ref.read(sizeProvider.notifier).state = newValue;
            }
          },
          hint: Text(AppLocalizations.of(context)!.size),
        ),
      ),
    );
  }
}
