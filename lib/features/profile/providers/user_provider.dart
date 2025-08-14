import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/features/profile/models/user_model.dart';

final userProvider = StreamProvider<UserModel?>((ref) {
  final user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    return docRef.snapshots().map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        return UserModel.fromJson(snapshot.data()!);
      }
      return null;
    });
  }
  
  return Stream.value(null);
  
});
final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final userDocumentProvider = StreamProvider<UserModel?>((ref) {
  final auth = FirebaseAuth.instance;
  
  return auth.authStateChanges().asyncMap((user) {
    if (user != null) {
      final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
      return docRef.get().then((snapshot) {
        if (snapshot.exists && snapshot.data() != null) {
          return UserModel.fromFirestore(snapshot.data()!);
        }
        return null;
      });
    }
    return null;
  });
});