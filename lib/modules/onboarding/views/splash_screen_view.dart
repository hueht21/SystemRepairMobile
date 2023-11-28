import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:systemrepair/cores/const/const.dart';
import 'package:systemrepair/modules/onboarding/controllers/splash_screen_controller.dart';
import 'package:systemrepair/router/app_pages.dart';

import '../../../cores/const/app_colors.dart';
import '../../../shared/utils/font_ui.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  @override
  SplashScreenController controller = Get.put(SplashScreenController());

  SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // controller.setTimeOutAnimation();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Obx(()
            => AnimatedContainer(
              duration: const Duration(seconds: 2),
              width: controller.containerWidth.value,
              height: controller.containerHeight.value,
              onEnd: () {
                Get.offAllNamed(AppPages.login);
              },
              child: SizedBox(
                width: 250,
                height: 150,
                child: Image.asset(AppConst.imgLogoScreen),
              ),
            ),
            ),
          ),
          const SizedBox(height: 16.0), // Khoảng cách giữa logo và văn bản
          Text(
            "Repairer Manage",
            style: FontStyleUI.fontPlusJakartaSans().copyWith(
                fontSize: 36,
                color: AppColors.textTitleColor,
                fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}