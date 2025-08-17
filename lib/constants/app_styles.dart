import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle heading1(bool isDarkMode) {
    return TextStyle(
      fontSize: 48.0,
      fontWeight: FontWeight.bold,
      color: isDarkMode ? Colors.white : Colors.black,
    );
  }

  static TextStyle heading2(bool isDarkMode) {
    return TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: isDarkMode ? Colors.white : Colors.black,
    );
  }

  static TextStyle heading3(bool isDarkMode) {
    return TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: isDarkMode ? Colors.white : Colors.black,
    );
  }

  static TextStyle heading4(bool isDarkMode) {
    return TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: isDarkMode ? Colors.white : Colors.black,
    );
  }

  static TextStyle heading5(bool isDarkMode) {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: isDarkMode ? Colors.white : Colors.black,
    );
  }

  static TextStyle heading6(bool isDarkMode) {
    return TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      color: isDarkMode ? Colors.white : Colors.black,
    );
  }

  static TextStyle bodyText(bool isDarkMode) {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      // A lighter grey for dark mode
      color: isDarkMode ? Colors.white : Colors.grey.shade700,
    );
  }

  static TextStyle body1(bool isDarkMode) {
    return TextStyle(
      fontSize: 16.0,
      color: isDarkMode ? Colors.white : Colors.black,
    );
  }

  static TextStyle body2(bool isDarkMode) {
    return TextStyle(
      fontSize: 14.0,
      color: isDarkMode ? Colors.white : Colors.black,
    );
  }

  static TextStyle body3(bool isDarkMode) {
    return TextStyle(
      fontSize: 12.0,
      color: isDarkMode ? Colors.white : Colors.black,
    );
  }
  static TextStyle subTitle1(bool isDarkMode) {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: isDarkMode ? Colors.white : Colors.black,
    );
  }

  static TextStyle subTitle2(bool isDarkMode) {
    return TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: isDarkMode ? Colors.white : Colors.black,
    );
  }

  static TextStyle seeAll(bool isDarkMode) {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: isDarkMode ? Colors.white : Colors.black,
    );
  }

  static TextStyle viewAll() {
    return const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: Color(0xff8E6CEF),
    );
  }

  static const TextStyle buttonLabel = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  //specialized text styles
  static const TextStyle price = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w600,
    color: Color(0xFF8A2BE2),
  );
  static const TextStyle faintGrey = TextStyle(
    fontSize: 16.0,
    color: Colors.grey,
  );
  static const TextStyle faintGrey2 = TextStyle(
    fontSize: 12.0,
    color: Colors.grey,
  );
  static const TextStyle review = TextStyle(fontSize: 15.0, color: Colors.grey);
  static const TextStyle review2 = TextStyle(
    fontSize: 12.0,
    color: Colors.grey,
  );
  static TextStyle priceSummaryRow(BuildContext context) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: .7),
    );
  }

  static TextStyle priceSummaryRowTotal(BuildContext context) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  static final labelStyle = TextStyle(
    color: Colors.grey.shade600,
    fontSize: 14,
  );
  static final valueStyle = const TextStyle(fontWeight: FontWeight.bold);
  static final totalStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static const TextStyle error = TextStyle(color: Colors.red);
}
