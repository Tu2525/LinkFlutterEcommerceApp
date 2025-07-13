import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required TextEditingController emailController,
    required this.isPassword,
    required this.hint,
  }) : _emailController = emailController;

  final TextEditingController _emailController;
  final bool isPassword;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _emailController, // Linking the controller
      obscureText: isPassword, // If this is a password field
      decoration: InputDecoration(
        fillColor: Color(0xffF4F4F4),
        filled: true, // To apply the fill color

        hintText: hint,
        hintStyle: TextStyle(color: const Color(0xff27272780)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
