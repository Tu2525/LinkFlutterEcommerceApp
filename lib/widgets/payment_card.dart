import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/providers/payment_provider.dart';

class PaymentCard extends ConsumerWidget {
  const PaymentCard( {super.key, required this.ontab, required this.isDarkMode});

  static const subtitleText = 'Add Payment Method';
  static const titleText = 'Payment Method';
  final void Function()? ontab;
  final bool isDarkMode;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final last4Digits = ref.watch(last4DigitsProvider);
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final fadedTextColor =
        isDarkMode
            ? Colors.white.withOpacity(0.5)
            : const Color(0xff272727).withOpacity(0.5);

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
          trailing: Icon(Icons.arrow_forward_ios, color: textColor),
          title: Text(titleText, style: TextStyle(color: fadedTextColor)),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 4.0.h),
            child:
                last4Digits.isNotEmpty
                    ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '**** **** **** $last4Digits',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            fontFamily: 'Circular',
                          ),
                        ),
                        SizedBox(width: 6.w),
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
                        color: textColor,
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
