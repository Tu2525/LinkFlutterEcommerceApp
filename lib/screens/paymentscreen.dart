import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/models/checkout_model.dart';
import 'package:link_flutter_ecommerce_app/providers/cart_item_provider.dart';
import 'package:link_flutter_ecommerce_app/providers/checkout_provider.dart';
import 'package:link_flutter_ecommerce_app/providers/controller_providors.dart';
import 'package:link_flutter_ecommerce_app/screens/order_placed_successfully_screen.dart';
import 'package:link_flutter_ecommerce_app/widgets/address_bottom_sheet.dart';
import 'package:link_flutter_ecommerce_app/widgets/address_card.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_button.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_back_icon.dart';
import 'package:link_flutter_ecommerce_app/orders/widgets/order_summary.dart';
import 'package:link_flutter_ecommerce_app/widgets/payment_card.dart';
import 'package:link_flutter_ecommerce_app/widgets/visa_data_bottom_sheet.dart';

class Paymentscreen extends ConsumerStatefulWidget {
  const Paymentscreen({super.key});

  @override
  ConsumerState<Paymentscreen> createState() => _PaymentscreenState();
}

class _PaymentscreenState extends ConsumerState<Paymentscreen> {
  final formKey = GlobalKey<FormState>();

  // The initState is no longer needed because the CheckoutNotifier
  // automatically handles listening to the data stream upon initialization.

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

    // Cart totals
    final subtotal = ref.watch(cartProvider.notifier).subtotal;
    final total = ref.watch(totalProvider);

    // Listen to the checkout controller for placeOrder actions (e.g., loading, error, success)
    ref.listen<AsyncValue<void>>(checkoutControllerProvider, (_, state) {
      state.when(
        error: (err, stack) {
          // Show an error message if placing the order fails
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error placing order: $err')),
          );
        },
        data: (_) {
          // On success, navigate to the success screen.
          // Using pushReplacement to prevent the user from going back to the payment screen.
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const OrderPlacedSuccessfullyScreen(),
            ),
          );
        },
        loading: () {
          // Optionally, you could show a loading indicator here
        },
      );
    });

    // Watch the checkout data provider to populate fields
    final checkoutState = ref.watch(checkoutProvider);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 48.h),
            child: Row(
              children: [
                const CustomIcon(),
                SizedBox(width: 100.w),
                Text(
                  AppLocalizations.of(context)!.checkout,
                  style: AppTextStyles.heading3(isDarkMode),
                ),
                SizedBox(width: 90.w),
              ],
            ),
          ),

          // Use the checkoutState to show loading/error or the main content
          Expanded(
            child: checkoutState.when(
              data: (checkoutData) {
                // FIX: The provider returns a List<CheckoutModel>. We need to check if it's empty
                // and then access the first element.
                if (checkoutData.isNotEmpty) {
                  final checkout = checkoutData.first;
                  // Populate controllers from the fetched data
                  // This will run on each build, but it's a simple way to ensure data is populated.
                  addressController.text = checkout.shippingAddress!.address;
                  cityController.text = checkout.shippingAddress!.city;
                  countryController.text = checkout.shippingAddress!.country;
                  zipCodeController.text = checkout.shippingAddress!.zipCode;
                  nameController.text = checkout.paymentMethod!.cardHolderName;
                  cardNumberController.text = checkout.paymentMethod!.cardNumber;
                  cvvController.text = checkout.paymentMethod!.cvv;
                  expiryController.text = checkout.paymentMethod!.expiry;
                }

                // Return the main scrollable content
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // Address Section
                      AddressCard(
                        isDarkMode: isDarkMode,
                        ontab: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) => AddressBottomSheet(
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
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) => VisaDataBottomSheet(
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
                    ],
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, st) => Center(child: Text("Error: $err")),
            ),
          ),

          // This container holds the summary and the place order button
          Container(
            color: AppColors.surfaceColor(isDarkMode),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  OrderSummary(subtotal: subtotal, total: total),
                  CustomButton(
                    row: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.placeOrder,
                          style: AppTextStyles.subTitle1(isDarkMode),
                        ),
                        Text(
                          ' \$${total.toStringAsFixed(2)}',
                          style: AppTextStyles.heading5(isDarkMode),
                        ),
                      ],
                    ),
                    onPressed: () {
                      final shipping = ShippingAddress(
                        address: addressController.text,
                        city: cityController.text,
                        country: countryController.text,
                        zipCode: zipCodeController.text, state: '',
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

                      ref.read(checkoutControllerProvider.notifier).placeOrder(
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
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
