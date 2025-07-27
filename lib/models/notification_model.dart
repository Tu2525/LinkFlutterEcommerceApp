class NotificationModel {
  final String message;
  final bool isImportant;

  NotificationModel({required this.message, this.isImportant = false});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      message: json['message'],
      isImportant: json['isImportant'] ?? false,
    );
  }
}
