import 'dart:async';

import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_controllers/app_controller.dart';

import '../../../router/app_pages.dart';

class SplashScreenController extends GetxController {
  int secondsDelay = 5;
  RxDouble containerWidth = 100.0.obs;
  RxDouble containerHeight = 100.0.obs;
  bool _animationComplete = false;

  @override
  void onInit() {
    Get.put(AppController(), permanent: true);
    Future.delayed(const Duration(seconds: 2), () {
      containerWidth.value = 200.0;
      containerHeight.value = 200.0;
      _animationComplete = true;
    });
    if(!_animationComplete) {
      Get.offAllNamed(AppPages.WALKTROUGHS);
    }
    super.onInit();
  }

}
