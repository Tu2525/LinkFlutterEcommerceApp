import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInEmailProvider = StateProvider<String>((ref) => '');
final signInDarkModeProvider = StateProvider<bool>((ref) => false);
final signInPasswordProvider = StateProvider<String>((ref) => '');

// Email validation: not empty, valid email format, extensible for Firebase
typedef ValidationResult = String?;

ValidationResult validateEmail(
  String? value, {
  String emptyMessage = 'Email is required',
  String invalidFormatMessage = 'Enter a valid email address',
  RegExp? emailRegex,
}) {
  if (value == null || value.isEmpty) {
    return emptyMessage;
  }
  final regex = emailRegex ?? RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!regex.hasMatch(value)) {
    return invalidFormatMessage;
  }
  // Add Firebase-specific checks here in the future
  return null;
}

// Password validation: not empty, min 8 chars, at least one letter and one number, extensible for Firebase
ValidationResult validatePassword(
  String? value, {
  String emptyMessage = 'Password is required',
  String minLengthMessage = 'Password must be at least 8 characters',
  String patternMessage = 'Password must contain letters and numbers',
  int minLength = 8,
  RegExp? pattern,
}) {
  if (value == null || value.isEmpty) {
    return emptyMessage;
  }
  if (value.length < minLength) {
    return minLengthMessage;
  }
  final pwPattern =
      pattern ?? RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  if (!pwPattern.hasMatch(value)) {
    return patternMessage;
  }
  // Add Firebase-specific checks here in the future
  return null;
}
