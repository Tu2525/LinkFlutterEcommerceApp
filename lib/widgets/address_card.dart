import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/models/checkout_model.dart';
import 'package:link_flutter_ecommerce_app/providers/address_provider.dart';

class AddressCard extends ConsumerWidget {
  const AddressCard({
    super.key,
    this.shippingAddress,
    required this.onTap,
    required this.isDarkMode,
  });

  final VoidCallback onTap;
  final bool isDarkMode;
  final ShippingAddress? shippingAddress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subtitleText = AppLocalizations.of(context)!.addShippingAddress;
    final titleText = AppLocalizations.of(context)!.shippingAddress;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    final address = shippingAddress?.address ?? '';

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
            child:
                address.isNotEmpty
                    ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            address,
                            style: AppTextStyles.heading5(isDarkMode),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        const Icon(Icons.location_on, size: 18),
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
