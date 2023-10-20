import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_widget/base_widget_page.dart';
import 'package:systemrepair/cores/const/app_colors.dart';
import 'package:systemrepair/shared/utils/font_ui.dart';

import '../../../shared/widget/base_widget_login.dart';
import '../controllers/login_controller.dart';
import '../controllers/login_controller_imp.dart';


class LoginView extends BaseGetWidget {
  @override
  LoginController controller = Get.put(LoginControllerImp());

  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseWidgetLogin().buildHeader(
                  "Đăng nhập", "Đăng nhập để nhận đầy đủ chức năng"),
              const SizedBox(
                height: 15,
              ),
              buildFromLogin(),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topRight,
                child: Text(
                  "Quên mật khẩu",
                  style: FontStyleUI.fontPlusJakartaSans().copyWith(
                      color: AppColors.textColorForgot,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Obx(
                    () => BaseWidgetLogin().buttonView(
                  "Đăng nhập",
                      () async {
                   await controller.loginAcc();
                  },
                  controller.isShowLoading.value,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // BaseWidgetLogin()
              //     .buildRegister("Bạn chưa có tài khoản? ", "Đăng ký ngay", () {
              //   Get.toNamed(AppPages.register);
              // }),
              const SizedBox(
                height: 30,
              ),
              // BaseWidgetLogin().buildLoginSocialNetwork()
            ],
          ).paddingSymmetric(horizontal: 20),
        ),
      ),
    );
  }

  Widget buildFromLogin() {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        BaseWidgetLogin()
            .buildFromTextInput(controller.textEmail, "Email", true),
        const SizedBox(
          height: 20,
        ),
        BaseWidgetLogin()
            .buildFromTextInput(controller.textPass, "Mật khẩu", false),
      ],
    );
  }
}