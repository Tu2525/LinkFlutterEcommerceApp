import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/providers/auth_providors.dart';
import 'package:link_flutter_ecommerce_app/screens/paymentscreen.dart';
import 'package:link_flutter_ecommerce_app/screens/user_info_screen.dart';
import 'package:link_flutter_ecommerce_app/services/auth_services.dart';
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
              const SizedBox(height: 40),
              Row(
                children: [
                  Text(
                    'Forgot Password?',
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
