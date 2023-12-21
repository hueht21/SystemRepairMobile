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
import '../../home_page/models/notification_model.dart';
import '../../home_page/response/notification_response.dart';
import '../../notifications/models/notification_get_model.dart';
import '../models/registration_schedule_model.dart';

class ScheduleRepairControllerImp extends ScheduleRepairController {
  @override
  Future<void> onInit() async {
    accountModel = HIVE_APP.get(AppConst.keyAccount);
    await getDataFixerModel();
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
  void getFixer() {
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
          fixerModel = item;
        }
      }
    }
  }

  @override
  Future<void> registerSchedule() async {
    showLoadingOverlay();
    if (isNullTime()) {
      if (checkFileType(image.value.path) || image.value.path.isEmpty) {
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

        if(isValidate()){
          if (isValidateTime(dateSelect.value)) {
            await insertData(registrationScheduleModel, id);
            await sentNotification(registrationScheduleModel);
            Get.offNamed(AppPages.completeRegistration, arguments: fixerModel);
          } else {
            BaseShowNotification.showNotification(
                Get.context!,
                "Thời gian đăng ký không vượt quá 7 ngày và không nhỏ hơn ngày hôm nay",
                QuickAlertType.warning);
            // Get.snackbar(titleText: "Thông báo", colorText: "Thời gian đăng ký không vượt quá 7 ngày và không nhỏ hơn ngày hôm nay");
          }
        }else {
          BaseShowNotification.showNotification(
            Get.context!,
            'Số điện thoại với email bạn phải nhập đúng',
            QuickAlertType.warning,
          );
        }

      } else {
        BaseShowNotification.showNotification(
          Get.context!,
          'Định dạng không được hỗ trợ',
          QuickAlertType.warning,
        );
      }
    } else {
      BaseShowNotification.showNotification(
        Get.context!,
        'Thời gian và mô tả không được để trống',
        QuickAlertType.warning,
      );
    }
    hideLoadingOverlay();
  }

  bool isValidate() {
    if (isValidEmail(textEmail.text) && textNumberPhone.text.length <= 11) {
      return true;
    } else {
      return false;
    }
  }

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  Future<void> insertData(
      RegistrationScheduleModel registrationScheduleModel, String id) async {
    if (image.value.path.isNotEmpty) {
      try {
        final storage = FirebaseStorage.instance;
        var updateImg = storage
            .ref()
            .child("ImageScheduleFixer")
            .child("${id}imageScheduleFixer.jpg");

        await updateImg.putFile(image.value); // Tải lên ảnh
      } catch (e) {
        log("$e");
        hideLoadingOverlay();
      }
      registrationScheduleModel.imgFix = "${id}imageScheduleFixer.jpg";
    } else {
      registrationScheduleModel.imgFix = "";
    }

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
  }

  bool checkFileType(String filePath) {
    String fileExtension = filePath.split('.').last;
    if (fileExtension == 'jpg' ||
        fileExtension == 'jpeg' ||
        fileExtension == 'png' ||
        fileExtension == 'gif') {
      return true;
    } else if (fileExtension == 'mp4' ||
        fileExtension == 'avi' ||
        fileExtension == 'mkv') {
      return false;
    } else {
      return false;
    }
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

  bool isValidateTime(String date) {
    DateTime dateNow = DateTime.now();
    Duration difference =
        convertStringToDate(date, PATTERN_1).difference(dateNow);

    if (difference.inDays > 7) {
      return false;
    } else if (difference.inDays < 0) {
      return false;
    } else {
      return true;
    }
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

  Future<void> sentNotification(
      RegistrationScheduleModel registrationScheduleModel) async {
    NotificationModel notificationModel = NotificationModel(
        to: registrationScheduleModel.uidFixer!.token ?? "",
        notification: NotificationChild(
            title: "Thông báo mới",
            body:
                'Bạn có nhiệm vụ mới ngày ${registrationScheduleModel.dateSet} thời gian ${registrationScheduleModel.timeSet} tại đại chỉ ${registrationScheduleModel.address}, khách hàng cần ${registrationScheduleModel.describe}'));

    var response = await NotificationResponse()
        .sentNotification(notificationModel.toJson());

    CollectionReference notificationSend =
        FirebaseFirestore.instance.collection('Notification');
    NotificationGetModel notificationGetModel = NotificationGetModel(
      createDate: convertDateToString(DateTime.now(), PATTERN_1),
      uidReceiver: registrationScheduleModel.uidFixer!.uid,
      uidSend: registrationScheduleModel.uidClient,
      content:
          'Bạn có nhiệm vụ mới ngày ${registrationScheduleModel.dateSet} thời gian ${registrationScheduleModel.timeSet} tại đại chỉ ${registrationScheduleModel.address}, khách hàng cần ${registrationScheduleModel.describe}',
      id: response.results[0].messageId,
      title: 'Thông báo mới',
    );
    try {
      await notificationSend.add(notificationGetModel.toJson());
    } catch (e) {
      BaseShowNotification.showNotification(
        Get.context!,
        'Lỗi khi thêm dữ liệu vào Firestore: $e',
        QuickAlertType.error,
      );
    }
  }
}