import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/features/profile/widgets/profile_header.dart';
import 'package:link_flutter_ecommerce_app/features/profile/widgets/settings_section.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/screens/sign_in_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor(isDarkMode),
      body: SafeArea(
        child: Column(
          children: [
            const ProfileHeader(),
            const SizedBox(height: 24),
            SettingsSection(
              onSettingsTap: () {
              },
             const SizedBox(height: 70),
             const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              backgroundImage: AssetImage('images/user_21.png'),
            ),
            const SizedBox(height: 20),
            const ProfileHeader(),
            const SizedBox(height: 5),
            const SettingsSection(),
            TextButton(
              child: Text(
                AppLocalizations.of(context)!.signOut,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
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
            ),
          ],
        ),
      ),
    );
  }
}
