import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';

class OnboardingScreenWidget extends StatelessWidget {
  const OnboardingScreenWidget({
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
  final Color? color;
  final Color? color2;
  final int index;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;
    final titleFontSize = screenWidth * 0.065;
    final subtitleFontSize = screenWidth * 0.04;
    final iconSize = screenWidth * 0.08;
    final imageHeight = screenHeight * 0.33;
    final verticalSpacing = screenHeight * 0.03;
    final largeSpacing = screenHeight * 0.05;

    return Scaffold(
      body: Container(
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: getCrossAxisAlignment(index),
              children: [
                SizedBox(height: verticalSpacing),
                Image.asset(
                  'images/icon.png',
                  width: iconSize,
                  height: iconSize,
                  color: color ?? Colors.white,
                ),
                Text(
                  AppLocalizations.of(context)!.ecommerceShop,
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    AppLocalizations.of(context)!.professionalAppForYour,
                    style: TextStyle(
                      color: color2 ?? Colors.white,
                      fontSize: subtitleFontSize,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    AppLocalizations.of(context)!.ecommerceBusiness,
                    style: TextStyle(
                      color: color2 ?? Colors.white,
                      fontSize: subtitleFontSize,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: largeSpacing),
                Center(
                  child: Image.asset(
                    iconPath,
                    height: imageHeight,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: largeSpacing),
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Center(
                    child: Text(
                      subtitle1,
                      style: TextStyle(fontSize: subtitleFontSize),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

CrossAxisAlignment getCrossAxisAlignment(int index) {
  switch (index) {
    case 0:
      return CrossAxisAlignment.start;
    case 1:
      return CrossAxisAlignment.center;
    default:
      return CrossAxisAlignment.end;
  }
}
