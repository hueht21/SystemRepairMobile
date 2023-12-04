import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:systemrepair/cores/const/app_colors.dart';
import 'package:systemrepair/router/app_pages.dart';
import 'package:systemrepair/shared/utils/font_ui.dart';

import '../../../base_utils/base_widget/base_widget_page.dart';
import '../../../cores/const/const.dart';
import '../../../shared/utils/date_utils.dart';
import '../../../shared/widget/base_widget.dart';
import '../controllers/oder_controller.dart';
import '../controllers/order_controller_imp.dart';
import '../models/registration_schedule_model.dart';

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
          child: Obx(
            () => Column(
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
                            child: _buildDataTable(),
                            onRefresh: controller.onRefresh,
                            onLoadMore: controller.onLoadMore,
                            enablePullUp: true,
                            enablePullDown: true,
                            refreshController: controller.refreshController,
                          ),
                        ),
                      )
                    : Center(child: BaseWidget().listEmpty())
                        .paddingSymmetric(vertical: 70)
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

  Widget _buildDataTable() {
    return Container(
      color: Colors.white,
      child: DataTable2(
        dataRowColor: MaterialStateColor.resolveWith((states) => Colors.white10),
        showCheckboxColumn: false,
        columnSpacing: 10,
        headingTextStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ), // Kiểu chữ của tiêu đề
        dividerThickness: 1,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue), // Màu sắc của thanh kẻ,
          color: Colors.blue.withOpacity(0.1), // Màu sắc giữa các hàng
        ),
        // rowDecoration: BoxDecoration(
        //   color: Colors.blue.withOpacity(0.1), // Màu sắc giữa các hàng
        // ),
        minWidth: 1000,
        columns: [
          DataColumn2(
            size: ColumnSize.S,
            label: Text("ID", style: FontStyleUI.fontPlusJakartaSans().copyWith(color: Colors.black, fontSize: 14),),
          ),
          DataColumn(
            label: Text("Tên khách hàng",style: FontStyleUI.fontPlusJakartaSans().copyWith(color: Colors.black,fontSize: 14),),
          ),
          DataColumn(
            label: Text("Số điện thoại",style: FontStyleUI.fontPlusJakartaSans().copyWith(color: Colors.black,fontSize: 14),),
          ),
          DataColumn(
            label: Text("Địa chỉ",style: FontStyleUI.fontPlusJakartaSans().copyWith(color: Colors.black,fontSize: 14),),
          ),
          DataColumn(
            label: Text("Tình trạng lỗi",style: FontStyleUI.fontPlusJakartaSans().copyWith(color: Colors.black,fontSize: 14),),
          ),
          DataColumn2(
            size: ColumnSize.S,
            label: Center(child: Text("Thợ sửa",style: FontStyleUI.fontPlusJakartaSans().copyWith(color: Colors.black,fontSize: 14),)),
          ),
          DataColumn(
            label: Center(child: Text("Thời gian yêu cầu",style: FontStyleUI.fontPlusJakartaSans().copyWith(color: Colors.black,fontSize: 14),)),
          ),
          DataColumn(
            label: Center(child: Text("Trạng thái",style: FontStyleUI.fontPlusJakartaSans().copyWith(color: Colors.black,fontSize: 14),)),
          ),
        ],
        rows: List.generate(
          controller.listRegistrationSchedule.length,
              (index) => recentFileDataRow(controller.listRegistrationSchedule[index]),
        ),

      ),
    );
  }

  DataRow recentFileDataRow(RegistrationScheduleModel registrationScheduleModel) {
    return DataRow(
      onSelectChanged: (bool? select) {
      },
      color: MaterialStateColor.resolveWith((states) => Colors.black12),
      cells: [
        DataCell(Text("${registrationScheduleModel.id}", style: FontStyleUI.fontPlusJakartaSans().copyWith(color: Colors.black, fontSize: 14),)),
        DataCell(Text("${registrationScheduleModel.uidClient}", style: FontStyleUI.fontPlusJakartaSans().copyWith(color: Colors.black, fontSize: 14),)),
        DataCell(Text(registrationScheduleModel.numberPhone ?? "", style: FontStyleUI.fontPlusJakartaSans().copyWith(color: Colors.black, fontSize: 14),)),
        DataCell(
            Text(registrationScheduleModel.address ?? "", style: FontStyleUI.fontPlusJakartaSans().copyWith(color: Colors.black, fontSize: 14),)),
        DataCell(Center(child: Text(registrationScheduleModel.describe ?? "", style: FontStyleUI.fontPlusJakartaSans().copyWith(color: Colors.black, fontSize: 14),))),
        DataCell(Center(child: Text(registrationScheduleModel.uidFixer?.name ?? "", style: FontStyleUI.fontPlusJakartaSans().copyWith(color: Colors.black, fontSize: 14),))),
        DataCell(Center(child: Text("${registrationScheduleModel.timeSet}:${registrationScheduleModel.dateSet}", style: FontStyleUI.fontPlusJakartaSans().copyWith(color: Colors.black, fontSize: 14),))),
        DataCell(Center(child: Text("${registrationScheduleModel.status}", style: FontStyleUI.fontPlusJakartaSans().copyWith(color: Colors.black, fontSize: 14),))),
        // const DataCell(Center(child: Text("..."))),
      ],
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
