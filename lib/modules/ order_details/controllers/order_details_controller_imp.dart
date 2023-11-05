
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:systemrepair/modules/register_account/model/account_model.dart';
import 'package:systemrepair/modules/schedule_repair/models/fixer_model.dart';

import '../../../base_utils/base_controllers/app_controller.dart';
import '../../../base_utils/base_widget/base_show_notification.dart';
import '../../../cores/const/const.dart';
import '../../../shared/utils/date_utils.dart';
import '../../home_page/models/notification_model.dart';
import '../../home_page/response/notification_response.dart';
import '../../notifications/models/notification_get_model.dart';
import '../../schedule_repair/models/registration_schedule_model.dart';
import '../models/cancel_oder_model.dart';
import '../views/filter_cancel_oder_view.dart';
import 'order_details_controller.dart';

class OderDetailControllerImp extends OderDetailController {


  @override
  Future<void> onInit() async {
    // TODO: implement onInit

    registrationScheduleModel = Get.arguments;
    indexHead.value = registrationScheduleModel.status ?? 0;


    try {
      final storage = FirebaseStorage.instance;
      imageUrlFix.value = await storage.ref().child('fixer/${registrationScheduleModel.uidFixer?.imgAcc}').getDownloadURL();
      imageUrlSchedule.value = await storage.ref().child('ImageScheduleFixer/${registrationScheduleModel.imgFix}').getDownloadURL();
    } catch(e) {
      log("$e");
    }

    super.onInit();
  }

  @override
  Future<void> cancelOrder() async {
    // await FirebaseFirestore.instance.collection("RegistrationSchedule").w

    // showLoadingOverlay();
    // registrationScheduleModel.status = 4;/// 4 Là huỷ
    // final CollectionReference collectionReference = FirebaseFirestore.instance.collection('RegistrationSchedule');
    // await collectionReference.where('ID', isEqualTo: registrationScheduleModel.id).get().then((QuerySnapshot querySnapshot) {
    //   for (var doc in querySnapshot.docs) {
    //     doc.reference.update(registrationScheduleModel.toJson());
    //   }
    // });
    // hideLoadingOverlay();
    // Get.back(result: registrationScheduleModel);

    if (isCancelOder()) {
      BaseShowNotification.showNotification(
          Get.context!, "Thời gian huỷ đã gần với thời gian đến", QuickAlertType.error);
    } else {
      Get.bottomSheet(
        FilterCancelOderView.buildPageStatus(),
        isScrollControlled: true,
      ).then((value) async {
        if (value != null) {
          showLoadingOverlay();
          // registrationScheduleModel.status = 4;/// 4 Là huỷ
          // final CollectionReference collectionReference = FirebaseFirestore.instance.collection('RegistrationSchedule');
          // await collectionReference.where('ID', isEqualTo: registrationScheduleModel.id).get().then((QuerySnapshot querySnapshot) {
          //   for (var doc in querySnapshot.docs) {
          //     doc.reference.update(registrationScheduleModel.toJson());
          //   }
          // });
          // await insertCancel(value);
          await sentNotification(registrationScheduleModel, value);
          hideLoadingOverlay();
          Get.back(result: registrationScheduleModel);
        }
      });
    }
  }

  Future<void> insertCancel(String reason) async {
    CollectionReference users =
    FirebaseFirestore.instance.collection('CancelOder');
    AccountModel accountModel =
    HIVE_APP.get(AppConst.keyAccount);

    CancelOderModel cancelOderModel = CancelOderModel(
        dateCancel: convertDateToString(DateTime.now(), PATTERN_9),
        idCustom: null,
        idFixer: accountModel.uid,
        reason: reason,
        idOder: registrationScheduleModel.id);

    try {
      await users.add(cancelOderModel.toJson());
      log('Dữ liệu đã được thêm vào Firestore.');
    } catch (e) {
      BaseShowNotification.showNotification(
        Get.context!,
        'Lỗi khi thêm dữ liệu vào Firestore: $e',
        QuickAlertType.error,
      );
    }
  }


  bool isCancelOder() {
    if (convertStringToDate(
        registrationScheduleModel.dateSet ?? DateTime.now().toString(),
        PATTERN_17) ==
        convertStringToDate(DateTime.now().toString(), PATTERN_17)) {
      return true;
    }
    return false;
  }

  Future<void> sentNotification(
      RegistrationScheduleModel registrationScheduleModel, String cancel) async {

    try{
      String token = "";
      final documentSnapshot = await FirebaseFirestore.instance
          .collection('Fixer') // Thay 'your_collection_name' bằng tên collection của bạn
          .where("UID", isEqualTo: registrationScheduleModel.uidFixer!.uid) // UID của tài khoản bạn muốn truy vấn
          .get();

      if (documentSnapshot.docs.isNotEmpty) {
        var doc =  documentSnapshot.docs.first;
        FixerModel fixerModel = FixerModel.fromJson(doc.data());
        token = fixerModel.token ?? "";

      } else {
        log('Dữ liệu không tồn tại cho UID này.');
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