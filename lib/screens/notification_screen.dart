import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/providers/notification_screen_provider.dart';
import 'package:link_flutter_ecommerce_app/widgets/notification_card.dart';
import 'package:link_flutter_ecommerce_app/widgets/without_data_widget.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final notifications = ref.watch(realTimeNotificationProvider);
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Text(
                "Notifications",
                style: TextStyle(
                  color: isDarkMode ? Colors.white : const Color(0xff272727),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: notifications.when(
              data: (data) {
                if (data.isEmpty) {
                  return const WithoutDataWidget(
                    img: 'images/bell 1.png',
                    text: "No Notification yet",
                  );
                } else {
                  final allNotifications =
                      data.expand((item) => item.data).toList();

                  return ListView.builder(
                    itemCount: allNotifications.length,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      final i = allNotifications[index];
                      return NotificationCard(item: i);
                    },
                  );
                }
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}
