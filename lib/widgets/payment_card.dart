import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({super.key, required this.ontab});

  static const _cardColor = Color(0xff342F3F);
  static const _subtitleText = 'Add Payment Method';
  static const _titleText = 'Payment Method';
  final void Function()? ontab;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
      child: GestureDetector(
        onTap:ontab,
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          tileColor: _cardColor,
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
          title: Text(
            _titleText,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          subtitle:  Padding(
            padding: EdgeInsets.only(top: 4.0.h),
            child: Text(
              _subtitleText,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                fontFamily: 'Circular',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

