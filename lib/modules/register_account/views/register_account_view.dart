import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_widget/base_widget_page.dart';
import 'package:systemrepair/modules/register_account/controllers/register_account_controller.dart';
import 'package:systemrepair/modules/register_account/controllers/register_account_controller_imp.dart';
import 'package:systemrepair/router/app_pages.dart';

import '../../../cores/const/app_colors.dart';
import '../../../cores/const/const.dart';
import '../../../shared/utils/font_ui.dart';
import '../../../shared/widget/base_widget_login.dart';

class RegisterAccount extends BaseGetWidget {
  @override
  RegisterAccountController controller =
      Get.put(RegisterAccountControllerImp());

  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode()); // Ẩn bàn phím
          },
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseWidgetLogin().buildHeader(
                      "Đăng ký", "Đăng ký để nhận dịch vụ của chúng tôi"),
                  const SizedBox(
                    height: 15,
                  ),
                  buildFromLogin(),
                  _buildFormCustomer(),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BaseWidgetLogin().buttonView(
                    "Đăng ký ngay",
                    () async {
                      controller.showLoading();
                      // Get.toNamed(AppPages.OTP);
                      await controller.isCheckEnterPass();
                      controller.hideLoading();
                    },
                    controller.isShowLoading.value,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BaseWidgetLogin().buildRegister(
                      "Bạn đã có tài khoản? ", "Đăng nhập ngay", () {
                    Get.back();
                  }),
                  const SizedBox(
                    height: 30,
                  ),
                  BaseWidgetLogin().buildLoginSocialNetwork()
                ],
              ).paddingSymmetric(horizontal: 20),
            ),
          ),
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
        const SizedBox(
          height: 20,
        ),
        BaseWidgetLogin().buildFromTextInput(
            controller.textEnterPassword, "Nhập lại mật khẩu", false),
      ],
    );
  }

  Widget _buildFormCustomer() {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        _buildItemInfor(
            controller.textName, "Họ và tên", AppConst.svgAccount, true),
        const SizedBox(
          height: 15,
        ),
        _buildItemInfor(controller.textNumberPhone, "Số điện thoại",
            AppConst.phoneSvg, false),
        const SizedBox(
          height: 15,
        ),
        _buildItemInfor(
            controller.textAddress, "Địa chỉ", AppConst.homeSvg, true),
        const SizedBox(
          height: 15,
        ),
        // _buildItemInfor(controller.textNumberPhone, "Họ và tên"),
      ],
    );
  }

  Widget _buildItemInfor(TextEditingController textEditingController,
      String title, String svg, bool isTextInputNumber) {
    return Container(
      width: Get.width,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SvgPicture.asset(
              svg,
              color: AppColors.colorIcon,
            ),
          ),
          Expanded(
            flex: 8,
            child: Center(
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .transparent), // Đặt màu trong suốt cho underline
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .transparent), // Đặt màu trong suốt cho underline khi focus
                  ),
                  hintText: title,
                  hintStyle: FontStyleUI.fontPlusJakartaSans()
                      .copyWith(color: AppColors.textColorXam88, fontSize: 14),
                ),
                style: FontStyleUI.fontPlusJakartaSans()
                    .copyWith(color: AppColors.textColorXam88, fontSize: 14),
                keyboardType: isTextInputNumber
                    ? TextInputType.text
                    : TextInputType.number,
              ).paddingSymmetric(horizontal: 10),
            ),
          ),
        ],
      ),
    );
  }
}
