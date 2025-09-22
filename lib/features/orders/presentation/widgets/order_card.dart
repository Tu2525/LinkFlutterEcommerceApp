import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/features/orders/domain/entities/order.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/features/orders/presentation/providers/orders_provider.dart';
import 'package:link_flutter_ecommerce_app/features/orders/presentation/screens/order_details_screen.dart';

class OrderCard extends ConsumerWidget {
  const OrderCard({super.key, required this.orders});
  final List<Order> orders;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (_, index) {
          final order = orders[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: AppColors.cardBackgroundColor(isDarkMode),
              elevation: 0,
              child: ListTile(
                leading: const Icon(Icons.receipt_long_outlined, size: 28),
                title: Text(
                  "${AppLocalizations.of(context)!.order} #${order.key}",
                  style: AppTextStyles.heading5(isDarkMode),
                ),
                subtitle: Text(
                  "${order.items.length} ${AppLocalizations.of(context)!.item}",
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  print("Navigating to OrderDetails with ID: ${order.key}");
                  ref.read(selectedOrderProvider.notifier).state = order;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetails(orderId: order.key),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}