import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:link_flutter_ecommerce_app/models/notification_model.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Save notification payload to Firebase for the current user
  Future<void> saveNotificationToFirebase({
    required String message,
    bool isImportant = false,
    Map<String, dynamic>? additionalData,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      log('User not logged in - cannot save notification');
      return;
    }

    try {
      await _firestore.collection('notifications').add({
        'userId': user.uid,
        'data': [
          {'message': message, 'isImportant': isImportant},
        ],
        'timestamp': FieldValue.serverTimestamp(),
        'additionalData': additionalData,
        'createdAt': FieldValue.serverTimestamp(),
      });
      log('Notification saved successfully for user: ${user.uid}');
    } catch (e) {
      log('Error saving notification: $e');
    }
  }

  Future<List<NotificationModel>> fetchNotificationData() async {
    await Future.delayed(const Duration(seconds: 1));
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final query =
        await _firestore
            .collection('notifications')
            .where('userId', isEqualTo: user.uid)
            .get();

    log("Fetched ${query.size} notifications for user: ${user.uid}");

    final notifications =
        query.docs.map((doc) {
          final data = doc.data();
          return NotificationModel.fromFireStore({...data, 'id': doc.id});
        }).toList();

    notifications.sort((a, b) {
      if (a.timestamp == null && b.timestamp == null) return 0;
      if (a.timestamp == null) return 1;
      if (b.timestamp == null) return -1;
      return b.timestamp!.compareTo(a.timestamp!);
    });

    return notifications;
  }

  Stream<List<NotificationModel>> getNotificationStream() {
    final user = _auth.currentUser;
    if (user == null) {
      return Stream.error('User not logged in');
    }

    return _firestore
        .collection('notifications')
        .where('userId', isEqualTo: user.uid)
        .snapshots()
        .map((snapshot) {
          log(
            "Real-time update: ${snapshot.docs.length} notifications for user: ${user.uid}",
          );

          final notifications =
              snapshot.docs.map((doc) {
                final data = doc.data();
                return NotificationModel.fromFireStore({...data, 'id': doc.id});
              }).toList();

          notifications.sort((a, b) {
            if (a.timestamp == null && b.timestamp == null) return 0;
            if (a.timestamp == null) return 1;
            if (b.timestamp == null) return -1;
            return b.timestamp!.compareTo(a.timestamp!);
          });

          return notifications;
        });
  }

  Stream<List<NotificationModel>> getNotificationStreamWithAuth() {
    return _auth.authStateChanges().asyncExpand((user) {
      if (user == null) {
        return Stream.value(<NotificationModel>[]);
      }
      return getNotificationStream();
    });
  }

  Future<void> deleteNotification(String notificationId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      await _firestore.collection('notifications').doc(notificationId).delete();
      log('Notification deleted: $notificationId');
    } catch (e) {
      log('Error deleting notification: $e');
    }
  }
}

void showFlutterNotification(RemoteMessage message) async {
  await setupFlutterNotifications();
  RemoteNotification? notification = message.notification;
  if (notification == null) return;

  final notificationService = NotificationService();
  await notificationService.saveNotificationToFirebase(
    message: notification.body ?? notification.title ?? 'New notification',
    isImportant:
        message.data['isImportant'] == 'true' ||
        message.data['priority'] == 'high',
    additionalData: message.data,
  );

  flutterLocalNotificationsPlugin.show(
    notification.hashCode,
    notification.title ?? '',
    notification.body ?? '',
    payload: json.encode(message.data),
    NotificationDetails(
      iOS: const DarwinNotificationDetails(presentSound: true),
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
      ),
    ),
  );
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
    enableLights: true,
    enableVibration: true,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  AndroidInitializationSettings androidSettings =
      const AndroidInitializationSettings("@drawable/icon");

  DarwinInitializationSettings iosSettings = const DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  InitializationSettings notificationsSettings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
  );

  flutterLocalNotificationsPlugin.initialize(
    notificationsSettings,
    onDidReceiveNotificationResponse: (NotificationResponse details) {
      //optional
      handleNotificationClicks(details.payload);
    },
    onDidReceiveBackgroundNotificationResponse:
        onDidReceiveBackgroundNotificationResponse,
  );

  tz.initializeDatabase([]);

  isFlutterLocalNotificationsInitialized = true;
}

void handleNotificationClicks(String? payload) async {
  if (payload != null) {
    try {
      log('Notification clicked with payload: $payload');
    } catch (e) {
      log('Error handling notification click: $e');
    }
  }
}

void onDidReceiveBackgroundNotificationResponse(NotificationResponse details) {
  handleNotificationClicks(details.payload);
}
