import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/screens/password_screen.dart';
import 'package:link_flutter_ecommerce_app/widgets/continue_button.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_text_field.dart';
import 'package:link_flutter_ecommerce_app/widgets/signin_with_button.dart';
import 'create_account_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with WidgetsBindingObserver {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateDarkMode(); // Call it here instead
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    _updateDarkMode();
  }

  void _updateDarkMode() {
    setState(() {
      isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
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
              CustomTextField(
                emailController: emailController,
                isPassword: false,
                hint: 'Email Address',
                isdark: isDarkMode,
              ),
              const SizedBox(height: 16),
              ContinueButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PasswordScreen(),
                    ),
                  );
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
                icon: Image.asset('images/apple.png', height: 25, width: 20),
                onPressed: () {},
              ),
              const SizedBox(height: 12),
              SigninWithButton(
                isdark: isDarkMode,
                text: 'Continue With Google',
                icon: Image.asset('images/google.png', height: 25, width: 20),
                onPressed: () {},
              ),
              const SizedBox(height: 12),
              SigninWithButton(
                isdark: isDarkMode,
                text: 'Continue With Facebook',
                icon: Image.asset('images/facebook.png', height: 25, width: 20),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
