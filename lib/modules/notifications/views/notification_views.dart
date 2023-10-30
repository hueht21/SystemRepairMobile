
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_widget/base_widget_page.dart';

import '../../../cores/const/app_colors.dart';
import '../../../shared/utils/font_ui.dart';

class NotificationView extends BaseGetWidget {
  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: AppColors.colorTextLogin, // Đặt màu cho icon ở đây
        ),
        centerTitle: true,
        title: Text(
          "Thông báo",
          style: FontStyleUI.fontPlusJakartaSans().copyWith(
            fontSize: 20,
            color: AppColors.colorTextLogin,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [buildList()],
        ),
      ),
    );
  }

  Widget buildList() {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: ListView.separated(
          itemBuilder: (context, index) {
            return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(color: Colors.blueAccent)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      FirebaseMessaging.instance.getToken().then((token) {
                        print("Device Token: $token");
                        // Sử dụng token này để gửi thông báo đến thiết bị cần nhận
                      });
                    },
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Hệ thống:',
                            style: FontStyleUI.fontPlusJakartaSans().copyWith(
                              fontSize: 16,
                              color: AppColors.colorTextLogin,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: ' Since notifications are a visible cue, it is common for users to interact with it (by pressing them). The default behavior on both Android & iOS is to open the application.',
                            style: FontStyleUI.fontPlusJakartaSans().copyWith(
                              fontSize: 16,
                              color: AppColors.colorDen,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
          },
          separatorBuilder: (context, index) => const Divider(height: 2),
          itemCount: 5),
    );
  }
}
