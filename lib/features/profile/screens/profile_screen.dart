import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/features/profile/widgets/profile_header.dart';
import 'package:link_flutter_ecommerce_app/features/profile/widgets/settings_section.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/screens/sign_in_screen.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor(isDarkMode),
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.profile,
          style: AppTextStyles.heading4(isDarkMode),
        ),
        backgroundColor: AppColors.backgroundColor(isDarkMode),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const ProfileHeader(),
            const SizedBox(height: 24),
            SettingsSection(
              onSettingsTap: () {
              },
            ),
            const Spacer(),
            // Sign Out Button
            CustomButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  if (context.mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  }
                } catch (e) {
                  print('Error signing out: $e');
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${AppLocalizations.of(context)!.somethingWentWrong} $e',
                        ),
                      ),
                    );
                  }
                }
              },
              text: AppLocalizations.of(context)!.signOut,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
