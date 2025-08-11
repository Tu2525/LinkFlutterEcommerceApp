
import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';

class AskButton extends StatelessWidget {
  const AskButton({
    super.key,
    required this.text,
    required this.button,
    required this.onpressed,
    required this.isdark,
  });
  final String text;
  final String button;
  final VoidCallback onpressed;
  final bool isdark;
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Text(
          text,
          style: AppTextStyles.body2(isDarkMode),
        ),
        GestureDetector(
          onTap: onpressed,
          child: Text(
            button,
            style: AppTextStyles.heading6(isDarkMode),
          ),
        ),
      ],
    );
  }
}
