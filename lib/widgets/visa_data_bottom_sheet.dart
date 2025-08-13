import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/providers/checkout_provider.dart';
import 'package:link_flutter_ecommerce_app/providers/payment_provider.dart';
import 'package:link_flutter_ecommerce_app/widgets/build_text_form.dart';
import 'package:link_flutter_ecommerce_app/widgets/continue_button.dart';
import 'package:link_flutter_ecommerce_app/widgets/form_label.dart';

class VisaDataBottomSheet extends StatelessWidget {
  const VisaDataBottomSheet({
    super.key,
    required this.nameController,
    required this.cardnumberController,
    required this.cvvController,
    required this.expiryController,
    required this.formKey,
    required this.ref,
    required this.isDarkMode,
    this.isBottomSheet = true,
  });

  final WidgetRef ref;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController cardnumberController;
  final TextEditingController cvvController;
  final TextEditingController expiryController;
  final bool isDarkMode;
  final bool isBottomSheet;

  @override
  Widget build(BuildContext context) {
    final content = _buildFormContent(context);

    if (isBottomSheet) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF342F3F) : const Color(0xffF4F4F4),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: content,
      );
    } else {
      return Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color:
                isDarkMode ? const Color(0xFF342F3F) : const Color(0xffF4F4F4),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: content,
        ),
      );
    }
  }

  Widget _buildFormContent(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormLabel(isDarkMode: isDarkMode, context: context, text: AppLocalizations.of(context)!.cardHolderName),
            BuildTextForm(isDarkMode: isDarkMode, ref: ref, context: context, controller: nameController, hint: AppLocalizations.of(context)!.cardHolderName, inputType: TextInputType.name, validator: (value) =>
                      value == null || value.isEmpty
                          ? AppLocalizations.of(
                            context,
                          )!.pleaseEnterCardHolderName
                          : null, stateProvider: nameTextProvider),
            FormLabel(isDarkMode: isDarkMode, context: context, text: AppLocalizations.of(context)!.cardNumber),
             BuildTextForm(isDarkMode: isDarkMode, ref: ref, context: context, controller: cardnumberController, hint: AppLocalizations.of(context)!.cardNumber, inputType: const TextInputType.numberWithOptions(decimal: true), validator: (value) =>
                      value == null || value.length < 16
                          ? AppLocalizations.of(context)!.pleaseEnterCardNumber
                          : null, stateProvider: cardNumberTextProvider),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormLabel(isDarkMode: isDarkMode, context: context, text: AppLocalizations.of(context)!.expiryDate),
                       BuildTextForm(isDarkMode: isDarkMode, ref: ref, context: context, controller: expiryController, hint: ' MM/YY', inputType: TextInputType.datetime, validator: (value) =>
                                value == null || value.length < 4
                                    ? AppLocalizations.of(
                                      context,
                                    )!.pleaseEnterExpiryDate
                                    : null, stateProvider: expiryTextProvider),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormLabel(isDarkMode: isDarkMode, context: context, text: 'CVV'),
                      BuildTextForm(isDarkMode: isDarkMode, ref: ref, context: context, controller: cvvController, hint: ' CVV', inputType: TextInputType.number, validator: (value) =>
                                value == null || value.length != 3
                                    ? AppLocalizations.of(context)!.validCvv
                                    : null, stateProvider: cvvTextProvider),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 16,
              ),
              child: ContinueButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ref.read(cardNumberProvider.notifier).state =
                        cardnumberController.text;
                    Navigator.pop(context);
                  }
                },
                text: AppLocalizations.of(context)!.addCard,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
