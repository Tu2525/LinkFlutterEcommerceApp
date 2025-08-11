import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';

class CustomTextForm extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String hint;
  final String? Function(String?)? validator;
  final bool isdarkmode;
  const CustomTextForm({
    super.key,
    required this.controller,
    required this.inputType,
    required this.hint,
    this.validator,
    required this.isdarkmode,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bordercolor =
        isdarkmode
            ? Colors.white.withOpacity(0.2)
            : Colors.black.withOpacity(0.2);
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      cursorColor: isdarkmode ? Colors.white : Colors.black,
      decoration: InputDecoration(
        filled: true,
        fillColor:
            isdarkmode ? const Color(0xff342F3F) : const Color(0xffF4F4F4),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: bordercolor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: bordercolor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: bordercolor),
        ),
        hintText: hint,
        hintStyle: AppTextStyles.subTitle1(isDarkMode),
      ),

      validator: validator,
    );
  }
}
