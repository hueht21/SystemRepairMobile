import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:systemrepair/router/app_pages.dart';

import '../../../base_utils/base_widget/base_widget_page.dart';
import '../../../cores/const/app_colors.dart';
import '../../../cores/const/const.dart';
import '../../../shared/utils/font_ui.dart';

class FinishRegiter extends BaseGetWidget {
  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.05,
            ),
            SizedBox(
              width: Get.width,
                height: Get.height * 0.4,
                child: Image.asset(AppConst.imgOtp)),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Hoàn tất! ",
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: AppColors.textTitleColor,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Chúc mừng bạn đã đăng ký thành công! ",
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.textTim,
              ),
            ),
             SizedBox(
              height: Get.height * 0.2,
            ),
            InkWell(
              onTap: () {
                Get.offAllNamed(AppPages.login);
              },
              child: Container(
                width: Get.width * 0.9,
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.textTitleColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "Đăng nhập ngay",
                    style: FontStyleUI.fontPlusJakartaSans().copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
