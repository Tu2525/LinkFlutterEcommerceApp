import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/providers/auth_providors.dart';
import 'package:link_flutter_ecommerce_app/screens/forgot_password_screen.dart';
import 'package:link_flutter_ecommerce_app/screens/onboarding_screen.dart';
import 'package:link_flutter_ecommerce_app/services/auth_services.dart';
import 'package:link_flutter_ecommerce_app/widgets/continue_button.dart';
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
    final isDarkMode = ref.watch(signInDarkModeProvider);

    // Update dark mode state on build
    final brightness = MediaQuery.of(context).platformBrightness;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(signInDarkModeProvider.notifier).state !=
          (brightness == Brightness.dark)) {
        ref.read(signInDarkModeProvider.notifier).state =
            brightness == Brightness.dark;
      }
    });

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 123),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color:
                        isDarkMode
                            ? Colors.white
                            : const Color.fromARGB(255, 176, 99, 99),
                    fontFamily: 'Circular',
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Form(
                key: _formKey,
                child: CustomTextField(
                  emailController: passwordController,
                  isPassword: true,
                  hint: 'Password',
                  isdark: isDarkMode,
                  validator: (value) => validatePassword(value),
                ),
              ),
              const SizedBox(height: 16),
              ContinueButton(
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
                          builder: (context) => const OnBoardingScreen(),
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
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    'Forgot Password ?',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Circular',
                      fontSize: 12,
                      color: Color(0xff000000),
                    ),
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
                    child: const Text(
                      ' Reset',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Circular',
                        fontSize: 12,
                        color: Colors.black,
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
