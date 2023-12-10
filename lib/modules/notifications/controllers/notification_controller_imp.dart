import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:systemrepair/modules/login/models/fixer_account_model.dart';
import 'package:systemrepair/modules/notifications/controllers/notification_controller.dart';
import '../../../base_utils/base_controllers/app_controller.dart';
import '../../../cores/const/const.dart';
import '../models/notification_get_model.dart';

class NotificationControllerImp extends NotificationController {
  @override
  Future<void> onInit() async {
    // TODO: implement onInit

    showLoading();
    await getDataNotification();
    hideLoading();
    super.onInit();
  }

  @override
  Future<void> getDataNotification() async {
    FixerAccountModel fixerAccountModel =
        HIVE_APP.get(AppConst.keyFixerAccount);

    final documentSnapshot = await FirebaseFirestore.instance
        .collection(
            'Notification') // Thay 'your_collection_name' bằng tên collection của bạn
        .where("UID_Receiver",
            isEqualTo:
                fixerAccountModel.uid) // UID của tài khoản bạn muốn truy vấn
        .get();

    if (documentSnapshot.docs.isNotEmpty) {
      listNotificationModel.value = [];
      for (final data in documentSnapshot.docs) {
        listNotificationModel.add(NotificationGetModel.fromJson(data.data()));
      }
      listNotificationModel.value = listNotificationModel.reversed.toList();
      // listNotificationModel.addAll(documentSnapshot.docs.map((item) {
      //   if (item != null) {
      //     return NotificationGetModel.fromJson(item); // Sử dụng hàm chuyển đổi hoặc cách tương ứng
      //   } else {
      //     return null; // Hoặc xử lý tùy theo trường hợp
      //   }
      // }).whereType<NotificationGetModel>().toList());
    }
  }

  @override
  Future<void> onLoadMore() async {
  }

  @override
  Future<void> onRefresh() async {
    showLoading();
    await getDataNotification().then((value) => hideLoading());
  }
}
