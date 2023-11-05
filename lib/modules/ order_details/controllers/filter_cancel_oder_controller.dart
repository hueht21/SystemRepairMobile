
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
      FilterCancelOderModel("Tôi bận không nhận được", 0,false),
      FilterCancelOderModel("Có lý do đột xuất", 1,false),
      FilterCancelOderModel("Không sửa được", 2,false),
      FilterCancelOderModel("Khác", 3,false),
    ];
  }
}