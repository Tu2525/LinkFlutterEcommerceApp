import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_text_form.dart';

class BuildTextForm extends StatelessWidget {
  const BuildTextForm({
    super.key,
    required this.isDarkMode,
    required this.ref,
    required this.context,
    required this.controller,
    required this.hint,
    required this.inputType,
    required this.validator,
    required this.stateProvider,
  });

  final bool isDarkMode;
  final WidgetRef ref;
  final BuildContext context;
  final TextEditingController controller;
  final String hint;
  final TextInputType inputType;
  final String? Function(String? p1) validator;
  final StateProvider<String> stateProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: CustomTextForm(
        controller: controller,
        isdarkmode: isDarkMode,
        inputType: inputType,
        hint: hint,
        validator: validator,
        onChanged: (value) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(stateProvider.notifier).state = value;
          });
        },
      ),
    );
  }
}
