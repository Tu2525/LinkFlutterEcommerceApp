import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/providers/cart_item_provider.dart';
import 'package:link_flutter_ecommerce_app/widgets/CartWidgets/price_summary_row.dart';

class OrderSummary extends ConsumerWidget {
  const OrderSummary({required this.subtotal, required this.total, super.key});
  final double subtotal;
  final double total;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subtotal = ref.read(cartProvider.notifier).subtotal;
    const shippingCost = 8.00;
    const tax = 0.00;
    final total = subtotal + shippingCost + tax;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PriceSummaryRow(
          label: AppLocalizations.of(context)!.subtotal,
          amount: subtotal,
        ),
        SizedBox(height: 8.h),
        PriceSummaryRow(
          label: AppLocalizations.of(context)!.shippingCost,
          amount: shippingCost,
        ),
        SizedBox(height: 8.h),
        PriceSummaryRow(label: AppLocalizations.of(context)!.tax, amount: tax),
        const Divider(height: 30),
        PriceSummaryRow(
          label: AppLocalizations.of(context)!.total,
          amount: total,
          isTotal: true,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
