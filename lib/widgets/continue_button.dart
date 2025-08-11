import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    super.key,
    required this.onPressed,
    this.text,
    this.width = double.infinity,
    this.height = 49,
  });
  final VoidCallback onPressed;
  final String? text;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff8E6CEF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        minimumSize: Size(width, height),
        elevation: 0, // Full width button
      ),
      child: Text(
        text ?? AppLocalizations.of(context)!.cont,
        style: AppTextStyles.subTitle1(!isDarkMode),
      ),
    );
  }
}
