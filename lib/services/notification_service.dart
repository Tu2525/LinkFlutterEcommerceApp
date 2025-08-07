import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:link_flutter_ecommerce_app/models/notification_model.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<NotificationModel>> fetchNotificationData() async {
    try {
      print('🔔 Fetching notifications from Firebase...');

      // For now, fetch all notifications (you can add user filtering later)
      final query = await _firestore.collection('notifications').get();

      print('🔔 Found ${query.docs.length} notification documents');

      List<NotificationModel> allNotifications = [];

      for (var doc in query.docs) {
        try {
          final data = doc.data();
          print('🔔 Processing document ${doc.id}: ${data.keys}');

          final notificationModel = NotificationModel.fromFireStore({
            ...data,
            'id': doc.id,
          });

          allNotifications.add(notificationModel);
          print(
            '🔔 Added ${notificationModel.data.length} notifications from document ${doc.id}',
          );
        } catch (e) {
          print('❌ Error processing notification document ${doc.id}: $e');
        }
      }

      print('🔔 Total notification models: ${allNotifications.length}');
      return allNotifications;
    } catch (e) {
      print('❌ Error fetching notifications: $e');
      return [];
    }
  }

  // Real-time listener for notifications
  Stream<List<NotificationModel>> notificationStream() {
    print('🔔 Starting real-time notification stream...');

    return _firestore.collection('notifications').snapshots().map((snapshot) {
      print(
        '🔔 Real-time update: ${snapshot.docs.length} notification documents',
      );

      List<NotificationModel> allNotifications = [];

      for (var doc in snapshot.docs) {
        try {
          final data = doc.data();
          print('🔔 Real-time processing document ${doc.id}');

          final notificationModel = NotificationModel.fromFireStore({
            ...data,
            'id': doc.id,
          });

          allNotifications.add(notificationModel);
        } catch (e) {
          print(
            '❌ Error processing real-time notification document ${doc.id}: $e',
          );
        }
      }

      print(
        '🔔 Real-time total notification models: ${allNotifications.length}',
      );
      return allNotifications;
    });
  }
}

void showFlutterNotification(RemoteMessage message) async {
  await setupFlutterNotifications();
  RemoteNotification? notification = message.notification;
  if (notification == null) return;
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
    //logic
  }
}

void onDidReceiveBackgroundNotificationResponse(NotificationResponse details) {
  handleNotificationClicks(details.payload);
}
