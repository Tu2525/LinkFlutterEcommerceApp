import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_back_icon.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.isDarkMode,
    required this.title,
  });

  final bool isDarkMode;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 48.h),
      child: Row(
        children: [
          const CustomIcon(),
          SizedBox(width: 100.w),
          Text(title, style: AppTextStyles.heading3(isDarkMode)),
        ],
      ),
    );
  }
}
