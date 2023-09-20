import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:systemrepair/modules/onboarding/controllers/splash_screen_controller.dart';

import '../../../base_utils/base_widget/base_widget_page.dart';
import '../../../cores/const/app_colors.dart';
import '../../../shared/utils/font_ui.dart';

class SplashScreenView extends GetView {

  @override
  SplashScreenController controller = SplashScreenController();

  SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
                width: 250,
                height: 150,
                child: Image.asset('assets/images/logo_screen.png')),
          ),
          const SizedBox(height: 16.0), // Khoảng cách giữa logo và văn bản
          Text(
            "Repairer",
            style: FontStyleUI.fontPlusJakartaSans().copyWith(fontSize: 36, color: AppColors.textTitleColor, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}