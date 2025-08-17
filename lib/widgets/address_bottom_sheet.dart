import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/providers/checkout_provider.dart';
import 'package:link_flutter_ecommerce_app/widgets/build_text_form.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_app_bar.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_button.dart';
import 'package:link_flutter_ecommerce_app/widgets/form_label.dart';

class AddressBottomSheet extends ConsumerWidget {
  const AddressBottomSheet({
    super.key,
    required this.countryController,
    required this.stateController,
    required this.addressController,
    required this.cityController,
    required this.ref,
    required this.zipcodeController,
    required this.formKey,
    required this.isDarkMode,
    this.isBottomSheet = true,
    this.onSave,
  });
  final WidgetRef ref;
  final GlobalKey<FormState> formKey;
  final TextEditingController countryController;
  final TextEditingController stateController;
  final TextEditingController addressController;
  final TextEditingController cityController;
  final TextEditingController zipcodeController;
  final bool isDarkMode;
  final bool isBottomSheet;
  final void Function(String address)? onSave;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final content = _buildFormContent(context, ref);

    if (isBottomSheet) {
      return Container(
        width: double.infinity,
        height: 500.h,
        decoration: BoxDecoration(
          color: AppColors.cardBackgroundColor(isDarkMode),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: content,
      );
    } else {
      return Scaffold(
        backgroundColor: AppColors.cardBackgroundColor(isDarkMode),
        body: Column(
          children: [
            CustomAppBar(
              isDarkMode: isDarkMode,
              title: AppLocalizations.of(context)!.addAddress,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.cardBackgroundColor(isDarkMode),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: content,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildFormContent(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormLabel(
                        isDarkMode: isDarkMode,
                        context: context,
                        text: AppLocalizations.of(context)!.country,
                      ),
                      BuildTextForm(
                        isDarkMode: isDarkMode,
                        ref: ref,
                        context: context,
                        controller: countryController,
                        hint: AppLocalizations.of(context)!.country,
                        inputType: TextInputType.name,
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? AppLocalizations.of(
                                      context,
                                    )!.pleaseEnterCountry
                                    : null,
                        stateProvider: countryTextProvider,
                      ),

                      FormLabel(
                        isDarkMode: isDarkMode,
                        context: context,
                        text: AppLocalizations.of(context)!.state,
                      ),
                      BuildTextForm(
                        isDarkMode: isDarkMode,
                        ref: ref,
                        context: context,
                        controller: stateController,
                        hint: AppLocalizations.of(context)!.state,
                        inputType: TextInputType.name,
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? AppLocalizations.of(
                                      context,
                                    )!.pleaseEnterState
                                    : null,
                        stateProvider: stateTextProvider,
                      ),

                      FormLabel(
                        isDarkMode: isDarkMode,
                        context: context,
                        text: AppLocalizations.of(context)!.address,
                      ),
                      BuildTextForm(
                        isDarkMode: isDarkMode,
                        ref: ref,
                        context: context,
                        controller: addressController,
                        hint: AppLocalizations.of(context)!.address,
                        inputType: TextInputType.name,
                        validator:
                            (value) =>
                                value == null || value.length < 8
                                    ? AppLocalizations.of(
                                      context,
                                    )!.pleaseEnterAddress
                                    : null,
                        stateProvider: addressTextProvider,
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormLabel(
                                  isDarkMode: isDarkMode,
                                  context: context,
                                  text: AppLocalizations.of(context)!.city,
                                ),
                                BuildTextForm(
                                  isDarkMode: isDarkMode,
                                  ref: ref,
                                  context: context,
                                  controller: cityController,
                                  hint: AppLocalizations.of(context)!.city,
                                  inputType: TextInputType.name,
                                  validator:
                                      (value) =>
                                          value == null || value.isEmpty
                                              ? AppLocalizations.of(
                                                context,
                                              )!.pleaseEnterCity
                                              : null,
                                  stateProvider: cityTextProvider,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormLabel(
                                  isDarkMode: isDarkMode,
                                  context: context,
                                  text: AppLocalizations.of(context)!.zipCode,
                                ),
                                BuildTextForm(
                                  isDarkMode: isDarkMode,
                                  ref: ref,
                                  context: context,
                                  controller: zipcodeController,
                                  hint: AppLocalizations.of(context)!.zipCode,
                                  inputType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocalizations.of(
                                        context,
                                      )!.pleaseEnterZipCode;
                                    } else if (value.length < 3 ||
                                        value.length > 10) {
                                      return AppLocalizations.of(
                                        context,
                                      )!.zipcodemustbe;
                                    }
                                    return null;
                                  },
                                  stateProvider: zipCodeTextProvider,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        child: CustomButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              onSave?.call(addressController.text);
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
            ),
          );
        },
      ),
    );
  }
}
