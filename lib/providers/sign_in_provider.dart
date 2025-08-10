import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';

final signInEmailProvider = StateProvider<String>((ref) => '');
final signInDarkModeProvider = StateProvider<bool>((ref) => false);
final signInPasswordProvider = StateProvider<String>((ref) => '');

// Email validation: not empty, valid email format, extensible for Firebase
typedef ValidationResult = String?;

ValidationResult validateEmail(
  BuildContext context,
  String? value, {
  RegExp? emailRegex,
}) {
  if (value == null || value.isEmpty) {
    return AppLocalizations.of(context)!.emptyMessage;
  }
  final regex = emailRegex ?? RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!regex.hasMatch(value)) {
    return AppLocalizations.of(context)!.invalidFormatMessage;
  }
  // Add Firebase-specific checks here in the future
  return null;
}

// Password validation: not empty, min 8 chars, at least one letter and one number, extensible for Firebase
ValidationResult validatePassword(
  BuildContext context,
  String? value, {
  int minLength = 8,
  RegExp? pattern,
}) {
  if (value == null || value.isEmpty) {
    return AppLocalizations.of(context)!.emptyPassword;
  }
  return null;
}
