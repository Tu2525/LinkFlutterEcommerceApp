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
        .collection('checkouts')
        .add(checkout.toMap());
  }

  Stream<List<CheckoutModel>> getCheckoutDataStream() {
    return _firestore
        .collection('users')
        .doc(_uid)
        .collection('checkouts')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return CheckoutModel.fromMap(doc.data(), id: doc.id);
            }).toList());
  }

  Future<void> updateCheckoutData(CheckoutModel checkout) async {
    if (checkout.id == null) {
      throw Exception("Checkout ID is required for update");
    }
    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('checkouts')
        .doc(checkout.id)
        .update(checkout.toMap());
  }

  Future<void> deleteCheckoutData(String checkoutId) async {
    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('checkouts')
        .doc(checkoutId)
        .delete();
  }
}

