import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:systemrepair/base_utils/base_controllers/app_controller.dart';
import 'package:systemrepair/base_utils/base_send_notification/base_show_notification.dart';
import 'package:systemrepair/cores/const/const.dart';
import 'package:systemrepair/cores/values/string_values.dart';
import 'package:systemrepair/modules/login/models/account_model.dart';
import 'package:systemrepair/modules/login/models/fixer_account_model.dart';
import 'package:systemrepair/modules/oders/models/fixer_model.dart';
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
    showLoading();
    registrationScheduleModel = Get.arguments;
    indexHead.value = registrationScheduleModel.status ?? 0;
    await getDetailOder();
    await getDataFixerModel();

    hideLoading();

    super.onInit();
  }

  Future<void> getDetailOder() async {
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
  }

  @override
  Future<void> cancelOrder() async {
    registrationScheduleModel.status = 1;
    await searchLocation(registrationScheduleModel.address ?? "")
        .then((value) async {
      /// 4 Là huỷ
      registrationScheduleModel.uidFixer = fixerModelCancel;

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
      String token = await BaseShowNotificationCtr()
          .getTokenFixer(registrationScheduleModel.uidFixer!.uid ?? "");

      String tokenClient = await BaseShowNotificationCtr()
          .getTokenClient(registrationScheduleModel.uidClient ?? "");

      await BaseShowNotificationCtr().sentNotification(
          uid: "uid",
          token: token,
          uidReceiver: registrationScheduleModel.uidFixer!.uid ?? "",
        content: "Bạn có 1 đơn đặt được điều chuyển từ khách hàng có địa chỉ ${registrationScheduleModel.address}"
      );

      await BaseShowNotificationCtr().sentNotification(
          uid: "uid",
          token: tokenClient,
          uidReceiver: registrationScheduleModel.uidClient ?? "",
          content: "Đơn đặt của bạn đã được chuyển cho thợ ${registrationScheduleModel.uidFixer!.name}"
      );
      Get.back(result: registrationScheduleModel);
    });
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
    showLoading();
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
    }).whenComplete(() => hideLoading());

    String tokenClient = await BaseShowNotificationCtr()
        .getTokenClient(registrationScheduleModel.uidClient ?? "");

    String content = AppStr.getNotificationnConfirm(
      registrationScheduleModel.timeSet ?? "",
      registrationScheduleModel.dateSet ?? "",
      registrationScheduleModel.address ?? "",
      registrationScheduleModel.uidFixer!.name ?? "",
    );
    await BaseShowNotificationCtr().sentNotification(
        uid: "uid",
        token: tokenClient,
        uidReceiver: registrationScheduleModel.uidClient ?? "",
        content: content
    );
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
    // await sentNotification(
    //   registrationScheduleModel,
    // );
    hideLoading();
    Get.back(result: registrationScheduleModel);
    // Get.back(result: registrationScheduleModel);
  }

  Future<void> getDataFixerModel() async {
    FixerAccountModel fixerAccountModel =
        HIVE_APP.get(AppConst.keyFixerAccount);
    try {
      var result = await FirebaseFirestore.instance
          .collection('Fixer')
          .where("Status", isEqualTo: true)
          .get();
      if (result.docs.isNotEmpty) {
        for (final dataFixerModel in result.docs) {
          FixerModel fixerModel = FixerModel.fromJson(dataFixerModel.data());
          if (fixerModel.uid != fixerAccountModel.uid) {
            listFixerModel.add(fixerModel);
          }
        }
      } else {
        BaseShowNotification.showNotification(
          Get.context!,
          "Dữ liệu không tồn tại cho UID này.",
          QuickAlertType.error,
        );
      }
    } catch (e) {
      log("$e");
    }
  }

//1
  Future<void> searchLocation(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        latitudeCancel = locations[0].latitude;
        longitudeCancel = locations[0].longitude;
      }
      await getFixer();
    } catch (e) {
      BaseShowNotification.showNotification(
        Get.context!,
        "Không lấy được vị trí $e",
        QuickAlertType.error,
      );
    }
  }

  Future<void> getFixer() async {
    for (var item in listFixerModel) {
      if (item.status ?? false) {
        // Tính khoảng cách giữa vị trí hiện tại và vị trí trong danh sách
        double distance = Geolocator.distanceBetween(
          latitudeCancel,
          longitudeCancel,
          item.latitude ?? 0,
          item.longitude ?? 0,
        );
        // So sánh khoảng cách với vị trí gần tôi nhất hiện tại
        if (nearestDistance == 0.0 || distance < nearestDistance) {
          nearestDistance = distance;
          fixerModelCancel = item;
        }
      }
    }
  }
}
