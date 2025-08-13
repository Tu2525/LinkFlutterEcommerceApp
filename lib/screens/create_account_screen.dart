import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/providers/auth_provider.dart';
import 'package:link_flutter_ecommerce_app/screens/user_info_screen.dart';
import 'package:link_flutter_ecommerce_app/services/auth_services.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_button.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_back_icon.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_text_field.dart';
import 'package:link_flutter_ecommerce_app/providers/create_account_provider.dart';

class CreateAccountScreen extends ConsumerWidget {
  CreateAccountScreen({super.key});

  final emailController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountManager = ref.watch(createAccountProvider);
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomIcon(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.createAccount,
                style: AppTextStyles.heading2(isDarkMode),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                isdark: isDarkMode,

                controller: accountManager.firstnameController,
                isPassword: false,
                hint: AppLocalizations.of(context)!.firstName,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                isdark: isDarkMode,
                controller: accountManager.lastnameController,
                isPassword: false,
                hint: AppLocalizations.of(context)!.lastName,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                isdark: isDarkMode,

                controller: accountManager.emailController,
                isPassword: false,
                hint: AppLocalizations.of(context)!.emailAddress,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                isdark: isDarkMode,
                controller: accountManager.passwordController,
                isPassword: true,
                hint: AppLocalizations.of(context)!.pass,
              ),
              const SizedBox(height: 40),
              CustomButton(
                onPressed: () async {
                  await AuthService().registerUser(
                    ref: ref,
                    email: accountManager.emailController.text.trim(),
                    password: accountManager.passwordController.text.trim(),
                    name:
                        '${accountManager.firstnameController.text.trim()} ${accountManager.lastnameController.text.trim()}',
                  );

                  final success = ref.read(authSuccessProvider);
                  final error = ref.read(authErrorProvider);

                  if (success) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const UserInfo()),
                    );
                  } else if (error.isNotEmpty) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(error)));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
