import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/models/order_model.dart';

class ShippingDetails extends StatelessWidget {
  final bool isDarkMode;
  final List<ShippingInfo> shippingInfo;

  const ShippingDetails({
    super.key,
    required this.isDarkMode,
    required this.shippingInfo,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor =
        isDarkMode ? const Color(0xff342F3f) : const Color(0xffF4F4F4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w, bottom: 12.h),
          child: Text(
            AppLocalizations.of(context)!.shippingDetails,
            style: AppTextStyles.heading5(isDarkMode),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Container(
            height: 72.h,
            width: 342.w,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' ${shippingInfo[0].address}',
                  style: AppTextStyles.body3(isDarkMode),
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
