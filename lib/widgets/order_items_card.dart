import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class OrderItemsCard extends StatelessWidget {
  final bool isDarkMode;

  const OrderItemsCard({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final cardColor = isDarkMode ? const Color(0xff342F3f) : const Color(0xffF4F4F4);

    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: SizedBox(
        height: 72.h,
        width: 342.w,
        child: Center(
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 8.h,
            ),
            tileColor: cardColor,
            leading: const Icon(IconsaxPlusBroken.receipt_1),
            title: const Text(
              '4 items',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Circular',
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            trailing: TextButton(
              onPressed: () {},
              child: const Text(
                'View all',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Circular',
                  fontSize: 16,
                  color: Color(0xff8E6CEF),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
