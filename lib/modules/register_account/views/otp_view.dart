import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_widget/base_widget_page.dart';
import 'package:systemrepair/cores/const/app_colors.dart';
import 'package:systemrepair/cores/const/const.dart';
import 'package:systemrepair/shared/utils/font_ui.dart';

class OtpView extends BaseGetWidget {
  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   iconTheme: IconThemeData(color: Colors.black), // Thay đổi màu ở đây
      // ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.05,
            ),
            Image.asset(AppConst.imgOtp),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Nhập mã OTP ",
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: AppColors.textTitleColor,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildInputOtp(),
                buildInputOtp(),
                buildInputOtp(),
                buildInputOtp(),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 157,
              height: 46,
              decoration: BoxDecoration(
                color: AppColors.textTitleColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  "Tiếp tục",
                  style: FontStyleUI.fontPlusJakartaSans().copyWith(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildInputOtp() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.textTitleColor, // Màu đường viền
          width: 1.0, // Độ dày của đường viền
        ),
      ),
    ).paddingOnly(right: 10);
  }
}
