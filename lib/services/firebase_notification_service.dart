import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:link_flutter_ecommerce_app/main.dart';
import 'package:link_flutter_ecommerce_app/services/notification_service.dart';

class FirebaseNotificationService{
  Future<void> requestNotificationPermission() async {
    await FirebaseMessaging.instance.requestPermission(
      provisional: true,
      criticalAlert: true,
    );
  }


  Future<void>initFirebaseMessaging()async{
    await onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await onForegroundMessage();
    await onMessageOpenedApp();

  }


  Future<String?> getToken() async{
    return await  FirebaseMessaging.instance.getToken();
  }
  
  Future<void> onBackgroundMessage(Future<void> Function(RemoteMessage message) handler) async {
    // When app is in background [Not Terminated].
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }


  Future<void> onForegroundMessage() async {
    // When app is open [Running]
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
  }


  Future<void> onMessageOpenedApp() async {
    FirebaseMessaging.onMessageOpenedApp.listen(
      (event) {
        if (event.notification != null) {
          handleNotificationClicks(json.encode(event.data));
        }
      },
    );
  }

  Future<void> getInitialMessage() async {
    // Handle incoming data message when the app is in the terminated
    FirebaseMessaging.instance.getInitialMessage().then(
      (value) {
        if (value != null) {
          handleNotificationClicks(json.encode(value.data));
        }
      },
    );
  }
}