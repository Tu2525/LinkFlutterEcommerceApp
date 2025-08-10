import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/providers/auth_providors.dart';
import 'package:link_flutter_ecommerce_app/screens/Main_screen.dart';
import 'package:link_flutter_ecommerce_app/screens/order_details_screen.dart';
import 'package:link_flutter_ecommerce_app/screens/password_screen.dart';
import 'package:link_flutter_ecommerce_app/screens/paymentscreen.dart';
import 'package:link_flutter_ecommerce_app/screens/product_details_screen.dart';
import 'package:link_flutter_ecommerce_app/widgets/continue_button.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_text_field.dart';
import 'package:link_flutter_ecommerce_app/widgets/signin_with_button.dart';
import 'create_account_screen.dart';
import 'package:link_flutter_ecommerce_app/providers/sign_in_provider.dart';

// Removed duplicate ConsumerWidget version
// Use only ConsumerStatefulWidget version below
class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  late final TextEditingController emailController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(
      text: ref.read(signInEmailProvider),
    );
    emailController.addListener(() {
      ref.read(signInEmailProvider.notifier).state = emailController.text;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
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
                    color: isDarkMode ? Colors.white : Colors.black,
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
                  emailController: emailController,
                  isPassword: false,
                  hint: 'Email Address',
                  isdark: isDarkMode,
                  validator: (value) => validateEmail(value),
                ),
              ),
              const SizedBox(height: 16),
              ContinueButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    final exists = await ref
                        .read(authServiceProvider)
                        .checkIfEmailExists(emailController.text.trim());
                    final error = ref.read(authErrorProvider);
                    if (!exists) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            error.isNotEmpty
                                ? error
                                : 'No user found for that email.',
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => PasswordScreen(
                                email: emailController.text.trim(),
                              ),
                        ),
                      );
                    }
                  }
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Don\'t have an Account?',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(fontFamily: 'Circular'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateAccountScreen(),
                        ),
                      );
                    },
                    child: Text(
                      ' Create One',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Circular',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 71),
              SigninWithButton(
                isdark: isDarkMode,
                text: 'Continue With Apple',
                icon:
                    isDarkMode
                        ? Image.asset(
                          'images/whiteApple.png',
                          height: 25,
                          width: 20,
                        )
                        : Image.asset(
                          'images/apple.png',
                          height: 25,
                          width: 20,
                        ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainScreen()
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              SigninWithButton(
                isdark: isDarkMode,
                text: 'Continue With Google',
                icon: Image.asset('images/google.png', height: 25, width: 20),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrderDetails(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              SigninWithButton(
                isdark: isDarkMode,
                text: 'Continue With Facebook',
                icon: Image.asset('images/facebook.png', height: 25, width: 20),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Paymentscreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
