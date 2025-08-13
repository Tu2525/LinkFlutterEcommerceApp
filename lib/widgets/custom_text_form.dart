import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        hintStyle: TextStyle(
          color:
              isdarkmode
                  ? Colors.white.withOpacity(0.5)
                  : Colors.black.withOpacity(0.5),
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),

      validator: validator,
      onChanged: onChanged,
    );
  }
}
