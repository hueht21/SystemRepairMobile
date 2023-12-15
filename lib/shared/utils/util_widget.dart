import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:systemrepair/cores/const/app_colors.dart';
import 'package:systemrepair/shared/utils/font_ui.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UtilWidget {
  static DateTime? _dateTime;
  static int _oldFunc = 0;

  static Widget baseBottomSheet({
    required String title,
    required Widget body,
    Widget? iconTitle,
    bool isSecondDisplay = false,
    Widget? actionArrowBack,
    double? padding,
    bool noHeader = false,
    Color? backgroundColor,
    TextAlign? textAlign,
    double? height,
  }) {
    return SafeArea(
      bottom: false,
      minimum: EdgeInsets.only(
          top: Get.mediaQuery.padding.top + (isSecondDisplay ? 100 : 20)),
      child: Container(
        height: height ?? Get.height / 3,
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Drag handle Icon
            Center(
              child: Container(
                height: 4,
                width: 36,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Colors.grey,
                ),
              ).paddingSymmetric(vertical: 10),
            ),
            noHeader
                ? const SizedBox()
                : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                actionArrowBack ??
                    const BackButton(
                      color: Colors.grey,
                    ),
                Expanded(
                  child: Text(
                    title.tr,
                    textAlign: textAlign ?? TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: FontStyleUI.fontPlusJakartaSans(),
                  ),
                ),
                iconTitle ??
                    const SizedBox(
                      width: 48, //size of Back Button
                    ),
              ],
            ),
            Expanded(child: body),
          ],
        ).paddingSymmetric(horizontal: padding ?? 16),
      ),
    );
  }

  static Widget buildBottomSheet(String telephone) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () async {
            if (Get.isDialogOpen == false) {
              Get.back();
            }
            await launchUrlString(telephone);
          },
          child: Container(
            width: Get.width - 20,
            height: 44,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.white),
            child: Center(
              child: Text(
                "Liên hệ",
                style: FontStyleUI.fontPlusJakartaSans()
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: Get.width - 20,
          height: 44,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.white),
          child: Center(
            child: Text(
              "Nhắn tin",
              style: FontStyleUI.fontPlusJakartaSans()
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            width: Get.width - 20,
            height: 44,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.white),
            child: Center(
              child: Text(
                "Huỷ",
                style: FontStyleUI.fontPlusJakartaSans()
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        )
      ],
    );
  }

  //dateTimePicker dung chung
  // static Future<DateTime?> dayPickerUtils(
  //     BuildContext context, String initialDate,
  //     {DateTime? firstDate, DateTime? lastDate, String? pattern}) async {
  //   DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: initialDate == ""
  //         ? DateTime.now()
  //         : convertStringToDate(initialDate, pattern ?? pattern13),
  //     firstDate: firstDate ?? DateTime(1980),
  //     lastDate: lastDate ?? DateTime.now().add(const Duration(days: 30)),
  //     locale: const Locale("vi"),
  //     helpText: AppStr.selectDay,
  //     // Can be used as title
  //     cancelText: AppStr.close,
  //     confirmText: AppStr.ok,
  //     builder: (context, child) {
  //       return Theme(
  //         data: Theme.of(context).copyWith(
  //           colorScheme: const ColorScheme.light(
  //             primary: Colors.deepOrangeAccent,
  //             onPrimary: Colors.black, // header text color
  //             onSurface: Colors.black,
  //           ),
  //           textButtonTheme: TextButtonThemeData(
  //             style: TextButton.styleFrom(
  //               foregroundColor: Colors.deepOrangeAccent, // button text color
  //             ),
  //           ),
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );
  //   return picked;
  // }

