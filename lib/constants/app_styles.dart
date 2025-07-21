// lib/constants/app_styles.dart
import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle heading1(bool isDarkMode) {
    return TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: isDarkMode ? Colors.white : Colors.black,
    );
  }

  static TextStyle bodyText(bool isDarkMode) {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      // A lighter grey for dark mode
      color: isDarkMode ? Colors.white70 : Colors.grey.shade700,
    );
  }

  static TextStyle sectionTitle(bool isDarkMode) {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
      color: isDarkMode ? Colors.white : Colors.black,
    );
  }

  static TextStyle seeAll(bool isDarkMode) {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: isDarkMode ? Colors.white : AppColors.seaAll,
    );
  }

  static const TextStyle buttonLabel = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}