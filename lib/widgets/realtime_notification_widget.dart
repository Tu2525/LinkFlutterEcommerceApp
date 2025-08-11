import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_flutter_ecommerce_app/providers/notification_screen_provider.dart';
import 'package:link_flutter_ecommerce_app/models/notification_model.dart';

class RealtimeNotificationWidget extends ConsumerWidget {
  const RealtimeNotificationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationStream = ref.watch(notificationProvider);

    return RefreshIndicator(
      onRefresh: () async {
        // Refresh the stream by invalidating the provider
        ref.invalidate(notificationProvider);
      },
      child: notificationStream.when(
        data: (notifications) {
          if (notifications.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_none, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No notifications yet'),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return NotificationTile(notification: notification);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, stackTrace) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: $error'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => ref.invalidate(notificationProvider),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}

class NotificationTile extends ConsumerWidget {
  final NotificationModel notification;

  const NotificationTile({super.key, required this.notification});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationService = ref.read(notificationDetailsProvider);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(
            notification.data.any((data) => data.isImportant)
                ? Icons.priority_high
                : Icons.notifications,
            color: Colors.white,
          ),
        ),
        title: Text(
          notification.data.isNotEmpty
              ? notification.data.first.message
              : 'No message',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (notification.timestamp != null)
              Text(
                'Received: ${_formatDateTime(notification.timestamp!)}',
                style: const TextStyle(fontSize: 12),
              ),
          ],
        ),
        trailing: PopupMenuButton(
          itemBuilder:
              (context) => [
                // if (!notification.isRead)
                //   PopupMenuItem(
                //     value: 'mark_read',
                //     child: const Row(
                //       children: [
                //         Icon(Icons.mark_email_read),
                //         SizedBox(width: 8),
                //         Text('Mark as Read'),
                //       ],
                //     ),
                //   ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Delete', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
          onSelected: (value) async {
            if (notification.id == null) return;

            switch (value) {
              // case 'mark_read':
              //   await notificationService.markNotificationAsRead(
              //     notification.id!,
              //   );
              //   break;
              case 'delete':
                await notificationService.deleteNotification(notification.id!);
                break;
            }
          },
        ),
        // onTap: () async {
        //   // Mark as read when tapped (if not already read)
        //   if (notification.id != null) {
        //     await notificationService.markNotificationAsRead(notification.id!);
        //   }

        //   // Add your navigation logic here
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text(
        //         'Notification tapped: ${notification.data.first.message}',
        //       ),
        //     ),
        //   );
        // },
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
