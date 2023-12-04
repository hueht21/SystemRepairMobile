import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:systemrepair/base_utils/base_controllers/app_controller.dart';
import 'package:systemrepair/cores/const/const.dart';
import 'package:systemrepair/cores/values/string_values.dart';
import 'package:systemrepair/modules/login/models/account_model.dart';
import 'package:systemrepair/modules/login/models/fixer_account_model.dart';
import 'package:systemrepair/shared/utils/date_utils.dart';

import '../../../base_utils/base_widget/base_show_notification.dart';
import '../../notifications/models/notification_get_model.dart';
import '../../notifications/models/notification_model.dart';
import '../../notifications/response/notification_response.dart';
import '../../oders/models/registration_schedule_model.dart';
import '../../pay_order/models/pay_oder_model.dart';
import '../models/cancel_oder_model.dart';
import '../views/filter_cancel_oder_view.dart';
import 'order_details_controller.dart';

class OderDetailControllerImp extends OderDetailController {
  @override
  Future<void> onInit() async {
    // TODO: implement onInit

    showLoading();
    registrationScheduleModel = Get.arguments;
    indexHead.value = registrationScheduleModel.status ?? 0;

    final storage = FirebaseStorage.instance;

    try {
      if (registrationScheduleModel.status == 3) {
        final documentSnapshot = await FirebaseFirestore.instance
            .collection(
                'PayOder') // Thay 'your_collection_name' bằng tên collection của bạn
            .where("IDOder",
                isEqualTo: registrationScheduleModel
                    .id) // UID của tài khoản bạn muốn truy vấn
            .get();

        if (documentSnapshot.docs.isNotEmpty) {
          var doc = documentSnapshot.docs.first;
          payOderModel.value = PayOderModel.fromJson(doc.data());
        }

        imageUrlPayOder.value = await storage
            .ref()
            .child('PayOder/${payOderModel.value.imgPay}')
            .getDownloadURL();
      }
      imageUrlFix.value = await storage
          .ref()
          .child('fixer/${registrationScheduleModel.uidFixer?.imgAcc}')
          .getDownloadURL();

      imageUrlSchedule.value = await storage
          .ref()
          .child('ImageScheduleFixer/${registrationScheduleModel.imgFix}')
          .getDownloadURL();
    } catch (e) {
      // hideLoading();
    }
    hideLoading();

    super.onInit();
  }

