import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_radio_button_check.dart';

class OrderStatusCard extends StatelessWidget {
  const OrderStatusCard({
    super.key,
    required this.text,
    required this.isChecked,
    required this.date,
    required this.isDarkMode,
  });

  final bool isDarkMode;
  final String text;
  final bool isChecked;
  final String date;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomRadioButtonCheck(isChecked: isChecked),
      title: Text(
        text,
        style: AppTextStyles.subTitle1(isDarkMode),
      ),
      trailing: Text(
        date,
        style: AppTextStyles.subTitle1(isDarkMode),
      ),
    );
  }
}
