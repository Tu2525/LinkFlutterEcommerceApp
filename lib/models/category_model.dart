import 'dart:ui';

class CategoryModel {
  final String imgPath;
  final String categoryName;
  final VoidCallback ontap;

  CategoryModel({
    required this.categoryName,
    required this.imgPath,
    required this.ontap,
  });
}
