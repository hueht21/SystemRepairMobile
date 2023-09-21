import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_widget/base_widget_page.dart';
import 'package:systemrepair/cores/const/app_colors.dart';
import 'package:systemrepair/cores/const/const.dart';
import 'package:systemrepair/modules/login/controllers/login_controller.dart';
import 'package:systemrepair/modules/login/controllers/login_controller_imp.dart';
import 'package:systemrepair/shared/utils/font_ui.dart';

class LoginView extends BaseGetWidget {
  @override
  LoginController controller = Get.put(LoginControllerImp());

  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(),
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
              Container(
                width: Get.width,
                height: 46,
                decoration: BoxDecoration(
                    color: AppColors.textTitleColor,
                    borderRadius: BorderRadius.circular(12)),
                child: InkWell(
                  onTap: () {},
                  child: Center(
                    child: Text(
                      "Đăng nhập",
                      style: FontStyleUI.fontPlusJakartaSans().copyWith(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              buildRegister(),
              const SizedBox(
                height: 30,
              ),
              _buildLoginSocialNetwork()
            ],
          ).paddingSymmetric(horizontal: 10),
        ),
      ),
    );
  }

  Widget buildRegister() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Bạn chưa có tài khoản? ",
          style: FontStyleUI.fontPlusJakartaSans().copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textTim),
        ),
        Text(
          "Đăng ký ngay",
          style: FontStyleUI.fontPlusJakartaSans().copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textTitleColor),
        ),
      ],
    );
  }

  Widget _buildLoginSocialNetwork() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 1,
              width: 94,
              decoration: BoxDecoration(
                  color: AppColors.colorThanh,
                  borderRadius: BorderRadius.circular(1)),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Đăng nhập bằng ",
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                color: AppColors.textColorDNBang,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 1,
              width: 94,
              decoration: BoxDecoration(
                  color: AppColors.colorThanh,
                  borderRadius: BorderRadius.circular(1)),
            ),
          ],
        ),

      ],
    );
  }

  Widget buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: Get.height * 0.15,
        ),
        SizedBox(
          width: 135,
          child: Text(
            "Đăng nhập",
            style: FontStyleUI.fontPlusJakartaSans().copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.colorTextLogin,
                fontSize: 26),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: 132,
          height: 5,
          decoration: BoxDecoration(
              color: AppColors.textTitleColor,
              borderRadius: BorderRadius.circular(25)),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          "Đăng nhập để nhận đầy đủ chức năng",
          style: FontStyleUI.fontPlusJakartaSans()
              .copyWith(color: AppColors.textColorXam, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget buildFromLogin() {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        buildFromTextInput(controller.textNumberPhone, "Số điện thoại", true),
        const SizedBox(
          height: 20,
        ),
        buildFromTextInput(controller.textPass, "Mật khẩu", false),
      ],
    );
  }

  Widget buildFromTextInput(
    TextEditingController textEditingController,
    String title,
    bool isKeyInputNumber,
  ) {
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
                isKeyInputNumber ? AppConst.svgAccount : AppConst.passSvg),
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
                keyboardType: isKeyInputNumber
                    ? TextInputType.number
                    : TextInputType.text,
              ).paddingSymmetric(horizontal: 10),
            ),
          ),
        ],
      ),
    );
  }
}
