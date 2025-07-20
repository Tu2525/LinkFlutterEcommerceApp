import 'package:flutter/painting.dart';
class CategoryModel{
  final String imgPath;
  final String categoryName;
  final VoidCallback ontap;
  
  CategoryModel({
    required this.categoryName,
    required this.imgPath ,
    required this.ontap
    });
}
