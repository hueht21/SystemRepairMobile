import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:systemrepair/modules/onboarding/views/splash_screen_view.dart';

class FirebaseInit {
  FirebaseInit._();

  static final instance = FirebaseInit._();

  StreamSubscription<RemoteMessage>? _onMessageOpenedAppSubscription;
  StreamSubscription<RemoteMessage>? _onMessageSubscription;

  Future<void> initFirebaseMessaging() async {
    _onMessageSubscription =
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("vào onMessage");
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        FlutterLocalNotificationsPlugin().show(
          notification.hashCode,
          "${notification.title} 1",
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'channel id',
              'channel name',
              icon: '@mipmap/ic_launcher',
              importance: Importance.max,
            ),
          ),
        );
      }
      // Xử lý thông báo ở đây
    });
    //
    // Lắng nghe khi nhấn vào thông báo và ứng dụng tắt hoàn toàn
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      print("vao initialMessage");
      _handleMessage(initialMessage);
    }

    // Lắng nghe khi nhấn vào thông báo và ứng dụng ở chế độ nền
    _onMessageOpenedAppSubscription =
        FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    String? payload = message.data['route'];
    print(payload);

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      FlutterLocalNotificationsPlugin().show(
        notification.hashCode,
        "${notification.title} $payload",
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel id',
            'channel name',
            icon: '@mipmap/ic_launcher',
            importance: Importance.max,
            // sound:
          ),
        ),
      );
    }
    if (payload != null) {
      Get.to(
        SplashScreenView(
          router: '/register',
        ),
      );
    }
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Thông báo nhận được trong chế độ background/terminated");
  print(message.notification?.title.toString());
  print(message.data.toString());

  // // Chỉ xử lý thông báo khi ứng dụng không ở trạng thái đã xóa
  // if (message.data.isNotEmpty) {
  //   print('Background message: ${message.data}');
  //   FlutterLocalNotificationsPlugin().show(
  //     DateTime.now().millisecondsSinceEpoch ~/ 1000,
  //     "Thng báo Background",
  //     "notification.body",
  //     const NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         'channel id',
  //         'channel name',
  //         icon: '@mipmap/ic_launcher',
  //         importance: Importance.max,
  //       ),
  //     ),
  //   );
  // }
}
