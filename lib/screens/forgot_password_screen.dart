import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/providers/forgot_password_Provider.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_button.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_back_icon.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_text_field.dart';

class ForgotPassword extends ConsumerWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = ref.watch(forgotPasswordProvider);
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06,
              vertical: screenHeight * 0.05,
            ),
            child: Form(
              key: manager.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomIcon(),
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    AppLocalizations.of(context)!.forgotPassword,
                    style: AppTextStyles.heading2(isDarkMode),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  CustomTextField(
                    controller: manager.emailController,
                    isPassword: false,
                    hint: AppLocalizations.of(context)!.enterEmailAddress,
                    isdark: isDarkMode,
                    validator: (email) => manager.validateEmail(context, email),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  CustomButton(onPressed: () => manager.submit(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
