import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';

class CouponCodeInput extends StatelessWidget {
  const CouponCodeInput({super.key});

  @override
  Widget build(BuildContext context) {
    final Widget discountIcon = const Icon(
      IconsaxPlusBroken.discount_shape,
      color: AppColors.black54,
    );

    final Widget arrowButton = Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(100),
        ),
        child: IconButton(
          icon: const Icon(
            IconsaxPlusBroken.arrow_right_3,
            color: Colors.white,
          ),
          onPressed: () {},
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ),
    );

    return TextField(
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.enterCouponCode,
        hintStyle: AppTextStyles.faintGrey,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide.none,
        ),
        prefixIcon: discountIcon,
        suffixIcon: arrowButton,
      ),
    );
  }
}
