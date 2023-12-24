import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:systemrepair/base_utils/base_widget/base_widget_page.dart';
import 'package:systemrepair/cores/const/app_colors.dart';
import 'package:systemrepair/modules/pay_order/controllers/pay_oder_controller_imp.dart';
import 'package:systemrepair/router/app_pages.dart';
import '../../../cores/const/const.dart';
import '../../../shared/utils/currency_utils.dart';
import '../../../shared/utils/font_ui.dart';
import '../../../shared/widget/base_widget_login.dart';
import '../controllers/pay_oder_controller.dart';

class PayOderView extends BaseGetWidget {
  @override
  PayOderController controller = Get.put(PayOderControllerImp());


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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Thông tin khách hàng",
                      style: FontStyleUI.fontPlusJakartaSans().copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: AppColors.colorTextLogin,
                      ),
                    ).paddingOnly(left: 10),
                    _buildCustom("Tên khách hàng", controller.registrationScheduleModel.customerName ?? ""),
                    _buildCustom("Số điện thoại", controller.registrationScheduleModel.numberPhone ?? ""),
                    _buildCustom("Địa chỉ", controller.registrationScheduleModel.address ?? ""),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Thông tin sửa chữa",
                      style: FontStyleUI.fontPlusJakartaSans().copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: AppColors.colorTextLogin,
                      ),
                    ).paddingOnly(left: 10, top: 10),
                    Text(
                      controller.registrationScheduleModel.describe ?? "",
                      style: FontStyleUI.fontPlusJakartaSans().copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColors.colorTextLogin,
                      ),
                    ).paddingOnly(left: 10, top: 10),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      _buildCustom("Thuế VAT", "0%"),
                      _buildCustom("Tiền trước thuế", "${controller.total.value} VND"),
                      _buildCustom("Tổng tiền", "${controller.amount.value} VND"),
                      Container(
                        color: Colors.white,
                        child: buildInputTotal(
                            controller.textTotalOder, "Nhập số tiền"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              await controller.getImageFromGallery();
                            },
                            child: Container(
                              width: 200,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: AppColors.colorDate, // Màu đường viền bạn muốn sử dụng
                                  width: 1.0, // Độ rộng của đường viền
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SvgPicture.asset(AppConst.iconCamera),
                                  Text(
                                    "Tải hình ảnh hoá đơn lên",
                                    style: FontStyleUI.fontPlusJakartaSans().copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.colorDate,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            ).paddingOnly(left: 10),
                          ),
                          InkWell(
                            onTap: () async {
                              // await controller.getImageFromGallery();
                              Get.toNamed(AppPages.pay);
                            },
                            child: Container(
                              width: 150,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: AppColors.colorDate, // Màu đường viền bạn muốn sử dụng
                                  width: 1.0, // Độ rộng của đường viền
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SvgPicture.asset(AppConst.iconCamera),
                                  Text(
                                    "QR thanh toán",
                                    style: FontStyleUI.fontPlusJakartaSans().copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.colorDate,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            ).paddingOnly(left: 10),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      controller.image.value.path.isNotEmpty
                          ? Image.file(
                        controller.image.value,
                        fit: BoxFit.cover,
                      ).paddingOnly(bottom: 20)
                          : const SizedBox(),
                      const SizedBox(height: 10,)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                    () => BaseWidgetLogin().buttonView(
                  "Thanh toán",
                      () async {
                    log("bam1");
                    await controller.payOder();
                  },
                  controller.isShowLoading.value,
                ),
              ),
            ],
          ),
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
          onChanged: (string) {
            if (string != '') {
              string = CurrencyUtils().formatNumber(string.replaceAll(',', ''));
              controller.textTotalOder.text = string;
              controller.textTotalOder.selection = TextSelection.fromPosition(
                TextPosition(offset: textEditingController.text.length),
              );
              controller.amount.value = controller.textTotalOder.text;
              controller.total.value = controller.textTotalOder.text;
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
                .copyWith(color: AppColors.textColorXam88, fontSize: 16),
          ),
          style: FontStyleUI.fontPlusJakartaSans()
              .copyWith(color: AppColors.textColorXam88, fontSize: 16),
          keyboardType: TextInputType.number,
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }
}
