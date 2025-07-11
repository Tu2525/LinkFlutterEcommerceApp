import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/screens/password_screen.dart';
import 'package:link_flutter_ecommerce_app/widgets/continue_button.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_text_field.dart';
import 'package:link_flutter_ecommerce_app/widgets/signin_with_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 123),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontFamily: 'Circular',
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                  ),
                ),
              ),
              SizedBox(height: 32),
              CustomTextField(
                emailController: _emailController,
                isPassword: false,
                hint: 'Email Address',
              ),
              SizedBox(height: 16),
              ContinueButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PasswordScreen()),
                  );
                },
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Dont have an Account ?',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Circular',
                      fontSize: 12,
                      color: Color(0xff000000),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      ' Create One',
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
              SizedBox(height: 71),
              SigninWithButton(
                text: 'Continue With Apple',
                icon: Image.asset('images/apple.png', height: 25, width: 20),
                onPressed: () {},
              ),
              SizedBox(height: 12),
              SigninWithButton(
                text: 'Continue With Google',
                icon: Image.asset('images/google.png', height: 25, width: 20),
                onPressed: () {},
              ),
              SizedBox(height: 12),
              SigninWithButton(
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
