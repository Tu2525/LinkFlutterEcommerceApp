import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:link_flutter_ecommerce_app/models/checkout_model.dart';

class CheckoutService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser!.uid;

  Future<void> saveCheckoutData(CheckoutModel checkout) async {
    await _firestore
        .collection('users')
        .doc(_uid)
        .set(checkout.toMap(), SetOptions(merge: true));
  }

  Future<CheckoutModel?> getCheckoutData() async {
    final doc = await _firestore.collection('users').doc(_uid).get();
    if (doc.exists && doc.data() != null) {
      return CheckoutModel.fromMap(doc.data()!);
    }
    return null;
  }
}
