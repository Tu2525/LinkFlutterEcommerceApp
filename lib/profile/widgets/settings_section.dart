import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/profile/providers/theme_provider.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations_provider.dart';

class SettingsSection extends ConsumerWidget {
  final VoidCallback onSettingsTap;

  const SettingsSection({super.key, required this.onSettingsTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final themeNotifier = ref.read(themeProvider.notifier);
    final localeNotifier = ref.read(localeProvider.notifier);
    final locale = ref.watch(localeProvider);


    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundColor(isDarkMode),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor(isDarkMode), width: 1),
      ),
      child: Column(
        children: [
          _buildSettingsTile(
            context,
            icon: IconsaxPlusBroken.moon,
            title: AppLocalizations.of(context)!.darkMode,
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) async {
                await themeNotifier.toggleTheme();
              },
              activeColor: AppColors.primary,
            ),
            isDarkMode: isDarkMode,
          ),
          Divider(height: 1, color: AppColors.borderColor(isDarkMode)),
          _buildSettingsTile(
            context,
            icon: IconsaxPlusBroken.notification,
            title: 'Notifications',
            trailing: Icon(
              IconsaxPlusBroken.arrow_right_3,
              color: AppColors.textSecondaryColor(isDarkMode),
            ),
            isDarkMode: isDarkMode,
          ),
          Divider(height: 1, color: AppColors.borderColor(isDarkMode)),
          Divider(height: 1, color: AppColors.borderColor(isDarkMode)),
          _buildSettingsTile(
            context,
            icon: IconsaxPlusBroken.language_circle,
            title: AppLocalizations.of(context)!.language,
            trailing: DropdownButton<Locale>(
              value: locale,
              underline: const SizedBox(),
              icon: Icon(
                IconsaxPlusBroken.arrow_down_1,
                color: AppColors.textSecondaryColor(isDarkMode),
              ),
              items: const [
                DropdownMenuItem(value: Locale('en'), child: Text('English')),
                DropdownMenuItem(value: Locale('ar'), child: Text('العربية')),
              ],
              onChanged: (newLocale) {
                if (newLocale != null) {
                  localeNotifier.setLocale(newLocale);
                }
              },
            ),
            isDarkMode: isDarkMode,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Widget trailing,
    required bool isDarkMode,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimaryColor(isDarkMode)),
      title: Text(title, style: AppTextStyles.subTitle1(isDarkMode)),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
