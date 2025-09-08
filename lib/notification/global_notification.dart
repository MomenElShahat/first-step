import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';
import '../services/auth_service.dart';

// Define the callback as a top-level function
Future<void> flutterNotificationClick(NotificationResponse? payload) async {
  final data = json.decode("${payload?.payload}");
  if (kDebugMode) {
    print('payload >> ${payload?.payload}');
  }
  print("_data $data");
  // GlobalNotification.navigationToOfferOrder(data['order_id'], data['offer_id']??"", data['order_status'], data['offer_status'], data['title']);
}

// Define the Firebase Messaging background handler as a top-level function
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  await Firebase.initializeApp();
}

class GlobalNotification {
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  String fcmToken = "";
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  void setupNotification() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const android = AndroidInitializationSettings("@mipmap/ic_launcher");
    const ios = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true);
    const initSettings = InitializationSettings(android: android, iOS: ios);
    await _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveBackgroundNotificationResponse:
          flutterNotificationClick, // Use the top-level function
      onDidReceiveNotificationResponse:
          flutterNotificationClick, // Use the top-level function
    );

    // Android 13+ notification permission and channel
    if (Platform.isAndroid) {
      final androidPlugin = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      await androidPlugin?.requestNotificationsPermission();
      await androidPlugin
          ?.createNotificationChannel(const AndroidNotificationChannel(
        'default_channel',
        'Default',
        description: 'Default notifications',
        importance: Importance.max,
      ));
    }
    await Firebase.initializeApp();
    final settings = await messaging.requestPermission(
        alert: true, badge: true, sound: true, provisional: true);
    if (kDebugMode) {
      print('User granted permission: ${settings.authorizationStatus}');
    }
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      messaging.getToken().then((token) {
        fcmToken = token ?? "";
        AuthService.fcmToken = fcmToken;
        if (kDebugMode) {
          print("token ======> $token");
          print("tokenfcmToken ======> ${AuthService.fcmToken}");
        }
      });
      await messaging.setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: true);
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (kDebugMode) {
          print("_____________________Message data:${message.data}");
          print(
              "_____________________notification:${message.notification?.title}");
        }
        _showLocalNotification(message);
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('OnMessageOpenedApp event was published! ${message.data}');
        // final data = json.decode("${message.data}");
        // if (kDebugMode) {
        //   print('payload >> ${message.data}');
        // }
        // print("_data $data");
        // navigationToOfferOrder(message.data['order_id'], message.data['offer_id'], message.data['order_status'], message.data['offer_status'],message. data['title']);
      });

      FirebaseMessaging.instance
          .getInitialMessage()
          .then((RemoteMessage? message) {
        if (message != null) {
          // handleMessage(message);
        }
      });

      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
    }
  }

  void _showLocalNotification(RemoteMessage? message) async {
    if (message == null) return;
    const android = AndroidNotificationDetails(
      "default_channel",
      "Default",
      channelDescription: "Default notifications",
      priority: Priority.low,
      importance: Importance.max,
      ongoing: true,
      autoCancel: true,
      styleInformation: BigTextStyleInformation(""),
    );
    const ios = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    const platform = NotificationDetails(android: android, iOS: ios);
    int id = Random().nextInt(1000);
    _flutterLocalNotificationsPlugin.show(
      id,
      "${message.notification?.title}",
      "${message.notification?.body}",
      platform,
      payload: json.encode(message.data),
    );
  }

  // static navigationToOfferOrder(String? orderId, String? offerId, String? orderStatus, String? offerStatus, String? title) async {
  //   if (title == null) {
  //     if (AuthService.to.isUser ?? false) {
  //       await Get.toNamed(Routes.ORDER_DETAILS, arguments: {
  //         "orderId": int.tryParse(orderId??"-1")
  //       });
  //     } else {
  //       if (orderStatus == OrderStatus.pending ) {
  //         Get.toNamed(Routes.PHOTOGRAPHER_ORDERS_DETAILS, arguments: {
  //           "id": int.tryParse(orderId??"-1"),
  //         });
  //       }else  if (orderStatus == OrderStatus.pendingForPayment) {
  //         Get.toNamed(Routes.CONTINUE_ORDER, arguments: {
  //           "id": int.tryParse(orderId??"-1"),
  //         });
  //       } else if (orderStatus == OrderStatus.pendingForOtp) {
  //         Get.toNamed(Routes.CONTINUE_ORDER, arguments: {
  //           "id": int.tryParse(orderId??"-1"),
  //         });
  //       }
  //     }
  //   } else {
  //     Get.toNamed(Routes.PHOTOGRAPHER_CLIENT_CHAT, arguments: {
  //       "orderId": int.tryParse(orderId??"-1"),
  //       "offerId": int.tryParse(offerId??"-1"),
  //     });
  //   }
  // }
}
