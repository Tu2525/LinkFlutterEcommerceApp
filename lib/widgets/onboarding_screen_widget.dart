import 'package:flutter/material.dart';

class OnboardingScreenWidget extends StatelessWidget {
  OnboardingScreenWidget({
    super.key,
    required this.title,
    required this.subtitle1,
    required this.imagePath,
    required this.iconPath,
    this.color,
    this.color2,
    required this.index,
  });

  final String title;
  final String subtitle1;
  final String imagePath;
  final String iconPath;
  Color? color;
  Color? color2;
  final int index;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;

        double titleFontSize = screenWidth * 0.065;
        double subtitleFontSize = screenWidth * 0.04;
        double sizedBoxHeight = screenHeight * 0.1;

        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.08,
              horizontal: screenWidth * 0.06,
            ),
            child: Column(
              crossAxisAlignment: getCrossAxisAlignment(index),

              children: [
                SizedBox(height: screenHeight * 0.05),
                Image.asset(
                  'images/icon.png',
                  width: screenWidth * 0.08,
                  height: screenWidth * 0.08,
                  color: color ?? Colors.white,
                ),
                Text(
                  'eCommerce Shop',
                  style: TextStyle(
                    color: color ?? Colors.white,
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.6,
                  child: Divider(color: color ?? Colors.white, thickness: 1),
                ),
                Text(
                  "Professional App for your",
                  style: TextStyle(
                    color: color2 ?? Colors.white,
                    fontSize: subtitleFontSize,
                  ),
                ),
                Text(
                  "eCommerce business",
                  style: TextStyle(
                    color: color2 ?? Colors.white,
                    fontSize: subtitleFontSize,
                  ),
                ),
                SizedBox(height: sizedBoxHeight),
                Center(
                  child: Image.asset(iconPath, height: screenHeight * 0.33),
                ),
                SizedBox(height: sizedBoxHeight),
                Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    subtitle1,
                    style: TextStyle(fontSize: subtitleFontSize),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

CrossAxisAlignment getCrossAxisAlignment(int index) {
  switch (index) {
    case 2:
      return CrossAxisAlignment.start;
    case 1:
      return CrossAxisAlignment.center;
    default:
      return CrossAxisAlignment.end;
  }
}
