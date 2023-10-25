import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:systemrepair/shared/utils/font_ui.dart';

import '../../../cores/const/app_colors.dart';
import '../../../shared/utils/util_widget.dart';
import '../controllers/filter_cancel_oder_controller.dart';

class FilterCancelOderView {
  static Widget buildPageStatus() {
    FilterCancelOderController controller =
        Get.put(FilterCancelOderController());

    return Container(
      height: Get.height * 0.44,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            height: Get.height * 0.44,
            child: Column(
              children: [
                _buildHead(),
                _buildStatus(controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildHead() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.colorThanh),
            ),
          ],
        ).paddingOnly(top: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Lý do huỷ",
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.clear,
                color: AppColors.colorNext,
                size: 30,
              ),
            )
          ],
        ),
        builDivider()
      ],
    ).paddingSymmetric(horizontal: 20, vertical: 15);
  }

  static Widget builDivider() {
    return Container(
      width: Get.width,
      height: 0.2,
      decoration: const BoxDecoration(color: AppColors.colorThanh),
    );
  }

  static Widget _buildStatus(FilterCancelOderController controller) {
    return SizedBox(
      width: Get.width,
      height: Get.height * 0.25,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return itemStatus(controller, index);
        },
        separatorBuilder: (context, index) => const Divider(
          height: 10,
          color: AppColors.colorThanh,
        ),
        itemCount: controller.listStatus.length,
      ),
    ).paddingOnly(left: 10);
  }

  static Widget itemStatus(FilterCancelOderController controller, int index) {
    return Obx(
      () => InkWell(
        onTap: () async {
          if (controller.listStatus.last.index != index) {
            Get.back(result: controller.listStatus[index].nameCancel);
          } else {
            Get.bottomSheet(
              buildInputCancelOder(controller),
              isScrollControlled: true,
            ).then((value) {
              if (value != null) {
                Get.back(result: value);
              }
            });
          }
        },
        child: Container(
          alignment: Alignment.centerLeft,
          height: 50,
          child: Text(
            controller.listStatus[index].nameCancel,
            style: FontStyleUI.fontPlusJakartaSans().copyWith(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }

  static Widget buildBtn(FilterCancelOderController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      color: Colors.white,
      height: kBottomNavigationBarHeight + 12,
      child: UtilWidget.buildButton("Xác nhận", () {
        Get.back(result: controller.textNote.text);
      }, colors: AppColors.colorGradientIconHome, showLoading: true)
          .paddingSymmetric(
        horizontal: 16,
        vertical: 8,
      ),
    ).paddingOnly(
      bottom: GetPlatform.isIOS ? 20 : 12,
    );
  }

  static Widget buildInputCancelOder(FilterCancelOderController controller) {
    return SizedBox(
      height: Get.height * 0.34,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            height: Get.height * 0.3,
            child: Column(
              children: [
                _buildHead(),
                buildFormNote(controller.textNote, "Lý do", "Lý do huỷ đơn")
                    .paddingOnly(left: 25),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          bottomNavigationBar: buildBtn(controller),
        ),
      ),
    );
  }

  static Widget buildFormNote(TextEditingController textEditingController,
      String title, String textHide) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildItemInforNote(
          textEditingController,
          textHide,
        ),
      ],
    );
  }

  static Widget _buildItemInforNote(
      TextEditingController textEditingController, String title) {
    return Container(
      width: Get.width,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: TextField(
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
          keyboardType: TextInputType.text,
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }
}
