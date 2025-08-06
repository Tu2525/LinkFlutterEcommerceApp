import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/screens/paymentscreen.dart';
import 'package:link_flutter_ecommerce_app/screens/user_info_screen.dart';
import 'package:link_flutter_ecommerce_app/widgets/continue_button.dart';
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
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                isdark: isDarkMode,

                emailController: accountManager.firstnameController,
                isPassword: false,
                hint: "Firstname",
              ),
              const SizedBox(height: 16),
              CustomTextField(
                isdark: isDarkMode,

                emailController: accountManager.lastnameController,
                isPassword: false,
                hint: "Lastname",
              ),
              const SizedBox(height: 16),
              CustomTextField(
                isdark: isDarkMode,

                emailController: accountManager.emailController,
                isPassword: false,
                hint: "Email Address",
              ),
              const SizedBox(height: 16),
              CustomTextField(
                isdark: isDarkMode,

                emailController: accountManager.passwordController,
                isPassword: true,
                hint: "Password",
              ),
              const SizedBox(height: 40),
              ContinueButton(
                onPressed: () {
                  accountManager.submit();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UserInfo()),
                  );
                },
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.forgotPassword,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(fontFamily: 'Circular'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Paymentscreen(),
                        ),
                      );
                    },
                    child: Text(
                      ' Reset',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Circular',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
