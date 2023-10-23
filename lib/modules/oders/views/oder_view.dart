import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:systemrepair/cores/const/app_colors.dart';
import 'package:systemrepair/router/app_pages.dart';
import 'package:systemrepair/shared/utils/font_ui.dart';

import '../../../base_utils/base_widget/base_widget_page.dart';
import '../../../shared/widget/base_widget.dart';
import '../../schedule_repair/models/registration_schedule_model.dart';
import '../controllers/order_controler.dart';
import '../controllers/order_controller_imp.dart';

class OdersView extends BaseGetWidget {
  @override
  OrderController controller = Get.put(OrderControllerImp());

  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          systemNavigationBarColor: Color.fromRGBO(143, 148, 251, 1),
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: SafeArea(
          child: Obx(()
          => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Đơn đặt của bạn",
                  style: FontStyleUI.fontPlusJakartaSans().copyWith(
                      color: AppColors.textTim,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: Get.width,
                    height: 35,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return optionOder(
                            controller.listTitleOption[index], index);
                      },
                    ),
                  )
                ],
              ).paddingSymmetric(vertical: 30),
              Text(
                "Danh sách đơn đặt của bạn",
                style: FontStyleUI.fontPlusJakartaSans().copyWith(
                  color: AppColors.textTim,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ).paddingOnly(left: 10),
              (controller.listRegistrationSchedule.isNotEmpty)
                  ? Expanded(
                child: SizedBox(
                    width: Get.width,
                    height: Get.height,
                    child: BaseWidget.buildSmartRefresher(
                      child: _buildListOder(),
                      onRefresh: controller.onRefresh,
                      onLoadMore: controller.onLoadMore,
                      enablePullUp: true,
                      enablePullDown: true,
                      refreshController: controller.refreshController,
                    )),
              )
                  : Center(child: BaseWidget().listEmpty()).paddingSymmetric(vertical: 70)
              // _buildItemOrder()
            ],
          ),
          ),
        ),
      ),
    );
  }

  Widget _buildListOder() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _buildItemOrder(controller.listRegistrationSchedule[index]);
      },
      itemCount: controller.listRegistrationSchedule.length,
    );
  }

  Widget optionOder(String title, int index) {
    return InkWell(
      onTap: () {
        controller.indexOption.value = index;
        controller.optionType(controller.indexOption.value);
      },
      child: Obx(
            () => Container(
          width: 100,
          height: 35,
          decoration: BoxDecoration(
            color: controller.indexOption.value == index
                ? AppColors.colorBottom
                : AppColors.textXam,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              title,
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: controller.indexOption.value == index
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ).paddingSymmetric(horizontal: 10),
      ),
    );
  }

  Widget _buildItemOrder(RegistrationScheduleModel registrationScheduleModel) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppPages.orderDetails, arguments: registrationScheduleModel)
            ?.then((value) async {
          if (value != null) {
            await controller.getDataRegistrationSchedule();
          }
        });
      },
      child: Container(
        width: Get.width,
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.textTitleColor, // Màu border muốn đặt
            width: 1.0, // Độ dày của border
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Khách hàng: ${registrationScheduleModel.customerName} ",
                  style: FontStyleUI.fontPlusJakartaSans().copyWith(
                      color: AppColors.textTitleColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "${registrationScheduleModel.numberPhone}",
                  style: FontStyleUI.fontPlusJakartaSans().copyWith(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                )
              ],
            ).paddingSymmetric(horizontal: 10, vertical: 8),
            Text(
              "${registrationScheduleModel.email}",
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ).paddingSymmetric(horizontal: 10),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "${registrationScheduleModel.timeSet} ",
                  style: FontStyleUI.fontPlusJakartaSans().copyWith(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                  width: 60,
                  height: 2,
                  decoration: const BoxDecoration(color: AppColors.colorThanh),
                ).paddingSymmetric(horizontal: 10),
                Text(
                  "${registrationScheduleModel.dateSet}",
                  style: FontStyleUI.fontPlusJakartaSans().copyWith(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 10),
            Container(
              width: Get.width,
              height: 1,
              decoration: const BoxDecoration(color: AppColors.colorThanh),
            ).paddingSymmetric(vertical: 10),
            _buildFixer(registrationScheduleModel)
          ],
        ),
      ).paddingSymmetric(horizontal: 10, vertical: 10),
    );
  }

  Widget _buildFixer(RegistrationScheduleModel registrationScheduleModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Thợ: ${registrationScheduleModel.uidFixer?.name ?? ""} ",
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                  color: AppColors.textTitleColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              registrationScheduleModel.uidFixer?.numberPhone ?? "",
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ).paddingSymmetric(vertical: 8),
        Text(
          registrationScheduleModel.uidFixer?.address ?? "",
          style: FontStyleUI.fontPlusJakartaSans().copyWith(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          "Miêu tả: ${registrationScheduleModel.describe}",
          style: FontStyleUI.fontPlusJakartaSans().copyWith(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: 100,
          height: 35,
          decoration: BoxDecoration(
              color: AppColors.colorCam,
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text(
              controller.getStatus(registrationScheduleModel.status ?? 0),
            ),
          ),
        ).paddingOnly(left: 10)
      ],
    ).paddingSymmetric(horizontal: 10);
  }
}