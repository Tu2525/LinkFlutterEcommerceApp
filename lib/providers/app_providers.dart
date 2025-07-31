import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../models/user_model.dart';

// Auth state provider
final authStateProvider = StreamProvider<firebase_auth.User?>((ref) {
  final authService = ref.read(authServiceProvider);
  return authService.authStateChanges;
});

// Current user provider
final currentUserProvider = Provider<firebase_auth.User?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.when(
    data: (user) => user,
    loading: () => null,
    error: (_, __) => null,
  );
});

// User data provider (Firestore user document)
final userDataProvider = StreamProvider.family<UserModel?, String>((
  ref,
  userId,
) {
  final firestoreService = ref.read(firestoreServiceProvider);
  return firestoreService.getUser(userId).asStream().map((doc) {
    if (doc.exists) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  });
});

// Products provider
final productsProvider = StreamProvider((ref) {
  final firestoreService = ref.read(firestoreServiceProvider);
  return firestoreService.getProducts();
});

// Categories provider
final categoriesProvider = StreamProvider((ref) {
  final firestoreService = ref.read(firestoreServiceProvider);
  return firestoreService.getCategories();
});

// User orders provider
final userOrdersProvider = StreamProvider.family<QuerySnapshot, String>((
  ref,
  userId,
) {
  final firestoreService = ref.read(firestoreServiceProvider);
  return firestoreService.getUserOrders(userId);
});

// Cart provider
final cartProvider = StateNotifierProvider<CartNotifier, Map<String, int>>((
  ref,
) {
  return CartNotifier(ref);
});

class CartNotifier extends StateNotifier<Map<String, int>> {
  final Ref ref;

  CartNotifier(this.ref) : super({});

  void addToCart(String productId, int quantity) {
    state = {...state, productId: (state[productId] ?? 0) + quantity};
    _syncWithFirestore();
  }

  void removeFromCart(String productId) {
    final newState = Map<String, int>.from(state);
    newState.remove(productId);
    state = newState;
    _syncWithFirestore();
  }

  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(productId);
    } else {
      state = {...state, productId: quantity};
    }
    _syncWithFirestore();
  }

  void clearCart() {
    state = {};
    _syncWithFirestore();
  }

  int get totalItems => state.values.fold(0, (sum, quantity) => sum + quantity);

  void _syncWithFirestore() async {
    final user = ref.read(currentUserProvider);
    if (user != null) {
      final firestoreService = ref.read(firestoreServiceProvider);
      for (final entry in state.entries) {
        await firestoreService.addToCart(
          userId: user.uid,
          productId: entry.key,
          quantity: entry.value,
        );
      }
    }
  }
}

// Wishlist provider
final wishlistProvider = StateNotifierProvider<WishlistNotifier, List<String>>((
  ref,
) {
  return WishlistNotifier(ref);
});

class WishlistNotifier extends StateNotifier<List<String>> {
  final Ref ref;

  WishlistNotifier(this.ref) : super([]);

  void addToWishlist(String productId) {
    if (!state.contains(productId)) {
      state = [...state, productId];
      _syncWithFirestore(productId, true);
    }
  }

  void removeFromWishlist(String productId) {
    state = state.where((id) => id != productId).toList();
    _syncWithFirestore(productId, false);
  }

  void toggleWishlist(String productId) {
    if (state.contains(productId)) {
      removeFromWishlist(productId);
    } else {
      addToWishlist(productId);
    }
  }

  bool isInWishlist(String productId) => state.contains(productId);

  void _syncWithFirestore(String productId, bool add) async {
    final user = ref.read(currentUserProvider);
    if (user != null) {
      final firestoreService = ref.read(firestoreServiceProvider);
      if (add) {
        await firestoreService.addToWishlist(
          userId: user.uid,
          productId: productId,
        );
      } else {
        await firestoreService.removeFromWishlist(
          userId: user.uid,
          productId: productId,
        );
      }
    }
  }
}
