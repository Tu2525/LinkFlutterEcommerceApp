import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';

import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';

import 'package:link_flutter_ecommerce_app/providers/address_providor.dart';
import 'package:link_flutter_ecommerce_app/providers/checkout_provider.dart';
import 'package:link_flutter_ecommerce_app/widgets/continue_button.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_text_form.dart';

class AddressBottomSheet extends StatelessWidget {
  const AddressBottomSheet({
    super.key,
    required this.countryController,
    required this.stateController,
    required this.addressController,
    required this.cityController,
    required this.zipcodeController,
    required this.formKey,
    required this.ref,
    required this.isDarkMode,
  });
  final WidgetRef ref;
  final GlobalKey<FormState> formKey;
  final TextEditingController countryController;
  final TextEditingController stateController;
  final TextEditingController addressController;
  final TextEditingController cityController;
  final TextEditingController zipcodeController;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
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
                  AppLocalizations.of(context)!.country,
                  style: AppTextStyles.subTitle1(isDarkMode),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                child: CustomTextForm(
                  isdarkmode: isDarkMode,
                  controller: countryController,
                  inputType: TextInputType.name,
                  hint: AppLocalizations.of(context)!.country,
                  validator:
                      (value) =>
                          value == null || value.trim().isEmpty
                              ? AppLocalizations.of(context)!.pleaseEnterCountry
                              : null,
                  onChanged: (value) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ref.read(countryTextProvider.notifier).state = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0.h, left: 20.w, right: 20.w),
                child: Text(
                  AppLocalizations.of(context)!.state,
                  style: AppTextStyles.subTitle1(isDarkMode),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                child: CustomTextForm(
                  controller: stateController,
                  inputType: TextInputType.name,
                  hint: AppLocalizations.of(context)!.state,
                  validator:
                      (value) =>
                          value == null || value.trim().isEmpty
                              ? AppLocalizations.of(context)!.pleaseEnterState
                              : null,
                  isdarkmode: isDarkMode,
                  onChanged: (value) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ref.read(stateTextProvider.notifier).state = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0.h, left: 20.w, right: 20.w),
                child: Text(
                  AppLocalizations.of(context)!.address,

                  style: AppTextStyles.subTitle1(isDarkMode),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                child: CustomTextForm(
                  controller: addressController,
                  inputType: TextInputType.name,
                  hint: AppLocalizations.of(context)!.address,
                  validator:
                      (value) =>
                          value == null || value.length < 8
                              ? AppLocalizations.of(context)!.pleaseEnterAddress
                              : null,
                  isdarkmode: isDarkMode,
                  onChanged: (value) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ref.read(addressTextProvider.notifier).state = value;
                    });
                  },
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
                            AppLocalizations.of(context)!.city,

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
                            controller: cityController,
                            inputType: TextInputType.name,
                            hint: AppLocalizations.of(context)!.city,
                            validator:
                                (value) =>
                                    value == null || value.trim().isEmpty
                                        ? AppLocalizations.of(
                                          context,
                                        )!.pleaseEnterCity
                                        : null,
                            onChanged: (value) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                ref.read(cityTextProvider.notifier).state =
                                    value;
                              });
                            },
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
                            AppLocalizations.of(context)!.zipCode,

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
                            controller: zipcodeController,
                            inputType: TextInputType.number,
                            hint: AppLocalizations.of(context)!.zipCode,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return AppLocalizations.of(
                                  context,
                                )!.pleaseEnterZipCode;
                              } else if (value.trim().length < 3 ||
                                  value.trim().length > 10) {
                                return AppLocalizations.of(
                                  context,
                                )!.zipcodemustbe;
                              }
                              return null;
                            },
                            onChanged: (value) {
                             WidgetsBinding.instance.addPostFrameCallback((_) {
                                ref.read(zipCodeTextProvider.notifier).state =
                                    value;
                              });
                            },
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
                      ref.read(addressProvider.notifier).state =
                          addressController.text;
                      Navigator.pop(context);
                    }
                  },
                  text: AppLocalizations.of(context)!.addAddress,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
