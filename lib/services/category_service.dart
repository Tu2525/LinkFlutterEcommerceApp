import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all categories
  static Future<List<Map<String, dynamic>>> getCategories() async {
    try {
      final querySnapshot = await _firestore.collection('categories').get();

      final List<Map<String, dynamic>> categories = [];
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        categories.add({
          'id': doc.id,
          'name': data['name'] ?? '',
          'imageUrl': data['imageUrl'] ?? '',
          'description': data['description'] ?? '',
        });
      }

      return categories;
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }
}
