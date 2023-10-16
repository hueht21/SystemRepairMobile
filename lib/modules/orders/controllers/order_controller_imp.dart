import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';

import '../../../base_utils/base_controllers/app_controller.dart';
import '../../../base_utils/base_widget/base_show_notification.dart';
import '../../../cores/const/const.dart';
import '../../../cores/enum/enum_status.dart';
import '../../register_account/model/account_model.dart';
import '../../schedule_repair/models/registration_schedule_model.dart';
import 'order_controler.dart';

class OrderControllerImp extends OrderController {
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    await getDataRegistrationSchedule();
    super.onInit();
  }

  @override
  void setIndexOption(int index) {
    // TODO: implement setIndexOption
  }

  @override
  String getStatus(int index) {
    // TODO: implement getStatus
    switch (index) {
      case 1:
        return EnumStatusOder.waitingStatus;
      case 2:
        return EnumStatusOder.confirmedStatus;
      case 3:
        return EnumStatusOder.completeStatus;
      case 4:
        return EnumStatusOder.canceledStatus;
    }
    return "";
  }

  @override
  Future<void> getDataRegistrationSchedule() async {
    // TODO: implement getDataRegistrationSchedule
    listRegistrationSchedule.value = [];
    listRegistrationScheduleSearch = [];
    AccountModel accountModel = HIVE_APP.get(AppConst.keyAccount);

    final documentSnapshot = await FirebaseFirestore.instance
        .collection(
            'RegistrationSchedule') // Thay 'your_collection_name' bằng tên collection của bạn
        .where("UIDClient",
            isEqualTo: accountModel.uid) // UID của tài khoản bạn muốn truy vấn
        .get();

    if (documentSnapshot.docs.isNotEmpty) {
      for (final dataFixerModel in documentSnapshot.docs) {
        listRegistrationScheduleSearch
            .add(RegistrationScheduleModel.fromJson(dataFixerModel.data()));
        listRegistrationSchedule.value = listRegistrationScheduleSearch;
      }
    } else {
      BaseShowNotification.showNotification(
        Get.context!,
        "Dữ liệu không rỗng",
        QuickAlertType.error,
      );
    }
  }

  @override
  Future<void> onLoadMore() async {
    log("Load xuong nay");
  }

  @override
  Future<void> onRefresh() async {
    showLoading();
    indexOption.value = 0;
    await getDataRegistrationSchedule();
    hideLoading();
    refreshController.refreshCompleted();
  }

  @override
  void optionType(int indexType) {

    listRegistrationSchedule.value = [];
    if(indexType == 0) {

      listRegistrationSchedule.value = listRegistrationScheduleSearch;
    }else {
      listRegistrationSchedule.value = listRegistrationScheduleSearch
          .where((element) => element.status == indexType)
          .toList();
    }

  }
}
