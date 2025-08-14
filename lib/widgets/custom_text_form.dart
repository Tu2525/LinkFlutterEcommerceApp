import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';

class CustomTextForm extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String hint;
  final String? Function(String?)? validator;
  final bool isdarkmode;
  final void Function(String)? onChanged;
  const CustomTextForm({
    super.key,
    required this.controller,
    required this.inputType,
    required this.hint,
    this.validator,
    required this.isdarkmode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bordercolor = AppColors.borderColor(isDarkMode);
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      cursorColor: isdarkmode ? Colors.white : Colors.black,
      decoration: InputDecoration(
        filled: true,
        fillColor:
            AppColors.surfaceColor(isDarkMode),
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
        hintStyle: TextStyle(
          color:
              isdarkmode
                  ? Colors.white.withValues(alpha: 0.5)
                  : Colors.black.withValues(alpha: 0.5),
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),

      validator: validator,
      onChanged: onChanged,
    );
  }
}
