import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:systemrepair/base_utils/base_widget/base_widget_page.dart';
import 'package:systemrepair/cores/const/app_colors.dart';
import 'package:systemrepair/modules/pay_order/controllers/pay_oder_controller_imp.dart';
import 'package:systemrepair/shared/widget/base_widget.dart';

import '../../../shared/utils/font_ui.dart';
import '../controllers/pay_oder_controller.dart';

class PayOderView extends BaseGetWidget {
  @override
  PayOderController controller = Get.put(PayOderControllerImp());
  static const _locale = 'en';
  String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(int.parse(s));

  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Thông tin thanh toán",
          style: FontStyleUI.fontPlusJakartaSans().copyWith(
            color: AppColors.colorTextLogin,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColors.colorTextLogin, // Đặt màu cho icon ở đây
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              "Thông tin khách hàng",
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: AppColors.colorTextLogin,
              ),
            ).paddingOnly(left: 10),
            _buildCustom("Tên khách hàng", "Nguyễn Văn A"),
            _buildCustom("Số điện thoại", "0358642533"),
            _buildCustom("Địa chỉ", "54 Triều Khúc Thanh Xuân Hà Nội"),
            Text(
              "Thông tin sửa chữa",
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: AppColors.colorTextLogin,
              ),
            ).paddingOnly(left: 10, top: 10),
            Text(
              "Điều hoà bật có lên nhưng không mát, cần bảo dưỡng làm vệ sinh",
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: AppColors.colorTextLogin,
              ),
            ).paddingOnly(left: 10, top: 10),
            Text(
              "Tổng thanh toán",
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: AppColors.colorTextLogin,
              ),
            ).paddingOnly(left: 10, top: 15),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              child: buildInputTotal(controller.textTotalOder, "Tổng tiền"),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCustom(String title, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: FontStyleUI.fontPlusJakartaSans().copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.colorTextLogin,
          ),
        ),
        Text(
          content,
          style: FontStyleUI.fontPlusJakartaSans().copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.colorTextLogin,
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 10, vertical: 5);
  }

  Widget buildInputTotal(
      TextEditingController textEditingController, String title) {
    return Container(
      width: Get.width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: TextField(
          onChanged: (string){
            if(string != ''){
              string = _formatNumber(string.replaceAll(',', ''));
              controller.textTotalOder.text = string;
              controller.textTotalOder.selection =TextSelection.fromPosition(
                TextPosition(offset: textEditingController.text.length),
              );

              log("${int.parse(string.replaceAll(',', ''))}");

            }
          },
          maxLines: 5,
          controller: textEditingController,
          decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                  color:
                  Colors.transparent), // Đặt màu trong suốt cho underline
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
          keyboardType: TextInputType.number,
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }
}