/*  static Future<TimeOfDay?> timePickerUtils(
      BuildContext context, String initialDate,
      {DateTime? firstDate, DateTime? lastDate, String? pattern}) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialDate == ""
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay(
              hour: int.parse(initialDate.split(":")[0]),
              minute: int.parse(initialDate.split(":")[1])),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    return picked;
  }*/
  // static Future<DateTime?> timePickerUtils(
  //     BuildContext context, String initialDate) async {
  //   DateTime? time;
  //   await Picker(
  //       adapter: DateTimePickerAdapter(
  //         customColumnType: [3, 4],
  //         value: initialDate == ""
  //             ? DateTime.now()
  //             : convertStringToDate(initialDate, pattern13),
  //       ),
  //       cancelTextStyle: const TextStyle(
  //         color: DefaultTheme.grey,
  //         fontWeight: FontWeight.w500,
  //         fontSize: 18,
  //       ),
  //       confirmTextStyle: const TextStyle(
  //         color: Colors.deepOrangeAccent,
  //         fontWeight: FontWeight.w500,
  //         fontSize: 18,
  //       ),
  //       cancelText: AppStr.close,
  //       confirmText: AppStr.confirm,
  //       onSelect: (Picker picker, int index, List<int> selected) {
  //         //range[0] = (picker.adapter as DateTimePickerAdapter).value;
  //       },
  //       onConfirm: (picker, selected) {
  //         time = DateTime.parse(picker.adapter.toString());
  //       }).showModal(context);
  //   return time;
  // }
  //
  // static Future<List<String>> showPickerDialog(
  //     BuildContext context,
  //     String data,
  //     int indexYear,
  //     int indexMonth,
  //     ) async {
  //   List<String>? parts;
  //   await Picker(
  //       adapter: PickerDataAdapter<String>(
  //           pickerData: const JsonDecoder().convert(data), isArray: true),
  //       selecteds: [indexYear, indexMonth],
  //       cancelTextStyle: const TextStyle(
  //         color: DefaultTheme.grey,
  //         fontWeight: FontWeight.w500,
  //         fontSize: 18,
  //       ),
  //       confirmTextStyle: const TextStyle(
  //         color: Colors.deepOrangeAccent,
  //         fontWeight: FontWeight.w500,
  //         fontSize: 18,
  //       ),
  //       cancelText: AppStr.cancelFilter,
  //       confirmText: AppStr.confirm,
  //       onSelect: (Picker picker, int index, List<int> selected) {},
  //       onConfirm: (picker, selected) {
  //         String cleanedYear = picker.selecteds
  //             .toString()
  //             .replaceAll('[', '')
  //             .replaceAll(']', '')
  //             .replaceAll(' ', '');
  //         parts = cleanedYear.split(',');
  //         // String indexYear = parts[0];
  //         // String indexMonth = parts[1];
  //
  //         // List<int> listYear = mapYear.values.toList();
  //         // listYear.sort((a, b) => a.compareTo(b));
  //
  //         // time = "${int.parse(indexMonth) <= 9 ? "0$indexMonth" : indexMonth}/${listYear[int.parse(indexYear)]}";
  //         // mapYear.keys(indexYear);
  //       }).showModal(context);
  //
  //   return parts ?? [];
  // }

  static Widget divider({double height = 1, Color color = Colors.white70}) =>
      Divider(
        height: height,
        color: color,
      );

  static const Widget sizedBox5 = SizedBox(
    height: 5,
  );
  static const Widget sizedBox3 = SizedBox(height: 3);
  static const Widget sizedBox10 = SizedBox(height: 10);
  static const Widget sizedBoxWidth10 = SizedBox(width: 10);
  static const Widget sizedBoxWidth5 = SizedBox(width: 5);
  static const Widget dividerDefault = Divider(
    height: 3,
  );
  // static const Widget sizedBoxPaddingHuge =
  // SizedBox(height: AppDimens.paddingHuge);
  // static const Widget sizedBoxPadding =
  // SizedBox(height: AppDimens.defaultPadding);

  // static Widget buildSafeArea(Widget childWidget,
  //     {double miniumBottom = 12, Color? color}) {
  //   return Container(
  //     color: color ?? AppColors.appBarColor(),
  //     child: SafeArea(
  //       bottom: true,
  //       maintainBottomViewPadding: true,
  //       minimum: EdgeInsets.only(bottom: miniumBottom),
  //       child: childWidget,
  //     ),
  //   );
  // }

  static Widget buildLogo(String imgLogo, double height) {
    return SizedBox(
      height: height,
      child: Image.asset(imgLogo),
    );
  }

  /// Sử dụng để tránh trường hợp click liên tiếp khi thực hiện function
  // static Widget baseOnAction({
  //   required Function onTap,
  //   required Widget child,
  // }) {
  //   return GestureDetector(
  //     behavior: HitTestBehavior.opaque,
  //     onTap: () {
  //       DateTime now = DateTime.now();
  //       if (_dateTime == null ||
  //           now.difference(_dateTime ?? DateTime.now()) > 2.seconds ||
  //           onTap.hashCode != _oldFunc) {
  //         _dateTime = now;
  //         _oldFunc = onTap.hashCode;
  //         onTap();
  //       }
  //     },
  //     child: child,
  //   );
  // }


  static Widget buildButton(
      String btnTitle,
      Function function, {
        List<Color> colors = AppColors.colorGradientBlue,
        Color? backgroundColor,
        bool isLoading = false,
        bool showLoading = true,
        IconData? icon,
        Color? iconColor,
        double? iconSize,
        double? width,
        double? height,
        Color? colorText,
        BorderRadiusGeometry? borderRadius,
      }) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 50,
      decoration: BoxDecoration(
          color: backgroundColor,
          gradient:
          backgroundColor != null ? null : LinearGradient(colors: colors),
          borderRadius: borderRadius ?? BorderRadius.circular(8)),
      child: baseOnAction(
        onTap: !isLoading ? function : () {},
        child: ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8.0)),
          ),
          child: Stack(
            children: [
              if (icon != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    icon,
                    size: iconSize,
                    color: iconColor,
                  ),
                ),
              Center(
                child: Text(btnTitle.tr,
                    style: TextStyle(
                        fontSize: 16,
                        color: colorText ?? Colors.white)),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Visibility(
                  visible: isLoading && showLoading,
                  child: const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.colorError,
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


  /// Sử dụng để tránh trường hợp click liên tiếp khi thực hiện function
  static Widget baseOnAction({
    required Function onTap,
    required Widget child,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        DateTime now = DateTime.now();
        if (_dateTime == null ||
            now.difference(_dateTime ?? DateTime.now()) > 2.seconds ||
            onTap.hashCode != _oldFunc) {
          _dateTime = now;
          _oldFunc = onTap.hashCode;
          onTap();
        }
      },
      child: child,
    );
  }
  static const Widget buildLoading = CupertinoActivityIndicator(color: Colors.black,);

  static Widget buildSmartRefresher({
    required RefreshController refreshController,
    required Widget child,
    ScrollController? scrollController,
    Function()? onRefresh,
    Function()? onLoadMore,
    bool enablePullUp = false,
  }) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: enablePullUp,
      scrollController: scrollController,
      header: const MaterialClassicHeader(),
      controller: refreshController,
      onRefresh: onRefresh,
      onLoading: onLoadMore,
      footer: buildSmartRefresherCustomFooter(),
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
            opacity: 1.0,
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }

  // static PreferredSizeWidget buildAppBar(String title,
  //     {Color? textColor,
  //       Color? actionsIconColor,
  //       Color? backbuttonColor,
  //       Color? backgroundColor,
  //       bool centerTitle = false,
  //       Function()? funcLeading,
  //       bool leading = true,
  //       List<Widget>? actions,
  //       bool isColorGradient = false,
  //       List<Color>? colorTranparent,
  //       TabBar? widget}) {
  //   return AppBar(
  //     bottom: widget,
  //     actionsIconTheme:
  //     IconThemeData(color: actionsIconColor ?? AppColors.textColorWhite),
  //     systemOverlayStyle: const SystemUiOverlayStyle(
  //       statusBarColor: Colors.transparent,
  //       statusBarIconBrightness: Brightness.light,
  //     ),
  //     title: UtilWidget.buildAppBarTitle(
  //       title,
  //       textColor: textColor ?? AppColors.textColorWhite,
  //     ),
  //     automaticallyImplyLeading: false,
  //     centerTitle: centerTitle,
  //     leading: !leading
  //         ? null
  //         : BackButton(
  //       color: backbuttonColor ?? AppColors.textColorWhite,
  //       onPressed: funcLeading,
  //     ),
  //     flexibleSpace: isColorGradient
  //         ? Container(
  //       decoration: BoxDecoration(
  //         gradient: LinearGradient(
  //             begin: Alignment.bottomLeft,
  //             end: Alignment.bottomRight,
  //             colors: colorTranparent ??
  //                 <Color>[Colors.orangeAccent, Colors.deepOrange]),
  //       ),
  //     )
  //         : null,
  //     actions: actions,
  //     backgroundColor:
  //     isColorGradient ? null : backgroundColor ?? AppColors.orange,
  //   );
  // }

  // static PreferredSizeWidget buildBaseBackgroudAppBar(
  //     {required Widget title, List<Widget>? actions, Widget? leading}) {
  //   return AppBar(
  //     leading: leading ?? const BackButton(color: AppColors.textColorWhite),
  //     systemOverlayStyle: const SystemUiOverlayStyle(
  //       statusBarColor: Colors.transparent,
  //     ),
  //     title: title,
  //     flexibleSpace: Container(
  //       decoration: const BoxDecoration(
  //         image: DecorationImage(
  //           image: AssetImage(ImageAsset.imgLoginBg),
  //           fit: BoxFit.fitWidth,
  //         ),
  //       ),
  //     ),
  //     centerTitle: true,
  //     actions: actions,
  //   );
  // }
  //
  // static Widget buildBottonWithBorder(
  //     String title,
  //     Function() func, {
  //       Color? textColor,
  //       Color? borderColor,
  //     }) {
  //   return OutlinedButton(
  //     onPressed: func,
  //     style: OutlinedButton.styleFrom(
  //       side: BorderSide(
  //         color: borderColor ?? Colors.black,
  //       ),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(8.0),
  //         side: BorderSide(
  //           color: borderColor ?? Colors.black,
  //         ),
  //       ),
  //       padding: const EdgeInsets.symmetric(
  //         vertical: AppDimens.defaultPadding,
  //       ),
  //     ),
  //     child: Text(
  //       title,
  //       style: const TextStyle(
  //         fontWeight: FontWeight.w600,
  //         fontSize: 14,
  //         color: Colors.black,
  //       ),
  //     ),
  //   );
  // }
  //
  // static Widget buildShimmerLoading() {
  //   const padding = AppDimens.defaultPadding;
  //   return Container(
  //     width: double.infinity,
  //     padding:
  //     const EdgeInsets.symmetric(horizontal: padding, vertical: padding),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.max,
  //       children: <Widget>[
  //         Expanded(
  //           child: Shimmer.fromColors(
  //             baseColor: Colors.grey.shade400,
  //             highlightColor: Colors.grey.shade100,
  //             enabled: true,
  //             child: ListView.separated(
  //                 itemBuilder: (context, index) => Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   crossAxisAlignment: CrossAxisAlignment.stretch,
  //                   children: [
  //                     Container(
  //                       width: double.infinity,
  //                       height: 24.0,
  //                       decoration: const BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.all(
  //                           Radius.circular(10),
  //                         ),
  //                       ),
  //                     ),
  //                     sizedBox10,
  //                     Row(
  //                       children: [
  //                         Expanded(
  //                           child: Container(
  //                             height: 16.0,
  //                             decoration: const BoxDecoration(
  //                               color: Colors.white,
  //                               borderRadius: BorderRadius.all(
  //                                 Radius.circular(10),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         const SizedBox(
  //                           width: 30,
  //                         ),
  //                         Expanded(
  //                           child: Container(
  //                             height: 16.0,
  //                             decoration: const BoxDecoration(
  //                               color: Colors.white,
  //                               borderRadius: BorderRadius.all(
  //                                 Radius.circular(10),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     sizedBox10,
  //                   ],
  //                 ),
  //                 separatorBuilder: (context, index) => const Divider(
  //                   height: 15,
  //                 ),
  //                 itemCount: 10),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // static Widget buildButton(
  //     String btnTitle,
  //     Function function, {
  //       List<Color> colors = AppColors.colorGradientBlue,
  //       Color? backgroundColor,
  //       bool isLoading = false,
  //       bool showLoading = true,
  //       IconData? icon,
  //       Color? iconColor,
  //       double? iconSize,
  //       double? width,
  //       double? height,
  //       Color? colorText,
  //       BorderRadiusGeometry? borderRadius,
  //     }) {
  //   return Container(
  //     width: width ?? double.infinity,
  //     height: height ?? AppDimens.btnMedium,
  //     decoration: BoxDecoration(
  //         color: backgroundColor,
  //         gradient:
  //         backgroundColor != null ? null : LinearGradient(colors: colors),
  //         borderRadius: borderRadius ?? BorderRadius.circular(8)),
  //     child: baseOnAction(
  //       onTap: !isLoading ? function : () {},
  //       child: ElevatedButton(
  //         onPressed: null,
  //         style: ElevatedButton.styleFrom(
  //           foregroundColor: Colors.transparent,
  //           backgroundColor: Colors.transparent,
  //           shadowColor: Colors.transparent,
  //           shape: RoundedRectangleBorder(
  //               borderRadius: borderRadius ?? BorderRadius.circular(8.0)),
  //         ),
  //         child: Stack(
  //           children: [
  //             if (icon != null)
  //               Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: Icon(
  //                   icon,
  //                   size: iconSize,
  //                   color: iconColor,
  //                 ),
  //               ),
  //             Center(
  //               child: Text(btnTitle.tr,
  //                   style: TextStyle(
  //                       fontSize: AppDimens.fontMedium(),
  //                       color: colorText ?? Colors.white)),
  //             ),
  //             Align(
  //               alignment: Alignment.centerRight,
  //               child: Visibility(
  //                 visible: isLoading && showLoading,
  //                 child: const SizedBox(
  //                   height: AppDimens.btnSmall,
  //                   width: AppDimens.btnSmall,
  //                   child: CircularProgressIndicator(
  //                     strokeWidth: 2,
  //                     backgroundColor: Colors.white,
  //                     valueColor: AlwaysStoppedAnimation<Color>(
  //                       AppColors.colorError,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // static Widget baseBottomSheet({
  //   required String title,
  //   required Widget body,
  //   Widget? iconTitle,
  //   bool isSecondDisplay = false,
  //   Widget? actionArrowBack,
  //   double? padding,
  //   bool noAppBar = false,
  //   Color? backgroundColor,
  //   TextAlign? textAlign,
  // }) {
  //   return SafeArea(
  //     bottom: false,
  //     minimum: EdgeInsets.only(
  //         top: Get.mediaQuery.padding.top + (isSecondDisplay ? 100 : 20)),
  //     child: Container(
  //       padding: const EdgeInsets.only(bottom: 10),
  //       decoration: BoxDecoration(
  //           color: backgroundColor ?? AppColors.bottomSheet(),
  //           borderRadius: !GetPlatform.isAndroid
  //               ? const BorderRadius.vertical(top: Radius.circular(20))
  //               : null),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.stretch,
  //         children: [
  //           sizedBox5,
  //           noAppBar
  //               ? const SizedBox()
  //               : Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               Align(
  //                 alignment: Alignment.bottomLeft,
  //                 child: actionArrowBack ??
  //                     const BackButton(
  //                       color: AppColors.lightPrimaryColor,
  //                     ),
  //               ),
  //               Expanded(
  //                 child: Text(title.tr,
  //                     textAlign: textAlign ?? TextAlign.center,
  //                     maxLines: 1,
  //                     overflow: TextOverflow.ellipsis,
  //                     style: Get.textTheme.bodyLarge!.copyWith(
  //                       color: AppColors.lightPrimaryColor,
  //                     )).paddingOnly(right: 24),
  //               ),
  //               iconTitle ?? const SizedBox(),
  //             ],
  //           ).paddingSymmetric(vertical: AppDimens.paddingSmall),
  //           Expanded(child: body),
  //         ],
  //       ).paddingSymmetric(horizontal: padding ?? AppDimens.defaultPadding),
  //     ),
  //   );
  // }
  //
  // static Widget buildItemShowBottomSheet({
  //   required IconData icon,
  //   required String title,
  //   required Function function,
  //   required Color backgroundIcons,
  // }) {
  //   return ListTile(
  //     leading: Container(
  //       padding: const EdgeInsets.all(8),
  //       decoration: BoxDecoration(
  //         color: backgroundIcons,
  //         borderRadius: BorderRadius.circular(30),
  //       ),
  //       child: Icon(
  //         icon,
  //         size: 20,
  //         color: Colors.white,
  //       ),
  //     ).marginOnly(left: 5),
  //     contentPadding: const EdgeInsets.all(8),
  //     title: Text(title.tr,
  //         style: Get.textTheme.titleMedium!
  //             .copyWith(color: AppColors.textColor())),
  //     onTap: () {
  //       Get.back();
  //       function();
  //     },
  //   );
  // }
  //
  // static Widget buildButtonIcon({
  //   required IconData icons,
  //   required Function func,
  //   Color? colors,
  //   String title = "",
  //   double sizeIcon = 30,
  //   double radius = 30,
  //   double padding = 8.0,
  //   Color? textColor,
  //   double? sizeBackGround,
  //   Color? iconColor = AppColors.hintTextSolidColor,
  //   String? imgAsset,
  //   Color? backgroundColor = Colors.transparent,
  // }) =>
  //     baseOnAction(
  //       onTap: func,
  //       child: Container(
  //         color: backgroundColor,
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Container(
  //               height: sizeBackGround,
  //               width: sizeBackGround,
  //               padding: EdgeInsets.all(padding),
  //               decoration: BoxDecoration(
  //                 color: colors,
  //                 borderRadius: BorderRadius.circular(radius),
  //               ),
  //               child: imgAsset != null
  //                   ? Image.asset(
  //                 imgAsset,
  //                 fit: BoxFit.cover,
  //                 height: sizeIcon,
  //                 width: sizeIcon,
  //               )
  //                   : Icon(
  //                 icons,
  //                 color: iconColor,
  //                 size: sizeIcon,
  //               ),
  //             ),
  //             if (title.isNotEmpty) ...[
  //               const SizedBox(height: 4),
  //               Text(
  //                 title.tr,
  //                 style: Get.theme.textTheme.titleMedium!.copyWith(
  //                     color: textColor ?? AppColors.textColor(), fontSize: 14),
  //               ).paddingAll(5),
  //             ]
  //           ],
  //         ),
  //       ),
  //     );
  //
  // static Widget buildDropdown(
  //     Map<dynamic, String> mapData, {
  //       required Rx<dynamic> item,
  //       double height = 30,
  //       Color fillColor = AppColors.backgroundColorWhite,
  //       double paddingLeft = AppDimens.paddingSmall,
  //       Function(dynamic)? onChanged,
  //     }) {
  //   return Obx(
  //         () => Container(
  //       decoration: BoxDecoration(
  //         color: fillColor,
  //         borderRadius: const BorderRadius.all(Radius.circular(10.0)),
  //       ),
  //       child: DropdownButtonHideUnderlineCustom(
  //         child: DropdownButtonCustom<dynamic>(
  //           selectedItemBuilder: (BuildContext context) {
  //             return mapData.values.map<Widget>((val) {
  //               return Container(
  //                 alignment: Alignment.centerLeft,
  //                 child: AutoSizeText(
  //                   val,
  //                   style: Get.textTheme.bodyMedium,
  //                   overflow: TextOverflow.ellipsis,
  //                   minFontSize: AppDimens.sizeTextMediumTb,
  //                 ),
  //               );
  //             }).toList();
  //           },
  //           dropdownColor: fillColor,
  //           isExpanded: true,
  //           // isDense: true,
  //           items: mapData
  //               .map((key, value) {
  //             return MapEntry(
  //                 key,
  //                 DropdownMenuItemCustom<dynamic>(
  //                   value: key,
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: AutoSizeText(
  //                       mapData[key] ?? "",
  //                       style: Get.textTheme.bodyMedium,
  //                     ),
  //                   ),
  //                 ));
  //           })
  //               .values
  //               .toList(),
  //           value: item.value,
  //           onChanged: onChanged,
  //         ),
  //       ).paddingOnly(left: paddingLeft),
  //     ).paddingOnly(
  //       bottom: AppDimens.paddingTitleAndTextForm,
  //     ),
  //   );
  // }
  //
  // static Future<DateTime?> buildDateTimePicker({
  //   required DateTime dateTimeInit,
  //   DateTime? minTime,
  //   DateTime? maxTime,
  // }) async {
  //   DateTime? newDateTime = await showRoundedDatePicker(
  //     context: Get.context!,
  //     height: 310,
  //     initialDate: dateTimeInit,
  //     firstDate: minTime,
  //     lastDate: maxTime,
  //     // barrierDismissible: true,
  //     theme: ThemeData(
  //       primaryColor: AppColors.appBarColor(),
  //       dialogBackgroundColor: AppColors.dateTimeColor(),
  //       primarySwatch: Colors.deepOrange,
  //       disabledColor: AppColors.hintTextColor(),
  //       textTheme: TextTheme(
  //         labelLarge: Get.textTheme.bodyLarge!
  //             .copyWith(color: AppColors.hintTextColor()),
  //         bodySmall: Get.textTheme.bodyLarge,
  //       ),
  //     ),
  //     styleDatePicker: MaterialRoundedDatePickerStyle(
  //       paddingMonthHeader: const EdgeInsets.all(15),
  //       textStyleMonthYearHeader: Get.textTheme.bodyLarge,
  //       colorArrowNext: AppColors.hintTextColor(),
  //       colorArrowPrevious: AppColors.hintTextColor(),
  //       textStyleButtonNegative:
  //       Get.textTheme.bodyLarge!.copyWith(color: AppColors.hintTextColor()),
  //       textStyleButtonPositive:
  //       Get.textTheme.bodyLarge!.copyWith(color: AppColors.linkText()),
  //     ),
  //   );
  //   return newDateTime;
  // }
  //
  // static Widget buildSearchEmpty(String titleEmpty) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Image(
  //         width: Get.width,
  //         height: Get.height / 3.5,
  //         image: const AssetImage(
  //           ImageAsset.imgLoginBg,
  //         ),
  //         fit: BoxFit.cover,
  //       ),
  //     ],
  //   );
  // }
  //
  // static Widget buildListEmpty(String titleEmpty, {Widget? child}) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Image(
  //         width: Get.width,
  //         height: Get.height / 3.5,
  //         image: const AssetImage(
  //           ImageAsset.imgLoginBg,
  //         ),
  //         fit: BoxFit.cover,
  //       ),
  //       sizedBox10,
  //       Text(
  //         titleEmpty,
  //         style: Get.textTheme.bodyLarge,
  //       ),
  //       if (child != null) ...[
  //         sizedBox10,
  //         child,
  //       ]
  //     ],
  //   );
  // }
  //
  // static Widget buildCardBase(
  //     Widget child, {
  //       Color? colorBorder,
  //       Color? backgroundColor,
  //       double? height,
  //       BorderRadiusGeometry? borderRadius,
  //       bool getShadow = true,
  //     }) =>
  //     Container(
  //       height: height,
  //       width: Get.width,
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //         color: backgroundColor ?? AppColors.cardBackgroundColor(),
  //         borderRadius:
  //         borderRadius ?? const BorderRadius.all(Radius.circular(5)),
  //         border: Border.all(
  //           color: colorBorder ?? Colors.white,
  //         ),
  //         boxShadow: getShadow
  //             ? [
  //           BoxShadow(
  //             color: Colors.grey.withOpacity(0.9),
  //             blurRadius: 3,
  //           ),
  //         ]
  //             : [],
  //       ),
  //       child: child,
  //     );
  //
  // static Widget buildDivider({
  //   double height = 10.0,
  //   double thickness = 1.0,
  //   double indent = 0.0,
  // }) {
  //   return Divider(
  //     height: height,
  //     thickness: thickness,
  //     indent: indent,
  //     endIndent: 1,
  //   );
  // }
  //
  // static Widget buildDividerDefault() {
  //   return const Divider(
  //     height: 10,
  //     thickness: 1,
  //     indent: AppDimens.paddingSmall,
  //     endIndent: AppDimens.paddingSmall,
  //   );
  // }
  //
  // static List<TextSpan> textImportantStrings({
  //   required String source,
  //   required String textImportants,
  // }) {
  //   int start = source.indexOf(textImportants);
  //   int end = start + textImportants.length;
  //
  //   return [
  //     TextSpan(text: source.substring(0, start)),
  //     TextSpan(
  //       text: source.substring(start, end),
  //       style: Get.textTheme.bodyLarge!.copyWith(color: AppColors.chipColor),
  //     ),
  //     TextSpan(text: source.substring(end)),
  //   ];
  // }
  //
  // static buildAppBarTitle(String title,
  //     {bool? textAlignCenter, Color? textColor}) {
  //   textAlignCenter = textAlignCenter ?? GetPlatform.isAndroid;
  //   return Text(
  //     title.tr,
  //     textAlign: textAlignCenter ? TextAlign.center : TextAlign.left,
  //     overflow: TextOverflow.ellipsis,
  //     style: TextStyle(
  //       color: textColor ?? AppColors.textColor(),
  //     ),
  //     maxLines: 1,
  //   );
  // }
  //
  // static buildRadioButton({
  //   required String title,
  //   required bool isCheck,
  //   required var onTap,
  // }) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Row(
  //       children: [
  //         Icon(
  //           !isCheck ? Icons.radio_button_off : Icons.radio_button_checked,
  //           color: isCheck ? AppColors.orange : Colors.grey,
  //         ),
  //         Text(title).paddingOnly(
  //           left: AppDimens.paddingSmall,
  //         )
  //       ],
  //     ).paddingOnly(
  //       left: AppDimens.paddingSmall,
  //     ),
  //   );
  // }
  //
  // static Widget buildListAndBtn({required Widget child, Widget? buildBtn}) {
  //   return Column(
  //     children: [
  //       Expanded(
  //         child: child,
  //       ),
  //       Visibility(visible: buildBtn != null, child: buildBtn ?? Container())
  //     ],
  //   );
  // }
  //
  // static Widget buildTextFormField({
  //   String? title,
  //   required TextEditingController textEditingController,
  //   String hintText = '',
  //   int? maxLength = 80,
  //   bool isValidate = false,
  //   TextAlign textAlign = TextAlign.start,
  //   TextInputAction textInputAction = TextInputAction.next,
  //   bool isProductCode = false,
  //   bool isNumeric = false,
  //   TextInputType? keyboardType,
  //   FocusNode? focusNode,
  //   bool? enable,
  //   bool typeEmail = false,
  //   var icon,
  //   var suffixIcon,
  //   var prefixIcon,
  //   var onChange,
  //   var onTap,
  //   bool? obscureText,
  // }) {
  //   return TextFormField(
  //     keyboardAppearance: Brightness.light,
  //     validator: (val) {
  //       if (isValidate) {
  //         if (val!.isNullOrEmpty) {
  //           return AppStr.productDetailNotEmpty.tr;
  //         }
  //         return null;
  //       }
  //       if (typeEmail && !val!.isNullOrEmpty && !isEmail(val)) {
  //         return AppStr.errorEmail.tr;
  //       }
  //       return null;
  //     },
  //     inputFormatters: isProductCode
  //         ? [
  //       FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9-_\.]')),
  //       LengthLimitingTextFieldFormatterFixed(maxLength),
  //     ]
  //         : isNumeric
  //         ? [
  //       FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
  //     ]
  //         : [LengthLimitingTextFieldFormatterFixed(maxLength)],
  //     autovalidateMode: AutovalidateMode.onUserInteraction,
  //     keyboardType: keyboardType ?? TextInputType.multiline,
  //     style: Get.textTheme.bodyLarge,
  //     controller: textEditingController,
  //     maxLength: maxLength,
  //     enabled: enable ?? true,
  //     textAlign: textAlign,
  //     textInputAction: textInputAction,
  //     focusNode: focusNode,
  //     onChanged: onChange,
  //     obscureText: obscureText ?? false,
  //     onTap: onTap,
  //     decoration: InputDecoration(
  //         labelText: title,
  //         labelStyle: Get.textTheme.bodyMedium!.copyWith(
  //           color: AppColors.hintTextColor(),
  //         ),
  //         errorStyle: TextStyle(color: AppColors.errorText()),
  //         border: InputBorder.none,
  //         suffixIcon: suffixIcon,
  //         prefixIcon: prefixIcon),
  //   ).paddingSymmetric(horizontal: 10, vertical: 5);
  // }
  //
  // static Widget buildTextInput({
  //   var height,
  //   Color? textColor,
  //   String? hintText,
  //   Color? hintColor,
  //   Color? fillColor,
  //   TextEditingController? controller,
  //   Function(String)? onChanged,
  //   Function()? onTap,
  //   Widget? prefixIcon,
  //   Widget? suffixIcon,
  //   FocusNode? focusNode,
  //   Color? borderColor,
  //   bool? autofocus,
  //   BorderRadius? borderRadius,
  // }) {
  //   return SizedBox(
  //     height: height,
  //     child: TextField(
  //       textAlignVertical: TextAlignVertical.center,
  //       focusNode: focusNode,
  //       autofocus: autofocus ?? true,
  //       style: TextStyle(
  //         color: textColor ?? Colors.black,
  //       ),
  //       decoration: InputDecoration(
  //           hoverColor: Colors.white,
  //           prefixIcon: prefixIcon,
  //           fillColor: fillColor,
  //           filled: true,
  //           suffixIcon: suffixIcon,
  //           hintText: hintText ?? "",
  //           hintStyle: TextStyle(
  //             color: hintColor ?? Colors.black,
  //           ),
  //           enabledBorder: OutlineInputBorder(
  //             borderSide: BorderSide(color: borderColor ?? Colors.grey),
  //             borderRadius: borderRadius ??
  //                 const BorderRadius.all(
  //                   Radius.circular(5),
  //                 ),
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             borderSide: BorderSide(color: borderColor ?? Colors.grey),
  //             borderRadius: borderRadius ??
  //                 const BorderRadius.all(
  //                   Radius.circular(5),
  //                 ),
  //           ),
  //           contentPadding: const EdgeInsets.all(10)),
  //       onChanged: onChanged,
  //       onTap: onTap,
  //       controller: controller,
  //     ),
  //   );
  // }
  //
  // static Widget buildSearch({
  //   required TextEditingController textEditingController,
  //   required String hintSearch,
  //   required Function function,
  //   required RxBool isClear,
  //   required FocusNode focusNode,
  //   Color? allColor,
  //   bool? autofocus,
  // }) {
  //   return UtilWidget.buildTextInput(
  //     height: 40.0,
  //     controller: textEditingController,
  //     hintText: hintSearch,
  //     textColor: AppColors.textColor(),
  //     hintColor: allColor ?? AppColors.hintTextColor(),
  //     borderColor: allColor ?? AppColors.textColorWhite,
  //     focusNode: focusNode,
  //     autofocus: autofocus,
  //     fillColor: AppColors.textColorWhite,
  //     borderRadius: const BorderRadius.all(Radius.circular(25)),
  //     onChanged: (v) {
  //       function();
  //       if (textEditingController.text.isNotEmpty) {
  //         isClear.value = true;
  //       } else {
  //         isClear.value = false;
  //       }
  //     },
  //     prefixIcon: const Icon(
  //       Icons.search,
  //       color: AppColors.lightPrimaryColor,
  //       size: 20,
  //     ),
  //     suffixIcon: Obx(() => Visibility(
  //       visible: isClear.value,
  //       child: IconButton(
  //         onPressed: () {
  //           textEditingController.clear();
  //           isClear.value = false;
  //           function();
  //         },
  //         icon: Icon(
  //           Icons.clear,
  //           color: AppColors.hintTextColor(),
  //         ),
  //       ).paddingOnly(bottom: AppDimens.paddingSmall),
  //     )),
  //   ).paddingSymmetric(vertical: AppDimens.paddingSmall);
  // }
  //
  // static Widget buildInput(
  //     String label,
  //     TextEditingController textEditingController,
  //     FocusNode focusNode, {
  //       FocusNode? nextNode,
  //       bool? enable,
  //       TextInputType? textInputType,
  //       var icon,
  //       var onChanged,
  //       Function()? onTap,
  //       var onNext,
  //       Function(String)? submitfunc,
  //       bool isValidate = false,
  //       int? inputFormatters,
  //       TextInputAction? iconNextTextInputAction,
  //       Color? fillColor,
  //       String? hintText,
  //       int? maxLengthInputForm,
  //       bool? showCounter,
  //       bool typeEmail = false,
  //       bool showDivider = true,
  //     }) {
  //   return Column(
  //     children: [
  //       BuildInputTextWithLabel(
  //         label: label,
  //         labelRequired: isValidate ? " *" : "",
  //         padding: AppDimens.paddingSmall,
  //         paddingText: const EdgeInsets.only(top: AppDimens.paddingSmall),
  //         buildInputText: BuildInputText(
  //           InputTextModel(
  //               enable: enable ?? true,
  //               textColor: Colors.black,
  //               errorTextColor: AppColors.colorRed444,
  //               fillColor: fillColor ?? Colors.white,
  //               controller: textEditingController,
  //               currentNode: focusNode,
  //               contentPadding: EdgeInsets.zero,
  //               nextNode: nextNode,
  //               inputFormatters: inputFormatters ?? 0,
  //               suffixIcon: icon,
  //               onChanged: onChanged,
  //               maxLengthInputForm: maxLengthInputForm,
  //               onTap: onTap,
  //               hintText: hintText,
  //               onNext: onNext,
  //               isShowCounterText: showCounter ?? false,
  //               submitFunc: submitfunc,
  //               iconNextTextInputAction:
  //               iconNextTextInputAction ?? TextInputAction.next,
  //               textInputType: textInputType ?? TextInputType.multiline,
  //               hintTextColor: Colors.grey,
  //               hintTextSize: 13,
  //               validator: (val) {
  //                 if (isValidate) {
  //                   if (val!.isNullOrEmpty) {
  //                     return AppStr.productDetailNotEmpty.tr;
  //                   }
  //
  //                   return null;
  //                 }
  //                 if (typeEmail && !val.isNullOrEmpty && !isEmail(val)) {
  //                   return AppStr.errorEmail.tr;
  //                 }
  //                 return null;
  //               }),
  //         ),
  //       ),
  //       showDivider ? buildDividerDefault() : const SizedBox(),
  //     ],
  //   );
  // }
  //
  // static Widget buildContainerBase(
  //     String title,
  //     String description,
  //     IconData? icon, {
  //       Color? color,
  //       Color? textColor,
  //       var onTap,
  //     }) =>
  //     GestureDetector(
  //       onTap: () {
  //         onTap();
  //       },
  //       child: Container(
  //         padding: const EdgeInsets.only(top: 5),
  //         width: Get.width / 2.5,
  //         height: Get.width / 3.2,
  //         decoration: BoxDecoration(
  //           color: color,
  //           borderRadius: const BorderRadius.all(
  //             Radius.circular(20),
  //           ),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.grey.withOpacity(0.5),
  //               spreadRadius: 3,
  //               blurRadius: 5,
  //               offset: const Offset(0, 3), // changes position of shadow
  //             ),
  //           ],
  //         ),
  //         child: Column(
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Icon(
  //                   icon,
  //                   size: 45,
  //                   color: textColor,
  //                 ).paddingOnly(left: AppDimens.paddingVerySmall),
  //                 Text(
  //                   title,
  //                   style: TextStyle(
  //                       color: textColor,
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 18),
  //                   textAlign: TextAlign.start,
  //                 ).paddingOnly(left: AppDimens.paddingSmall),
  //               ],
  //             ),
  //             Text(
  //               description,
  //               style: TextStyle(
  //                 color: textColor,
  //                 fontSize: 15,
  //               ),
  //             ).paddingSymmetric(horizontal: 8),
  //           ],
  //         ),
  //       ),
  //     );
  //
  // static Widget buildProfileItem(
  //     {required String title,
  //       required Widget leading,
  //       Widget trailingWidget =
  //       const Icon(Icons.arrow_forward_ios_outlined, size: 15),
  //       Function()? onClick,
  //       RxInt? count}) {
  //   Widget listTitle = ListTile(
  //     title: Text(title, style: TextStyle(color: AppColors.textColor())),
  //     leading: leading,
  //     horizontalTitleGap: 0,
  //     trailing: trailingWidget,
  //     onTap: onClick,
  //   );
  //   return count != null ? Obx(() => listTitle) : listTitle;
  // }
  //
  // static Widget incrementAndDecrement({
  //   var onLongPressStart,
  //   var onLongPressEnd,
  //   var onTap,
  //   IconData? icon,
  //   Color? color,
  // }) {
  //   return GestureDetector(
  //     onLongPressStart: (_) {
  //       onLongPressStart();
  //     },
  //     onLongPressEnd: (_) {
  //       onLongPressEnd();
  //     },
  //     onTap: () {
  //       onTap();
  //     },
  //     child: Container(
  //       height: 30,
  //       width: 30,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(5),
  //         color: color ?? AppColors.spinboxColor(),
  //       ),
  //       child: Icon(
  //         icon,
  //         color: AppColors.textReColor(),
  //       ),
  //     ),
  //   );
  // }
  //
  // static Widget buildRecomment(
  //     TextEditingController textController,
  //     Function(String) function,
  //     ) {
  //   RxList<String> listResultRecomment = RxList<String>();
  //   RxList<String> listRecomment = RxList<String>();
  //   void addRecoment(int price) {
  //     for (int i = 0; i < 3; i++) {
  //       price = price * 10;
  //       if (price <= 50000000) {
  //         listResultRecomment.add(price.toString());
  //       } else if (listResultRecomment.isEmpty) {
  //         listResultRecomment.value = ["5000", "50000", "500000"];
  //       }
  //     }
  //     listRecomment.value = listResultRecomment.toList();
  //   }
  //
  //   Future<void> recomment(int price) async {
  //     addRecoment(price);
  //     if (price == 0) {
  //       listResultRecomment.clear();
  //       recomment(50);
  //     }
  //   }
  //
  //   //default when user ontap after textinput valuable
  //   if (textController.text.isNotEmpty) {
  //     int oldPrice = int.parse(textController.text.toString().replaceAllMapped(
  //         (RegExp(r'[,.]', caseSensitive: true)), (Match m) => ""));
  //     if (oldPrice != 0) {
  //       addRecoment(oldPrice);
  //     } else {
  //       recomment(50);
  //     }
  //   } else {
  //     recomment(50);
  //   }
  //
  //   textController.addListener(
  //         () {
  //       if (textController.text.isNotEmpty) {
  //         listResultRecomment.clear();
  //         int price = int.parse(textController.text.toString().replaceAllMapped(
  //             (RegExp(r'[,.]', caseSensitive: true)), (Match m) => ""));
  //         recomment(price);
  //       } else {
  //         listResultRecomment.clear();
  //         recomment(50);
  //       }
  //     },
  //   );
  //   return Obx(
  //         () => SizedBox(
  //       width: double.infinity,
  //       height: 55,
  //       child: Row(
  //         mainAxisAlignment: listRecomment.length < 3
  //             ? MainAxisAlignment.start
  //             : MainAxisAlignment.spaceAround,
  //         children: [
  //           for (int index = 0; index < listRecomment.length; index++)
  //             buildBtnRecomment(
  //               onPressed: () {
  //                 function(
  //                   CurrencyUtils.formatCurrencyForeign(
  //                     listRecomment[index].toString(),
  //                   ),
  //                 );
  //               },
  //               child: Text(
  //                 CurrencyUtils.formatCurrencyForeign(
  //                   listRecomment[index].toString(),
  //                 ),
  //               ),
  //               color: listRecomment[index].toString() == "0"
  //                   ? Colors.white
  //                   : Colors.blue.shade50,
  //             ).paddingOnly(
  //                 left: listRecomment.length < 3
  //                     ? AppDimens.paddingVerySmall
  //                     : 0),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // static Widget buildBtnRecomment({
  //   var onPressed,
  //   var child,
  //   double? width,
  //   Color? color,
  //   Color? colorBorder,
  // }) {
  //   return GestureDetector(
  //     onTap: onPressed,
  //     child: Container(
  //       width: Get.width / 3 - AppDimens.paddingVerySmall * 2.5,
  //       height: 35,
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //           color: color ?? Colors.blue.shade50,
  //           border: Border.all(
  //             color: colorBorder ?? Colors.white,
  //           ),
  //           borderRadius: const BorderRadius.all(Radius.circular(20))),
  //       child: child,
  //     ),
  //   );
  // }
  //
  // static buildInputDefault(
  //     TextEditingController textEditingController,
  //     String value,
  //     ) {
  //   return {
  //     textEditingController
  //       ..text = CurrencyUtils.formatCurrencyForeign(
  //         value,
  //       )
  //       ..selection = TextSelection.fromPosition(
  //         TextPosition(
  //             offset: CurrencyUtils.formatCurrencyForeign(value).length),
  //       )
  //   };
  // }
  //
  // static Widget baseBackButton({
  //   required String content,
  //   required Widget child,
  //   String? title,
  //   String? exitTitle,
  //   Function? notCheck,
  // }) {
  //   return WillPopScope(
  //     onWillPop: () {
  //       if (notCheck?.call() ?? false) {
  //         return Future.value(true);
  //       }
  //       ShowPopup.showDialogConfirm(
  //         content,
  //         confirm: () => Get.back(),
  //         actionTitle: AppStr.confirm.tr,
  //         title: title ?? AppStr.notification,
  //         exitTitle: exitTitle ?? AppStr.cancel.tr,
  //       );
  //
  //       return Future.value(true);
  //     },
  //     child: child,
  //   );
  // }
  //
  // static Widget buildCheckBox(RxBool checkBoxValue, String textBox,
  //     {Color? activeColor, TextStyle? styleTextBox}) {
  //   return Row(
  //     children: [
  //       Obx(
  //             () => Checkbox(
  //             activeColor: activeColor ?? AppColors.mainColors,
  //             value: checkBoxValue.value,
  //             onChanged: (value) {
  //               checkBoxValue.toggle();
  //             }),
  //       ),
  //       Text(
  //         textBox,
  //         style: styleTextBox ?? Get.textTheme.bodyMedium,
  //       )
  //     ],
  //   );
  // }
  //
  // static Widget buildPageBackground(Widget child) {
  //   return Container(
  //     height: Get.height,
  //     width: Get.width,
  //     decoration: const BoxDecoration(
  //       image: DecorationImage(
  //           image: AssetImage(ImageAsset.imgLoginBg), fit: BoxFit.cover),
  //     ),
  //   );
  // }
  //
  // static Widget buildPopupPage(RxBool rxCheck, Widget widget) {
  //   return Obx(
  //         () => SizedBox(
  //         height: rxCheck.value ? Get.height / 2 : null, child: widget),
  //   );
  // }
  //
  // static Widget buildEmptyData() {
  //   return Column(
  //     children: [
  //       Container(
  //         height: 50,
  //         width: 50,
  //         decoration: const BoxDecoration(
  //             image: DecorationImage(
  //               image: AssetImage(ImageAsset.imageEmpty),
  //             )),
  //       ),
  //       Text(
  //         AppStr.emptyData,
  //         style: Get.textTheme.bodyLarge,
  //       ),
  //     ],
  //   );
  // }
  //
  // static Future<DateTime?> buildMonthYearPicker(BuildContext context,
  //     {DateTime? currentTime, DateTime? minTime, DateTime? maxTime}) async {
  //   // them lại thư viện
  //   DateTime? newDateTime;
  //   // = await DatePicker.showPicker(
  //   //   Get.context!,
  //   //   pickerModel: CustomMonthPicker(
  //   //     minTime: DateTime(1970, 1, 1),
  //   //     maxTime: DateTime.now(),
  //   //     currentTime: currentTime,
  //   //     locale: LocaleType.vi,
  //   //   ),
  //   // );
  //   await Picker(
  //       hideHeader: false,
  //       adapter: DateTimePickerAdapter(
  //         value: currentTime,
  //         yearBegin: minTime?.year ?? 1970,
  //         yearEnd: maxTime?.year ?? DateTime.now().year,
  //         months: const [
  //           "Tháng 1",
  //           "Tháng 2",
  //           "Tháng 3",
  //           "Tháng 4",
  //           "Tháng 5",
  //           "Tháng 6",
  //           "Tháng 7",
  //           "Tháng 8",
  //           "Tháng 9",
  //           "Tháng 10",
  //           "Tháng 11",
  //           "Tháng 12",
  //         ],
  //         customColumnType: [0, 1],
  //       ),
  //       confirmText: AppStr.done,
  //       cancelText: AppStr.cancel,
  //       selectedTextStyle: const TextStyle(color: Colors.black),
  //       onConfirm: (Picker picker, List value) {
  //         newDateTime = DateTime.parse(picker.adapter.toString());
  //       }).showModal(context);
  //   return newDateTime;
  // }
  //
  // static Widget baseBottomSheetFilter(
  //     {required String title,
  //       required Widget body,
  //       Widget? iconTitle,
  //       bool isSecondDisplay = false}) {
  //   return SafeArea(
  //     bottom: false,
  //     minimum: EdgeInsets.only(
  //         top: Get.mediaQuery.padding.top + (isSecondDisplay ? 100 : 20)),
  //     child: Container(
  //       padding: const EdgeInsets.only(bottom: 10),
  //       decoration: BoxDecoration(
  //           color: AppColors.bottomSheet(),
  //           borderRadius:
  //           const BorderRadius.vertical(top: Radius.circular(20))),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.stretch,
  //         children: [
  //           Center(
  //             child: Container(
  //               width: 80,
  //               height: 6,
  //               margin: const EdgeInsets.all(AppDimens.paddingSmall),
  //               decoration: BoxDecoration(
  //                   color: AppColors.iconHomeColor(),
  //                   borderRadius: const BorderRadius.all(Radius.circular(8))),
  //             ),
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Expanded(
  //                 child: Text(title.tr,
  //                     textAlign: iconTitle == null
  //                         ? TextAlign.center
  //                         : TextAlign.left,
  //                     maxLines: 1,
  //                     overflow: TextOverflow.ellipsis,
  //                     style: Get.textTheme.titleLarge
  //                         ?.copyWith(color: AppColors.textColor()))
  //                     .paddingSymmetric(vertical: AppDimens.paddingSmall),
  //               ),
  //               iconTitle ?? const SizedBox(),
  //             ],
  //           ),
  //           Expanded(child: body),
  //         ],
  //       ).paddingSymmetric(horizontal: AppDimens.defaultPadding),
  //     ),
  //   );
  // }
}
