import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_widget/base_widget_page.dart';

import '../../../cores/const/app_colors.dart';
import '../../../shared/utils/font_ui.dart';
import '../../../shared/widget/base_widget.dart';

class CancelOder extends BaseGetWidget{
  const CancelOder({super.key});

  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      body: body()
    );
  }

  Widget body() {
    return Column(
      children: [
        Text(
          "Danh sách đơn đặt của bạn",
          style: FontStyleUI.fontPlusJakartaSans().copyWith(
            color: AppColors.textTim,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ).paddingOnly(left: 10),
        // (controller.listRegistrationSchedule.isNotEmpty)
        //     ? Expanded(
        //   child: SizedBox(
        //     width: Get.width,
        //     height: Get.height,
        //     child: BaseWidget.buildSmartRefresher(
        //       child: _buildDataTable(),
        //       onRefresh: controller.onRefresh,
        //       onLoadMore: controller.onLoadMore,
        //       enablePullUp: true,
        //       enablePullDown: true,
        //       refreshController: controller.refreshController,
        //     ),
        //   ),
        // )
        //     : Center(child: BaseWidget().listEmpty())
        //     .paddingSymmetric(vertical: 70)
      ],
    );
  }

}