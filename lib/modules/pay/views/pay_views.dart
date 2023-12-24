import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_widget/base_widget_page.dart';
import 'package:systemrepair/cores/const/app_colors.dart';
import 'package:systemrepair/modules/pay/controllers/pay_controler.dart';
import 'package:systemrepair/shared/utils/font_ui.dart';
import 'package:systemrepair/shared/widget/base_widget.dart';

class PayViews extends BaseGetWidget {
  @override
  PayController controller = Get.put(PayController());

  PayViews({super.key});

  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "Thông tin thanh toán",
          style: FontStyleUI.fontPlusJakartaSans().copyWith(color: AppColors.textTitleColor, ),
        ),
      ),
      body: Obx(
        () => BaseWidget()
            .baseShowOverlayLoading(body(), controller.isShowLoading.value),
      ),
    );
  }

  Widget body() {
    return Column(
      children: [

        const SizedBox(
          height: 20,
        ),
        Text(
          "Trung tâm sửa chữa điện lạnh Hanel, thông tin thanh toán",
          style: FontStyleUI.fontPlusJakartaSans().copyWith(color: AppColors.textTitleColor, fontSize: 23, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        controller.imageUrlPayOder.value.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: controller.imageUrlPayOder.value,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
            : const SizedBox(),
      ],
    );
  }
}
