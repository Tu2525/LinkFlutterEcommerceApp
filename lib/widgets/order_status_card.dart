import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_radio_button_check.dart';

class OrderStatusCard extends StatelessWidget {
  const OrderStatusCard({
    super.key,
    required this.text,
    required this.isChecked,
  });
  final String text;
  final bool isChecked;
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
              isChecked
                  ? const Color(0xfffffffF)
                  : const Color(0xffFFffff).withOpacity(0.5),
        ),
      ),
      trailing: Text(
        '28 May ',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontFamily: 'Circular',
          fontSize: 16.sp,
          color:
              isChecked
                  ? const Color(0xfffffffF)
                  : const Color(0xffFFffff).withOpacity(0.5),
        ),
      ),
    );
  }
}
