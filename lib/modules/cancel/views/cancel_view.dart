import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:systemrepair/cores/const/app_colors.dart';
import 'package:systemrepair/modules/cancel/controllers/cancel_controller.dart';
import 'package:systemrepair/modules/cancel/controllers/cancel_oder_imp.dart';
import 'package:systemrepair/shared/utils/font_ui.dart';

import '../../../base_utils/base_widget/base_widget_page.dart';
import '../../../shared/widget/base_widget.dart';
import '../../oders/models/registration_schedule_model.dart';

class CancelView extends BaseGetWidget {
  @override
  CancelController get controller => Get.put(CancelOderImp());

  const CancelView({super.key});

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Quản lý đơn huỷ",
                  style: FontStyleUI.fontPlusJakartaSans().copyWith(
                      color: AppColors.textTim,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              // Row(
              //   children: [
              //     SizedBox(
              //       width: Get.width,
              //       height: 35,
              //       child: ListView.builder(
              //         scrollDirection: Axis.horizontal,
              //         itemCount: 5,
              //         itemBuilder: (context, index) {
              //           return optionOder(
              //               controller.listCancelOder[index], index);
              //         },
              //       ),
              //     )
              //   ],
              // ).paddingSymmetric(vertical: 30),
              Text(
                "Danh sách đơn huỷ",
                style: FontStyleUI.fontPlusJakartaSans().copyWith(
                  color: AppColors.textTim,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ).paddingOnly(left: 10),
              // BaseWidget().baseShowOverlayLoading(
              //     _buildData(), controller.isShowLoading.value)
              // _buildItemOrder()
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildData() {
  //   return (controller.listRegistrationSchedule.isNotEmpty)
  //       ? Expanded(
  //           child: SizedBox(
  //             width: Get.width,
  //             height: Get.height,
  //             child: BaseWidget.buildSmartRefresher(
  //               child: _buildDataTable(),
  //               onRefresh: controller.onRefresh,
  //               onLoadMore: controller.onLoadMore,
  //               enablePullUp: true,
  //               enablePullDown: true,
  //               refreshController: controller.refreshController,
  //             ),
  //           ),
  //         )
  //       : Center(child: BaseWidget().listEmpty())
  //           .paddingSymmetric(vertical: 70);
  // }

  // Widget _buildDataTable() {
  //   return Container(
  //     color: Colors.white,
  //     child: DataTable2(
  //       // dataRowColor:
  //       //     MaterialStateColor.resolveWith((states) => Colors.white10),
  //       showCheckboxColumn: false,
  //       columnSpacing: 10,
  //       headingTextStyle: const TextStyle(
  //         fontSize: 16,
  //         fontWeight: FontWeight.bold,
  //         color: Colors.black,
  //       ),
  //       // Kiểu chữ của tiêu đề
  //       dividerThickness: 1,
  //       // decoration: BoxDecoration(
  //       //   // border: Border.all(color: Colors.blue), // Màu sắc của thanh kẻ,
  //       //   color: Colors.blue.withOpacity(0.1), // Màu sắc giữa các hàng
  //       // ),
  //       // rowDecoration: BoxDecoration(
  //       //   color: Colors.blue.withOpacity(0.1), // Màu sắc giữa các hàng
  //       // ),
  //       minWidth: 1000,
  //       columns: [
  //         DataColumn2(
  //           size: ColumnSize.S,
  //           label: Text(
  //             "ID",
  //             style: FontStyleUI.fontPlusJakartaSans()
  //                 .copyWith(color: Colors.black, fontSize: 14),
  //           ),
  //         ),
  //         DataColumn(
  //           label: Text(
  //             "Tên khách hàng",
  //             style: FontStyleUI.fontPlusJakartaSans()
  //                 .copyWith(color: Colors.black, fontSize: 14),
  //           ),
  //         ),
  //         DataColumn(
  //           label: Text(
  //             "Số điện thoại",
  //             style: FontStyleUI.fontPlusJakartaSans()
  //                 .copyWith(color: Colors.black, fontSize: 14),
  //           ),
  //         ),
  //         DataColumn(
  //           label: Text(
  //             "Địa chỉ",
  //             style: FontStyleUI.fontPlusJakartaSans()
  //                 .copyWith(color: Colors.black, fontSize: 14),
  //           ),
  //         ),
  //         DataColumn(
  //           label: Text(
  //             "Tình trạng lỗi",
  //             style: FontStyleUI.fontPlusJakartaSans()
  //                 .copyWith(color: Colors.black, fontSize: 14),
  //           ),
  //         ),
  //         DataColumn2(
  //           size: ColumnSize.S,
  //           label: Center(
  //               child: Text(
  //             "Thợ sửa",
  //             style: FontStyleUI.fontPlusJakartaSans()
  //                 .copyWith(color: Colors.black, fontSize: 14),
  //           )),
  //         ),
  //         DataColumn(
  //           label: Center(
  //               child: Text(
  //             "Thời gian yêu cầu",
  //             style: FontStyleUI.fontPlusJakartaSans()
  //                 .copyWith(color: Colors.black, fontSize: 14),
  //           )),
  //         ),
  //         DataColumn(
  //           label: Center(
  //               child: Text(
  //             "Trạng thái",
  //             style: FontStyleUI.fontPlusJakartaSans()
  //                 .copyWith(color: Colors.black, fontSize: 14),
  //           )),
  //         ),
  //       ],
  //       rows: List.generate(
  //         controller.listRegistrationSchedule.length,
  //         (index) =>
  //             recentFileDataRow(controller.listRegistrationSchedule[index]),
  //       ),
  //     ),
  //   );
  // }

  // DataRow recentFileDataRow(
  //     RegistrationScheduleModel registrationScheduleModel) {
  //   return DataRow(
  //     onSelectChanged: (bool? select) {},
  //     // color: MaterialStateColor.resolveWith((states) => Colors.black12),
  //     cells: [
  //       DataCell(
  //         Text(
  //           "${registrationScheduleModel.id}",
  //           style: FontStyleUI.fontPlusJakartaSans()
  //               .copyWith(color: Colors.black, fontSize: 14),
  //         ),
  //       ),
  //       DataCell(
  //         Text(
  //           controller.getNameUser(registrationScheduleModel.uidClient ?? ""),
  //           style: FontStyleUI.fontPlusJakartaSans()
  //               .copyWith(color: Colors.black, fontSize: 14),
  //         ),
  //       ),
  //       DataCell(
  //         Text(
  //           registrationScheduleModel.numberPhone ?? "",
  //           style: FontStyleUI.fontPlusJakartaSans()
  //               .copyWith(color: Colors.black, fontSize: 14),
  //         ),
  //       ),
  //       DataCell(
  //         Text(
  //           registrationScheduleModel.address ?? "",
  //           style: FontStyleUI.fontPlusJakartaSans()
  //               .copyWith(color: Colors.black, fontSize: 14),
  //         ),
  //       ),
  //       DataCell(
  //         Center(
  //           child: Text(
  //             registrationScheduleModel.describe ?? "",
  //             style: FontStyleUI.fontPlusJakartaSans()
  //                 .copyWith(color: Colors.black, fontSize: 14),
  //           ),
  //         ),
  //       ),
  //       DataCell(
  //         Center(
  //           child: Text(
  //             registrationScheduleModel.uidFixer?.name ?? "",
  //             style: FontStyleUI.fontPlusJakartaSans()
  //                 .copyWith(color: Colors.black, fontSize: 14),
  //           ),
  //         ),
  //       ),
  //       DataCell(
  //         Center(
  //           child: Text(
  //             "${registrationScheduleModel.timeSet}:${registrationScheduleModel.dateSet}",
  //             style: FontStyleUI.fontPlusJakartaSans()
  //                 .copyWith(color: Colors.black, fontSize: 14),
  //           ),
  //         ),
  //       ),
  //       DataCell(
  //         Center(
  //           child: Container(
  //             decoration: BoxDecoration(
  //                 color: controller
  //                     .colorStatus(registrationScheduleModel.status ?? 0),
  //                 borderRadius: BorderRadius.circular(10)),
  //             // width: 70,
  //             height: 25,
  //             child: Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 8),
  //               child: Text(
  //                 controller.getStatus(registrationScheduleModel.status ?? 0),
  //                 style: FontStyleUI.fontPlusJakartaSans()
  //                     .copyWith(color: Colors.white, fontSize: 14),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //       // const DataCell(Center(child: Text("..."))),
  //     ],
  //   );
  // }

  Widget optionOder(String title, int index) {
    return InkWell(
      onTap: () {
        // controller.indexOption.value = index;
        // controller.optionType(controller.indexOption.value);
      },
      child: Obx(
        () => Container(
          width: 100,
          height: 35,
          decoration: BoxDecoration(
            color: AppColors.colorBottom,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              title,
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ).paddingOnly(top: 5),
          ),
        ).paddingSymmetric(horizontal: 10),
      ),
    );
  }
}
