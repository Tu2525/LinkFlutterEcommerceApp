import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/screens/reset_password%20screen.dart';
import 'package:link_flutter_ecommerce_app/widgets/continue_button.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_back_icon.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_text_field.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({super.key});

  final emailController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                isdark: Theme.of(context).brightness == Brightness.dark,
                emailController: firstnameController,
                isPassword: false,
                hint: "Firstname",
              ),
              const SizedBox(height: 16),
              CustomTextField(
                isdark: Theme.of(context).brightness == Brightness.dark,
                emailController: lastnameController,
                isPassword: false,
                hint: "Lastname",
              ),
              const SizedBox(height: 16),
              CustomTextField(
                isdark: Theme.of(context).brightness == Brightness.dark,
                emailController: emailController,
                isPassword: false,
                hint: "Email Address",
              ),
              const SizedBox(height: 16),
              CustomTextField(
                isdark: Theme.of(context).brightness == Brightness.dark,
                emailController: passwordController,
                isPassword: true,
                hint: "Password",
              ),
              const SizedBox(height: 40),
              ContinueButton(onPressed: () {}),
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
                          builder: (context) => const ResetPassword(),
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
