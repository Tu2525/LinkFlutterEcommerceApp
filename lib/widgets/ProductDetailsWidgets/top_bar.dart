import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/models/product.dart';
import 'package:link_flutter_ecommerce_app/providers/favourites_provider.dart';

class TopBar extends ConsumerWidget {
  final bool showHeartIcon;
  final Product? product;
  final VoidCallback? onHeartPressed;
  const TopBar({super.key, this.showHeartIcon = true, this.onHeartPressed, this.product });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final isFav = product != null && favorites.contains(product!.id);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIconButton(
            context: context,
            icon: IconsaxPlusBroken.arrow_left_2,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          if (showHeartIcon && product != null)
            _buildIconButton(
              context: context,
              icon: isFav ? IconsaxPlusBold.heart : IconsaxPlusBroken.heart,
              iconColor: isFav ? Colors.red : null,
              onPressed: () {
                ref.read(favoritesProvider.notifier).toggleFavorite(product!.id);
                if (onHeartPressed != null) onHeartPressed!();
              },
            ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required BuildContext context,
    required IconData icon,
    Color? iconColor,
    required VoidCallback onPressed,
  }) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundColor(isDarkMode),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.borderColor(isDarkMode),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: iconColor ?? (isDarkMode ? Colors.white : Colors.black87),
          size: 20,
        ),
        onPressed: onPressed,
      ),
    );
  }
}