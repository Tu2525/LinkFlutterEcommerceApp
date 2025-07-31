import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection references
  CollectionReference get users => _firestore.collection('users');
  CollectionReference get products => _firestore.collection('products');
  CollectionReference get orders => _firestore.collection('orders');
  CollectionReference get categories => _firestore.collection('categories');

  // User operations
  Future<void> createUser({
    required String uid,
    required Map<String, dynamic> userData,
  }) async {
    await users.doc(uid).set(userData);
  }

  Future<DocumentSnapshot> getUser(String uid) async {
    return await users.doc(uid).get();
  }

  Future<void> updateUser({
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    await users.doc(uid).update(data);
  }

  // Product operations
  Stream<QuerySnapshot> getProducts() {
    return products.orderBy('createdAt', descending: true).snapshots();
  }

  Stream<QuerySnapshot> getProductsByCategory(String categoryId) {
    return products
        .where('categoryId', isEqualTo: categoryId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<DocumentSnapshot> getProduct(String productId) async {
    return await products.doc(productId).get();
  }

  // Order operations
  Future<String> createOrder({
    required String userId,
    required Map<String, dynamic> orderData,
  }) async {
    final docRef = await orders.add({
      ...orderData,
      'userId': userId,
      'createdAt': FieldValue.serverTimestamp(),
      'status': 'pending',
    });
    return docRef.id;
  }

  Stream<QuerySnapshot> getUserOrders(String userId) {
    return orders
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> updateOrderStatus({
    required String orderId,
    required String status,
  }) async {
    await orders.doc(orderId).update({
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Category operations
  Stream<QuerySnapshot> getCategories() {
    return categories.orderBy('name').snapshots();
  }

  // Search operations
  Future<QuerySnapshot> searchProducts(String searchTerm) async {
    return await products
        .where('name', isGreaterThanOrEqualTo: searchTerm)
        .where('name', isLessThanOrEqualTo: '$searchTerm\uf8ff')
        .get();
  }

  // Cart operations (storing in user document)
  Future<void> addToCart({
    required String userId,
    required String productId,
    required int quantity,
  }) async {
    final userDoc = users.doc(userId);
    await userDoc.update({'cart.$productId': quantity});
  }

  Future<void> removeFromCart({
    required String userId,
    required String productId,
  }) async {
    final userDoc = users.doc(userId);
    await userDoc.update({'cart.$productId': FieldValue.delete()});
  }

  Future<void> clearCart(String userId) async {
    final userDoc = users.doc(userId);
    await userDoc.update({'cart': {}});
  }

  // Wishlist operations
  Future<void> addToWishlist({
    required String userId,
    required String productId,
  }) async {
    final userDoc = users.doc(userId);
    await userDoc.update({
      'wishlist': FieldValue.arrayUnion([productId]),
    });
  }

  Future<void> removeFromWishlist({
    required String userId,
    required String productId,
  }) async {
    final userDoc = users.doc(userId);
    await userDoc.update({
      'wishlist': FieldValue.arrayRemove([productId]),
    });
  }
}

// Provider for FirestoreService
final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService();
});
