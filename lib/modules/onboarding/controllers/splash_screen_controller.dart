import 'dart:async';

import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_controllers/app_controller.dart';
import 'package:systemrepair/firebase/firebase_init.dart';


class SplashScreenController extends GetxController {
  int secondsDelay = 5;
  RxDouble containerWidth = 100.0.obs;
  RxDouble containerHeight = 100.0.obs;


  @override
  void onInit() async {
    Get.put(AppController(), permanent: true);
    FirebaseInit.instance.initFirebaseMessaging();
    setTimeOutAnimation();
    super.onInit();
  }

  void setTimeOutAnimation() {
    Future.delayed(const Duration(seconds: 2), () {
      containerWidth.value = 200.0;
      containerHeight.value = 200.0;
    });

  }

}
