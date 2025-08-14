import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';

class FormLabel extends StatelessWidget {
  const FormLabel({
    super.key,
    required this.isDarkMode,
    required this.context,
    required this.text,
  });

  final bool isDarkMode;
  final BuildContext context;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0.h, left: 20.w, right: 20.w),
      child: Text(text, style: AppTextStyles.subTitle1(isDarkMode)),
    );
  }
}
