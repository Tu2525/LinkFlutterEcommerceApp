import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/features/orders/domain/entities/order.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/models/checkout_model.dart';
import 'package:link_flutter_ecommerce_app/providers/cart_item_provider.dart';
import 'package:link_flutter_ecommerce_app/providers/checkout_provider.dart';
import 'package:link_flutter_ecommerce_app/providers/controller_providors.dart';
import 'package:link_flutter_ecommerce_app/features/orders/presentation/providers/orders_provider.dart';
import 'package:link_flutter_ecommerce_app/screens/order_placed_successfully_screen.dart';
import 'package:link_flutter_ecommerce_app/widgets/address_bottom_sheet.dart';
import 'package:link_flutter_ecommerce_app/widgets/address_card.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_button.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_back_icon.dart';
import 'package:link_flutter_ecommerce_app/features/orders/presentation/widgets/order_summary.dart';
import 'package:link_flutter_ecommerce_app/widgets/payment_card.dart';
import 'package:link_flutter_ecommerce_app/widgets/visa_data_bottom_sheet.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({super.key});

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final nameController = ref.watch(nameControllerProvider);
    final cardNumberController = ref.watch(cardNumberControllerProvider);
    final cvvController = ref.watch(cvvControllerProvider);
    final expiryController = ref.watch(expiryControllerProvider);
    final countryController = ref.watch(countryControllerProvider);
    final stateController = ref.watch(stateControllerProvider);
    final addressController = ref.watch(addressControllerProvider);
    final cityController = ref.watch(cityControllerProvider);
    final zipCodeController = ref.watch(zipCodeControllerProvider);
    final subtotal = ref.watch(cartProvider.notifier).subtotal;
    final total = ref.watch(totalProvider);
    final checkoutState = ref.watch(checkoutProvider);

    ref.listen(checkoutProvider, (_, next) {
      if (next is AsyncData<List<CheckoutModel>>) {
        final checkout = next.value.isNotEmpty ? next.value.first : null;
        if (mounted && checkout != null) {
          addressController.text = checkout.shippingAddress?.address ?? '';
          cityController.text = checkout.shippingAddress?.city ?? '';
          stateController.text = checkout.shippingAddress?.state ?? '';
          countryController.text = checkout.shippingAddress?.country ?? '';
          zipCodeController.text = checkout.shippingAddress?.zipCode ?? '';
          nameController.text = checkout.paymentMethod?.cardHolderName ?? '';
          cardNumberController.text = checkout.paymentMethod?.cardNumber ?? '';
          cvvController.text = checkout.paymentMethod?.cvv ?? '';
          expiryController.text = checkout.paymentMethod?.expiry ?? '';
        }
      }
    });

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
          Expanded(
            child: checkoutState.when(
              data: (checkoutData) {
                final checkout =
                    checkoutData.isNotEmpty ? checkoutData.first : null;
                final paymentMethod = checkout?.paymentMethod;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      AddressCard(
                        isDarkMode: isDarkMode,
                        shippingAddress: checkout?.shippingAddress,
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder:
                                (_) => AddressBottomSheet(
                                  formKey: formKey,
                                  isDarkMode: isDarkMode,
                                  countryController: countryController,
                                  stateController: stateController,
                                  addressController: addressController,
                                  cityController: cityController,
                                  zipcodeController: zipCodeController,
                                  ref: ref,
                                  onSave: (updatedAddress) async {
                                    if (checkout == null) return;
                                    final updatedCheckout = CheckoutModel(
                                      id: checkout.id,
                                      shippingAddress: updatedAddress,
                                      paymentMethod: checkout.paymentMethod,
                                    );
                                    await ref
                                        .read(checkoutServiceProvider)
                                        .saveCheckoutData(updatedCheckout);
                                    ref.invalidate(checkoutProvider);
                                  },
                                ),
                          );
                        },
                      ),
                      PaymentCard(
                        isDarkMode: isDarkMode,
                        paymentMethod: paymentMethod,
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder:
                                (_) => VisaDataBottomSheet(
                                  ref: ref,
                                  formKey: formKey,
                                  isDarkMode: isDarkMode,
                                  nameController: nameController,
                                  cardnumberController: cardNumberController,
                                  cvvController: cvvController,
                                  expiryController: expiryController,
                                  onSave: (updatedPayment) async {
                                    if (checkout == null) return;
                                    final updatedCheckout = CheckoutModel(
                                      id: checkout.id,
                                      shippingAddress: checkout.shippingAddress,
                                      paymentMethod: updatedPayment,
                                    );
                                    await ref
                                        .read(checkoutServiceProvider)
                                        .saveCheckoutData(updatedCheckout);
                                    ref.invalidate(checkoutProvider);
                                  },
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
                    onPressed: () async {
                      if (addressController.text.isEmpty ||
                          nameController.text.isEmpty ||
                          cardNumberController.text.isEmpty ||
                          cvvController.text.isEmpty ||
                          expiryController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              AppLocalizations.of(context)!.pleaseFillAllFields,
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      final navigator = Navigator.of(context);
                      final scaffoldMessenger = ScaffoldMessenger.of(context);
                      final localizations = AppLocalizations.of(context)!;
                      final cartItems = ref.read(cartProvider);

                      if (cartItems.isEmpty) {
                        scaffoldMessenger.showSnackBar(
                          SnackBar(content: Text(localizations.emptyCart)),
                        );
                        return;
                      }

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder:
                            (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                      );

                      try {
                        final userId = FirebaseAuth.instance.currentUser?.uid;
                        if (userId == null) {
                          throw Exception('User is not logged in.');
                        }

                        final shippingInfo = ShippingInfo(
                          address:
                              '${addressController.text}, ${cityController.text}, ${stateController.text}, ${countryController.text}',
                        );

                        final createOrderUseCase = ref.read(
                          createOrderUseCaseProvider,
                        );

                        final newOrder = await createOrderUseCase(
                          cartItems: cartItems,
                          shipping: shippingInfo,
                          userId: userId,
                        );

                        ref.read(cartProvider.notifier).clearCart();

                        if (!mounted) return;
                        navigator.pop();

                        scaffoldMessenger.showSnackBar(
                          SnackBar(
                            content: Text(
                              '${localizations.orderPlaced} #${newOrder.key}',
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );

                        if (!mounted) return;
                        navigator.pushReplacement(
                          MaterialPageRoute(
                            builder:
                                (context) => OrderPlacedSuccessfullyScreen(
                                  orderId: newOrder.key,
                                ),
                          ),
                        );
                      } catch (e) {
                        if (!mounted) return;
                        navigator.pop();
                        scaffoldMessenger.showSnackBar(
                          SnackBar(content: Text('Error placing order: $e')),
                        );
                      }
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
