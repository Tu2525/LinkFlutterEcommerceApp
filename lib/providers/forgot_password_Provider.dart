import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/screens/reset_password%20screen.dart';

class ForgotPasswordManager extends ChangeNotifier {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void submit(BuildContext context) {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ResetPassword()),
    );
  }

  String? validateEmail(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.emptyMessage;
    }
    if (!value.contains('@') || !value.contains('.')) {
      return AppLocalizations.of(context)!.invalidFormatMessage;
    }
    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}

final forgotPasswordProvider = ChangeNotifierProvider<ForgotPasswordManager>(
  (ref) => ForgotPasswordManager(),
);
