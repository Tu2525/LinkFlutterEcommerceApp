import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/screens/order_details_screen.dart';
import 'package:link_flutter_ecommerce_app/widgets/continue_button.dart';

class OrderPlacedSuccessfullyScreen extends StatelessWidget {
  const OrderPlacedSuccessfullyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff8E6CEF),
      body: Column(
        children: [
          Container(
            color: const Color(0xff8E6CEF),
            width: double.infinity,
            height: screenHeight * 0.52,
            child: Image.asset('images/order-placed-successfully.png'),
          ),
          Container(
            width: double.infinity,
            height: screenHeight * 0.48,
            decoration: BoxDecoration(
              color:
                  isDarkMode
                      ? const Color(0xff272727)
                      : const Color(0xffF4F4F4),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Text(
                  "Order Placed",
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : const Color(0xff272727),
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                Text(
                  "Successfully",
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : const Color(0xff272727),
                    fontWeight: FontWeight.bold,
                    fontSize: 31,
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  "You Will recieve an email confirmation",
                  style: TextStyle(
                    fontSize: 16,
                    color:
                        isDarkMode
                            ? const Color.fromARGB(138, 255, 255, 255)
                            : const Color.fromARGB(127, 39, 39, 39),
                  ),
                ),
                const SizedBox(height: 80),
                ContinueButton(
                  width: 350,
                  height: 52,
                  text: 'See Order details',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderDetails(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
