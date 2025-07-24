import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_back_icon.dart';

class OrderHeader extends StatelessWidget {
  const OrderHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomIcon(),
        SizedBox(width: 80.w),
        Text(
          'Order #00545',
          style: TextStyle(
            fontFamily: 'Circular',
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
          ),
        ),
      ],
    );
  }
}
