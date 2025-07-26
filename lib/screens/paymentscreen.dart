import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/widgets/payment_card.dart';
import 'package:link_flutter_ecommerce_app/widgets/visa_data_bottom_sheet.dart';

class Paymentscreen extends ConsumerStatefulWidget {
  const Paymentscreen({super.key});

  @override
  ConsumerState<Paymentscreen> createState() => _PaymentscreenState();
}

class _PaymentscreenState extends ConsumerState<Paymentscreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cardnumberController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    cardnumberController.dispose();
    cvvController.dispose();
    expiryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PaymentCard(
            ontab:
                () => showModalBottomSheet(
                  context: context,
                  builder:
                      (context) => VisaDataBottomSheet(
                        formKey: formKey,
                        nameController: nameController,
                        cardnumberController: cardnumberController,
                        cvvController: cvvController,
                        expiryController: expiryController,
                        ref: ref,
                      ),
                ),
          ),
        ],
      ),
    );
  }
}
