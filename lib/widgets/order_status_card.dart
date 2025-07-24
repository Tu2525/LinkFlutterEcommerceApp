import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/widgets/custom_radio_button_check.dart';

class OrderStatusCard extends StatelessWidget {
  const OrderStatusCard({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CustomRadioButtonCheck(),
      title: Text(text),
      trailing: const Text('28 May ', style: TextStyle(color: Colors.grey)),
    );
  }
}
