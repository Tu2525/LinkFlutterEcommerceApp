// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class Custom_Icon extends StatelessWidget {
  const Custom_Icon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Color(0xffF4F4F4),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.black),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
      ),
    );
  }
}
