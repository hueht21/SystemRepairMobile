import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_widget/base_widget_page.dart';

import '../../../cores/const/app_colors.dart';
import '../../../cores/const/const.dart';
import '../../../shared/utils/font_ui.dart';
import '../../../shared/widget/base_widget_login.dart';
import '../controllers/update_profile_controller.dart';
import '../controllers/update_profile_controller_imp.dart';

class UpdateProfile extends BaseGetWidget {
  @override
  UpdateProfileController controller = Get.put(UpdateProfileControllerImp());

  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorNen,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Chỉnh sửa thông tin cá nhân",
          style: FontStyleUI.fontPlusJakartaSans().copyWith(
            fontSize: 20,
            color: AppColors.colorTextLogin,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.colorTextLogin, // Đặt màu cho icon ở đây
        ),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          systemNavigationBarColor: Color.fromRGBO(143, 148, 251, 1),
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    await controller.getImageFromGallery();
                  },
                  child: Stack(
                    children: [
                      Positioned(
                        child: Center(
                          child: SizedBox(
                            width: 106,
                            height: 106,
                            child: Image.asset(AppConst.userUser),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 55,
                        left: 180,
                        child: SvgPicture.asset(AppConst.iconUpdateImg),
                      )
                    ],
                  ).paddingOnly(top: 50),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Chỉnh sửa ảnh đại diện",
                  style: FontStyleUI.fontPlusJakartaSans().copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColorForgot,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                buildFromLogin(),
                _buildFormCustomer(),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                      () => BaseWidgetLogin().buttonView(
                    "Cập nhập tài khoản",
                        () async {

                    },
                    controller.isShowLoading.value,
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 10),
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
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Lưu ý: Địa chỉ cần nhập đúng ngõ,đường, quân",
            style: FontStyleUI.fontPlusJakartaSans()
                .copyWith(color: AppColors.textColorXam, fontSize: 13),
          ).paddingOnly(top: 10),
        ),
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
