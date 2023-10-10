import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_widget/base_widget_page.dart';

import '../../../cores/const/app_colors.dart';
import '../../../cores/const/const.dart';
import '../../../shared/utils/font_ui.dart';
import '../../../shared/widget/base_widget.dart';
import '../controllers/order_details_controller.dart';
import '../controllers/order_details_controller_imp.dart';

class OrderDetails extends BaseGetWidget {
  @override
  OderDetailController controller = Get.put(OderDetailControllerImp());

  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Chi tiết đơn đặt",
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              _buildTitleHead(),
              const SizedBox(
                height: 10,
              ),
              _buildInforOder(),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: Get.width,
                height: 1,
                decoration: const BoxDecoration(color: AppColors.colorThanh),
              ),
              const SizedBox(
                height: 15,
              ),
              _buildInforFixer(),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: Get.width,
                height: 1,
                decoration: const BoxDecoration(color: AppColors.colorThanh),
              ),
              const SizedBox(
                height: 15,
              ),
              _buildRepairPhoto()
            ],
          ),
        ),
      ),
      bottomNavigationBar: BaseGetWidget.buildButton("Huỷ đơn", () {},
          isLoading: controller.isShowLoading.value,
          colors: AppColors.colorButton).paddingSymmetric(horizontal: 10),
    );
  }

  Widget _buildTitleHead() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: BaseWidget().buildItemHead("Đang chờ", "1", true),
          ),
          Expanded(
              child:
                  BaseWidget().buildItemBar(controller.indexHead.value >= 2)),
          Expanded(
            child: BaseWidget().buildItemHead(
              "Đã nhận",
              "2",
              controller.indexHead.value >= 1 ? true : false,
            ),
          ),
          Expanded(
            child: BaseWidget().buildItemBar(controller.indexHead.value >= 2),
          ),
          Expanded(
            child: BaseWidget().buildItemHead(
              "Đã huỷ",
              "3",
              controller.indexHead.value >= 2,
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 10),
    );
  }

  Widget _buildInforOder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          "Thông tin đơn",
          style: FontStyleUI.fontPlusJakartaSans().copyWith(
            color: AppColors.textTitleColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Khách hàng: Phạm Văn An",
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              "0358685200",
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          "Địa chỉ sửa: 345 Khương Trung, Thanh Xuân",
          style: FontStyleUI.fontPlusJakartaSans().copyWith(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          "Mô tả sửa: Máy giặt bật không lên",
          style: FontStyleUI.fontPlusJakartaSans().copyWith(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          "Lưu ý: Đến gọi sớm cho tôi",
          style: FontStyleUI.fontPlusJakartaSans().copyWith(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 10);
  }

  Widget _buildInforFixer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Thông thợ sửa",
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                color: AppColors.textTitleColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "Xem chi tiết",
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                color: AppColors.textTitleColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Thợ: Phạm Văn Hùng",
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              "0358685200",
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Text(
                "Địa chỉ sửa: 345 Khương Trung, Thanh Xuân",
                style: FontStyleUI.fontPlusJakartaSans().copyWith(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                width: 50,
                height: 100,
                child: Image.asset(
                  AppConst.userUser,
                  fit: BoxFit.fill,
                ),
              ),
            )
          ],
        ),
      ],
    ).paddingSymmetric(horizontal: 10);
  }

  Widget _buildRepairPhoto() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Hình ảnh sửa",
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                color: AppColors.textTitleColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "Xem chi tiết",
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                color: AppColors.textTitleColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.topCenter,
          width: 250,
          height: 250,
          child: Image.memory(
            base64Decode(AppConst.imgBase64.split(',').last), /// Đoạn này ghép API vào bỏ đi
            fit: BoxFit.cover,
          ),
        )
      ],
    ).paddingSymmetric(horizontal: 10);
  }
}
