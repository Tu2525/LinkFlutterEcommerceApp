import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required TextEditingController emailController,
    required this.isPassword,
    required this.hint,
    required this.isdark,
    this.validator,
    this.onChanged,
  }) : _emailController = emailController;

  final TextEditingController _emailController;
  final bool isPassword;
  final String hint;
  final bool isdark;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: _emailController,
      obscureText: isPassword,
      onChanged: onChanged,
      decoration: InputDecoration(
        fillColor: isdark ? const Color(0xff342F3F) : const Color(0xffF4F4F4),
        filled: true,
        hintText: hint,
        hintStyle: TextStyle(
          color: isdark ? const Color(0xffffffff8) : const Color(0xff27272780),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
