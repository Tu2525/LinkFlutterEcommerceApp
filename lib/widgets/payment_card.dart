import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/models/checkout_model.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    super.key,
    this.paymentMethod,
    required this.onTap,
    required this.isDarkMode,
  });

  final PaymentMethod? paymentMethod;
  final VoidCallback onTap;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    final subtitleText = AppLocalizations.of(context)!.addPaymentMethod;
    final titleText = AppLocalizations.of(context)!.paymentMethod;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    final cardNumber = paymentMethod?.cardNumber;
    final last4Digits = (cardNumber != null && cardNumber.length > 4)
        ? cardNumber.substring(cardNumber.length - 4)
        : null;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
      child: GestureDetector(
        onTap: onTap,
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          tileColor: AppColors.cardBackgroundColor(isDarkMode),
          trailing: Icon(IconsaxPlusBroken.arrow_right_3, color: textColor),
          title: Text(titleText, style: AppTextStyles.faintGrey),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 4.0.h),
            child: last4Digits != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '**** **** **** $last4Digits',
                        style: AppTextStyles.heading5(isDarkMode),
                      ),
                      SizedBox(width: 6.w),
                      Image.network(
                        'https://www.freepnglogos.com/uploads/mastercard-png/mastercard-marcus-samuelsson-group-2.png',
                        width: 30,
                        height: 20,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.credit_card_off, size: 20);
                        },
                      ),
                    ],
                  )
                : Text(
                    subtitleText,
                    style: AppTextStyles.heading5(isDarkMode),
                  ),
          ),
        ),
      ),
    );
  }
}