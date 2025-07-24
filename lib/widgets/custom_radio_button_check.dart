import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';

class CustomRadioButtonCheck extends StatelessWidget {
  const CustomRadioButtonCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Icon(Icons.check, size: 12, color: Color(0xFFFFFFFf)),
      ),
    );
  }
}
