import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/widgets/without_data_widget.dart';
import '../providers/order_provider.dart';
import '../widgets/order_card.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  static const statuses = [
    "Processing",
    "Shipped",
    "Delivered",
    "Returned",
    "Cancelled",
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStatus = ref.watch(selectedStatusProvider);
    final orderAsync = ref.watch(orderProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: orderAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
        data: (orders) {
          if (orders.isEmpty) {
            return const WithoutDataWidget(
              img: 'images/check-out 1.png',
              text: 'No Orders yet',
            );
          }
          final filtered =
              orders.where((o) => o.status == selectedStatus).toList();

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
                            selectedColor: Colors.purple,
                            backgroundColor: Colors.grey.shade200,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
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
}
