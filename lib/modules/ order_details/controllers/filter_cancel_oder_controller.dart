
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_controllers/base_controller.dart';

import '../models/filter_cancel_oder_model.dart';
import 'order_details_controller.dart';

class FilterCancelOderController extends BaseGetxController {

  RxList<FilterCancelOderModel> listStatus = <FilterCancelOderModel>[].obs;

  OderDetailController oderDetailController = Get.find();

  TextEditingController textNote = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    initDataStatus();
    super.onInit();
  }

  void initDataStatus() {
    listStatus.value = [
      FilterCancelOderModel("Tôi cảm thấy không cần phải sửa", 0,false),
      FilterCancelOderModel("Tôi đã tìm thấy thợ sửa khác", 1,false),
      FilterCancelOderModel("Tôi đã tự sửa được", 2,false),
      FilterCancelOderModel("Khác", 3,false),
    ];
  }
}