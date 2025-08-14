import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/providers/auth_provider.dart';
import 'package:link_flutter_ecommerce_app/screens/forgot_password_screen.dart';
import 'package:link_flutter_ecommerce_app/screens/main_screen.dart';
import 'package:link_flutter_ecommerce_app/widgets/ProductDetailsWidgets/top_bar.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_button.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_text_field.dart';
import 'package:link_flutter_ecommerce_app/providers/sign_in_provider.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  final String email;
  const PasswordScreen({super.key, required this.email});

  @override
  ConsumerState<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends ConsumerState<PasswordScreen> {
  late final TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController(
      text: ref.read(signInPasswordProvider),
    );
    passwordController.addListener(() {
      ref.read(signInPasswordProvider.notifier).state = passwordController.text;
    });
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor(isDarkMode),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopBar(showHeartIcon: false),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  AppLocalizations.of(context)!.signIn,
                  style: AppTextStyles.heading2(isDarkMode),
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: CustomTextField(
                    controller: passwordController,
                    isPassword: true,
                    hint: AppLocalizations.of(context)!.pass,
                    isdark: isDarkMode,
                    validator: (value) => validatePassword(context, value),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      await ref
                          .read(authServiceProvider)
                          .loginUser(
                            ref: ref,
                            email: widget.email,
                            password: passwordController.text.trim(),
                          );

                      if (!context.mounted) return;

                      final success = ref.read(authSuccessProvider);
                      final error = ref.read(authErrorProvider);

                      if (success) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(),
                          ),
                        );
                      } else if (error.isNotEmpty) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(error)));
                      }
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.forgotPassword,
                      style: AppTextStyles.subTitle2(isDarkMode),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPassword(),
                          ),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.reset,
                        style: AppTextStyles.heading6(isDarkMode),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
