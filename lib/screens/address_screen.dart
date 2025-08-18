import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/models/checkout_model.dart';
import 'package:link_flutter_ecommerce_app/providers/checkout_provider.dart';
import 'package:link_flutter_ecommerce_app/widgets/address_bottom_sheet.dart';
import 'package:link_flutter_ecommerce_app/widgets/address_card.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_app_bar.dart';

class AddressScreen extends ConsumerStatefulWidget {
  const AddressScreen({super.key});

  @override
  ConsumerState<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends ConsumerState<AddressScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final checkoutService = ref.read(checkoutServiceProvider);
      checkoutService.getCheckoutDataStream();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final checkoutState = ref.watch(checkoutProvider);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAppBar(
            isDarkMode: isDarkMode,
            title: AppLocalizations.of(context)!.address,
          ),
          Expanded(
            child: checkoutState.when(
              data: (checkoutList) {
                if (checkoutList.isEmpty) {
                  return const Center(child: Text("No saved Addresses"));
                }

                final addressOnly =
                    checkoutList
                        .where((c) => c.shippingAddress != null)
                        .toList();

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: addressOnly.length,
                  itemBuilder: (context, index) {
                    final checkout = addressOnly[index];
                    final formKey = GlobalKey<FormState>();
                    final addressCopy =
                        checkout.shippingAddress != null
                            ? ShippingAddress(
                              address: checkout.shippingAddress!.address,
                              city: checkout.shippingAddress!.city,
                              country: checkout.shippingAddress!.country,
                              state: checkout.shippingAddress!.state,
                              zipCode: checkout.shippingAddress!.zipCode,
                            )
                            : ShippingAddress(
                              address: '',
                              city: '',
                              country: '',
                              state: '',
                              zipCode: '',
                            );

                    final countryController = TextEditingController(
                      text: addressCopy.country,
                    );
                    final stateController = TextEditingController(
                      text: addressCopy.state,
                    );
                    final cityController = TextEditingController(
                      text: addressCopy.city,
                    );
                    final zipcodeController = TextEditingController(
                      text: addressCopy.zipCode,
                    );
                    final addressController = TextEditingController(
                      text: addressCopy.address,
                    );
                    return AddressCard(
                      isDarkMode: isDarkMode,
                      shippingAddress: checkout.shippingAddress!,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder:
                              (_) => AddressBottomSheet(
                                formKey: formKey,
                                ref: ref,
                                checkoutId: checkout.id!,
                                countryController: countryController,
                                stateController: stateController,
                                addressController: addressController,
                                cityController: cityController,
                                zipcodeController: zipcodeController,
                                isDarkMode: isDarkMode,
                                isBottomSheet: false,
                                onSave: (updatedAddress) async {
                                  if (formKey.currentState!.validate()) {
                                    final updatedCheckout = CheckoutModel(
                                      id: checkout.id,
                                      shippingAddress: updatedAddress,
                                      paymentMethod: checkout.paymentMethod,
                                    );
                                    await ref
                                        .read(checkoutServiceProvider)
                                        .updateCheckoutData(updatedCheckout);
                                    ref
                                        .read(checkoutProvider.notifier)
                                        .listenToCheckoutData();
                                  }
                                },
                              ),
                        );
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error:
                  (err, st) => Center(
                    child: Text(
                      AppLocalizations.of(context)!.somethingWentWrong,
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
