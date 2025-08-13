import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';

class TopBar extends StatelessWidget {
  final bool showHeartIcon;
  final VoidCallback? onHeartPressed;
  const TopBar({super.key, this.showHeartIcon = true, this.onHeartPressed});

  @override
  Widget build(BuildContext context) {
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
          if (showHeartIcon)
            _buildIconButton(
              context: context,
              icon: IconsaxPlusBroken.heart,
              onPressed: onHeartPressed ?? () {},
            ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundColor(isDarkMode),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withValues(alpha: 0.25)
                : Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: isDarkMode ? Colors.white : Colors.black87,
          size: 20,
        ),
        onPressed: onPressed,
      ),
    );
  }
}