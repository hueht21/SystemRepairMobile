import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:systemrepair/router/app_pages.dart';

import 'cores/values/string_values.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      const Application()
  );
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