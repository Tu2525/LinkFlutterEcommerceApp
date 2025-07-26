import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/providers/payment_provider.dart';


class PaymentCard extends ConsumerWidget {
  const PaymentCard({super.key, required this.ontab});

  static const cardColor = Color(0xff342F3F);
  static const subtitleText = 'Add Payment Method';
  static const titleText = 'Payment Method';
  final void Function()? ontab;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final last4Digits = ref.watch(last4DigitsProvider);
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
      child: GestureDetector(
        onTap:ontab,
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          tileColor: cardColor,
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
          title: Text(
            titleText,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          subtitle:  Padding(
            padding: EdgeInsets.only(top: 4.0.h),
            child: last4Digits.isNotEmpty
    ? Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '**** **** **** $last4Digits',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              fontFamily: 'Circular',
            ),
          ),
          const SizedBox(width: 6),
          Image.network(
            'https://www.freepnglogos.com/uploads/mastercard-png/mastercard-marcus-samuelsson-group-2.png',
            width: 30,
            height: 20,
          ),
        ],
      )
    : Text(
        subtitleText,
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

