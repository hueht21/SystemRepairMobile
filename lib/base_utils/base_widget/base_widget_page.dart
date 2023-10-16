import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'package:systemrepair/base_utils/base_controllers/base_controller.dart';
import 'package:systemrepair/shared/utils/util_widget.dart';

import '../../cores/const/app_colors.dart';
import '../../shared/widget/base_widget.dart';

abstract class BaseGetWidget<T extends BaseGetxController> extends GetView<T> {
  const BaseGetWidget({Key? key}) : super(key: key);

  Widget buildWidgets(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // tắt tính năng vuốt trái để back lại màn hình trước đó trên iphone
      onWillPop: () async {
        // KeyBoard.hide();
        // await 300.milliseconds.delay();
        return !Navigator.of(context).userGestureInProgress;
      },
      child: buildWidgets(context),
    );
  }

  Widget baseShowLoading(WidgetCallback child) {
    return Obx(
          () => controller.isShowLoading.value
          ? const Center(child: UtilWidget.buildLoading)
          : child(),
    );
  }

  static Widget buildButton(String btnTitle, Function function,
      {List<Color> colors = AppColors.colorGradientOrange,
        bool isLoading = false,
        bool showLoading = true}) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
          borderRadius: BorderRadius.circular(8)),
      child: BaseWidget.baseOnAction(
        onTap: !isLoading ? function : () {},
        child: ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
          ),
          child: Stack(
            children: [
              Center(
                child: Text(btnTitle.tr,
                    style: const TextStyle(
                        fontSize: 16, color: Colors.white)),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Visibility(
                  visible: isLoading && showLoading,
                  child: Container(
                    height: 20,
                    width: 20,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFFff5f6d),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget baseShimmerLoading(WidgetCallback child, {Widget? shimmer}) {
  //   return Obx(
  //         () => controller.isShowLoading.value
  //         ? shimmer ?? UtilWidget.buildShimmerLoading()
  //         : child(),
  //   );
  // }

  Widget buildLoadingOverlay(WidgetCallback child) {
    return Obx(
          () => Stack(
        children: [
          LoadingOverlayPro(
            progressIndicator: !GetPlatform.isMobile
                ? const CupertinoActivityIndicator(
              radius: 50,
            )
                : UtilWidget.buildLoading,
            isLoading: controller.isLoadingOverlay.value,
            child: child(),
          ),
          // if (controller.isIssueSuccess.value)
            // Stack(
            //   children: [
            //     Container(
            //       color: Colors.black38,
            //     ),
            //     Center(
            //       child: SlitInVertical(
            //         preferences: AnimationPreferences(
            //           autoPlay: AnimationPlayStates.Forward,
            //           duration: 500.milliseconds,
            //         ),
            //         child: Icon(
            //           Icons.check_circle,
            //           color: Colors.lightGreenAccent,
            //           size: Get.width / 2,
            //         ),
            //       ),
            //     )
            //   ],
            // ),
        ],
      ),
    );
  }

}
