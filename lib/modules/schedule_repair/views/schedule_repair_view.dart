import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_widget/base_widget_page.dart';
import 'package:systemrepair/modules/schedule_repair/controllers/schedule_repair_controller_imp.dart';
import 'package:systemrepair/shared/utils/font_ui.dart';

import '../../../cores/const/app_colors.dart';
import '../../../cores/const/const.dart';
import '../../../shared/utils/date_utils.dart';
import '../../../shared/widget/base_widget.dart';
import '../controllers/schedule_repair_controller.dart';

part 'customer_information_view.dart';

part 'information_corrupted_view.dart';

part 'confirm_schedule_repair.dart';

class ScheduleRepair extends BaseGetWidget {
  @override
  ScheduleRepairController controller = Get.put(ScheduleRepairControllerImp());

  ScheduleRepair({super.key});

  @override
  Widget buildWidgets(BuildContext context) {
    final widgetView = [
      buildCustomerInformation(controller),
      buildInformationCorrupted(controller),
      buildConfirmSchedule(controller),
    ];

    return Scaffold(
      backgroundColor: AppColors.colorNen,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Đặt lịch",
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
          child: Obx(
            () => BaseWidget().baseLoading(
              isLoading: controller.isLoadingOverlay.value,
              widget: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    _buildTitleHead(),
                    const SizedBox(
                      height: 20,
                    ),
                    widgetView[controller.indexHead.value],
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ).paddingSymmetric(horizontal: 10),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildButtonNext().paddingOnly(bottom: 10),
    );
  }

  Widget _buildTitleHead() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child:
                BaseWidget().buildItemHead("Thông tin khách hàng", "1", true),
          ),
          Expanded(
              child:
                  BaseWidget().buildItemBar(controller.indexHead.value >= 2)),
          Expanded(
            child: BaseWidget().buildItemHead(
              "Tình trạng hỏng",
              "2",
              controller.indexHead.value >= 1 ? true : false,
            ),
          ),
          Expanded(
              child:
                  BaseWidget().buildItemBar(controller.indexHead.value >= 2)),
          Expanded(
            child: BaseWidget().buildItemHead(
              "Xác nhận",
              "3",
              controller.indexHead.value >= 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonNext() {
    return Obx(
      () => Row(
        children: [
          controller.indexHead.value != 0
              ? InkWell(
                  onTap: () {
                    controller.indexHead.value--;
                  },
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.textTitleColor),
                    child: const Icon(Icons.arrow_back),
                  ),
                )
              : const SizedBox(
                  width: 45,
                  height: 45,
                ),
          const Flexible(
            fit: FlexFit.tight,
            child: SizedBox(),
          ),
          InkWell(
            onTap: () async {
              if (controller.indexHead.value != 2) {
                controller.indexHead.value++;
              } else {
                await controller.registerSchedule();
              }
            },
            child: Container(
              width: controller.indexHead.value == 2 ? 200 : 100,
              height: 35,
              decoration: BoxDecoration(
                  color: AppColors.textTitleColor,
                  borderRadius: BorderRadius.circular(25)),
              child: Center(
                child: Text(
                  controller.indexHead.value == 2 ? "Tìm kiếm thợ sửa" : "Tiếp",
                  style: FontStyleUI.fontPlusJakartaSans().copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 10),
    );
  }
}
