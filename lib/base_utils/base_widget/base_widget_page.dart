import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'package:systemrepair/base_utils/base_controllers/base_controller.dart';
import 'package:systemrepair/cores/values/defaul_theme.dart';
import 'package:systemrepair/cores/values/string_values.dart';
import 'package:systemrepair/shared/utils/util_widget.dart';

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

  static Widget listEmpty() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(
          FontAwesomeIcons.circleExclamation,
          size: 30,
          color: DefaultTheme.greyText,
        ),
        Text(
          AppStr.emptyList,
          style: TextStyle(
            fontSize: 20,
            color: DefaultTheme.greyText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
