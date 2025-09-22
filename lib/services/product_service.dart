import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:link_flutter_ecommerce_app/models/product.dart';
import 'package:link_flutter_ecommerce_app/models/review.dart';

class ProductService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch featured section product IDs (top selling, new in)
  static Future<List<String>> _getFeaturedSectionProductIds(
    String sectionName,
  ) async {
    try {
      final doc =
          await _firestore
              .collection('featured_sections')
              .doc(sectionName)
              .get();

      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        final productIds = List<String>.from(data['productIds'] ?? []);
        return productIds;
      }
      return [];
    } catch (e) {
      print('Error fetching featured section $sectionName: $e');
      return [];
    }
  }

  // Fetch products by IDs
  static Future<List<Product>> _getProductsByIds(
    List<String> productIds,
  ) async {
    if (productIds.isEmpty) return [];

    try {
      final List<Product> products = [];

      // Fetch products in batches (Firestore has a limit of 10 for 'in' queries)
      for (int i = 0; i < productIds.length; i += 10) {
        final batch = productIds.skip(i).take(10).toList();

        final querySnapshot =
            await _firestore
                .collection('products')
                .where(FieldPath.documentId, whereIn: batch)
                .get();

        for (var doc in querySnapshot.docs) {
          final data = doc.data();
          final product = _mapFirebaseDataToProduct(doc.id, data);
          products.add(product);
        }
      }

      // Sort products based on the original order in productIds
      products.sort((a, b) {
        final indexA = productIds.indexOf(a.id);
        final indexB = productIds.indexOf(b.id);
        return indexA.compareTo(indexB);
      });

      return products;
    } catch (e) {
      print('Error fetching products by IDs: $e');
      return [];
    }
  }

  // Map Firebase document data to Product model
  static Product _mapFirebaseDataToProduct(
    String id,
    Map<String, dynamic> data,
  ) {
    // Handle image URLs
    List<String> imageUrls = [];
    if (data['imageUrls'] != null) {
      if (data['imageUrls'] is List) {
        imageUrls = List<String>.from(data['imageUrls']);
      } else if (data['imageUrls'] is String) {
        imageUrls = [data['imageUrls']];
      }
    }

    // Create placeholder review if no reviews exist
    List<Review> reviews = [];
    if (data['reviews'] != null && data['reviews'] is List) {
      for (var reviewData in data['reviews']) {
        if (reviewData is Map<String, dynamic>) {
          reviews.add(Review.fromJson(reviewData));
        }
      }
    }

    // If no reviews, add a placeholder
    if (reviews.isEmpty) {
      reviews.add(
        Review(
          author: "Anonymous",
          avatarUrl: "",
          rating: data['rating']?.toDouble() ?? 5.0,
          comment: "Great product!",
          date: "Recent",
        ),
      );
    }

    return Product(
      id: id,
      name: data['name']?.toString() ?? '',
      price: (data['price'] ?? 0).toDouble(),
      originalPrice: data['originalPrice']?.toDouble(),
      imageUrls: imageUrls,
      isFavorite: data['isFavorite'] ?? false,
      category: data['categoryId']?.toString(),
      rating: (data['rating'] ?? 5.0).toDouble(),
      reviews: reviews,
      reviewCount: data['reviewCount'] ?? reviews.length,
      description: data['description']?.toString() ?? '',
    );
  }

  // Fetch top selling products
  static Future<List<Product>> getTopSellingProducts() async {
    try {
      final productIds = await _getFeaturedSectionProductIds('top_selling');
      return await _getProductsByIds(productIds);
    } catch (e) {
      print('Error fetching top selling products: $e');
      return [];
    }
  }

  // Fetch new in products
  static Future<List<Product>> getNewInProducts() async {
    try {
      final productIds = await _getFeaturedSectionProductIds('new_in');
      return await _getProductsByIds(productIds);
    } catch (e) {
      print('Error fetching new in products: $e');
      return [];
    }
  }

  // Fetch products by category
  static Future<List<Product>> getProductsByCategory(String categoryId) async {
    try {
      print('🔍 Searching for products with categoryId: "$categoryId"');

      final querySnapshot =
          await _firestore
              .collection('products')
              .where('categoryId', isEqualTo: categoryId)
              .get();

      print(
        '🔍 Found ${querySnapshot.docs.length} products for categoryId: "$categoryId"',
      );

      final List<Product> products = [];
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        print('🔍 Product ${doc.id}: categoryId = "${data['categoryId']}"');
        final product = _mapFirebaseDataToProduct(doc.id, data);
        products.add(product);
      }

      return products;
    } catch (e) {
      print('❌ Error fetching products by category: $e');
      return [];
    }
  }

  // Fetch all products
  static Future<List<Product>> getAllProducts() async {
    try {
      final querySnapshot = await _firestore.collection('products').get();

      final List<Product> products = [];
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        final product = _mapFirebaseDataToProduct(doc.id, data);
        products.add(product);
      }

      return products;
    } catch (e) {
      print('Error fetching all products: $e');
      return [];
    }
  }

  // Search products by name or description
  static Future<List<Product>> searchProducts(String query) async {
    try {
      final querySnapshot = await _firestore.collection('products').get();

      final List<Product> products = [];
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        final name = data['name']?.toString().toLowerCase() ?? '';
        final description = data['description']?.toString().toLowerCase() ?? '';

        if (name.contains(query.toLowerCase()) ||
            description.contains(query.toLowerCase())) {
          final product = _mapFirebaseDataToProduct(doc.id, data);
          products.add(product);
        }
      }

      return products;
    } catch (e) {
      print('Error searching products: $e');
      return [];
    }
  }
  Stream<List<Product>> searchProductsStream(String query) {
    return FirebaseFirestore.instance.collection('products').snapshots().map((
      snapshot,
    ) {
      final lowerQuery = query.toLowerCase();
      final List<Product> results = [];

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final name = data['name']?.toString().toLowerCase() ?? '';
        final description = data['description']?.toString().toLowerCase() ?? '';

        if (name.contains(lowerQuery) || description.contains(lowerQuery)) {
          results.add(ProductService._mapFirebaseDataToProduct(doc.id, data));
        }
      }

      return results;
    });
  }
}


