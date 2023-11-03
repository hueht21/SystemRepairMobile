import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:systemrepair/router/app_pages.dart';

import 'cores/const/app_colors.dart';
import 'cores/values/string_values.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initFirebaseMessaging();
  runApp(
      const Application()
  );
}

void initFirebaseMessaging() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      FlutterLocalNotificationsPlugin().show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'channel id',
              'channel name',
              icon: '@mipmap/ic_launcher',
              importance: Importance.max,
            ),
          ));
    }
    // Xử lý thông báo ở đây
  });
}


class Application extends StatefulWidget {
  const Application({super.key});
  @override
  State<Application> createState() => _Application();
}

class _Application extends State<Application> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: KeyBoard.hide,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode()); // Ẩn bàn phím
      },
      child: GetMaterialApp(
        locale: const Locale('vi', 'VN'),
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
        builder: (context, child) => ScrollConfiguration(
          behavior: MyBehavior(),
          child: MediaQuery(
              data:
              MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child ?? Container()),
        ),
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate
        ],
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.white,
          canvasColor: Colors.white,
        ),
        title: AppStr.appName,
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  Widget buildViewPortChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
