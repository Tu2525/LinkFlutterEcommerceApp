import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:link_flutter_ecommerce_app/models/notification_model.dart';

class NotificationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  Future<List<NotificationModel>> fetchNotificationData() async {
    await Future.delayed(const Duration(seconds: 1)); 
    //final user = _auth.currentUser;// test it when sign in finish 
    //if (user == null) throw Exception('User not logged in');
      final query = await _firestore
        .collection('notifications')
        //.where('userId', isEqualTo: user.uid)
        .get();
      log("${query.docs}, ${query.size}");  
      return query.docs.map((doc) {
      final data = doc.data();
      return NotificationModel.fromFireStore({
        ...data,
        'id': doc.id,
      });
    }).toList();     
  }
}