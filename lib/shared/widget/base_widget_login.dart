import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_widget/base_widget_page.dart';

import '../../cores/const/app_colors.dart';
import '../../cores/const/const.dart';
import '../utils/font_ui.dart';

class BaseWidgetLogin {
  Widget buildRegister(
      String titleAcc, String textButtom, VoidCallback function) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          titleAcc,
          style: FontStyleUI.fontPlusJakartaSans().copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textTim),
        ),
        InkWell(
          onTap: function,
          child: Text(
            textButtom,
            style: FontStyleUI.fontPlusJakartaSans().copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.textTitleColor),
          ),
        ),
      ],
    );
  }

  Widget buttonView(String title, VoidCallback function, bool isLoading) {
    return Container(
        width: Get.width,
        height: 46,
        decoration: BoxDecoration(
            color: AppColors.textTitleColor,
            borderRadius: BorderRadius.circular(12)),
        child: BaseGetWidget.buildButton(title, function,
            isLoading: isLoading, colors: AppColors.colorButton));
  }

  Widget buildLoginSocialNetwork() {
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
          ],
        ),
        // const SizedBox(
        //   height: 20,
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     SvgPicture.asset(AppConst.iconFacebook),
        //     const SizedBox(
        //       width: 20,
        //     ),
        //     SvgPicture.asset(AppConst.iconGoogle),
        //   ],
        // ),
      ],
    );
  }

  Widget buildHeader(String titleHeader, String contentTitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: Get.height * 0.15,
        ),
        SizedBox(
          width: 135,
          child: Text(
            titleHeader,
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
          contentTitle,
          style: FontStyleUI.fontPlusJakartaSans().copyWith(
              color: AppColors.textColorXam,
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
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
              isKeyInputNumber ? AppConst.emailSvg : AppConst.passSvg,
              color: AppColors.colorIcon,
            ),
          ),
          Expanded(
            flex: 8,
            child: Center(
              child: TextField(
                obscureText: isKeyInputNumber ? false : true,
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
                keyboardType: TextInputType.text,
              ).paddingSymmetric(horizontal: 10),
            ),
          ),
        ],
      ),
    );
  }
}