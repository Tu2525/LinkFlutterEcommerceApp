import 'dart:math';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order_model.dart';
import '../../models/cartitem_model.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String generateRandomId() {
    final random = Random();
    final randomNumber = random.nextInt(999999);
    return '$randomNumber';
  }

  Future<OrderModel> saveOrderToFirebase({
    required List<CartItem> cartItems,
    required ShippingInfo shipping,
    String status = 'Shipped',
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not logged in ');
    }

    try {
      final orderItems =
          cartItems.map((item) => OrderItem.fromCartItem(item)).toList();

      final totalAmount = cartItems.fold<double>(
        0.0,
        (sum, item) => sum + (item.price * item.quantity),
      );

      final orderSteps = [
        OrderStep(
          title: 'Order Placed',
          isChecked: true,
          date: DateFormat('dMMM').format(DateTime.now()),
        ),
        OrderStep(
          title: 'Processing',
          isChecked: false,
          date: DateFormat('dMMM').format(DateTime.now()),
        ),
        OrderStep(
          title: 'Shipped',
          isChecked: false,
          date: DateFormat('dMMM').format(DateTime.now()),
        ),
        OrderStep(
          title: 'Delivered',
          isChecked: false,
          date: DateFormat('dMMM').format(DateTime.now()),
        ),
      ];

      // Create order model
      final order = OrderModel(
        key: generateRandomId(),
        items: orderItems,
        steps: orderSteps,
        shipping: shipping,
        status: status,
        userId: user.uid,
        createdAt: DateTime.now(),
        totalAmount: totalAmount,
      );

      final docRef = await _firestore.collection('orders').add(order.toJson());

      return order;
    } catch (e) {
      throw Exception('Failed to save order: $e');
    }
  }

  /// Get orders as a stream for real-time updates
  Stream<List<OrderModel>> getOrdersStream() {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: user.uid)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            return OrderModel.fromFireStore({...data, 'idd': doc.id});
          }).toList();
        });
  }

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
        final data = doc.data();
        return OrderModel.fromFireStore({...data, 'idd': doc.id});
      }).toList();
    } catch (e) {
      throw Exception('Failed to get orders: $e');
    }
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    try {
      await _firestore.collection('orders').doc(orderId).update({
        'status': newStatus,
      });
    } catch (e) {
      throw Exception('Failed to update order status: $e');
    }
  }

  Future<void> updateOrderStep(
    String orderId,
    int stepIndex,
    bool isChecked,
    String date,
  ) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

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
