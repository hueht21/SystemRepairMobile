import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base_utils/base_widget/base_widget_page.dart';
import '../../../cores/const/app_colors.dart';
import '../../../router/app_pages.dart';
import '../../../shared/utils/font_ui.dart';
import '../../orders/controllers/order_controler.dart';
import '../controllers/complete_registration_controller.dart';
import '../controllers/complete_registration_controller_imp.dart';

class CompleteRegistration extends BaseGetWidget {

  @override
  CompleteRegistrationController controller = Get.put(CompleteRegistrationControllerImp());

  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(()
          => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.05,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Đã tìm thấy thợ sửa",
                  style: FontStyleUI.fontPlusJakartaSans().copyWith(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textTitleColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              controller.imgFixer.value.isNotEmpty ?
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30)
                ),
                alignment: Alignment.center,
                width: Get.width,
                height: 250,
                child: CachedNetworkImage(
                  imageUrl: controller.imgFixer.value,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ) : const SizedBox(),
              const SizedBox(
                height: 40,
              ),

              _buildInforFixer(),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Kinh nghiệm làm việc: 8 năm",
                style: FontStyleUI.fontPlusJakartaSans().copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textTim,
                ),
              ),
              SizedBox(
                height: Get.height * 0.2,
              ),
              InkWell(
                onTap: () async {
                  bool isCreateOrderController = Get.isRegistered<OrderController>();

                  if(isCreateOrderController) {
                    await Get.find<OrderController>().getDataRegistrationSchedule();
                  }
                  Get.back(result: true);
                },
                child: Container(
                  width: Get.width * 0.9,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.textTitleColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "Hoàn thành",
                      style: FontStyleUI.fontPlusJakartaSans().copyWith(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ).paddingSymmetric(horizontal: 10),
        ),
      ),
    );
  }

  Widget _buildInforFixer() {
    return Column(
      children: [
        _buildItemInfor("Thợ : ${controller.accFixerModel.name}", "SDT: ${controller.accFixerModel.numberPhone}"),
        const SizedBox(
          height: 10,
        ),
        _buildItemInfor("Địa chỉ: ${controller.accFixerModel.address}",
            "Email: ${controller.accFixerModel.email}"),
      ],
    );
  }

  Widget _buildItemInfor(String titleHeader, String titleBottom) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 8,
          child: Text(
            titleHeader,
            style: FontStyleUI.fontPlusJakartaSans().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textTim,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 6,
          child: Text(
            titleBottom,
            style: FontStyleUI.fontPlusJakartaSans().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textTim,
            ),
          ),
        ),
      ],
    );
  }
}