  @override
  Future<void> cancelOrder() async {
    // await FirebaseFirestore.instance.collection("RegistrationSchedule").w

    registrationScheduleModel.status = 4;

    /// 4 Là huỷ
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('RegistrationSchedule');
    await collectionReference
        .where('ID', isEqualTo: registrationScheduleModel.id)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        doc.reference.update(registrationScheduleModel.toJson());
      }
    });
    Get.back(result: registrationScheduleModel);
  }

  @override
  Future<void> cancelOrderBtn() async {
    if (isCancelOder()) {
      BaseShowNotification.showNotification(Get.context!,
          "Thời gian huỷ đã gần với thời gian đến", QuickAlertType.error);
    } else {
      Get.bottomSheet(
        FilterCancelOderView.buildPageStatus(),
        isScrollControlled: true,
      ).then((value) async {
        if (value != null) {
          showLoading();
          await insertCancel(value);
          await cancelOrder();
          await sentNotification(registrationScheduleModel, cancel: value, isCancel: true);
          hideLoading();
        }
      });
    }
  }

  @override
  Future<void> insertCancel(String reason) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('CancelOder');
    FixerAccountModel fixerAccountModel =
        HIVE_APP.get(AppConst.keyFixerAccount);

    CancelOderModel cancelOderModel = CancelOderModel(
        dateCancel: convertDateToString(DateTime.now(), PATTERN_9),
        idCustom: null,
        idFixer: fixerAccountModel.uid,
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

  @override
  Future<void> confirmStatus() async {
    showLoadingOverlay();
    registrationScheduleModel.status = 2;

    /// 2 Xác nhận
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('RegistrationSchedule');
    await collectionReference
        .where('ID', isEqualTo: registrationScheduleModel.id)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        doc.reference.update(registrationScheduleModel.toJson());
      }
    }).whenComplete(() => hideLoadingOverlay());

    sentNotification(registrationScheduleModel);
    // hideLoading();
    BaseShowNotification.showNotification(
        Get.context!, 'Đơn đã được bạn xác nhận! ', QuickAlertType.confirm,
        confirm: () {
      Get.back();
      Get.back(result: registrationScheduleModel);
    });
    // Get.back(result: registrationScheduleModel);
  }

  @override
  bool isCancelOder() {
    if (convertStringToDate(
            registrationScheduleModel.dateSet ?? DateTime.now().toString(),
            PATTERN_17) ==
        convertStringToDate(DateTime.now().toString(), PATTERN_17)) {
      return true;
    }
    return false;
  }

  @override
  Future<void> confirmPayOder() async {
    showLoading();
    registrationScheduleModel.status = 3;

    /// 2 Xác nhận
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('RegistrationSchedule');
    await collectionReference
        .where('ID', isEqualTo: registrationScheduleModel.id)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        doc.reference.update(registrationScheduleModel.toJson());
      }
    });
    await sentNotification(
      registrationScheduleModel,
    );
    hideLoading();
    Get.back(result: registrationScheduleModel);
    // Get.back(result: registrationScheduleModel);
  }

  Future<void> sentNotification(
    RegistrationScheduleModel registrationSchedule, {
    String? cancel,
    bool isCancel = false,
  }) async {
    try {
      String token = "";
      final documentSnapshot = await FirebaseFirestore.instance
          .collection(
              'User') // Thay 'your_collection_name' bằng tên collection của bạn
          .where("UID",
              isEqualTo: registrationSchedule
                  .uidClient) // UID của tài khoản bạn muốn truy vấn
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
      String idNotification = "";
      String contentNotification = "";
      if (isCancel) {
        idNotification = await cancelSchedule(registrationSchedule, token);
        contentNotification = AppStr.getNotificationnCancel(
          registrationSchedule.dateSet ?? "",
          registrationSchedule.timeSet ?? "",
          registrationSchedule.address ?? "",
          cancel ?? "",
          "Tên thợ sửa",
        );
      } else {
        idNotification = await sentConfirm(registrationSchedule, token);
        contentNotification = AppStr.getNotificationnConfirm(
          registrationSchedule.timeSet ?? "",
          registrationSchedule.dateSet ?? "",
          registrationSchedule.address ?? "",
          registrationSchedule.uidFixer!.name ?? "",
        );
      }

      await saveNotification(
        registrationSchedule,
        contentNotification,
        idNotification,
      );
    } catch (e) {
      BaseShowNotification.showNotification(
        Get.context!,
        'Lỗi khi thêm dữ liệu vào Firestore: $e',
        QuickAlertType.error,
      );
    }
  }

  Future<String> sentConfirm(
      RegistrationScheduleModel registrationSchedule, String token) async {
    NotificationModel notificationModel = NotificationModel(
      to: token,
      notification: NotificationChild(
          title: "Thông báo mới",
          body: AppStr.getNotificationnConfirm(
              registrationSchedule.dateSet ?? "",
              registrationSchedule.timeSet ?? "",
              registrationSchedule.address ?? "",
              registrationSchedule.uidFixer?.name ?? "")),
    );

    var response = await NotificationResponse()
        .sentNotification(notificationModel.toJson());
    return response.results[0].messageId ?? "";
  }

  Future<String> cancelSchedule(
      RegistrationScheduleModel registrationSchedule, String token) async {
    NotificationModel notificationModel = NotificationModel(
      to: token,
      notification: NotificationChild(
          title: "Thông báo mới",
          body: AppStr.getNotificationnConfirm(
              registrationSchedule.dateSet ?? "",
              registrationSchedule.timeSet ?? "",
              registrationSchedule.address ?? "",
              registrationSchedule.uidFixer?.name ?? "")),
    );

    var response = await NotificationResponse()
        .sentNotification(notificationModel.toJson());
    return response.results[0].messageId ?? "";
  }

  Future<void> saveNotification(
    RegistrationScheduleModel registrationSchedule,
    String content,
    String idNotification,
  ) async {
    CollectionReference notificationSend =
        FirebaseFirestore.instance.collection('Notification');

    NotificationGetModel notificationGetModel = NotificationGetModel(
      createDate: convertDateToString(DateTime.now(), PATTERN_1),
      uidReceiver: registrationSchedule.uidFixer!.uid,
      uidSend: registrationSchedule.uidClient,
      content: content,
      id: idNotification,
      title: 'Thông báo mới',
    );
    await notificationSend.add(notificationGetModel.toJson());
  }
}
