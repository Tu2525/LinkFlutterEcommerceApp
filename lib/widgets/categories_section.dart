import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/model/category_model.dart';
import 'package:link_flutter_ecommerce_app/screens/categories_list_screen.dart';
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Categories",
                      style: AppTextStyles.sectionTitle(isDarkMode),
                      ),
                    const Spacer(flex: 1),
                    GestureDetector(
                      onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CategoriesList(),
                    ),
                  );
                },
                      child: Text(
                        "See All",
                        style: AppTextStyles.seeAll(isDarkMode),
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
