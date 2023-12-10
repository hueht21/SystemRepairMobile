import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:systemrepair/base_utils/base_controllers/app_controller.dart';
import 'package:systemrepair/cores/const/const.dart';
import 'package:systemrepair/modules/profile/controllers/profile_controller.dart';

class ProfileControllerImp extends ProfileController {


  @override
  Future<void> onInit() async {


    try {
      fixerModel = HIVE_APP.get(AppConst.keyFixerAccount);
      final storage = FirebaseStorage.instance;
      imgLinkUser.value =  await storage.ref().child('fixer/${fixerModel.imgAcc}').getDownloadURL();
    } catch (e) {
      log("$e");
    }


    super.onInit();
  }

}