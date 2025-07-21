import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/model/category_model.dart';
import 'package:link_flutter_ecommerce_app/widgets/categories.dart';

class CategoriesSection extends StatelessWidget {
  CategoriesSection({super.key});

  final List<CategoryModel> allCategories = [
    CategoryModel(
      categoryName: 'Hoodies',
      imgPath: 'images/Ellipse 1.png',
      ontap: () {},
    ),
    CategoryModel(
      categoryName: 'Shorts',
      imgPath: 'images/Ellipse 2.png',
      ontap: () {},
    ),
    CategoryModel(
      categoryName: 'Shoes',
      imgPath: 'images/Ellipse 3.png',
      ontap: () {},
    ),
    CategoryModel(
      categoryName: 'Bag',
      imgPath: 'images/Ellipse 4.png',
      ontap: () {},
    ),
    CategoryModel(
      categoryName: 'Accessories',
      imgPath: 'images/Ellipse 3 (1).png',
      ontap: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.09),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(flex: 1),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "See All",
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(children: getAllCategories()),
            ],
          ),
        ),
      ],
    );
  }

  List<Categories> getAllCategories() {
    return allCategories
        .map(
          (e) => Categories(
            imgPath: e.imgPath,
            title: e.categoryName,
            ontap: e.ontap,
          ),
        )
        .toList();
  }
}
