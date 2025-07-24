import 'package:flutter/material.dart';

class CustomRadioButtonCheck extends StatelessWidget {
  const CustomRadioButtonCheck({super.key, required this.isChecked});
  final bool isChecked;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isChecked ? const Color(0xff8E6CEF) : const Color(0xffEFEAF5),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Icon(Icons.check, size: 12, color: Color(0xFFFFFFFf)),
      ),
    );
  }
}
