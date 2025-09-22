// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:link_flutter_ecommerce_app/models/cartitem_model.dart'; // Your new CartItem model

// class CartNotifier extends StateNotifier<List<CartItem>> {
//   CartNotifier() : super([]);

//   void addItem({
//     required String productId,
//     required String productName,
//     required String productImageUrl,
//     required double productPrice,
//     required int quantity,
//     required String color,
//     required String size,
//   }) {
//     final existingItemIndex = state.indexWhere((item) =>
//         item.id == productId &&
//         item.size == size &&
//         item.color == color);

//     if (existingItemIndex != -1) {
//       final existingItem = state[existingItemIndex];
//       final updatedItem =
//           existingItem.copyWith(quantity: existingItem.quantity + quantity);
      
//       final updatedState = List<CartItem>.from(state);
//       updatedState[existingItemIndex] = updatedItem;
//       state = updatedState;

//     } else {
//       state = [
//         ...state,
//         CartItem(
//           id: productId,
//           name: productName,
//           imageUrl: productImageUrl,
//           price: productPrice,
//           quantity: quantity,
//           color: color,
//           size: size, selectedSize: ' ',
//         )
//       ];
//     }
//   }
// }

// final cartProvider =
//     StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
//   return CartNotifier();
// });