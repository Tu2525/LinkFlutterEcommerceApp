import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/models/checkout_model.dart';
import 'package:link_flutter_ecommerce_app/providers/cart_item_provider.dart';
import 'package:link_flutter_ecommerce_app/services/user_address_payment.dart';

class AddressInfo {
  final String address, city, state, zipCode, country;
  AddressInfo({
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
  });
}

class PaymentInfo {
  final String cardHolderName, cardNumber, cvv, expiryDate;
  PaymentInfo({
    required this.cardHolderName,
    required this.cardNumber,
    required this.cvv,
    required this.expiryDate,
  });
}

class CheckoutController extends AsyncNotifier<void> {
  @override
  Future<void> build() async => Future.value();

  Future<void> placeOrder({
    required AddressInfo shippingAddress,
    required PaymentInfo paymentDetails,
    required CheckoutModel checkout,
  }) async {
    state = const AsyncValue.loading();

    final cartItems = ref.read(cartProvider);
    final total = ref.read(totalProvider);

    state = await AsyncValue.guard(() async {
      await ref.read(checkoutProvider.notifier).saveCheckoutData(checkout);

      print('Processing payment for: ${paymentDetails.cardHolderName}');
      print('Total amount: $total');
      print('Shipping to: ${shippingAddress.address}, ${shippingAddress.city}');

      await Future.delayed(const Duration(seconds: 2)); // Simulate network call

      ref.read(cartProvider.notifier).clearCart();
    });
  }
}

// The provider definition stays the same
final checkoutControllerProvider =
    AsyncNotifierProvider<CheckoutController, void>(() {
      return CheckoutController();
    });
final checkoutServiceProvider = Provider<CheckoutService>((ref) {
  return CheckoutService();
});

class CheckoutNotifier extends StateNotifier<AsyncValue<CheckoutModel?>> {
  final CheckoutService _service;

  CheckoutNotifier(this._service) : super(const AsyncValue.loading()) {
    getCheckoutData();
  }

  Future<void> getCheckoutData() async {
    try {
      state = const AsyncValue.loading();
      final data = await _service.getCheckoutData();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> saveCheckoutData(CheckoutModel checkout) async {
    try {
      state = const AsyncValue.loading();
      await _service.saveCheckoutData(checkout);
      state = AsyncValue.data(checkout);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final checkoutProvider =
    StateNotifierProvider<CheckoutNotifier, AsyncValue<CheckoutModel?>>((ref) {
      final service = ref.watch(checkoutServiceProvider);
      return CheckoutNotifier(service);
    });
