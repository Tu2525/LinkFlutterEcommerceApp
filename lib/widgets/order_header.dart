import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_back_icon.dart';

class OrderHeader extends StatelessWidget {
  const OrderHeader({super.key, required this.orderIdd});
  final String orderIdd;
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        const CustomIcon(),
        SizedBox(width: 80.w),
        Text(
          '${AppLocalizations.of(context)!.order} #$orderIdd',
          style: AppTextStyles.subTitle1(isDarkMode),
        ),
      ],
    );
  }
}
