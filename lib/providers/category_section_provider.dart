import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/models/category_data.dart';
import 'package:link_flutter_ecommerce_app/widgets/categories.dart';

// Provider that returns CategoryData for use in screens
final categoryDataProvider = FutureProvider<List<CategoryData>>((ref) async {
  final categoriesData =
      await FirebaseFirestore.instance
          .collection('categories')
          .orderBy('sortOrder')
          .get();

  return categoriesData.docs.map((doc) {
    final data = doc.data();
    return CategoryData.fromFireStore(doc.id, data);
  }).toList();
});

// Provider that returns Categories widgets for UI
final categoryProvider = FutureProvider<List<Categories>>((ref) async {
  final categoryDataList = await ref.watch(categoryDataProvider.future);

  return categoryDataList.map((categoryData) {
    return Categories(
      imgPath: categoryData.imageUrl,
      title: categoryData.name,
      categoryId: categoryData.id,
      ontap: () {},
    );
  }).toList();
});
