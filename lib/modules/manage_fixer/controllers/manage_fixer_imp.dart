import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import 'package:systemrepair/base_utils/base_widget/base_show_notification.dart';
import 'package:systemrepair/modules/login/models/fixer_account_model.dart';
import 'package:systemrepair/modules/manage_fixer/controllers/manage_fixer_controller.dart';

class ManageFixerImp extends ManageFixerController {
  @override
  Future<void> getFixerAcc() async {
    final documentSnapshot = await FirebaseFirestore.instance
        .collection('Fixer')
        .get()
        .whenComplete(() => hideLoading());
    if (documentSnapshot.docs.isNotEmpty) {
      for (final item in documentSnapshot.docs) {
        FixerAccountModel fixerAccountModel = FixerAccountModel.fromJson(item.data());
        listFixerAccountModel.add(fixerAccountModel);
      }
    } else {
      BaseShowNotification.showNotification(
        Get.context!,
        "Dữ liệu tài khoản rỗng",
        QuickAlertType.error,
      );
    }
  }

}