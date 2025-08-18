import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/features/profile/providers/theme_provider.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations_provider.dart';
import 'package:link_flutter_ecommerce_app/screens/payment_screen.dart';
import 'package:link_flutter_ecommerce_app/screens/splash_screen.dart';
=======
import 'package:link_flutter_ecommerce_app/screens/address_screen.dart';
import 'package:link_flutter_ecommerce_app/screens/credit_card_screen.dart';
import 'package:link_flutter_ecommerce_app/screens/notification_screen.dart';


class SettingsSection extends ConsumerWidget {

  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final themeNotifier = ref.read(themeProvider.notifier);
    final localeNotifier = ref.read(localeProvider.notifier);
    final locale = ref.watch(localeProvider);

    return  Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
               _buildSettingsTile(
                context,
                title: AppLocalizations.of(context)!.address,
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                isDarkMode: isDarkMode,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SplashScreen()),
                  );
                },
              ),
               _buildSettingsTile(
                context,
                title: AppLocalizations.of(context)!.whishlist,
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                isDarkMode: isDarkMode,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SplashScreen()),
                  );
                },
              ),
              _buildSettingsTile(
                context,
                title: AppLocalizations.of(context)!.payment,
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                isDarkMode: isDarkMode,
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const PaymentScreen()),
                    (route) => false,
                  );
                },
              ),
              _buildSettingsTile(
                context,
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
              _buildSettingsTile(
                context,
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
        ),
      );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required String title,
    Widget? trailing ,
    required bool isDarkMode,
    VoidCallback? onTap,
  }) {
    return Card(
      color:isDarkMode? const Color(0xff342F3F): const Color.fromARGB(255, 234, 234, 232),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
      child: ListTile(
        title: Text(title),
        trailing: trailing?? Image.asset("images/Vector.png"),
        onTap: onTap,
      ),
    );
  }
}
