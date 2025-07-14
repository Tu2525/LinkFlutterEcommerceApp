import 'package:flutter/material.dart';

class GenderButton extends StatelessWidget {
  final String gender;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderButton({
    super.key,
    required this.gender,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color:
                isSelected
                    ? const Color(0xff8E6CEF)
                    : Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF342F3F)
                    : const Color(0xffF4F4F4),
            borderRadius: BorderRadius.circular(24),
          ),
          alignment: Alignment.center,
          child: Text(
            gender,
            style: TextStyle(
              color:
                  isSelected
                      ? Colors.white
                      : Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
