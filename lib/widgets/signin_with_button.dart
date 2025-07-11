import 'package:flutter/material.dart';

class SigninWithButton extends StatelessWidget {
  const SigninWithButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
    required this.isdark,
  });
  final VoidCallback onPressed;
  final String text;
  final Widget icon;
  final bool isdark;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: isdark ? Color(0xff342F3F) : Color(0xffF4F4F4),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        minimumSize: Size(double.infinity, 49),
        elevation: 0, // Full width button
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          SizedBox(width: 40),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Circular',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: isdark ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
    );
    ;
  }
}
