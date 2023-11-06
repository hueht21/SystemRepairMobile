import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../cores/const/app_colors.dart';
import '../../cores/values/defaul_theme.dart';
import '../../cores/values/string_values.dart';
import '../utils/font_ui.dart';
import '../utils/limit_textfield.dart';
import '../utils/util_widget.dart';

class BaseWidget {
  static DateTime? _dateTime;
  static int _oldFunc = 0;

  static const Widget sizedBox10 = SizedBox(height: 10);
  static const Widget sizedBox5 = SizedBox(height: 5);

  /// Sử dụng để tránh trường hợp click liên tiếp khi thực hiện function
  static Widget baseOnAction({
    required Function onTap,
    required Widget child,
  }) {
    return GestureDetector(
      onTap: () {
        DateTime now = DateTime.now();
        if (_dateTime == null ||
            now.difference(_dateTime ?? DateTime.now()) > 1.seconds ||
            onTap.hashCode != _oldFunc) {
          _dateTime = now;
          _oldFunc = onTap.hashCode;
          onTap();
        }
      },
      child: child,
    );
  }

  Widget optionCircle(
      {required double width,
        required double height,
        required String icon,
        int? check}) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.09),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ], color: Colors.orange, shape: BoxShape.circle),
        child: CircleAvatar(
            backgroundColor: Colors.white,
            child: check == 1
                ? SvgPicture.asset(
              icon,
              color: const Color(0xff6B46D6),
            )
                : SvgPicture.asset(icon)));
  }

  Widget buildItemHead(String title, String number, bool isSelect) {
    return Column(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
              color: isSelect
                  ? AppColors.textTitleColor
                  : AppColors.textColorXam88,
              borderRadius: BorderRadius.circular(50)),
          child: Center(
            child: Text(
              number,
              style: FontStyleUI.fontNunito().copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 102,
          child: Text(
            title,
            style: FontStyleUI.fontPlusJakartaSans().copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isSelect ? AppColors.textTim : AppColors.textColorXam88,
            ),
            textAlign: TextAlign.center,
          ),
        ).paddingOnly(top: 5)
      ],
    );
  }

  Widget buildItemHeadSelect(String title, String number, bool isSelect) {
    return Column(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
              color: isSelect
                  ? AppColors.textTitleColor
                  : AppColors.textColorXam88,
              borderRadius: BorderRadius.circular(50)),
          child: Center(
            child: Text(
              number,
              style: FontStyleUI.fontNunito().copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 102,
          child: Text(
            title,
            style: FontStyleUI.fontPlusJakartaSans().copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isSelect ? AppColors.textTim : AppColors.textColorXam88,
            ),
            textAlign: TextAlign.center,
          ),
        ).paddingOnly(top: 5)
      ],
    );
  }

  Widget buildItemBar(bool isSelect) {
    return Container(
      width: 50,
      height: 1,
      decoration: BoxDecoration(
        color: isSelect ? AppColors.textTim : AppColors.textColorXam88,
        borderRadius: BorderRadius.circular(5),
      ),
    ).paddingSymmetric(vertical: 13);
  }

  Widget baseLoading({required bool isLoading, required Widget widget}) {
    return LoadingOverlayPro(
      isLoading: isLoading,
      child: widget,
    );
  }

  /// Widget cài đặt việc refresh page
  static Widget buildSmartRefresher({
    required RefreshController refreshController,
    required Widget child,
    ScrollController? scrollController,
    Function()? onRefresh,
    Function()? onLoadMore,
    bool enablePullUp = false,
    bool enablePullDown = false,
  }) {
    return SmartRefresher(
      enablePullDown: enablePullDown,
      enablePullUp: enablePullUp,
      scrollController: scrollController,
      // header: const MaterialClassicHeader(),
      controller: refreshController,
      onRefresh: onRefresh,
      onLoading: onLoadMore,
      footer: BaseWidget.buildSmartRefresherCustomFooter(),
      child: child,
    );
  }

  static Widget buildSmartRefresherCustomFooter() {
    return CustomFooter(
      builder: (context, mode) {
        if (mode == LoadStatus.loading) {
          return const CupertinoActivityIndicator();
        } else {
          return const Opacity(
            opacity: 0.0,
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }

  Widget listEmpty() {
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

  Widget buildItemInforNote(
      TextEditingController textEditingController, String title) {
    return Container(
      width: Get.width,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: TextField(
          maxLines: 5,
          controller: textEditingController,
          decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                  color:
                  Colors.transparent), // Đặt màu trong suốt cho underline
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors
                      .transparent), // Đặt màu trong suốt cho underline khi focus
            ),
            hintText: title,
            hintStyle: FontStyleUI.fontPlusJakartaSans()
                .copyWith(color: AppColors.textColorXam88, fontSize: 14),
          ),
          style: FontStyleUI.fontPlusJakartaSans()
              .copyWith(color: AppColors.textColorXam88, fontSize: 14),
          keyboardType: TextInputType.text,
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }

  Widget buildInputTotal(
      TextEditingController textEditingController, String title) {
    return Container(
      width: Get.width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: TextField(
          maxLines: 5,
          controller: textEditingController,
          decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                  color:
                  Colors.transparent), // Đặt màu trong suốt cho underline
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors
                      .transparent), // Đặt màu trong suốt cho underline khi focus
            ),
            hintText: title,
            hintStyle: FontStyleUI.fontPlusJakartaSans()
                .copyWith(color: AppColors.textColorXam88, fontSize: 14),
          ),
          style: FontStyleUI.fontPlusJakartaSans()
              .copyWith(color: AppColors.textColorXam88, fontSize: 14),
          keyboardType: TextInputType.number,
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }

  Widget buildProductTextFormField({
    required String title,
    required TextEditingController textEditingController,
    int maxLength = 80,
    int maxLines = 1,
    bool isValidate = false,
    bool enable = true,
    TextAlign textAlign = TextAlign.start,
    TextInputAction textInputAction = TextInputAction.next,
    bool isProductCode = false,
  }) {
    return TextFormField(
      keyboardAppearance: Brightness.light,
      validator: (val) {
        if (isValidate) {
          // if (val!.isStringEmpty) {
          //   return "AppStr.productDetailNotEmpty.tr";
          // }
          return null;
        }
        return null;
      },
      inputFormatters: isProductCode
          ? [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9-_\.]')),
        LengthLimitingTextFieldFormatterFixed(maxLength),
      ]
          : [
        LengthLimitingTextFieldFormatterFixed(maxLength),
      ],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.multiline,
      style: Get.textTheme.bodyMedium,
      controller: textEditingController,
      maxLength: maxLength,
      maxLines: maxLines,
      enabled: enable,
      textAlign: textAlign,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: Get.textTheme.bodyMedium,
        errorStyle: const TextStyle(color: AppColors.errorTextColor),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.all(12),
      ),
    ).paddingAll(1.0);
  }

  Widget baseShowOverlayLoading(Widget child, bool isLoadingOverlay) {
    return isLoadingOverlay
        ? const Center(child: UtilWidget.buildLoading)
        : child;
  }
}