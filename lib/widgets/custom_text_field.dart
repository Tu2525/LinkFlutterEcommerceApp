import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';

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
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return TextFormField(
      validator: validator,
      controller: _emailController,
      obscureText: isPassword,
      onChanged: onChanged,
      decoration: InputDecoration(
        fillColor: isdark ? const Color(0xff342F3F) : const Color(0xffF4F4F4),
        filled: true,
        hintText: hint,
        hintStyle: AppTextStyles.body2(isDarkMode),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
