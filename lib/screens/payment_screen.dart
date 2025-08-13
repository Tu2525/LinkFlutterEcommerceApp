import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/providers/checkout_provider.dart';
import 'package:link_flutter_ecommerce_app/providers/controller_providors.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_app_bar.dart';
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
           final checkoutService = ref.read(checkoutServiceProvider);
  checkoutService.getCheckoutDataStream;
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

    final checkoutState = ref.watch(checkoutProvider);

    checkoutState.when(
      data: (checkoutList) {
        if (checkoutList.isNotEmpty) {
          final checkout = checkoutList.last; 
          WidgetsBinding.instance.addPostFrameCallback((_) {
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
        ],
      ),
    );
  }
}
