import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/features/orders/domain/entities/order.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/widgets/CartWidgets/price_summary_row.dart';

class OrderPriceSummary extends StatelessWidget {
  final Order order;
  const OrderPriceSummary({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    // Calculate subtotal from the list of items in the order.
    var subtotal = order.items.fold<double>(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    // Shipping and tax are calculated as the difference between the total and subtotal.
    // final shippingAndTax = order.totalAmount - subtotal;
    final shippingAndTax = 8.0;
    subtotal = subtotal - shippingAndTax;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Subtotal
        PriceSummaryRow(
          label: AppLocalizations.of(context)!.subtotal,
          amount: subtotal,
        ),
        const SizedBox(height: 8),

        PriceSummaryRow(
          label: AppLocalizations.of(context)!.shippingCost,
          // amount: shippingAndTax > 0 ? shippingAndTax : 0.0,
          amount: shippingAndTax,
        ),
        const Divider(height: 30),

        // Total
        PriceSummaryRow(
          label: AppLocalizations.of(context)!.total,
          amount: order.totalAmount,
          isTotal: true,
        ),
      ],
    );
  }
}
