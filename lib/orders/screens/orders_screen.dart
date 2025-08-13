import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/constants/app_colors.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/l10n/app_localizations.dart';
import 'package:link_flutter_ecommerce_app/orders/models/order_model.dart';
import 'package:link_flutter_ecommerce_app/widgets/without_data_widget.dart';
import '../providers/orders_provider.dart';
import '../widgets/order_card.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> statuses = [
      AppLocalizations.of(context)!.processing,
      AppLocalizations.of(context)!.shipped,
      AppLocalizations.of(context)!.delivered,
      AppLocalizations.of(context)!.returned,
      AppLocalizations.of(context)!.cancelled,
    ];
    final selectedStatus = ref.watch(selectedStatusProvider);
    final orderAsync = ref.watch(ordersStreamProvider);
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.order),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.backgroundColor(isDarkMode),
      ),
      backgroundColor: AppColors.backgroundColor(isDarkMode),
      body: orderAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
        data: (orders) {
          if (orders.isEmpty) {
            return WithoutDataWidget(
              img: 'images/check-out 1.png',
              text: AppLocalizations.of(context)!.noOrders,
            );
          }
          log(
            "Orderssssssssssssssssssssssss: ${orders.map((o) => o.userId).toList()}",
          );
          final filtered =
              orders
                  .where((o) => getStepStatus(o, context) == selectedStatus)
                  .toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children:
                      statuses.map((status) {
                        final isSelected = selectedStatus == status;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(status),
                            selected: isSelected,
                            selectedColor: Colors.blue,
                            backgroundColor: Colors.grey.shade200,
                            labelStyle: AppTextStyles.subTitle1(isDarkMode),
                            onSelected:
                                (_) =>
                                    ref
                                        .read(selectedStatusProvider.notifier)
                                        .state = status,
                          ),
                        );
                      }).toList(),
                ),
              ),
              const SizedBox(height: 16),
              OrderCard(orders: filtered),
            ],
          );
        },
      ),
    );
  }

  String getStepStatus(OrderModel order, BuildContext context) {
    switch (order.status) {
      case 'Order Placed':
        return AppLocalizations.of(context)!.orderPlaced;
      case 'Processing':
        return AppLocalizations.of(context)!.processing;
      case 'Shipped':
        return AppLocalizations.of(context)!.shipped;
      case 'Delivered':
        return AppLocalizations.of(context)!.delivered;
      default:
        return order.status;
    }
  }
}
