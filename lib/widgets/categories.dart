import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
    required this.imgPath,
    required this.title,
  });

  final String title;
  final String imgPath;

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: SizedBox(
            height: screenWidth * 0.15,
            width: screenWidth * 0.15,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
              child: Image.asset(
                imgPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.008),
        Text(
          title,
          style: TextStyle(
            fontSize: screenWidth * 0.03,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
