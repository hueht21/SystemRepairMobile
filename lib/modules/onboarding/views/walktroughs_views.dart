import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_widget/base_widget_page.dart';
import 'package:systemrepair/router/app_pages.dart';
import 'package:systemrepair/shared/utils/font_ui.dart';

import '../../../cores/const/app_colors.dart';
import '../../../cores/const/const.dart';
import '../controllers/walktroughs_controller.dart';

class WalktroughsViews extends BaseGetWidget {
  @override
  WalkTroughsController controller = Get.put(WalkTroughsController());

  WalktroughsViews({super.key});

  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              if (controller.indexView.value != 0) {
                controller.indexView.value--;
              }
            } else if (details.primaryVelocity! < 0) {
              if (controller.indexView.value != 2) {
                controller.indexView.value++;
              }
            }
          },
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.offAllNamed(AppPages.login);
                    },
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(
                        "Bỏ qua",
                        style: FontStyleUI.fontPlusJakartaSans().copyWith(
                            color: AppColors.colorNext,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ).paddingOnly(top: 10),
                    ),
                  ),
                  Image.asset(
                      controller.getImgWalkTroughs(controller.indexView.value)),
                  // imgWalkTroughs(),
                  Text(
                    controller.getTitle(controller.indexView.value),
                    style: FontStyleUI.fontPlusJakartaSans().copyWith(
                        color: AppColors.textTitleColor,
                        fontSize: 26,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AutoSizeText(
                    "Chúng tôi tạo ra sản phẩm này nhằm giúp đỡ bạn có thể tìm kiếm thợ sửa uy tín gần với bạn nhất, giúp bạn có một trải nghiệm dịch vụ thật là tuyệt vời ",
                    style: FontStyleUI.fontPlusJakartaSans().copyWith(
                      color: AppColors.textTim,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 120,
                  ),
                  Row(
                    children: [
                      itemSelect(
                          controller.indexView.value == 0 ? 24 : 8,
                          controller.indexView.value == 0
                              ? AppColors.textTitleColor
                              : AppColors.textXam),
                      const SizedBox(
                        width: 5,
                      ),
                      itemSelect(
                          controller.indexView.value == 1 ? 24 : 8,
                          controller.indexView.value == 1
                              ? AppColors.textTitleColor
                              : AppColors.textXam),
                      const SizedBox(
                        width: 5,
                      ),
                      itemSelect(
                          controller.indexView.value == 2 ? 24 : 8,
                          controller.indexView.value == 2
                              ? AppColors.textTitleColor
                              : AppColors.textXam),
                      const Flexible(
                        fit: FlexFit.tight,
                        child: SizedBox(),
                      ),
                      InkWell(
                        onTap: () {
                          controller.setUpIndex();
                        },
                        child: controller.indexView.value != 2
                            ? Container(
                                width: 54,
                                height: 54,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: AppColors.textTitleColor),
                                child: const Icon(Icons.arrow_forward),
                              )
                            : InkWell(
                              onTap: () {
                                Get.offAllNamed(AppPages.login);
                              },
                              child: Container(
                                  width: 158,
                                  height: 54,
                                  decoration: BoxDecoration(
                                      color: AppColors.colorBottom,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Center(
                                    child: Text(
                                      "Bắt đầu thôi!",
                                      style: FontStyleUI.fontPlusJakartaSans()
                                          .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                            ),
                      )
                    ],
                  ),
                ],
              ).paddingSymmetric(horizontal: 10),
            ),
          ),
        ),
      ),
    );
  }

  Widget itemSelect(double width, Color color) {
    return Container(
      width: width,
      height: 8,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(32)),
    );
  }

  Widget imgWalkTroughs() {
    if(controller.indexView.value == 0) {
      return Image.asset(
        AppConst.imgWalkTroughs,
      );
    } else if(controller.indexView.value == 1) {
      return Image.asset(
        AppConst.imgWalkTroughs2,
      );
    } else {
      return Image.asset(
        AppConst.imgWalkTroughs3,
      );
    }

  }
}
