import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:systemrepair/base_utils/base_widget/base_widget_page.dart';
import 'package:systemrepair/cores/const/app_colors.dart';
import 'package:systemrepair/modules/home_views/controllers/home_view_controller.dart';
import 'package:systemrepair/modules/home_views/controllers/home_view_controller_imp.dart';
import 'package:systemrepair/modules/home_views/views/sales_data_view.dart';
import 'package:systemrepair/shared/utils/font_ui.dart';
import 'package:intl/intl.dart';
import 'package:systemrepair/shared/widget/base_widget.dart';


class HomeViewPage extends BaseGetWidget {
  @override
  HomeViewController controller = Get.put(HomeViewControllerImp());

  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorNen,
      body: Obx(
        () => BaseWidget()
            .baseShowOverlayLoading(body(), controller.isShowLoading.value),
      ),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildItemHeader(
                    "Hoàn thành",
                    "${controller.numberFinish} đơn",
                    AppColors.colorBackgroundIcon,
                    Icons.note_alt),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: _buildItemHeader(
                    "Chờ duyệt",
                    "${controller.numberWaiting} đơn",
                    AppColors.colorIconDuyet,
                    Icons.speaker_notes),
              )
            ],
          ).paddingOnly(top: 10).paddingSymmetric(horizontal: 10),
          Row(
            children: [
              Expanded(
                child: _buildItemHeader(
                    "Chờ sửa",
                    "${controller.numberConfirmedStatus} đơn",
                    AppColors.colorCam,
                    Icons.note_add_rounded),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: _buildItemHeader(
                    "Đã huỷ",
                    "${controller.numberCanceledStatus} đơn",
                    AppColors.colorIconCancel,
                    Icons.speaker_notes_off),
              )
            ],
          ).paddingOnly(top: 10).paddingSymmetric(horizontal: 10),
          chartsMoney(),
          chartsMoneyHeight()
        ],
      ),
    );
  }

  Widget _buildItemHeader(
      String title, String content, Color colorIcon, IconData icon) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Bo góc của card
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        height: 85,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                  color: AppColors.textColorXam88,
                  fontSize: 12,
                  fontWeight: FontWeight.w700),
            ).paddingOnly(left: 10, bottom: 15, top: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  content,
                  style: FontStyleUI.fontPlusJakartaSans().copyWith(
                    color: AppColors.colorDonHang,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ).paddingOnly(left: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: colorIcon,
                  ),
                  width: 35,
                  height: 35,
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ).paddingOnly(right: 10)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget chartsMoney() {
    return SizedBox(
      width: Get.width,
      height: 300,
      child: SfCircularChart(
        legend: Legend(
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap,
          textStyle: FontStyleUI.fontPlusJakartaSans().copyWith(
            color: AppColors.colorNext,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        title: ChartTitle(
          text: "Thống kê giao dịch trong tháng",
          textStyle: FontStyleUI.fontPlusJakartaSans().copyWith(
            color: AppColors.colorNext,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        series: <CircularSeries>[
          PieSeries<SalesData, String>(
            dataSource: controller.salesData,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              textStyle: FontStyleUI.fontPlusJakartaSans().copyWith(
                color: AppColors.colorNext,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget chartsMoneyHeight() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Biểu đồ thống kê doanh thu",
          style: FontStyleUI.fontPlusJakartaSans().copyWith(
            color: AppColors.colorNext,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        SfCartesianChart(
          plotAreaBorderWidth: 2.0, // Đặt độ rộng của biên khu vực vẽ
          series: <ChartSeries<MonthMoney, int>>[
            // Renders column chart
            BarSeries<MonthMoney, int>(
              width: 0.7,
              // Giảm kích thước của cột
              color: AppColors.colorTextLogin,
              dataSource: controller.charGetData,
              xValueMapper: (MonthMoney data, _) => data.monthMoney,
              yValueMapper: (MonthMoney data, _) => data.toalMoney,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                textStyle: TextStyle(color: Colors.black),
                labelAlignment: ChartDataLabelAlignment.outer,
                // labelPosition: ChartDataLabelPosition.inside,
                // textStyle: TextStyle(color: Colors.white),
              ),
              markerSettings: const MarkerSettings(
                  isVisible: false), // Ẩn marker để tránh che phủ nhãn
            )
          ],
          primaryXAxis: CategoryAxis(
            title: AxisTitle(
                text: 'Tháng', textStyle: const TextStyle(color: Colors.black)),
            labelStyle: const TextStyle(color: Colors.black),
            majorGridLines:
                const MajorGridLines(width: 0), // Ẩn đường lưới chính giữa cột
          ),
          primaryYAxis: NumericAxis(
            numberFormat: NumberFormat.currency(locale: 'vi_VN', symbol: '₫'),
            labelStyle: const TextStyle(color: Colors.black),
            // interval: 1, // Đặt giá trị này để hiển thị tất cả các tháng
            labelRotation: -45, // Đặt góc quay để nhãn không bị tràn
          ),
        ),
      ],
    );
  }
}
