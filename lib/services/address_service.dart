import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:link_flutter_ecommerce_app/models/address_model.dart';

class AddressService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user's addresses
  Stream<List<AddressModel>> getUserAddresses() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      return Stream.value([]);
    }

    return _firestore
        .collection('users')
        .doc(userId)
        .collection('addresses')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return AddressModel.fromMap({...doc.data(), 'id': doc.id});
          }).toList();
        });
  }

  // Add a new address
  Future<String> addAddress(AddressModel address) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    try {
      final docRef = await _firestore
          .collection('users')
          .doc(userId)
          .collection('addresses')
          .add(address.toMap());

      return docRef.id;
    } catch (e) {
      throw Exception('Failed to add address: $e');
    }
  }

  // Update an existing address
  Future<void> updateAddress(String addressId, AddressModel address) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('addresses')
          .doc(addressId)
          .update(address.toMap());
    } catch (e) {
      throw Exception('Failed to update address: $e');
    }
  }

  // Delete an address
  Future<void> deleteAddress(String addressId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('addresses')
          .doc(addressId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete address: $e');
    }
  }

  // Get a specific address by ID
  Future<AddressModel?> getAddressById(String addressId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    try {
      final doc =
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('addresses')
              .doc(addressId)
              .get();

      if (doc.exists) {
        return AddressModel.fromMap({...doc.data()!, 'id': doc.id});
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get address: $e');
    }
  }
}
