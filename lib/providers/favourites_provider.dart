import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesNotifier extends StateNotifier<List<String>> {
  FavoritesNotifier(this.userId) : super([]) {
    _listenToFavorites();
  }

  final String userId;

  void _listenToFavorites() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        final favs = List<String>.from(snapshot.data()!['favorites'] ?? []);
        state = favs;
      }
    });
  }

  Future<void> toggleFavorite(String productId) async {
    final userRef =
        FirebaseFirestore.instance.collection("users").doc(userId);

    final snapshot = await userRef.get();
    if (!snapshot.exists) return;
    
 final currentFavs = List<String>.from(snapshot.data()?['favorites'] ?? []);
     if (currentFavs.contains(productId)) {
      currentFavs.remove(productId);
    } else {
      currentFavs.add(productId);
    }

    await userRef.update({"favorites": currentFavs});
  }
}

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final user = _auth.currentUser;
final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<String>>((ref) {
  return FavoritesNotifier(user!.uid);
});
