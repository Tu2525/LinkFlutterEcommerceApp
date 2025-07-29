import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  final nameController = TextEditingController();
  final cardnumberController = TextEditingController();
  final cvvController = TextEditingController();
  final expiryController = TextEditingController();
  final countryController = TextEditingController();
  final stateController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final zipcodeController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    cardnumberController.dispose();
    cvvController.dispose();
    expiryController.dispose();
    countryController.dispose();
    stateController.dispose();
    addressController.dispose();
    cityController.dispose();
    zipcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
                  zipcodeController: zipcodeController,
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
                  cardnumberController: cardnumberController,
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
