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
  
  Future<List<NotificationModel>> fetchNotificationData() async {
    await Future.delayed(const Duration(seconds: 1)); 
    //final user = _auth.currentUser;// test it when sign in finish 
    //if (user == null) throw Exception('User not logged in');
      final query = await _firestore
        .collection('notifications')
        //.where('userId', isEqualTo: user.uid)
        .get();
      log("${query.docs}, ${query.size}");  
      return query.docs.map((doc) {
      final data = doc.data();
      return NotificationModel.fromFireStore({
        ...data,
        'id': doc.id,
      });
    }).toList();     
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
    description: 'This channel is used for important notifications.', // description
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
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  AndroidInitializationSettings androidSettings = const AndroidInitializationSettings("@drawable/icon");

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
    onDidReceiveNotificationResponse: (NotificationResponse details) {//optional
      handleNotificationClicks(details.payload);
    },
    onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse,
  );

  tz.initializeDatabase([]);

  isFlutterLocalNotificationsInitialized = true;
}

void handleNotificationClicks(String? payload) async {
  if(payload !=null){
    //logic 
  }
}

void onDidReceiveBackgroundNotificationResponse(NotificationResponse details) {
  handleNotificationClicks(details.payload);
}