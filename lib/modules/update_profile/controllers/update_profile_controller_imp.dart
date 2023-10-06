import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';
import 'package:systemrepair/modules/update_profile/controllers/update_profile_controller.dart';

import '../../../base_utils/base_controllers/app_controller.dart';
import '../../../base_utils/base_widget/base_show_notification.dart';
import '../../../cores/const/const.dart';
import '../../schedule_repair/models/registration_schedule_model.dart';

class UpdateProfileControllerImp extends UpdateProfileController {

  @override
  void onInit() {
    accountModel = HIVE_APP.get(AppConst.keyAccount);

    textEmail.text = accountModel.email;
    textName.text = accountModel.nameAccout ?? "";
    textNumberPhone.text = accountModel.numberPhone ?? "";
    textAddress.text = accountModel.address;
    super.onInit();
  }

  @override
  String fileToBase64(File file) {
    List<int> imageBytes = file.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  @override
  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }else {
      BaseShowNotification.showNotification(
        Get.context!,
        "Không lấy ảnh",
        QuickAlertType.error,
      );
    }
  }

  @override
  Future<void> searchLocation(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        latitude.value = locations[0].latitude;
        longitude.value = locations[0].longitude;
      } else {
        latitude.value = 0.0;
        longitude.value = 0.0;
      }
      log("${latitude.value} ${longitude.value}");
    } catch (e) {
      BaseShowNotification.showNotification(
        Get.context!,
        "Không lấy được vị trí $e",
        QuickAlertType.error,
      );
    }
  }

  @override
  Future<void> btnConfirm() async {


  }

}