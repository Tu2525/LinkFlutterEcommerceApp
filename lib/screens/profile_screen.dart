import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/screens/address_screen.dart';
import 'package:link_flutter_ecommerce_app/providers/theme_provider.dart';
import 'package:link_flutter_ecommerce_app/providers/locale_provider.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    final locale = ref.watch(localeProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor(isDarkMode),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(
                  'images/Ellipse 1.png',
                ), // Using existing image
              ),
              const SizedBox(height: 16),
              // Profile Header with Avatar and User Info
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.cardBackgroundColor(isDarkMode),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    // Profile Avatar

                    // User Name
                    Text(
                      'Gilbert Jones',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryColor(isDarkMode),
                        fontFamily: 'Circular',
                      ),
                    ),
                    const SizedBox(height: 4),
                    // User Email
                    GestureDetector(
                      onTap: () {
                        // Edit functionality
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Gilbertjones001@gmail.com',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondaryColor(isDarkMode),
                              fontFamily: 'Circular',
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Edit',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF8E6CEF),
                              fontFamily: 'Circular',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Phone Number
                    Text(
                      '121-224-7890',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondaryColor(isDarkMode),
                        fontFamily: 'Circular',
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Menu Items
              Column(
                children: [
                  // Dark Mode Toggle
                  _buildToggleMenuItem(
                    context,
                    AppLocalizations.of(context)!.darkMode,
                    IconsaxPlusBroken.moon,
                    isDarkMode,
                    value: isDarkMode,
                    onToggle: (value) {
                      ref.read(themeProvider.notifier).toggleTheme();
                    },
                  ),
                  const SizedBox(height: 16),

                  // Language Toggle
                  _buildToggleMenuItem(
                    context,
                    AppLocalizations.of(context)!.language,
                    IconsaxPlusBroken.global,
                    isDarkMode,
                    value: locale.languageCode == 'ar',
                    onToggle: (value) {
                      ref.read(localeProvider.notifier).toggleLanguage();
                    },
                    onTap: () {
                      ref.read(localeProvider.notifier).toggleLanguage();
                    },
                    trailing: Text(
                      locale.languageCode == 'ar' ? 'عربي' : 'English',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF8E6CEF),
                        fontFamily: 'Circular',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildMenuItem(
                    context,
                    AppLocalizations.of(context)!.address,
                    IconsaxPlusBroken.arrow_right_3,
                    isDarkMode,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddressScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildMenuItem(
                    context,
                    AppLocalizations.of(context)!.wishlist,
                    IconsaxPlusBroken.arrow_right_3,
                    isDarkMode,
                    onTap: () {
                      // Navigate to wishlist
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildMenuItem(
                    context,
                    AppLocalizations.of(context)!.paymentMethod,
                    IconsaxPlusBroken.arrow_right_3,
                    isDarkMode,
                    onTap: () {
                      // Navigate to payment
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildMenuItem(
                    context,
                    AppLocalizations.of(context)!.help,
                    IconsaxPlusBroken.arrow_right_3,
                    isDarkMode,
                    onTap: () {
                      // Navigate to help
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildMenuItem(
                    context,
                    AppLocalizations.of(context)!.support,
                    IconsaxPlusBroken.arrow_right_3,
                    isDarkMode,
                    onTap: () {
                      // Navigate to support
                    },
                  ),

                  const SizedBox(height: 48),

                  // Sign Out Button
                  GestureDetector(
                    onTap: () {
                      // Sign out functionality
                    },
                    child: Text(
                      AppLocalizations.of(context)!.signOut,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontFamily: 'Circular',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    bool isDarkMode, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.cardBackgroundColor(isDarkMode),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimaryColor(isDarkMode),
                fontFamily: 'Circular',
              ),
            ),
            Icon(
              icon,
              size: 16,
              color: AppColors.textSecondaryColor(isDarkMode),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    bool isDarkMode, {
    required bool value,
    required Function(bool) onToggle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.cardBackgroundColor(isDarkMode),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: AppColors.textSecondaryColor(isDarkMode),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimaryColor(isDarkMode),
                    fontFamily: 'Circular',
                  ),
                ),
              ],
            ),
            trailing ??
                Switch(
                  value: value,
                  onChanged: onToggle,
                  activeColor: Color(0xFF8E6CEF),
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey.withOpacity(0.3),
                ),
          ],
        ),
      ),
    );
  }
}
