import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/model/category_model.dart';
import 'package:link_flutter_ecommerce_app/widgets/categories.dart';

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

final categoryProvider = Provider<List<Categories>>((ref) {
  return getAllCategories();
});
