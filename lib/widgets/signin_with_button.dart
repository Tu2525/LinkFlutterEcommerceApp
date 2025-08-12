import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';

class SigninWithButton extends StatelessWidget {
  const SigninWithButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
    required this.isdark,
  });
  final VoidCallback onPressed;
  final String text;
  final Widget icon;
  final bool isdark;
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isdark ? const Color(0xFF444444) : const Color(0xffF4F4F4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        minimumSize: const Size(double.infinity, 49),
        elevation: 0, // Full width button
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon,
          SizedBox(width: 35.w),
          Text(text, style: AppTextStyles.subTitle1(isDarkMode)),
        ],
      ),
    );
  }
}
