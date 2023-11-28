import 'dart:developer';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:systemrepair/modules/login/models/account_model.dart';
import '../../../base_utils/base_widget/base_show_notification.dart';
import '../../../cores/enum/enum_status.dart';
import '../models/registration_schedule_model.dart';
import 'oder_controller.dart';

class OrderControllerImp extends OrderController {
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    showLoading();
    await getDataRegistrationSchedule();
    await getDataUser();
    hideLoading();
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
    final documentSnapshot = await FirebaseFirestore.instance
        .collection(
            'RegistrationSchedule') // Thay 'your_collection_name' bằng tên collection của bạn
        .get();
    if (documentSnapshot.docs.isNotEmpty) {
      for (final dataFixerModel in documentSnapshot.docs) {
        listRegistrationScheduleSearch
            .add(RegistrationScheduleModel.fromJson(dataFixerModel.data()));
      }
      if (indexOption.value == 0) {
        listRegistrationSchedule.value = listRegistrationScheduleSearch;
      } else {
        listRegistrationSchedule.value = listRegistrationScheduleSearch
            .where((element) => element.status == indexOption.value)
            .toList();
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
    // indexOption.value = 0;
    await getDataRegistrationSchedule();
    hideLoading();
    refreshController.refreshCompleted();
  }

  @override
  void optionType(int indexType) {
    listRegistrationSchedule.value = [];
    if (indexType == 0) {
      listRegistrationSchedule.value = listRegistrationScheduleSearch;
    } else {
      listRegistrationSchedule.value = listRegistrationScheduleSearch
          .where((element) => element.status == indexType)
          .toList();
    }
  }

  @override
  Future<void> getDataUser() async {
    final documentSnapshot =
        await FirebaseFirestore.instance.collection('User').get();

    if (documentSnapshot.docs.isNotEmpty) {
      listAccount.addAll(documentSnapshot.docs
          .map((user) => AccountModel.fromJson(user.data()))
          .toList());
    }
  }

  @override
  String getNameUser(String uid) {
    AccountModel accountModel = listAccount.firstWhere((element) => element.uid == uid);
    return accountModel.nameAccout ?? "";
  }

  @override
  Color colorStatus(int status) {
    // Color color = Colors.white;
    switch(status) {
      case 0: return Colors.white;
      case 1: return Colors.amberAccent;
      case 2: return Colors.indigoAccent;
      case 3: return Colors.green;
      case 4: return Colors.red;
      default: return Colors.white;
    }
  }
}
