import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/screens/paymentscreen.dart';
import 'package:link_flutter_ecommerce_app/widgets/CartWidgets/coupon_code_input.dart';
import 'package:link_flutter_ecommerce_app/widgets/CartWidgets/price_summary_row.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key, required this.subtotal, required this.total});

  final double subtotal;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PriceSummaryRow(
          label: AppLocalizations.of(context)!.subtotal,
          amount: subtotal,
        ),
        const SizedBox(height: 8),
        PriceSummaryRow(
          label: AppLocalizations.of(context)!.shippingCost,
          amount: 8.00,
        ),
        const SizedBox(height: 8),
        PriceSummaryRow(label: AppLocalizations.of(context)!.tax, amount: 0.00),
        const Divider(height: 30),
        PriceSummaryRow(
          label: AppLocalizations.of(context)!.total,
          amount: total,
          isTotal: true,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
