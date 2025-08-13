import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';

class QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const QuantityButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.surfaceColor(isDarkMode),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 16,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}