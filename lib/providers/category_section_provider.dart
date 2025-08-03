import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/models/category_model.dart';
import 'package:link_flutter_ecommerce_app/widgets/categories.dart';

final categoryProvider = FutureProvider<List<Categories>>((ref) async {
  final categoriesData =
      await FirebaseFirestore.instance
  .collection('categories')
  .orderBy('sortOrder')
  .get();


  return categoriesData.docs.map((doc) {
    final data = doc.data();
    final model = CategoryModel.fromFireStore(data);

    return Categories(
      imgPath: model.imgPath,
      title: model.categoryName,
      ontap: () {
        
      },
    );
  }).toList();
});
