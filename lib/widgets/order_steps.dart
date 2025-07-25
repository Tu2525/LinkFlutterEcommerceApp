import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/models/order_model.dart';
import 'package:link_flutter_ecommerce_app/widgets/order_status_card.dart';

class OrderSteps extends StatelessWidget {
  const OrderSteps({super.key, required this.steps, required this.isDarkMode});

  final List<OrderStep> steps;
  final bool isDarkMode ;

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          steps.map((step) {
            return Column(
              children: [
                OrderStatusCard(
                  isDarkMode: isDarkMode,
                  text: step.title,
                  isChecked: step.isChecked,
                  date: step.date,
                ),
                const SizedBox(height: 14),
              ],
            );
          }).toList(),
    );
  }
}

