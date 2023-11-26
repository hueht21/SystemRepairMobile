import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:systemrepair/modules/login/models/fixer_account_model.dart';

import '../../modules/notifications/models/notification_get_model.dart';
import '../../modules/notifications/models/notification_model.dart';
import '../../modules/notifications/response/notification_response.dart';
import '../../modules/oders/models/registration_schedule_model.dart';
import '../../shared/utils/date_utils.dart';
import '../base_widget/base_show_notification.dart';

class BaseShowNotificationCtr {
  Future<void> sentNotification(
      RegistrationScheduleModel registrationScheduleModel, String cancel) async {

    try{
      String token = "";
      final documentSnapshot = await FirebaseFirestore.instance
          .collection('User') // Thay 'your_collection_name' bằng tên collection của bạn
          .where("UID", isEqualTo: registrationScheduleModel.uidFixer!.uid) // UID của tài khoản bạn muốn truy vấn
          .get();

      if (documentSnapshot.docs.isNotEmpty) {
        var doc =  documentSnapshot.docs.first;
        FixerAccountModel fixerModel = FixerAccountModel.fromJson(doc.data());
        token = fixerModel.token ?? "";

      } else {
        BaseShowNotification.showNotification(
          Get.context!,
          "Dữ liệu không tồn tại cho UID này.",
          QuickAlertType.error,
        );
      }

      NotificationModel notificationModel = NotificationModel(
          to: token,
          notification: NotificationChild(
              title: "Thông báo mới",
              body:
              'Nhiệm vụ mới ngày ${registrationScheduleModel.dateSet} thời gian ${registrationScheduleModel.timeSet} tại đại chỉ ${registrationScheduleModel.address} đã bị huỷ bởi khách hàng với lý do $cancel'));

      var response = await NotificationResponse()
          .sentNotification(notificationModel.toJson());

      CollectionReference notificationSend =
      FirebaseFirestore.instance.collection('Notification');
      NotificationGetModel notificationGetModel = NotificationGetModel(
        createDate: convertDateToString(DateTime.now(), PATTERN_1),
        uidReceiver: registrationScheduleModel.uidFixer!.uid,
        uidSend: registrationScheduleModel.uidClient,
        content:
        'Nhiệm vụ mới ngày ${registrationScheduleModel.dateSet} thời gian ${registrationScheduleModel.timeSet} tại đại chỉ ${registrationScheduleModel.address} đã bị huỷ bởi khách hàng với lý do $cancel',
        id: response.results[0].messageId,
        title: 'Thông báo mới',
      );
      await notificationSend.add(notificationGetModel.toJson());
    }catch (e) {
      BaseShowNotification.showNotification(
        Get.context!,
        'Lỗi khi thêm dữ liệu vào Firestore: $e',
        QuickAlertType.error,
      );
    }
  }

}