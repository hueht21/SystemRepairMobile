import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:systemrepair/modules/login/models/account_model.dart';
import '../../../base_utils/base_controllers/base_refresh_controller.dart';
import '../models/registration_schedule_model.dart';

abstract class OrderController extends BaseRefreshGetxController {

  RxInt indexOption = 1.obs;

  List<AccountModel> listAccount = [];

  List<String> listTitleOption = [
    "Tất cả",
    "Đang chờ",
    "Đã nhận",
    "Hoàn thành",
    "Đã huỷ"
  ];

  RxList<RegistrationScheduleModel> listRegistrationSchedule = <RegistrationScheduleModel>[].obs;

  List<RegistrationScheduleModel> listRegistrationScheduleSearch = [];


  Future<void> getDataRegistrationSchedule();

  void setIndexOption(int index);

  String getStatus(int index);

  void optionType(int indexType);

  Future<void> getDataUser();

  String getNameUser(String uid);

  Color colorStatus(int status);
}