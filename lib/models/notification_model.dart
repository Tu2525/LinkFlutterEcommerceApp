class NotificationModel {
  final List<NotificationData> data;
  final String userId;

  NotificationModel({required this.data, required this.userId});

  factory NotificationModel.fromFireStore(Map<String, dynamic> json) {
    return NotificationModel(
      data:
          (json['data'] as List? ?? [])
              .map((e) => NotificationData.fromJson(e as Map<String, dynamic>))
              .toList(),
      userId: json['userId']?.toString() ?? '',
    );
  }
}

class NotificationData {
  final String message;
  final bool isImportant;

  NotificationData({required this.message, this.isImportant = false});

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      message: json['message']?.toString() ?? '',
      isImportant: json['isImportant'] as bool? ?? false,
    );
  }
}
