import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/screens/products_of_category_screen.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
    required this.imgPath,
    required this.title,
    required this.ontap,
  });

  final String title;
  final String imgPath;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductsOfCategoryScreen(categoryName: title,)))},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: SizedBox(
              height: screenWidth * 0.15,
              width: screenWidth * 0.15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(screenWidth * 0.02),
                child: Image.asset(imgPath, fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.008),
          Text(
            title,
            style: TextStyle(
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
              fontSize: screenWidth * 0.03,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
