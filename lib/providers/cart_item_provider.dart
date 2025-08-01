import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/models/cartitem_model.dart';
import 'package:link_flutter_ecommerce_app/utils/mock_product_data.dart';

class CartController extends StateNotifier<List<CartItem>> {
  CartController() : super(placeHolderOrders);

  void addItem(CartItem item) {
    final existingIndex = state.indexWhere((i) => i.id == item.id);
    if (existingIndex != -1) {
      final updatedItem = state[existingIndex].copyWith(
        quantity: state[existingIndex].quantity + 1,
      );
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == existingIndex) updatedItem else state[i],
      ];
    } else {
      state = [...state, item];
    }
  }

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
                return null;
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


final cartProvider = StateNotifierProvider<CartController, List<CartItem>>((ref) {
  return CartController();
});

final totalProvider = Provider<double>((ref) {
    final cartItems = ref.watch(cartProvider);
    final subtotal = cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
    const shippingCost = 8.00;
    return subtotal + shippingCost;
});