import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    this.text,
    this.width = double.infinity,
    this.height = 52,
    this.row,
  });
  final VoidCallback onPressed;
  final String? text;
  final double width;
  final double height;
  final Widget? row;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        minimumSize: Size(width, height),
        elevation: 0, // Full width button
      ),

      child:
          row != null
              ? row!
              : Text(
                text ?? AppLocalizations.of(context)!.cont,
                style: const TextStyle(color: Colors.white),
              ),
    );
  }
}
