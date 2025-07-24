import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_back_icon.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_radio_button_check.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xff1D182A) : const Color(0xffFFFFFF),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 36),
        child: Column(
          children: [
            Row(
              children: [
                CustomIcon(),
                SizedBox(width: 80),
                Text(
                  'Order #00545',
                  style: TextStyle(
                    fontFamily: 'Circular',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            ListTile(
              leading: CustomRadioButtonCheck(),
              title: Text('Order placed'),
              trailing: Text('28 May ', style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}
