import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_widget/base_widget_page.dart';
import 'package:systemrepair/cores/const/app_colors.dart';
import 'package:systemrepair/modules/login/models/fixer_account_model.dart';
import 'package:systemrepair/modules/manage_fixer/controllers/manage_fixer_controller.dart';
import 'package:systemrepair/modules/manage_fixer/controllers/manage_fixer_imp.dart';
import 'package:systemrepair/shared/utils/font_ui.dart';
import 'package:systemrepair/shared/utils/util_widget.dart';
import 'package:systemrepair/shared/widget/base_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ManageFixerView extends BaseGetWidget {
  @override
  ManageFixerController controller = Get.put(ManageFixerImp());

  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(),
        body: body());
  }

  Widget body() {
    return Column(
      children: [
        Text(
          "Quản lý danh sách thợ",
          style: FontStyleUI.fontPlusJakartaSans().copyWith(
            color: AppColors.textTim,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Obx(
          () => BaseWidget().baseShowOverlayLoading(
              _buildData(), controller.isShowLoading.value),
        )
      ],
    );
  }

  Widget _buildData() {
    return (controller.listFixerAccountModel.isNotEmpty)
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
            .paddingSymmetric(vertical: 70);
  }

  Widget _buildDataTable() {
    return Container(
      color: Colors.white,
      child: DataTable2(
        // dataRowColor:
        //     MaterialStateColor.resolveWith((states) => Colors.white10),
        showCheckboxColumn: false,
        columnSpacing: 10,
        headingTextStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        // Kiểu chữ của tiêu đề
        dividerThickness: 1,
        // decoration: BoxDecoration(
        //   // border: Border.all(color: Colors.blue), // Màu sắc của thanh kẻ,
        //   color: Colors.blue.withOpacity(0.1), // Màu sắc giữa các hàng
        // ),
        // rowDecoration: BoxDecoration(
        //   color: Colors.blue.withOpacity(0.1), // Màu sắc giữa các hàng
        // ),
        minWidth: 1000,
        columns: [
          DataColumn2(
            size: ColumnSize.L,
            label: Text(
              "Tên thợ sửa",
              style: FontStyleUI.fontPlusJakartaSans()
                  .copyWith(color: Colors.black, fontSize: 14),
            ),
          ),
          DataColumn2(
            size: ColumnSize.L,
            label: Text(
              "Số điện thoại",
              style: FontStyleUI.fontPlusJakartaSans()
                  .copyWith(color: Colors.black, fontSize: 14),
            ),
          ),
          DataColumn2(
            size: ColumnSize.L,
            label: Text(
              "Địa chỉ",
              style: FontStyleUI.fontPlusJakartaSans()
                  .copyWith(color: Colors.black, fontSize: 14),
            ),
          ),
          DataColumn2(
            size: ColumnSize.S,
            label: Center(
                child: Text(
              "Tuổi",
              style: FontStyleUI.fontPlusJakartaSans()
                  .copyWith(color: Colors.black, fontSize: 14),
            )),
          ),
          DataColumn2(
            size: ColumnSize.L,
            label: Center(
                child: Text(
              "Trạng thái",
              style: FontStyleUI.fontPlusJakartaSans()
                  .copyWith(color: Colors.black, fontSize: 14),
            )),
          ),
          DataColumn2(
            size: ColumnSize.L,
            label: Center(
              child: Text(
                "Active",
                style: FontStyleUI.fontPlusJakartaSans()
                    .copyWith(color: Colors.black, fontSize: 14),
              ),
            ),
          ),
        ],
        rows: List.generate(
          controller.listFixerAccountModel.length,
          (index) => recentFileDataRow(controller.listFixerAccountModel[index]),
        ),
      ),
    );
  }

  DataRow recentFileDataRow(FixerAccountModel fixerAccountModel) {
    return DataRow(
      onSelectChanged: (bool? select) {
        Get.bottomSheet(
          UtilWidget.baseBottomSheet(
            backgroundColor: AppColors.lightAccentColor,
            noHeader: true,
            title: "",
            padding: 0,
            body: UtilWidget.buildBottomSheet("tel:${fixerAccountModel.numberPhone}"),
          ),
        );
      },
      // color: MaterialStateColor.resolveWith((states) => Colors.black12),
      cells: [
        DataCell(
          Text(
            "${fixerAccountModel.name}",
            style: FontStyleUI.fontPlusJakartaSans()
                .copyWith(color: Colors.black, fontSize: 14),
          ),
        ),
        DataCell(
          Text(
            "${fixerAccountModel.numberPhone}",
            style: FontStyleUI.fontPlusJakartaSans()
                .copyWith(color: Colors.black, fontSize: 14),
          ),
        ),
        DataCell(
          Text(
            "${fixerAccountModel.address}",
            style: FontStyleUI.fontPlusJakartaSans()
                .copyWith(color: Colors.black, fontSize: 14),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              "${fixerAccountModel.age}",
              style: FontStyleUI.fontPlusJakartaSans()
                  .copyWith(color: Colors.black, fontSize: 14),
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              fixerAccountModel.status ?? false ? "Bật" : "Tắt",
              style: FontStyleUI.fontPlusJakartaSans()
                  .copyWith(color: Colors.black, fontSize: 14),
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              fixerAccountModel.isActive ? "Hoạt động" : "Khoá",
              style: FontStyleUI.fontPlusJakartaSans()
                  .copyWith(color: Colors.black, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

}
