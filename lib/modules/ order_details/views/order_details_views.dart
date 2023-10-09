import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_widget/base_widget_page.dart';

import '../../../cores/const/app_colors.dart';
import '../../../shared/utils/font_ui.dart';
import '../../../shared/widget/base_widget.dart';
import '../controllers/order_details_controller.dart';
import '../controllers/order_details_controller_imp.dart';

class OrderDetails extends BaseGetWidget {

  @override
  OderDetailController controller =  Get.put(OderDetailControllerImp());
  @override
  Widget buildWidgets(BuildContext context) {
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
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            _buildTitleHead(),
          ],
        ),
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
            child:
                BaseWidget().buildItemHead("Đang chờ", "1", true),
          ),
          Expanded(child: BaseWidget().buildItemBar(controller.indexHead.value >= 2)),
          Expanded(
            child: BaseWidget().buildItemHead(
              "Đã nhận",
              "2",
              controller.indexHead.value >= 1 ? true : false,
            ),
          ),
          Expanded(child: BaseWidget().buildItemBar(controller.indexHead.value >= 2)),
          Expanded(
            child: BaseWidget().buildItemHead(
              "Đã huỷ",
              "3",
              controller.indexHead.value >= 2,
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 10),
    );
  }
}
