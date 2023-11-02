import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:systemrepair/cores/const/const.dart';
import 'package:systemrepair/modules/login/models/fixer_account_model.dart';

import '../../../base_utils/base_controllers/app_controller.dart';
import 'home_view_controller.dart';

class HomeViewControllerImp extends HomeViewController {

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    FixerAccountModel fixerAccountModel = HIVE_APP.get(AppConst.keyFixerAccount);
    isOperatingStatus.value = fixerAccountModel.status ??  false;

    String tokenFixer = '';
    await FirebaseMessaging.instance.getToken().then((token) {
      tokenFixer = token??"";
    });
    if(fixerAccountModel.token != tokenFixer){
      fixerAccountModel.token = tokenFixer;
      final CollectionReference collectionReference = FirebaseFirestore.instance.collection('Fixer');
      await collectionReference.where('UID', isEqualTo: fixerAccountModel.uid).get().then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          doc.reference.update(fixerAccountModel.toJson());
        }
      });
      await HIVE_APP.put(AppConst.keyFixerAccount, fixerAccountModel);
    }




    super.onInit();
  }

}