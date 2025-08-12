import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // This is a private constructor

  static const Color primary = Color(0xFF8A2BE2); // Blue Violet
  static const Color secondary = Color(0xFF5F9EA0); // Cadet Blue
  static const Color success = Color(0xFF2E8B57); // Sea Green

  // Light theme colors
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF5F5F5);
  static const Color lightCardBackground = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF000000);
  static const Color lightTextSecondary = Color(0xFF757575);
  static const Color lightBorder = Color(0xFFE0E0E0);

  // Dark theme colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkCardBackground = Color(0xFF2C2C2C);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB3B3B3);
  static const Color darkBorder = Color(0xFF404040);

  // Legacy colors (for backward compatibility)
  static Color? grey = Colors.grey[200];
  static const Color seaAll = Color(0xFF272727);

  static const Color black = Color(0xFF000000);

  static const Color white = Color(0xFFFFFFFF);

  static const Color purple = Color(0xFF8A2BE2);

  // Dynamic colors based on theme
  static Color backgroundColor(bool isDarkMode) =>
      isDarkMode ? darkBackground : lightBackground;

  static Color surfaceColor(bool isDarkMode) =>
      isDarkMode ? darkSurface : lightSurface;

  static Color cardBackgroundColor(bool isDarkMode) =>
      isDarkMode ? darkCardBackground : lightCardBackground;

  static Color textPrimaryColor(bool isDarkMode) =>
      isDarkMode ? darkTextPrimary : lightTextPrimary;

  static Color textSecondaryColor(bool isDarkMode) =>
      isDarkMode ? darkTextSecondary : lightTextSecondary;

  static Color borderColor(bool isDarkMode) =>
      isDarkMode ? darkBorder : lightBorder;
}
