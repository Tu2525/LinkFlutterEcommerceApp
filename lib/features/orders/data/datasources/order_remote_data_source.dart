import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/order_model.dart';

abstract class OrderRemoteDataSource {
  Stream<List<OrderModel>> getOrdersStream();
  Future<List<OrderModel>> getOrderDetails();
  Future<OrderModel> getOrderById(String orderId);
  Future<void> createOrder(OrderModel order);
  Future<void> updateOrderStatus(String orderId, String newStatus);
  Future<void> updateOrderStep({
    required String orderId,
    required int stepIndex,
    required bool isChecked,
    required String date,
  });
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> createOrder(OrderModel order) async {
    try {
      await _firestore.collection('orders').add(order.toJson());
    } catch (e) {
      throw Exception('Failed to save order: $e');
    }
  }

  @override
  Stream<List<OrderModel>> getOrdersStream() {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: user.uid)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return OrderModel.fromFireStore({
              ...doc.data(),
              'documentId': doc.id,
            });
          }).toList();
        });
  }

  @override
  Future<List<OrderModel>> getOrderDetails() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    try {
      final query =
          await _firestore
              .collection('orders')
              .where('userId', isEqualTo: user.uid)
              .get();

      return query.docs.map((doc) {
        return OrderModel.fromFireStore({...doc.data(), 'documentId': doc.id});
      }).toList();
    } catch (e) {
      throw Exception('Failed to get orders: $e');
    }
  }

@override
Future<OrderModel> getOrderById(String orderId) async {
  final user = _auth.currentUser;
  if (user == null) throw Exception('User not logged in');

  try {
    final querySnapshot = await _firestore
        .collection('orders')
        .where('userId', isEqualTo: user.uid)
        .where('key', isEqualTo: orderId) // Uses the orderId string directly
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final doc = querySnapshot.docs.first;
      return OrderModel.fromFireStore(
          {...doc.data(), 'documentId': doc.id});
    } else {
      throw Exception('Order not found');
    }
  } catch (e) {
    throw Exception('Failed to get order details: e.toString()');
  }
}

  @override
  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({
        'status': newStatus,
      });
    } catch (e) {
      throw Exception('Failed to update order status: $e');
    }
  }

  @override
  Future<void> updateOrderStep({
    required String orderId,
    required int stepIndex,
    required bool isChecked,
    required String date,
  }) async {
    try {
      final orderDoc = await _firestore.collection('orders').doc(orderId).get();
      if (!orderDoc.exists) throw Exception('Order not found');

      final orderData = orderDoc.data()!;
      final steps = List<Map<String, dynamic>>.from(orderData['steps'] ?? []);

      if (stepIndex < steps.length) {
        steps[stepIndex]['isChecked'] = isChecked;
        steps[stepIndex]['date'] = date;

        await _firestore.collection('orders').doc(orderId).update({
          'steps': steps,
        });
      }
    } catch (e) {
      throw Exception('Failed to update order step: $e');
    }
  }
}
