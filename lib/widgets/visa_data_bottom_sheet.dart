import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      height: 700.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xff342F3F),
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
                  'Cardholder Name',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                child: CustomTextForm(
                  controller: nameController,
                  inputType: TextInputType.name,
                  hint: ' Name',
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Please enter cardholder name'
                              : null,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0.h, left: 20.w),
                child: Text(
                  'Card Number',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                child: CustomTextForm(
                  controller: cardnumberController,
                  inputType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  hint: ' Card Number',
                  validator:
                      (value) =>
                          value == null || value.length < 16
                              ? 'Enter valid card number'
                              : null,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20.0.h, left: 20.w),
                          child: Text(
                            'Expiry',
                            style: TextStyle(
                              color:textColor,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 8.h,
                          ),
                          child: CustomTextForm(
                            controller: expiryController,
                            inputType: TextInputType.datetime,
                            hint: ' Expiry',
                            validator:
                                (value) =>
                                    value == null || value.length < 4
                                        ? 'Enter valid expiry date/Use format MM/YY'
                                        : null,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20.0.h, left: 20.w),
                          child: Text(
                            'CVV',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 8.h,
                          ),
                          child: CustomTextForm(
                            controller: cvvController,
                            inputType: TextInputType.number,
                            hint: ' CVV',
                            validator:
                                (value) =>
                                    value == null || value.length != 3
                                        ? 'Enter valid CVV'
                                        : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
                  text: 'Add Card',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
