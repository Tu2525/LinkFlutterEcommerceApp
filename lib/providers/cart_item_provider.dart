import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/models/cartitem_model.dart';

// No longer need to import mock_product_data.dart

class CartController extends StateNotifier<List<CartItem>> {
  // 1. Initialize with an empty list for a real user session.
  CartController() : super([]);

  void addItem(
    CartItem item, {
    required String productId,
    required String productName,
  }) {
    // 2. Check for an item with the same ID, size, AND color.
    final existingIndex = state.indexWhere(
      (i) => i.id == item.id && i.size == item.size && i.color == item.color,
    );

    if (existingIndex != -1) {
      // 3. If it exists, update the quantity correctly.
      final updatedItem = state[existingIndex].copyWith(
        // Add the quantity from the new item, not just incrementing by 1.
        quantity: state[existingIndex].quantity + item.quantity,
      );
      // Rebuild the state list
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == existingIndex) updatedItem else state[i],
      ];
    } else {
      // If no matching item is found, add the new item to the cart.
      state = [...state, item];
    }
  }

  // The rest of your methods are great and don't need changes.
  void increment(String itemId) {
    state = [
      for (final item in state)
        if (item.id == itemId)
          item.copyWith(quantity: item.quantity + 1)
        else
          item,
    ];
  }

  void decrement(String itemId) {
    state =
        state
            .map((item) {
              if (item.id == itemId) {
                if (item.quantity > 1) {
                  return item.copyWith(quantity: item.quantity - 1);
                }
                return null; // This will remove the item if quantity is 1
              }
              return item;
            })
            .whereType<CartItem>()
            .toList();
  }

  void clearCart() {
    state = [];
  }

  double get subtotal =>
      state.fold(0, (total, item) => total + (item.price * item.quantity));
}

final cartProvider = StateNotifierProvider<CartController, List<CartItem>>((
  ref,
) {
  return CartController();
});

final totalProvider = Provider<double>((ref) {
  final cartItems = ref.watch(cartProvider);
  final subtotal = cartItems.fold(
    0.0,
    (sum, item) => sum + (item.price * item.quantity),
  );
  const shippingCost = 8.00;
  return subtotal + shippingCost;
});
