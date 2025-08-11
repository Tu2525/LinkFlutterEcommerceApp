import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/providers/address_providor.dart';
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
                padding: EdgeInsets.only(top: 20.0.h, left: 20.w),
                child: Text(
                  'Country',
                  style: AppTextStyles.subTitle1(isDarkMode),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                child: CustomTextForm(
                  isdarkmode: isDarkMode,
                  controller: countryController,
                  inputType: TextInputType.name,
                  hint: ' Country',
                  validator:
                      (value) =>
                          value == null || value.trim().isEmpty
                              ? 'Country is required'
                              : null,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0.h, left: 20.w),
                child: Text(
                  'State/Region',
                  style: AppTextStyles.subTitle1(isDarkMode),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                child: CustomTextForm(
                  controller: stateController,
                  inputType: TextInputType.name,
                  hint: 'State/Region',
                  validator:
                      (value) =>
                          value == null || value.trim().isEmpty
                              ? 'State/Region is required'
                              : null,
                  isdarkmode: isDarkMode,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0.h, left: 20.w),
                child: Text(
                  'Address',
                  style: AppTextStyles.subTitle1(isDarkMode),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                child: CustomTextForm(
                  controller: addressController,
                  inputType: TextInputType.name,
                  hint: 'Address',
                  validator:
                      (value) =>
                          value == null || value.length < 16
                              ? 'Address is required'
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
                          padding: EdgeInsets.only(top: 20.0.h, left: 20.w),
                          child: Text(
                            'city',
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
                            inputType: TextInputType.datetime,
                            hint: 'city',
                            validator:
                                (value) =>
                                    value == null || value.trim().isEmpty
                                        ? 'city is required'
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
                          padding: EdgeInsets.only(top: 20.0.h, left: 20.w),
                          child: Text(
                            'Zipcode',
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
                            hint: 'Zipcode',
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your zipcode';
                              } else if (value.trim().length < 3 ||
                                  value.trim().length > 10) {
                                return 'Zipcode must be between 3 to 10 digits';
                              }
                              return null;
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
                  text: 'Add Address',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
