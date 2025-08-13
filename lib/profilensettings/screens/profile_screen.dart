import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/profilensettings/providers/theme_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final themeNotifier = ref.read(themeProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor(isDarkMode),
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            color: AppColors.textPrimaryColor(isDarkMode),
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.backgroundColor(isDarkMode),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardBackgroundColor(isDarkMode),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.borderColor(isDarkMode),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.primary,
                    child: Icon(
                      IconsaxPlusBroken.profile,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User Name',
                          style: TextStyle(
                            color: AppColors.textPrimaryColor(isDarkMode),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'user@example.com',
                          style: TextStyle(
                            color: AppColors.textSecondaryColor(isDarkMode),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Settings Section
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardBackgroundColor(isDarkMode),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.borderColor(isDarkMode),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  _buildSettingsTile(
                    context,
                    icon: IconsaxPlusBroken.moon,
                    title: 'Dark Mode',
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
                  _buildSettingsTile(
                    context,
                    icon: IconsaxPlusBroken.setting_2,
                    title: 'Settings',
                    trailing: Icon(
                      IconsaxPlusBroken.arrow_right_3,
                      color: AppColors.textSecondaryColor(isDarkMode),
                    ),
                    isDarkMode: isDarkMode,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Widget trailing,
    required bool isDarkMode,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimaryColor(isDarkMode)),
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.textPrimaryColor(isDarkMode),
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: trailing,
      onTap: () {
        // Handle navigation if needed
      },
    );
  }
}
