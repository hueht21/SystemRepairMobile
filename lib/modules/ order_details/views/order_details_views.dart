import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_widget/base_widget_page.dart';

import '../../../cores/const/app_colors.dart';
import '../../../cores/const/const.dart';
import '../../../cores/enum/enum_status.dart';
import '../../../router/app_pages.dart';
import '../../../shared/utils/font_ui.dart';
import '../../../shared/widget/base_widget.dart';
import '../controllers/order_details_controller.dart';
import '../controllers/order_details_controller_imp.dart';

class OrderDetails extends BaseGetWidget {
  @override
  OderDetailController controller = Get.put(OderDetailControllerImp());

  @override
  Widget buildWidgets(BuildContext context) {
    // return Obx(() => BaseWidget().baseShowOverlayLoading( body(), controller.isLoadingOverlay.value));
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
          child: BaseWidget().baseShowOverlayLoading(
              body(), controller.isLoadingOverlay.value)),
      bottomNavigationBar:
          (controller.indexHead.value != 3 && controller.indexHead.value != 4)
              ? (controller.isLoadingOverlay.value ? const SizedBox() : BaseGetWidget.buildButton("Huỷ đơn", () async {
            await controller.cancelOrder();
          },
                          isLoading: controller.isLoadingOverlay.value,
                          colors: AppColors.colorButton)
              .paddingSymmetric(horizontal: 10))
              : const SizedBox(),
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
          _buildRepairPhoto()
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
            child: BaseWidget()
                .buildItemHead(EnumStatusOder.waitingStatus, "1", true),
          ),
          Expanded(
            child: BaseWidget().buildItemBar(controller.indexHead.value >= 0),
          ),
          Expanded(
            child: BaseWidget().buildItemHead(
              EnumStatusOder.confirmedStatus,
              "2",
              controller.indexHead.value > 1 ? true : false,
            ),
          ),
          Expanded(
            child: BaseWidget().buildItemBar(controller.indexHead.value > 1),
          ),
          Expanded(
            child: BaseWidget().buildItemHead(
              EnumStatusOder.completeStatus,
              "3",
              controller.indexHead.value > 2,
            ),
          ),
          Expanded(
            child: BaseWidget().buildItemBar(controller.indexHead.value > 3),
          ),
          Expanded(
            child: BaseWidget().buildItemHead(
              EnumStatusOder.canceledStatus,
              "4",
              controller.indexHead.value > 3,
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
                    // fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
          ),
        ).paddingSymmetric(vertical: 30),
      ],
    ).paddingSymmetric(horizontal: 10);
  }

// Widget _buildItemConfirm() {
//   return (controller.indexHead.value != 3 && controller.indexHead.value != 4)
//       ? ((controller.indexHead.value == 1)
//           ? Row(
//               children: [
//                 Expanded(
//                   child: BaseGetWidget.buildButton("Từ chối",
//                            () async {
//                     // await controller.cancelOrderBtn();
//                   },
//                           isLoading: controller.isShowLoading.value,
//                           colors: AppColors.xamHuy)
//                       .paddingSymmetric(horizontal: 10),
//                 ),
//                 Expanded(
//                   child: BaseGetWidget.buildButton("Xác nhận", () async {
//                     // await controller.confirmStatus();
//                   },
//                           isLoading: controller.isShowLoading.value,
//                           colors: AppColors.colorButton)
//                       .paddingSymmetric(horizontal: 10),
//                 ),
//               ],
//             )
//           : Row(
//               children: [
//                 Expanded(
//                   child: BaseGetWidget.buildButton("Huỷ đơn",
//                            () async {
//                     // await controller.cancelOrderBtn();
//                   },
//                           isLoading: controller.isShowLoading.value,
//                           colors: AppColors.xamHuy)
//                       .paddingSymmetric(horizontal: 10),
//                 ),
//                 Expanded(
//                   child: BaseGetWidget.buildButton("Thanh toán", () async {
//                     Get.toNamed(AppPages.payOder,
//                             arguments: controller.registrationScheduleModel)
//                         ?.then((value) async {
//                       if (value != null) {
//                         await controller.confirmPayOder();
//                       }
//                     });
//                   },
//                           isLoading: controller.isShowLoading.value,
//                           colors: AppColors.colorButton)
//                       .paddingSymmetric(horizontal: 10),
//                 ),
//               ],
//             ))
//       : const SizedBox();
// }
}