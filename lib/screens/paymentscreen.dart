import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/models/checkout_model.dart';
import 'package:link_flutter_ecommerce_app/providers/cart_item_provider.dart';
import 'package:link_flutter_ecommerce_app/providers/checkout_provider.dart';
import 'package:link_flutter_ecommerce_app/providers/controller_providors.dart';
import 'package:link_flutter_ecommerce_app/screens/order_placed_successfully_screen.dart';
import 'package:link_flutter_ecommerce_app/screens/address_screen.dart';
import 'package:link_flutter_ecommerce_app/widgets/address_card.dart';
import 'package:link_flutter_ecommerce_app/widgets/continue_button.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_back_icon.dart';
import 'package:link_flutter_ecommerce_app/widgets/order_summary.dart';
import 'package:link_flutter_ecommerce_app/widgets/payment_card.dart';
import 'package:link_flutter_ecommerce_app/widgets/visa_data_bottom_sheet.dart';
import 'package:link_flutter_ecommerce_app/providers/address_providor.dart';

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
    // Still watch to rebuild UI if needed, but side-effects are handled in ref.listen
    final _ = ref.watch(checkoutProvider);

    // Listen to checkout changes and update controllers/providers after frame
    ref.listen<AsyncValue<CheckoutModel?>>(checkoutProvider, (previous, next) {
      next.when(
        data: (checkout) {
          if (checkout != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final addr = checkout.shippingAddress;
              final pay = checkout.paymentMethod;

              if (addr != null) {
                addressController.text = addr.address;
                cityController.text = addr.city;
                countryController.text = addr.country;
                zipCodeController.text = addr.zipCode;

                if (addr.address.isNotEmpty) {
                  ref.read(addressProvider.notifier).state = addr.address;
                }
              }

              if (pay != null) {
                nameController.text = pay.cardHolderName;
                cardNumberController.text = pay.cardNumber;
                cvvController.text = pay.cvv;
                expiryController.text = pay.expiry;
              }
            });
          }
        },
        loading: () {},
        error: (err, st) {
          debugPrint("Error loading checkout data: $err");
        },
      );
    });

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

          // Address Section
          AddressCard(
            isDarkMode: isDarkMode,
            ontab: () async {
              final selectedAddress = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddressScreen()),
              );

              // If an address was selected, update both controllers
              if (selectedAddress != null) {
                // selectedAddress is AddressModel from AddressScreen
                final addr = selectedAddress;
                addressController.text = addr.streetAddress;
                cityController.text = addr.city;
                stateController.text = addr.state;
                zipCodeController.text = addr.zipCode;
                countryController.text =
                    countryController.text.isNotEmpty
                        ? countryController.text
                        : ''; // keep existing if any

                // Show formatted address on AddressCard
                ref.read(addressProvider.notifier).state =
                    addr.formattedAddress;
              }
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
                  onPressed: () async {
                    final shipping = ShippingAddress(
                      address: addressController.text,
                      city: cityController.text,
                      country:
                          countryController.text.isNotEmpty
                              ? countryController.text
                              : '',
                      zipCode: zipCodeController.text,
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
