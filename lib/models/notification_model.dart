import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final List<NotificationData> data;
  final String userId;
  final DateTime? timestamp;
  final String? id;
  final bool isRead;
  final DateTime? readAt;

  NotificationModel({
    required this.data,
    required this.userId,
    this.timestamp,
    this.id,
    this.isRead = false,
    this.readAt,
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
      isRead: json['isRead'] ?? false,
      readAt:
          json['readAt'] != null
              ? (json['readAt'] as Timestamp).toDate()
              : null,
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
