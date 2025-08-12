import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/models/checkout_model.dart';
import 'package:link_flutter_ecommerce_app/models/order_model.dart';
import 'package:link_flutter_ecommerce_app/providers/cart_item_provider.dart';
import 'package:link_flutter_ecommerce_app/providers/checkout_provider.dart';
import 'package:link_flutter_ecommerce_app/providers/controller_providors.dart';
import 'package:link_flutter_ecommerce_app/providers/order_provider.dart';
import 'package:link_flutter_ecommerce_app/screens/order_placed_successfully_screen.dart';
import 'package:link_flutter_ecommerce_app/services/order_service.dart';
import 'package:link_flutter_ecommerce_app/widgets/address_bottom_sheet.dart';
import 'package:link_flutter_ecommerce_app/widgets/address_card.dart';
import 'package:link_flutter_ecommerce_app/widgets/continue_button.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_app_bar.dart';
import 'package:link_flutter_ecommerce_app/widgets/order_summary.dart';
import 'package:link_flutter_ecommerce_app/widgets/payment_card.dart';
import 'package:link_flutter_ecommerce_app/widgets/visa_data_bottom_sheet.dart';

class Paymentscreen extends ConsumerStatefulWidget {
  const Paymentscreen({super.key});

  @override
  ConsumerState<Paymentscreen> createState() => _PaymentscreenState();
}

class _PaymentscreenState extends ConsumerState<Paymentscreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(checkoutProvider.notifier).getCheckoutData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    // Controllers
    final nameController = ref.watch(nameControllerProvider);
    final cardNumberController = ref.watch(cardNumberControllerProvider);
    final cvvController = ref.watch(cvvControllerProvider);
    final expiryController = ref.watch(expiryControllerProvider);
    final countryController = ref.watch(countryControllerProvider);
    final stateController = ref.watch(stateControllerProvider);
    final addressController = ref.watch(addressControllerProvider);
    final cityController = ref.watch(cityControllerProvider);
    final zipCodeController = ref.watch(zipCodeControllerProvider);

    final subtotal = ref.read(cartProvider.notifier).subtotal;
    final total = ref.watch(totalProvider);
    final checkoutState = ref.watch(checkoutProvider);
    final cartItems = ref.watch(cartProvider);
    final isFormValid = ref.watch(isFormValidProvider);

    checkoutState.when(
      data: (checkout) {
        if (checkout != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            addressController.text = checkout.shippingAddress?.address ?? '';
            cityController.text = checkout.shippingAddress?.city ?? '';
            countryController.text = checkout.shippingAddress?.country ?? '';
            zipCodeController.text = checkout.shippingAddress?.zipCode ?? '';
            nameController.text = checkout.paymentMethod?.cardHolderName ?? '';
            cardNumberController.text =
                checkout.paymentMethod?.cardNumber ?? '';
            cvvController.text = checkout.paymentMethod?.cvv ?? '';
            expiryController.text = checkout.paymentMethod?.expiry ?? '';
          });
        }
      },
      loading: () {},
      error: (err, st) {
        debugPrint("Error loading checkout data: $err");
      },
    );

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header
          CustomAppBar(
            isDarkMode: isDarkMode,
            title: AppLocalizations.of(context)!.checkout,
          ),

          // Address Section
          AddressCard(
            isDarkMode: isDarkMode,
            ontab: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder:
                    (_) => AddressBottomSheet(
                      formKey: formKey,
                      ref: ref,
                      isDarkMode: isDarkMode,
                      countryController: countryController,
                      stateController: stateController,
                      addressController: addressController,
                      cityController: cityController,
                      zipcodeController: zipCodeController,
                    ),
              );
            },
          ),

          // Payment Section
          PaymentCard(
            isDarkMode: isDarkMode,
            ontab: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder:
                    (_) => VisaDataBottomSheet(
                      formKey: formKey,
                      ref: ref,
                      isDarkMode: isDarkMode,
                      nameController: nameController,
                      cardnumberController: cardNumberController,
                      cvvController: cvvController,
                      expiryController: expiryController,
                    ),
              );
            },
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                OrderSummary(subtotal: subtotal, total: total),
                ContinueButton(
                  row: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.placeOrder,
                        style: const TextStyle(
                          fontFamily: 'Circular',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        ' ${total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  onPressed:
                      isFormValid
                          ? () async {
                            final shipping = ShippingAddress(
                              address: addressController.text,
                              city: cityController.text,
                              country: countryController.text,
                              zipCode: zipCodeController.text,
                              state: stateController.text,
                            );

                            final payment = PaymentMethod(
                              cardHolderName: nameController.text,
                              cardNumber: cardNumberController.text,
                              cvv: cvvController.text,
                              expiry: expiryController.text,
                            );

                            final checkout = CheckoutModel(
                              shippingAddress: shipping,
                              paymentMethod: payment,
                            );

                            await ref
                                .read(checkoutControllerProvider.notifier)
                                .placeOrder(
                                  shippingAddress: AddressInfo(
                                    address: shipping.address,
                                    city: shipping.city,
                                    state: stateController.text,
                                    zipCode: shipping.zipCode,
                                    country: shipping.country,
                                  ),
                                  paymentDetails: PaymentInfo(
                                    cardHolderName: payment.cardHolderName,
                                    cardNumber: payment.cardNumber,
                                    cvv: payment.cvv,
                                    expiryDate: payment.expiry,
                                  ),
                                  checkout: checkout,
                                );

                            if (mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          const OrderPlacedSuccessfullyScreen(),
                                ),
                              );
                            }
                            if (cartItems.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    AppLocalizations.of(context)!.emptyCart,
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            try {
                              final shippingInfo = ShippingInfo(
                                address:
                                    addressController.text.isNotEmpty
                                        ? addressController.text
                                        : AppLocalizations.of(context)!.address,
                              );

                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder:
                                    (context) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                              );

                              final order = await OrderService()
                                  .saveOrderToFirebase(
                                    cartItems: cartItems,
                                    shipping: shippingInfo,
                                    status: 'Processing',
                                  );
                              ref.read(selectedOrderProvider.notifier).state =
                                  order;
                              Navigator.of(context).pop();
                              ref.read(cartProvider.notifier).clearCart();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          const OrderPlacedSuccessfullyScreen(),
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${AppLocalizations.of(context)!.orderPlacedSuccessfully} ${order.key}',
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } catch (e) {
                              if (Navigator.canPop(context)) {
                                Navigator.of(context).pop();
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${AppLocalizations.of(context)!.failedToPlaceOrder} $e',
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                          : () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.pleaseFillAllFields,
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
