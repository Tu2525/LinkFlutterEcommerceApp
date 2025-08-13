import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';

class PaymentCard extends ConsumerWidget {
  const PaymentCard({
    super.key,
    this.title,
    this.cardNumber,
    required this.onTap,
    required this.isDarkMode,
  });

  final String? title;
  final String? cardNumber;
  final VoidCallback onTap;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subtitleText = AppLocalizations.of(context)!.addPaymentMethod;
    final titleText = AppLocalizations.of(context)!.paymentMethod;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final last4Digits =
        cardNumber!.length > 4
            ? cardNumber?.substring(cardNumber!.length - 4)
            : cardNumber;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
      child: GestureDetector(
        onTap: onTap,
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          tileColor:
              AppColors.surfaceColor(isDarkMode),
          trailing: Icon(IconsaxPlusBroken.arrow_right_3, color: textColor),
          title: Text(titleText, style: AppTextStyles.faintGrey),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 4.0.h),
            child:
                cardNumber != null
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
