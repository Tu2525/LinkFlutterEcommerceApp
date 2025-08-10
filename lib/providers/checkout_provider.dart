import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/providers/cart_item_provider.dart';

class AddressInfo {
  final String address, city, state, zipCode, country;
  AddressInfo({ required this.address, required this.city, required this.state, required this.zipCode, required this.country });
}
class PaymentInfo {
  final String cardHolderName, cardNumber, cvv, expiryDate;
  PaymentInfo({ required this.cardHolderName, required this.cardNumber, required this.cvv, required this.expiryDate });
}


class CheckoutController extends AsyncNotifier<void> {
  @override
  Future<void> build() async => Future.value();

  // UPDATE THIS METHOD to accept the new data
  Future<void> placeOrder({
    required AddressInfo shippingAddress,
    required PaymentInfo paymentDetails,
  }) async {
    state = const AsyncValue.loading();
    
    final cartItems = ref.read(cartProvider);
    final total = ref.read(totalProvider);

    state = await AsyncValue.guard(() async {
      // THIS IS WHERE YOU USE ALL THE DATA
      // 1. Send cartItems, total, shippingAddress, and paymentDetails
      //    to your payment gateway (e.g., Stripe) or backend API.
      
      print('Processing payment for: ${paymentDetails.cardHolderName}');
      print('Shipping to: ${shippingAddress.address}, ${shippingAddress.city}');
      
      await Future.delayed(const Duration(seconds: 2)); // Simulate network call

      // 2. If payment is successful, clear the cart.
      ref.read(cartProvider.notifier).clearCart();
    });
  }
}

// The provider definition stays the same
final checkoutControllerProvider =
    AsyncNotifierProvider<CheckoutController, void>(() {
  return CheckoutController();
});