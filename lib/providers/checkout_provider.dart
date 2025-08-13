import 'dart:async';

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

class CheckoutNotifier extends StateNotifier<AsyncValue<List<CheckoutModel>>> {
  final CheckoutService _service;
  StreamSubscription<List<CheckoutModel>>? _subscription;

  CheckoutNotifier(this._service) : super(const AsyncValue.loading()) {
    _listenToCheckoutData();
  }

  void _listenToCheckoutData() {
    _subscription?.cancel();

    _subscription = _service.getCheckoutDataStream().listen(
      (data) {
        state = AsyncValue.data(data);
      },
      onError: (e, st) {
        state = AsyncValue.error(e, st);
      },
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> saveCheckoutData(CheckoutModel checkout) async {
    try {
      await _service.saveCheckoutData(checkout);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateCheckoutData(CheckoutModel checkout) async {
    try {
      await _service.updateCheckoutData(checkout);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final checkoutProvider =
    StateNotifierProvider<CheckoutNotifier, AsyncValue<List<CheckoutModel>>>(
      (ref) => CheckoutNotifier(ref.watch(checkoutServiceProvider)),
    );


    
final addressTextProvider = StateProvider<String>((ref) => '');
final cityTextProvider = StateProvider<String>((ref) => '');
final countryTextProvider = StateProvider<String>((ref) => '');
final zipCodeTextProvider = StateProvider<String>((ref) => '');
final stateTextProvider = StateProvider<String>((ref) => '');
final nameTextProvider = StateProvider<String>((ref) => '');
final cardNumberTextProvider = StateProvider<String>((ref) => '');
final cvvTextProvider = StateProvider<String>((ref) => '');
final expiryTextProvider = StateProvider<String>((ref) => '');

final isFormValidProvider = Provider<bool>((ref) {
  return ref.watch(addressTextProvider).trim().isNotEmpty &&
      ref.watch(cityTextProvider).trim().isNotEmpty &&
      ref.watch(countryTextProvider).trim().isNotEmpty &&
      ref.watch(zipCodeTextProvider).trim().isNotEmpty &&
      ref.watch(stateTextProvider).trim().isNotEmpty &&
      ref.watch(nameTextProvider).trim().isNotEmpty &&
      ref.watch(cardNumberTextProvider).trim().isNotEmpty &&
      ref.watch(cvvTextProvider).trim().isNotEmpty &&
      ref.watch(expiryTextProvider).trim().isNotEmpty;
});
