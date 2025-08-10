import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order_model.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<OrderModel>> getOrderDetails() async {
    final user = _auth.currentUser; // test it when sign in finish
    if (user == null) throw Exception('User not logged in');

    final query =
        await _firestore
            .collection('orders')
            .where('userId', isEqualTo: user.uid)
            .get();

    return query.docs.map((doc) {
      final data = doc.data();
      log("${query.docs.length}, ${query.docs.first},  ${query.docs}");
      return OrderModel.fromFireStore({...data, 'id': doc.id});
    }).toList();
  }
}
