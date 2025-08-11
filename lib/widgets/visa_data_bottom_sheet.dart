import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';

import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';

import 'package:link_flutter_ecommerce_app/providers/payment_provider.dart';
import 'package:link_flutter_ecommerce_app/widgets/continue_button.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_text_form.dart';

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
  });
  final WidgetRef ref;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController cardnumberController;
  final TextEditingController cvvController;
  final TextEditingController expiryController;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF342F3F) : const Color(0xffF4F4F4),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Form(
        key: formKey,

        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.0.h, left: 20.w, right: 20.w),
                child: Text(

                  AppLocalizations.of(context)!.cardHolderName,
              
                  style: AppTextStyles.subTitle1(isDarkMode),

                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                child: CustomTextForm(
                  isdarkmode: isDarkMode,
                  controller: nameController,
                  inputType: TextInputType.name,
                  hint: AppLocalizations.of(context)!.cardHolderName,
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? AppLocalizations.of(
                                context,
                              )!.pleaseEnterCardHolderName
                              : null,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0.h, left: 20.w, right: 20.w),
                child: Text(

                  AppLocalizations.of(context)!.cardNumber,
          
                  style: AppTextStyles.subTitle1(isDarkMode),

                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                child: CustomTextForm(
                  controller: cardnumberController,
                  inputType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  hint: AppLocalizations.of(context)!.cardNumber,
                  validator:
                      (value) =>
                          value == null || value.length < 16
                              ? AppLocalizations.of(
                                context,
                              )!.pleaseEnterCardNumber
                              : null,
                  isdarkmode: isDarkMode,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20.0.h,
                            left: 20.w,
                            right: 20.w,
                          ),
                          child: Text(

                            AppLocalizations.of(context)!.expiryDate,
                     
                            style: AppTextStyles.subTitle1(isDarkMode),

                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 8.h,
                          ),
                          child: CustomTextForm(
                            isdarkmode: isDarkMode,
                            controller: expiryController,
                            inputType: TextInputType.datetime,
                            hint: ' MM/YY',
                            validator:
                                (value) =>
                                    value == null || value.length < 4
                                        ? AppLocalizations.of(
                                          context,
                                        )!.pleaseEnterExpiryDate
                                        : null,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20.0.h,
                            left: 20.w,
                            right: 20.w,
                          ),
                          child: Text(
                            'CVV',
                            style: AppTextStyles.subTitle1(isDarkMode),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 8.h,
                          ),
                          child: CustomTextForm(
                            isdarkmode: isDarkMode,
                            controller: cvvController,
                            inputType: TextInputType.number,
                            hint: ' CVV',
                            validator:
                                (value) =>
                                    value == null || value.length != 3
                                        ? AppLocalizations.of(context)!.validCvv
                                        : null,
                          ),
                        ),
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
      ),
    );
  }
}
