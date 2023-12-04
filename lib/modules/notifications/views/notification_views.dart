import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_widget/base_widget_page.dart';
import 'package:systemrepair/modules/notifications/controllers/notification_controller.dart';
import 'package:systemrepair/modules/notifications/controllers/notification_controller_imp.dart';

import '../../../cores/const/app_colors.dart';
import '../../../shared/utils/font_ui.dart';
import '../../../shared/widget/base_widget.dart';
import '../models/notification_get_model.dart';

class NotificationView extends BaseGetWidget {
  const NotificationView({super.key});

  @override
  NotificationController get controller => Get.put(NotificationControllerImp());

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
        child: baseShowLoading(() => buildList()),
      ),
    );
  }

  Widget buildList() {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: controller.listNotificationModel.isNotEmpty
          ? ListView.separated(
                  itemBuilder: (context, index) {
                    return _buildItemNotification(
                        controller.listNotificationModel[index]);
                  },
                  separatorBuilder: (context, index) =>
                      const Divider(height: 2),
                  itemCount: controller.listNotificationModel.length)
              .paddingSymmetric(vertical: 10)
          : BaseWidget().listEmpty(),
    );
  }

  Widget _buildItemNotification(NotificationGetModel notificationGetModel) {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              // FirebaseMessaging.instance.getToken().then((token) {
              //   print("Device Token: $token");
              //   // Sử dụng token này để gửi thông báo đến thiết bị cần nhận
              // });
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
                    text: notificationGetModel.content,
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
  }
}
