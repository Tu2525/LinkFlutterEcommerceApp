import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/features/profile/providers/theme_provider.dart';

class ThemeToggleWidget extends ConsumerWidget {
  const ThemeToggleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final themeNotifier = ref.read(themeProvider.notifier);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor(isDarkMode),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderColor(isDarkMode)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            IconsaxPlusBroken.sun_1,
            color:
                !isDarkMode
                    ? AppColors.primary
                    : AppColors.textSecondaryColor(isDarkMode),
            size: 18,
          ),
          const SizedBox(width: 8),
          Switch(
            value: isDarkMode,
            onChanged: (value) async {
              await themeNotifier.toggleTheme();
            },
            activeColor: AppColors.primary,
            inactiveThumbColor: AppColors.primary,
            activeTrackColor: AppColors.primary.withOpacity(0.3),
            inactiveTrackColor: AppColors.textSecondaryColor(
              isDarkMode,
            ).withOpacity(0.3),
          ),
          const SizedBox(width: 8),
          Icon(
            IconsaxPlusBroken.moon,
            color:
                isDarkMode
                    ? AppColors.primary
                    : AppColors.textSecondaryColor(isDarkMode),
            size: 18,
          ),
        ],
      ),
    );
  }
}

class ThemeToggleButton extends ConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final themeNotifier = ref.read(themeProvider.notifier);

    return GestureDetector(
      onTap: () async {
        await themeNotifier.toggleTheme();
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surfaceColor(isDarkMode),
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.borderColor(isDarkMode)),
        ),
        child: Icon(
          isDarkMode ? IconsaxPlusBroken.sun_1 : IconsaxPlusBroken.moon,
          color: AppColors.primary,
          size: 20,
        ),
      ),
    );
  }
}
