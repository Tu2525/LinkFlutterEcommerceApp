// ignore_for_file: camel_case_types


import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C2C2C) : const Color(0xffF4F4F4),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            IconsaxPlusBroken.arrow_left_2,
            size: 16,
            color: isDark ? Colors.white : Colors.black,
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ),
    );
  }
}

