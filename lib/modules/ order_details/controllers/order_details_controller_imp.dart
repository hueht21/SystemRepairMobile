
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import 'order_details_controller.dart';

class OderDetailControllerImp extends OderDetailController {


  @override
  Future<void> onInit() async {
    // TODO: implement onInit

    registrationScheduleModel = Get.arguments;
    indexHead.value = registrationScheduleModel.status ?? 0;


    try {
      final storage = FirebaseStorage.instance;
      imageUrlFix.value = await storage.ref().child('fixer/${registrationScheduleModel.uidFixer?.imgAcc}').getDownloadURL();
      imageUrlSchedule.value = await storage.ref().child('ImageScheduleFixer/${registrationScheduleModel.imgFix}').getDownloadURL();
    } catch(e) {
      log("$e");
    }

    super.onInit();
  }

  @override
  Future<void> cancelOrder() async {
    // await FirebaseFirestore.instance.collection("RegistrationSchedule").w

    showLoadingOverlay();
    registrationScheduleModel.status = 3;/// 3 Là huỷ
    final CollectionReference collectionReference = FirebaseFirestore.instance.collection('RegistrationSchedule');
    await collectionReference.where('ID', isEqualTo: registrationScheduleModel.id).get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        doc.reference.update(registrationScheduleModel.toJson());
      }
    });
    hideLoadingOverlay();
    Get.back(result: registrationScheduleModel);
  }


}