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
<<<<<<< HEAD
        backgroundColor: isdark ? Color(0xff342F3F) : Color(0xffF4F4F4),
=======
        backgroundColor: const Color(0xffF4F4F4),
>>>>>>> origin/develop

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        minimumSize: const Size(double.infinity, 49),
        elevation: 0, // Full width button
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 40),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Circular',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: isdark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
