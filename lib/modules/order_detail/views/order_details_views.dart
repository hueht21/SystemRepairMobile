import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_widget/base_widget_page.dart';
import 'package:systemrepair/modules/order_detail/controllers/order_details_controller_imp.dart';
import 'package:systemrepair/router/app_pages.dart';
import 'package:systemrepair/shared/utils/util_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../cores/const/app_colors.dart';
import '../../../cores/enum/enum_status.dart';
import '../../../shared/utils/currency_utils.dart';
import '../../../shared/utils/font_ui.dart';
import '../../../shared/widget/base_widget.dart';
import '../controllers/order_details_controller.dart';

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
      body: Obx(
        () => BaseWidget().baseShowOverlayLoading(
          body(),
          controller.isShowLoading.value,
        ),
      ),
      bottomSheet: _buildItemConfirm().paddingOnly(bottom: 10),
    );
  }

  Widget body() {
    return SingleChildScrollView(
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
          _buildRepairPhoto(),
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
          controller.payOderModel.value.idOder != ""
              ? buildPayOder()
              : const SizedBox()
        ],
      ),
    );
  }

  Widget _buildTitleHead() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: BaseWidget().buildItemHead(EnumStatusOder.waitingStatus, "1",
                controller.indexHead.value == 1),
          ),
          Expanded(
            child: BaseWidget().buildItemBar(controller.indexHead.value >= 0),
          ),
          Expanded(
            child: BaseWidget().buildItemHead(
              EnumStatusOder.confirmedStatus,
              "2",
              controller.indexHead.value == 2,
            ),
          ),
          Expanded(
            child: BaseWidget().buildItemBar(controller.indexHead.value >= 1),
          ),
          Expanded(
            child: BaseWidget().buildItemHead(
              EnumStatusOder.completeStatus,
              "3",
              controller.indexHead.value == 3,
            ),
          ),
          Expanded(
            child: BaseWidget().buildItemBar(controller.indexHead.value >= 2),
          ),
          Expanded(
            child: BaseWidget().buildItemHead(
              EnumStatusOder.canceledStatus,
              "4",
              controller.indexHead.value == 4,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Thông tin đơn",
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                color: AppColors.textTitleColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            InkWell(
              onTap: () async {
                // await launchUrlString("tel://1900565653");
                Get.bottomSheet(
                  UtilWidget.baseBottomSheet(
                    backgroundColor: AppColors.lightAccentColor,
                    noHeader: true,
                    title: "",
                    body: _buildBottomSheet("tel:${controller.registrationScheduleModel.numberPhone}"),
                  ),
                );
              },
              child: Text(
                "Xem chi tiết",
                style: FontStyleUI.fontPlusJakartaSans().copyWith(
                  color: AppColors.textTitleColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
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
              "Khách hàng: ${controller.registrationScheduleModel.customerName}",
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              controller.registrationScheduleModel.numberPhone ?? "",
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
          controller.registrationScheduleModel.address ?? "",
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
          "Mô tả sửa: ${controller.registrationScheduleModel.describe}",
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
          "Lưu ý: ${controller.registrationScheduleModel.note}",
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
            InkWell(
              onTap: () async {
                // await launchUrlString("tel://1900565653");
                Get.bottomSheet(
                  UtilWidget.baseBottomSheet(
                    backgroundColor: AppColors.lightAccentColor,
                    noHeader: true,
                    title: "",
                    body: _buildBottomSheet("tel:${controller.registrationScheduleModel.uidFixer!.numberPhone}"),
                  ),
                );
              },
              child: Text(
                "Xem chi tiết",
                style: FontStyleUI.fontPlusJakartaSans().copyWith(
                  color: AppColors.textTitleColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
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
              "Thợ: ${controller.registrationScheduleModel.uidFixer?.name ?? ""}",
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              controller.registrationScheduleModel.uidFixer?.numberPhone ?? "",
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
                "Địa chỉ sửa: ${controller.registrationScheduleModel.uidFixer?.address}",
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
                child: Obx(
                  () => controller.imageUrlFix.value.isEmpty
                      ? const SizedBox()
                      : CachedNetworkImage(
                          imageUrl: controller.imageUrlFix.value,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                ),
              ),
            )
          ],
        ),
      ],
    ).paddingSymmetric(horizontal: 10);
  }

  Widget _buildBottomSheet(String telephone) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () async {
            if(Get.isDialogOpen == false){
              Get.back();
            }
            await launchUrlString(telephone);
          },
          child: Container(
            width: Get.width - 20,
            height: 44,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.white),
            child: Center(
              child: Text(
                "Điện thoại",
                style: FontStyleUI.fontPlusJakartaSans()
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: Get.width - 20,
          height: 44,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.white),
          child: Center(
            child: Text(
              "Nhắn tin",
              style: FontStyleUI.fontPlusJakartaSans()
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: Get.width - 20,
          height: 44,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.white),
          child: Center(
              child: Text(
                "Báo cáo",
                style: FontStyleUI.fontPlusJakartaSans()
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
              )),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            width: Get.width - 20,
            height: 44,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.white),
            child: Center(
                child: Text(
                  "Huỷ",
                  style: FontStyleUI.fontPlusJakartaSans()
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
                )),
          ),
        )
      ],
    );
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
          width: Get.width,
          // height: Get.height,
          child: Obx(
            () => controller.imageUrlSchedule.value.isEmpty
                ? const SizedBox()
                : CachedNetworkImage(
                    imageUrl: controller.imageUrlSchedule.value,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 10);
  }

  Widget _buildItemConfirm() {
    return (controller.indexHead.value != 3 && controller.indexHead.value != 4)
        ? ((controller.indexHead.value == 1)
            ? Row(
                children: [
                  Expanded(
                    child: BaseGetWidget.buildButton("Từ chối",
                            colorText: AppColors.colorNext, () async {
                      controller.showLoadingOverlay();
                      await controller.cancelOrderBtn();
                      controller.hideLoadingOverlay();
                    },
                            isLoading: controller.isLoadingOverlay.value,
                            colors: AppColors.xamHuy)
                        .paddingSymmetric(horizontal: 10),
                  ),
                  Expanded(
                    child: BaseGetWidget.buildButton("Xác nhận", () async {
                      await controller.confirmStatus();
                    },
                            isLoading: controller.isLoadingOverlay.value,
                            colors: AppColors.colorButton)
                        .paddingSymmetric(horizontal: 10),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: BaseGetWidget.buildButton("Huỷ đơn",
                            colorText: AppColors.colorNext, () async {
                      await controller.cancelOrderBtn();
                    },
                            isLoading: controller.isLoadingOverlay.value,
                            colors: AppColors.xamHuy)
                        .paddingSymmetric(horizontal: 10),
                  ),
                  Expanded(
                    child: BaseGetWidget.buildButton("Thanh toán", () async {
                      Get.toNamed(AppPages.payOder,
                              arguments: controller.registrationScheduleModel)
                          ?.then((value) async {
                        if (value != null) {
                          await controller.confirmPayOder();
                        }
                      });
                    },
                            isLoading: controller.isLoadingOverlay.value,
                            colors: AppColors.colorButton)
                        .paddingSymmetric(horizontal: 10),
                  ),
                ],
              ))
        : const SizedBox();
  }

  Widget buildPayOder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          "Thông tin thanh toán",
          style: FontStyleUI.fontPlusJakartaSans().copyWith(
            color: AppColors.textTitleColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        _buildCustom("Thuế VAT", "0 %"),
        _buildCustom("Tiền trước thuế",
            "${CurrencyUtils().formatNumber(controller.payOderModel.value.amount.toString().replaceAll(',', ''))} VND"),
        _buildCustom("Tổng tiền",
            "${CurrencyUtils().formatNumber(controller.payOderModel.value.amount.toString().replaceAll(',', ''))} VND"),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Hình ảnh hoá đơn",
          style: FontStyleUI.fontPlusJakartaSans().copyWith(
            color: AppColors.textTitleColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        controller.imageUrlPayOder.value.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: controller.imageUrlPayOder.value,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
            : const SizedBox(),
        const SizedBox(
          height: 10,
        )
      ],
    ).paddingSymmetric(horizontal: 10);
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
}
