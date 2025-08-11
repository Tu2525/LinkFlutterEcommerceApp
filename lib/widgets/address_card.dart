import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';

import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';

import 'package:link_flutter_ecommerce_app/providers/address_providor.dart';

class AddressCard extends ConsumerWidget {
  const AddressCard({super.key, required this.ontab, required this.isDarkMode});

  final void Function()? ontab;
  final bool isDarkMode;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subtitleText = AppLocalizations.of(context)!.addShippingAddress;
    final titleText = AppLocalizations.of(context)!.shippingAddress;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final fadedTextColor =
        isDarkMode
            ? Colors.white.withOpacity(0.5)
            : const Color(0xff272727).withOpacity(0.5);
    final address = ref.watch(addressProvider);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
      child: GestureDetector(
        onTap: ontab,
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          tileColor:
              isDarkMode ? const Color(0xFF342F3F) : const Color(0xffF4F4F4),
          trailing: Icon(IconsaxPlusBroken.arrow_right_3, color: textColor),
          title: Text(titleText, style: TextStyle(color: fadedTextColor)),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 4.0.h),
            child: Text(
              address.isNotEmpty ? address : subtitleText,
              style: AppTextStyles.heading5(isDarkMode),
            ),
          ),
        ),
      ),
    );
  }
}
