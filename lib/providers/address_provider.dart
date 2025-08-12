import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/models/address_model.dart';
import 'package:link_flutter_ecommerce_app/services/address_service.dart';

// Address service provider
final addressServiceProvider = Provider<AddressService>((ref) {
  return AddressService();
});

// User addresses stream provider
final userAddressesProvider = StreamProvider<List<AddressModel>>((ref) {
  final addressService = ref.read(addressServiceProvider);
  return addressService.getUserAddresses();
});

// Selected address provider
final selectedAddressProvider = StateProvider<AddressModel?>((ref) => null);

// Loading state for address operations
final addressLoadingProvider = StateProvider<bool>((ref) => false);

// Error state for address operations
final addressErrorProvider = StateProvider<String>((ref) => '');

// Success state for address operations
final addressSuccessProvider = StateProvider<bool>((ref) => false);

// Address operations provider
final addressOperationsProvider = Provider<AddressOperations>((ref) {
  return AddressOperations(ref);
});

class AddressOperations {
  final Ref ref;

  AddressOperations(this.ref);

  Future<void> addAddress({
    required String streetAddress,
    required String city,
    required String state,
    required String zipCode,
  }) async {
    ref.read(addressLoadingProvider.notifier).state = true;
    ref.read(addressErrorProvider.notifier).state = '';
    ref.read(addressSuccessProvider.notifier).state = false;

    try {
      final address = AddressModel(
        id: '', // Will be set by Firestore
        streetAddress: streetAddress,
        city: city,
        state: state,
        zipCode: zipCode,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final addressService = ref.read(addressServiceProvider);
      await addressService.addAddress(address);

      ref.read(addressSuccessProvider.notifier).state = true;
    } catch (e) {
      ref.read(addressErrorProvider.notifier).state = e.toString();
    } finally {
      ref.read(addressLoadingProvider.notifier).state = false;
    }
  }

  Future<void> updateAddress({
    required String addressId,
    required String streetAddress,
    required String city,
    required String state,
    required String zipCode,
  }) async {
    ref.read(addressLoadingProvider.notifier).state = true;
    ref.read(addressErrorProvider.notifier).state = '';
    ref.read(addressSuccessProvider.notifier).state = false;

    try {
      final address = AddressModel(
        id: addressId,
        streetAddress: streetAddress,
        city: city,
        state: state,
        zipCode: zipCode,
        createdAt: DateTime.now(), // This will be ignored in update
        updatedAt: DateTime.now(),
      );

      final addressService = ref.read(addressServiceProvider);
      await addressService.updateAddress(addressId, address);

      ref.read(addressSuccessProvider.notifier).state = true;
    } catch (e) {
      ref.read(addressErrorProvider.notifier).state = e.toString();
    } finally {
      ref.read(addressLoadingProvider.notifier).state = false;
    }
  }

  Future<void> deleteAddress(String addressId) async {
    ref.read(addressLoadingProvider.notifier).state = true;
    ref.read(addressErrorProvider.notifier).state = '';

    try {
      final addressService = ref.read(addressServiceProvider);
      await addressService.deleteAddress(addressId);

      ref.read(addressSuccessProvider.notifier).state = true;
    } catch (e) {
      ref.read(addressErrorProvider.notifier).state = e.toString();
    } finally {
      ref.read(addressLoadingProvider.notifier).state = false;
    }
  }

  void selectAddress(AddressModel? address) {
    ref.read(selectedAddressProvider.notifier).state = address;
  }

  void clearMessages() {
    ref.read(addressErrorProvider.notifier).state = '';
    ref.read(addressSuccessProvider.notifier).state = false;
  }
}
