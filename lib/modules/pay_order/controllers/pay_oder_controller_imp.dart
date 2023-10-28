import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:systemrepair/modules/pay_order/controllers/pay_oder_controller.dart';
import 'package:systemrepair/modules/pay_order/models/pay_oder_model.dart';
import 'package:systemrepair/shared/utils/date_utils.dart';

import '../../../base_utils/base_widget/base_show_notification.dart';

class PayOderControllerImp extends PayOderController {
  @override
  void onInit() {
    // TODO: implement onInit
    registrationScheduleModel = Get.arguments;
    super.onInit();
  }

  @override
  Future<void> payOder() async {
    if(image.value.path.isNotEmpty && textTotalOder.text.isNotEmpty) {
      showLoading();
      try {
        final storage = FirebaseStorage.instance;
        var updateImg = storage.ref().child("PayOder").child("${registrationScheduleModel.id}payOder.jpg");

        await updateImg.putFile(image.value); // Tải lên ảnh

      }catch(e) {
        BaseShowNotification.showNotification(
          Get.context!,
          'Lỗi khi đẩy ảnh lên: $e',
          QuickAlertType.error,
        );
        hideLoading();
      }

      showLoading();
      CollectionReference payOder =
      FirebaseFirestore.instance.collection('PayOder');

      PayOderModel payOderModel = PayOderModel(
        amount: int.parse(amount.replaceAll(',', '')),
        createDate: convertDateToString(DateTime.now(), PATTERN_1),
        idOder: registrationScheduleModel.id,
        uidCustomer: registrationScheduleModel.uidClient,
        uidFixer: registrationScheduleModel.uidFixer!.uid,
        imgPay: "${registrationScheduleModel.id}payOder.jpg",
      );

      try {
        await payOder.add(payOderModel.toJson());
        log('Dữ liệu đã được thêm vào Firestore.');
        // Get.back();
      } catch (e) {
        BaseShowNotification.showNotification(
          Get.context!,
          'Lỗi khi thêm dữ liệu vào Firestore: $e',
          QuickAlertType.error,
        );
        log("$e");
        hideLoading();
      }

      hideLoading();
      Get.back(result: true);
    } else {
      BaseShowNotification.showNotification(
        Get.context!,
        'Số tiền và ảnh hoá đơn không được để trống',
        QuickAlertType.warning,
      );
    }

  }

  @override
  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  bool checkFileType(String filePath) {
    String fileExtension = filePath.split('.').last;
    if (fileExtension == 'jpg' || fileExtension == 'jpeg' || fileExtension == 'png' || fileExtension == 'gif') {
      return true;
    } else if (fileExtension == 'mp4' || fileExtension == 'avi' || fileExtension == 'mkv') {
      return false;
    } else {
      return false;
    }
  }


}
