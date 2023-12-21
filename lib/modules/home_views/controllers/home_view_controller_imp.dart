import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:systemrepair/cores/const/const.dart';
import 'package:systemrepair/modules/login/models/fixer_account_model.dart';
import 'package:systemrepair/shared/utils/date_utils.dart';

import '../../../base_utils/base_controllers/app_controller.dart';
import '../../../base_utils/base_widget/base_show_notification.dart';
import '../../oders/models/registration_schedule_model.dart';
import '../../pay_order/models/pay_oder_model.dart';
import '../views/sales_data_view.dart';
import 'home_view_controller.dart';

class HomeViewControllerImp extends HomeViewController {
  @override
  Future<void> onInit() async {
    await getToken();
    await getDataStatistical();
    await getDataPayOder();
    findData();
    super.onInit();
  }

  Future<void> getToken() async {
    FixerAccountModel fixerAccountModel =
        HIVE_APP.get(AppConst.keyFixerAccount);
    isOperatingStatus.value = fixerAccountModel.status ?? false;
    String tokenFixer = '';
    await FirebaseMessaging.instance.getToken().then((token) {
      tokenFixer = token ?? "";
    });
    if (fixerAccountModel.token != tokenFixer) {
      fixerAccountModel.token = tokenFixer;
      final CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('Fixer');
      await collectionReference
          .where('UID', isEqualTo: fixerAccountModel.uid)
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          doc.reference.update(fixerAccountModel.toJson());
        }
      });
      await HIVE_APP.put(AppConst.keyFixerAccount, fixerAccountModel);
    }
  }

  Future<void> getDataPayOder() async {
    FixerAccountModel fixerAccountModel =
        HIVE_APP.get(AppConst.keyFixerAccount);
    final documentSnapshot = await FirebaseFirestore.instance
        .collection(
            'PayOder') // Thay 'your_collection_name' bằng tên collection của bạn
        .where("UID_Fixer",
            isEqualTo:
                fixerAccountModel.uid) // UID của tài khoản bạn muốn truy vấn
        .get()
        .whenComplete(() => hideLoading());
    if (documentSnapshot.docs.isNotEmpty) {
      for (final payModel in documentSnapshot.docs) {
        PayOderModel payOderModel = PayOderModel.fromJson(payModel.data());
        if (convertStringToDate(payOderModel.createDate ?? "", PATTERN_1)
                .year ==
            DateTime.now().year) {
          listPayModel.add(PayOderModel.fromJson(payModel.data()));
        }
      }
    } else {
      BaseShowNotification.showNotification(
        Get.context!,
        "Dữ liệu thanh toán rỗng",
        QuickAlertType.error,
      );
    }
  }

  @override
  Future<void> getDataStatistical() async {
    showLoading();
    FixerAccountModel fixerAccountModel =
        HIVE_APP.get(AppConst.keyFixerAccount);
    final documentSnapshot = await FirebaseFirestore.instance
        .collection(
            'RegistrationSchedule') // Thay 'your_collection_name' bằng tên collection của bạn
        .where("UIDFixer.UID",
            isEqualTo:
                fixerAccountModel.uid) // UID của tài khoản bạn muốn truy vấn
        .get();
    if (documentSnapshot.docs.isNotEmpty) {
      for (final dataFixerModel in documentSnapshot.docs) {
        listDataSchedule
            .add(RegistrationScheduleModel.fromJson(dataFixerModel.data()));
      }
      for (var item in listDataSchedule) {
        if (item.status == 1) {
          numberWaiting++;
        } else if (item.status == 2) {
          numberConfirmedStatus++;
        } else if (item.status == 3) {
          numberFinish++;
        } else if (item.status == 4) {
          numberCanceledStatus++;
        }
      }
    } else {
      BaseShowNotification.showNotification(
        Get.context!,
        "Dữ liệu không rỗng",
        QuickAlertType.error,
      );
    }
  }

  void findData() {
    salesData = [
      SalesData('Hoàn thành', numberFinish.toDouble()),
      SalesData('Chờ sửa', numberWaiting.toDouble()),
      SalesData('Chờ duyệt', numberCanceledStatus.toDouble()),
      SalesData('Đã huỷ', numberCanceledStatus.toDouble()),
    ];


    for (int i = 0; i < listPayModel.length; i++) {
      int month = convertStringToDate(listPayModel[i].createDate ?? "", PATTERN_1).month;
      if (mapAmount.containsKey(month)) {
        mapAmount[month] = (mapAmount[month] ?? 0) + listPayModel[i].amount;
      }else {
        mapAmount.addAll({month : listPayModel[i].amount});
      }
    }

    List<int> listKey = mapAmount.keys.toList();
    for(var item in listKey){
      charGetData.add(MonthMoney(item, (mapAmount[item]!.toDouble())));
    }
  }

  @override
  Future<void> setStatus() async {
    showLoading();
    FixerAccountModel fixerAccountModel =
        HIVE_APP.get(AppConst.keyFixerAccount);
    fixerAccountModel.status = isOperatingStatus.value;
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Fixer');
    await collectionReference
        .where('UID', isEqualTo: fixerAccountModel.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        doc.reference.update(fixerAccountModel.toJson());
      }
    }).whenComplete(() {
      HIVE_APP.put(AppConst.keyFixerAccount, fixerAccountModel);
      getStatus();
      hideLoading();
    });
  }

  void getStatus() {
    FixerAccountModel fixerAccountModel =
        HIVE_APP.get(AppConst.keyFixerAccount);
    isOperatingStatus.value = fixerAccountModel.status ?? false;
  }
}
