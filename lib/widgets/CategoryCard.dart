// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isDarkMode;
  final double screenHeight;
  final double screenWidth;

  const CategoryCard({super.key, 
    required this.image,
    required this.title,
    required this.isDarkMode,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      height: screenHeight * 0.08,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xff272727) : const Color(0xffF4F4F4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(image),
            radius: screenWidth * 0.06,
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Circular',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: isDarkMode ? Colors.white : const Color(0xff272727),
            ),
          ),
        ],
      ),
    );
  }
}
