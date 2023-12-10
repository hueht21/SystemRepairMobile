import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:systemrepair/modules/login/models/account_model.dart';
import 'package:systemrepair/modules/login/models/fixer_account_model.dart';

import '../../modules/notifications/models/notification_get_model.dart';
import '../../modules/notifications/models/notification_model.dart';
import '../../modules/notifications/response/notification_response.dart';
import '../../shared/utils/date_utils.dart';
import '../base_widget/base_show_notification.dart';

class BaseShowNotificationCtr {
  Future<String> getTokenFixer(String uid) async {
    String token = "";
    try {
      final documentSnapshot = await FirebaseFirestore.instance
          .collection("Fixer")
          .where("UID", isEqualTo: uid)
          .get();

      if (documentSnapshot.docs.isNotEmpty) {
        var doc = documentSnapshot.docs.first;
        FixerAccountModel fixerModel = FixerAccountModel.fromJson(doc.data());
        token = fixerModel.token ?? "";
      } else {
        BaseShowNotification.showNotification(
          Get.context!,
          "Dữ liệu không tồn tại cho UID này.",
          QuickAlertType.error,
        );
      }
    } catch (e) {
      BaseShowNotification.showNotification(
        Get.context!,
        "Dữ liệu không tồn tại cho UID này.",
        QuickAlertType.error,
      );
    }
    return token;
  }


  Future<String> getTokenClient(String uid) async {
    String token = "";
    try {
      final documentSnapshot = await FirebaseFirestore.instance
          .collection("User")
          .where("UID", isEqualTo: uid)
          .get();

      if (documentSnapshot.docs.isNotEmpty) {
        var doc = documentSnapshot.docs.first;
        AccountModel accountModel = AccountModel.fromJson(doc.data());
        token = accountModel.token ?? "";
      } else {
        BaseShowNotification.showNotification(
          Get.context!,
          "Dữ liệu không tồn tại cho UID này.",
          QuickAlertType.error,
        );
      }
    } catch (e) {
      BaseShowNotification.showNotification(
        Get.context!,
        "Dữ liệu không tồn tại cho UID này.",
        QuickAlertType.error,
      );
    }
    return token;
  }

  Future<void> sentNotification({
    required String uid,
    required String token,
    required String uidReceiver,
    required String content
  }) async {
    try {
      NotificationModel notificationModel = NotificationModel(
          to: token,
          notification: NotificationChild(title: "Thông báo mới", body: content));
      var response = await NotificationResponse()
          .sentNotification(notificationModel.toJson());
      CollectionReference notificationSend =
          FirebaseFirestore.instance.collection('Notification');
      NotificationGetModel notificationGetModel = NotificationGetModel(
        createDate: convertDateToString(DateTime.now(), PATTERN_1),
        uidReceiver: uidReceiver,
        uidSend: uid,
        content: content,
        id: response.results[0].messageId,
        title: 'Thông báo mới',
      );
      await notificationSend.add(notificationGetModel.toJson());

    } catch (e) {
      BaseShowNotification.showNotification(
        Get.context!,
        'Lỗi khi thêm dữ liệu vào Firestore: $e',
        QuickAlertType.error,
      );
    }
  }
}
