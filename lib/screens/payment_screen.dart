import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/models/checkout_model.dart';
import 'package:link_flutter_ecommerce_app/providers/checkout_provider.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_app_bar.dart';
import 'package:link_flutter_ecommerce_app/widgets/payment_card.dart';
import 'package:link_flutter_ecommerce_app/widgets/visa_data_bottom_sheet.dart';

class Paymentscreen extends ConsumerStatefulWidget {
  const Paymentscreen({super.key});

  @override
  ConsumerState<Paymentscreen> createState() => _PaymentscreenState();
}

class _PaymentscreenState extends ConsumerState<Paymentscreen> {
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
            title: AppLocalizations.of(context)!.checkout,
          ),
          Expanded(
            child: checkoutState.when(
              data: (checkoutList) {
                if (checkoutList.isEmpty) {
                  return const Center(child: Text("No saved payment methods"));
                }
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: checkoutList.length,
                    itemBuilder: (context, index) {
                      final checkout = checkoutList[index];
                      final formKey = GlobalKey<FormState>();

                      return PaymentCard(
                        isDarkMode: isDarkMode,
                        title: checkout.paymentMethod?.cardHolderName ?? '',
                        cardNumber: checkout.paymentMethod?.cardNumber ?? '',
                        onTap: () {
                          final paymentCopy =
                              checkout.paymentMethod != null
                                  ? PaymentMethod(
                                    cardHolderName:
                                        checkout.paymentMethod!.cardHolderName,
                                    cardNumber:
                                        checkout.paymentMethod!.cardNumber,
                                    cvv: checkout.paymentMethod!.cvv,
                                    expiry: checkout.paymentMethod!.expiry,
                                  )
                                  : PaymentMethod(
                                    cardHolderName: '',
                                    cardNumber: '',
                                    cvv: '',
                                    expiry: '',
                                  );

                          final nameController = TextEditingController(
                            text: paymentCopy.cardHolderName,
                          );
                          final cardNumberController = TextEditingController(
                            text: paymentCopy.cardNumber,
                          );
                          final cvvController = TextEditingController(
                            text: paymentCopy.cvv,
                          );
                          final expiryController = TextEditingController(
                            text: paymentCopy.expiry,
                          );

                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder:
                                (_) => Padding(
                                  padding: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom,
                                  ),
                                  child: VisaDataBottomSheet(
                                    isBottomSheet: false,
                                    formKey: formKey,
                                    ref: ref,
                                    isDarkMode: isDarkMode,
                                    nameController: nameController,
                                    cardnumberController: cardNumberController,
                                    cvvController: cvvController,
                                    expiryController: expiryController,
                                    onSave: (updatedPayment) async {
                                      if (formKey.currentState!.validate()) {
                                        final updatedCheckout = CheckoutModel(
                                          id: checkout.id,
                                          shippingAddress:
                                              checkout.shippingAddress,
                                          paymentMethod: updatedPayment,
                                        );
                                        await ref
                                            .read(checkoutServiceProvider)
                                            .updateCheckoutData(
                                              updatedCheckout,
                                            );
                                        ref
                                            .read(checkoutProvider.notifier)
                                            .listenToCheckoutData();
                                      }
                                    },
                                  ),
                                ),
                          );
                        },
                      );
                    },
                  ),
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
