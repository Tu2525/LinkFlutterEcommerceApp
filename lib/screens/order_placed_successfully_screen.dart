import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/features/orders/presentation/screens/order_details_screen.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_button.dart';

class OrderPlacedSuccessfullyScreen extends ConsumerWidget {
  final String orderId;
  const OrderPlacedSuccessfullyScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          Container(
            color: AppColors.primary,
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
                      ? AppColors.darkBackground
                      : AppColors.lightBackground,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Text(
                  AppLocalizations.of(context)!.orderPlaced,
                  style: AppTextStyles.heading2(isDarkMode),
                ),
                Text(
                  AppLocalizations.of(context)!.successfully,
                  style: AppTextStyles.heading2(isDarkMode),
                ),
                const SizedBox(height: 25),
                Text(
                  AppLocalizations.of(context)!.receiveEmail,
                  style: TextStyle(
                    fontSize: 16,
                    color:
                        isDarkMode
                            ? const Color.fromARGB(138, 255, 255, 255)
                            : const Color.fromARGB(127, 39, 39, 39),
                  ),
                ),
                const SizedBox(height: 80),
                CustomButton(
                  width: 350,
                  height: 52,
                  text: AppLocalizations.of(context)!.seeOrderDetails,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => OrderDetails(orderId: orderId),
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
