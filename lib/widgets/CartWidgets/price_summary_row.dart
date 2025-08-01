import 'package:flutter/material.dart';

class PriceSummaryRow extends StatelessWidget {
  final String label;
  final double amount;
  final bool isTotal;

  const PriceSummaryRow({
    super.key,
    required this.label,
    required this.amount,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: isTotal ? 18 : 16,
      fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
      color: isTotal ? Colors.black : Colors.black54,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text('\$${amount.toStringAsFixed(2)}', style: style),
      ],
    );
  }
}