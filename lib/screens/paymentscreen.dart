import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/providers/controller_providors.dart';
import 'package:link_flutter_ecommerce_app/widgets/address_bottom_sheet.dart';
import 'package:link_flutter_ecommerce_app/widgets/address_card.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_back_icon.dart';
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
                  'Checkout',
                  style: TextStyle(
                    fontFamily: 'Circular',
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
          ),
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
          PaymentCard(
            isDarkMode: isDarkMode,
            ontab: () {
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
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: OrderSummary(),
          ),
        ],
      ),
    );
  }
}
