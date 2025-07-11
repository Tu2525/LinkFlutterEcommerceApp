import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/widgets/continue_button.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_text_field.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                emailController: _passwordController,
                isPassword: true,
                hint: 'Password',
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
                    'Forgot Password ?',
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
