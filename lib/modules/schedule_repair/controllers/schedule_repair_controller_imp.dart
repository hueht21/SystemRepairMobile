import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:systemrepair/base_utils/base_controllers/app_controller.dart';
import 'package:systemrepair/cores/const/const.dart';
import 'package:systemrepair/modules/schedule_repair/controllers/schedule_repair_controller.dart';
import 'package:systemrepair/modules/schedule_repair/models/fixer_model.dart';
import 'package:systemrepair/router/app_pages.dart';

import '../../../base_utils/base_widget/base_show_notification.dart';
import '../../../shared/utils/date_utils.dart';
import '../models/registration_schedule_model.dart';

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
    timeSelect.value = selectedTime.value.format(Get.context!);
  }

  @override
  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
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
      }
    } else {
      BaseShowNotification.showNotification(
        Get.context!,
        "Dữ liệu không tồn tại cho UID này.",
        QuickAlertType.error,
      );
    }
  }

  @override
  Future<void> getFixer() async {
    for (var item in listFixerModel) {
      if (item.status ?? false) {
        // Tính khoảng cách giữa vị trí hiện tại và vị trí trong danh sách
        double distance = Geolocator.distanceBetween(
          accountModel.latitude ?? 0.0,
          accountModel.longitude ?? 0.0,
          item.latitude ?? 0,
          item.longitude ?? 0,
        );

        // So sánh khoảng cách với vị trí gần tôi nhất hiện tại
        if (nearestDistance == 0.0 || distance < nearestDistance) {
          nearestDistance = distance;
          // latitudeFixer = item.latitude ?? 0.0;
          // longitudeFixer = item.longitude ?? 0.0;
          // accFixer.latitude = item.latitude ?? 0.0;
          // accFixer.longitude = item.longitude ?? 0.0;
          // accFixer.uid = item.uid;
          fixerModel = item;
        }
      }
    }
  }

  @override
  Future<void> registerSchedule() async {
    showLoadingOverlay();

    if (isNullTime()) {
      await searchLocation(
        textAddress.text.trim().isEmpty
            ? accountModel.address
            : textAddress.text.trim(),
      );
      getFixer();
      fixAccNull();
      String id = uuid.v4();
      RegistrationScheduleModel registrationScheduleModel =
          RegistrationScheduleModel(
              id: id,
              address: textAddress.text.trim(),
              numberPhone: textNumberPhone.text.trim(),
              email: textEmail.text.trim(),
              status: 1,
              customerName: textName.text.trim(),
              numberCancel: 0,
              uidFixer: fixerModel,
              latitude: accountModel.latitude,
              longitude: accountModel.longitude,
              describe: textDescribe.text.trim(),
              note: textNote.text.trim(),
              imgFix: "",
                  // image.value.path.isNotEmpty ? fileToBase64(image.value) : "",
              timeSet: timeSelect.value,
              dateSet: dateSelect.value,
              uidClient: accountModel.uid);

      try {
        final storage = FirebaseStorage.instance;
        var updateImg = storage.ref().child("ImageScheduleFixer").child("${id}imageScheduleFixer.jpg");

        await updateImg.putFile(image.value); // Tải lên ảnh

      }catch(e) {
        log("$e");
        hideLoadingOverlay();
      }

      registrationScheduleModel.imgFix = "${id}imageScheduleFixer.jpg";
      CollectionReference users =
          FirebaseFirestore.instance.collection('RegistrationSchedule');
      try {
        await users.add(registrationScheduleModel.toJson());
        log('Dữ liệu đã được thêm vào Firestore.');
        // Get.back();
      } catch (e) {
        BaseShowNotification.showNotification(
          Get.context!,
          'Lỗi khi thêm dữ liệu vào Firestore: $e',
          QuickAlertType.error,
        );
        log("$e");
        hideLoadingOverlay();
      }
      Get.offNamed(AppPages.completeRegistration, arguments: fixerModel);
    } else {
      BaseShowNotification.showNotification(
        Get.context!,
        'Thời gian và mô tả không được để trống',
        QuickAlertType.warning,
      );
    }

    hideLoadingOverlay();
  }

  @override
  void fixAccNull() {
    // TODO: implement fixAccNull
    if (textName.text.isEmpty) {
      textName.text = accountModel.nameAccout ?? "";
    }
    if (textEmail.text.isEmpty) {
      textEmail.text = accountModel.email;
    }
    if (textNumberPhone.text.isEmpty) {
      textNumberPhone.text = accountModel.numberPhone ?? "";
    }
    if (textAddress.text.isEmpty) {
      textAddress.text = accountModel.address;
    }
  }

  bool isNullTime() {
    if (timeSelect.value.isEmpty ||
        dateSelect.value.isEmpty ||
        textDescribe.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Future<void> searchLocation(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        accountModel.latitude = locations[0].latitude;
        accountModel.longitude = locations[0].longitude;
      }
      log("${accountModel.latitude} ${accountModel.longitude}");
    } catch (e) {
      BaseShowNotification.showNotification(
        Get.context!,
        "Không lấy được vị trí $e",
        QuickAlertType.error,
      );
    }
  }
}
