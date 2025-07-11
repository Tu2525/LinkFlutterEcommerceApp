import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/screens/reset_password%20screen.dart';
import 'package:link_flutter_ecommerce_app/widgets/continue_button.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_back_icon.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_text_field.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06,
              vertical: screenHeight * 0.05,
            ),
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
                ),
                SizedBox(height: screenHeight * 0.03),
                ContinueButton(onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResetPassword(),
                      ),
                    );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
