import 'package:flutter/cupertino.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:systemrepair/cores/const/app_colors.dart';

import '../../shared/utils/font_ui.dart';

class BaseShowNotification {
  static void showNotification(
      BuildContext context, String title, dynamic type) {
    QuickAlert.show(
      context: context,
      type: type,
      text: title,
      confirmBtnColor: AppColors.textTitleColor,
      confirmBtnText: "Tôi hiểu",
      textColor: AppColors.textColorXam,
    );
  }
}
