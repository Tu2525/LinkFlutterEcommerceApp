import 'package:flutter/material.dart';
import 'package:link_flutter_ecommerce_app/constants/app_styles.dart';
import 'package:link_flutter_ecommerce_app/models/notification_model.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.item});
  final NotificationData item;
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Image.asset(
          item.isImportant ? 'images/Frame 67.png' : 'images/Frame 67 (1).png',
        ),
        title: Text(
          item.message,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.body2(isDarkMode),
        ),
      ),
    );
  }
}
