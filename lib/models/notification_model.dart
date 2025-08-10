import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final List<NotificationData> data;
  final String userId;
  final DateTime? timestamp;
  final String? id;

  NotificationModel({
    required this.data,
    required this.userId,
    this.timestamp,
    this.id,
  });

  factory NotificationModel.fromFireStore(Map<String, dynamic> json) {
    return NotificationModel(
      data:
          (json['data'] as List)
              .map((e) => NotificationData.fromJson(e))
              .toList(),
      userId: json['userId'],
      timestamp:
          json['timestamp'] != null
              ? (json['timestamp'] as Timestamp).toDate()
              : null,
      id: json['id'],
    );
  }
}

class NotificationData {
  final String message;
  final bool isImportant;

  NotificationData({required this.message, this.isImportant = false});

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      message: json['message'],
      isImportant: json['isImportant'] ?? false,
    );
  }
}
