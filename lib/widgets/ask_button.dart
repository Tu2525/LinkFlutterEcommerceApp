import 'dart:ui';

import 'package:flutter/material.dart';

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
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontFamily: 'Circular',
            fontSize: 12,
            color: isdark ? Colors.white : const Color(0xff000000),
          ),
        ),
        GestureDetector(
          onTap: onpressed,
          child: Text(
            button,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'Circular',
              fontSize: 12,
              color: isdark ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
