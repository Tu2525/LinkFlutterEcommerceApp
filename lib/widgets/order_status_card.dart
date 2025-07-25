import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontFamily: 'Circular',
          fontSize: 16.sp,
          color:
              isDarkMode
                  ? (isChecked ? Colors.white : Colors.white.withOpacity(0.5))
                  : (isChecked ? Colors.black : Colors.black.withOpacity(0.5)),
        ),
      ),
      trailing: Text(
        date,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontFamily: 'Circular',
          fontSize: 16.sp,
          color:
              isDarkMode
                  ? (isChecked ? Colors.white : Colors.white.withOpacity(0.5))
                  : (isChecked ? Colors.black : Colors.black.withOpacity(0.5)),
        ),
      ),
    );
  }
}
