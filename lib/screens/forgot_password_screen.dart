import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/screens/reset_password%20screen.dart';
import 'package:link_flutter_ecommerce_app/widgets/continue_button.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_back_icon.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_text_field.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomIcon(),
                  SizedBox(height: screenHeight * 0.03),
                  const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontFamily: 'Circular',
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  CustomTextField(
                    emailController: emailController,
                    isPassword: false,
                    hint: 'Enter Email address',
                    isdark: isDarkMode,

                    validator:
                        (value) =>
                            (value == null || value.trim().isEmpty)
                                ? 'Please enter your email'
                                : !value.contains('@') || !value.contains('.')
                                ? 'Please enter a valid email address'
                                : null,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  ContinueButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ResetPassword(),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
