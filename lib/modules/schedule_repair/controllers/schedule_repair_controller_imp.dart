import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:systemrepair/base_utils/base_controllers/app_controller.dart';
import 'package:systemrepair/cores/const/const.dart';
import 'package:systemrepair/modules/schedule_repair/controllers/schedule_repair_controller.dart';
import 'package:systemrepair/modules/schedule_repair/models/fixer_model.dart';

import '../../../base_utils/base_widget/base_show_notification.dart';
import '../../../shared/utils/date_utils.dart';

class ScheduleRepairControllerImp extends ScheduleRepairController {
  @override
  Future<void> onInit() async {
    accountModel = HIVE_APP.get(AppConst.keyAccount);
    getDataFixerModel();
    super.onInit();
  }

  @override
  void setIndexHead(int index) {
    indexHead.value = index;
  }

  @override
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    selectedDate.value = picked ?? DateTime.now();
    dateSelect.value = formatDateTimeToString(selectedDate.value);
  }

  @override
  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
    );
    selectedTime.value = picked ?? TimeOfDay.now();
    dateSelect.value = selectedTime.value.format(Get.context!);
  }

  @override
  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Đã chọn ảnh, bạn có thể làm gì đó với nó ở đây
      // Ví dụ: hiển thị nó trên màn hình
      image.value = File(pickedFile.path);
      // linkImg.value = fileToBase64(image.value);
    }
  }

  @override
  String fileToBase64(File file) {
    List<int> imageBytes = file.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  @override
  Future<void> getDataFixerModel() async {
    var result = await FirebaseFirestore.instance
        .collection(
            'Fixer') // Thay 'your_collection_name' bằng tên collection của bạn
        // .where("UID", isEqualTo: uid) // UID của tài khoản bạn muốn truy vấn
        .get();

    if (result.docs.isNotEmpty) {
      for (final dataFixerModel in result.docs) {
        listFixerModel.add(FixerModel.fromJson(dataFixerModel.data()));
        // print(dataFixerModel.);
      }
      // var doc = result.docs.first;
      // print(doc);
    } else {
      BaseShowNotification.showNotification(
        Get.context!,
        "Dữ liệu không tồn tại cho UID này.",
        QuickAlertType.error,
      );
    }
  }
}
