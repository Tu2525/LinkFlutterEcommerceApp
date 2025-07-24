import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/widgets/order_status_card.dart';

class OrderSteps extends StatelessWidget {
  const OrderSteps({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        OrderStatusCard(text: 'Delivered', isChecked: false),
        SizedBox(height: 14),
        OrderStatusCard(text: 'Shipped', isChecked: true),
        SizedBox(height: 14),
        OrderStatusCard(text: 'Order confirmed', isChecked: true),
        SizedBox(height: 14),
        OrderStatusCard(text: 'Order placed', isChecked: true),
      ],
    );
  }
}
