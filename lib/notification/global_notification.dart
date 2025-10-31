import 'dart:convert';
import 'dart:math';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:first_step/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';

// ✅ Top-level function required by FlutterLocalNotifications
Future<void> flutterNotificationClick(NotificationResponse? payload) async {
  if (payload?.payload == null) return;
  final data = json.decode(payload!.payload!);
  if (kDebugMode) {
    print('Notification Clicked with payload: $data');
  }
  Get.toNamed(Routes.BOTTOM_NAVIGATION, arguments: 3.obs);
}

// ✅ Top-level background handler (MUST stay outside any class)
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

class GlobalNotification {
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  String fcmToken = "";

  void setupNotification() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // ✅ Initialization settings
    const android = AndroidInitializationSettings("@mipmap/ic_launcher");
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSettings = InitializationSettings(android: android, iOS: ios);

    await _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: flutterNotificationClick,
      onDidReceiveBackgroundNotificationResponse: flutterNotificationClick,
    );

    // ✅ Android 13+ permission + channel
    if (Platform.isAndroid) {
      final androidPlugin = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      await androidPlugin?.requestNotificationsPermission();

      await androidPlugin?.createNotificationChannel(
        const AndroidNotificationChannel(
          'default_channel',
          'Default',
          description: 'Default notifications',
          importance: Importance.high,
        ),
      );
    }

    // ✅ Firebase permission
    final settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: true,
    );

    if (kDebugMode) {
      print('User granted permission: ${settings.authorizationStatus}');
    }

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      messaging.getToken().then((token) {
        fcmToken = token ?? "";
        AuthService.fcmToken = fcmToken;
        if (kDebugMode) {
          print("FCM Token: $fcmToken");
        }
      });

      await messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      // ✅ Foreground message
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (kDebugMode) {
          print("Foreground Message: ${message.messageId}");
          print("Data: ${message.data}");
          print("Notification: ${message.notification?.title}");
        }
        _showLocalNotification(message);
      });

      // ✅ Notification opened when app in background
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print("Notification opened (background): ${message.data}");
        flutterNotificationClick(
          NotificationResponse(
              payload: json.encode(message.data),
              notificationResponseType:
                  NotificationResponseType.selectedNotification),
        );
      });

      // ✅ App killed then opened by tapping a notification
      FirebaseMessaging.instance.getInitialMessage().then((message) {
        if (message != null) {
          flutterNotificationClick(
            NotificationResponse(
                payload: json.encode(message.data),
                notificationResponseType:
                    NotificationResponseType.selectedNotification),
          );
        }
      });

      // ✅ Background handler registration
      FirebaseMessaging.onBackgroundMessage(
        firebaseMessagingBackgroundHandler,
      );
    }
  }

  void _showLocalNotification(RemoteMessage? message) async {
    if (message == null) return;

    const android = AndroidNotificationDetails(
      'default_channel',
      'Default',
      channelDescription: 'Default notifications',
      importance: Importance.high,
      priority: Priority.high,
      autoCancel: true,
    );

    const ios = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const platform = NotificationDetails(android: android, iOS: ios);

    _flutterLocalNotificationsPlugin.show(
      Random().nextInt(100000),
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      platform,
      payload: json.encode(message.data),
    );
  }
}
