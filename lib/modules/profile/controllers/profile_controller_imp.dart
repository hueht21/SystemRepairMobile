import 'package:firebase_storage/firebase_storage.dart';
import 'package:systemrepair/base_utils/base_controllers/app_controller.dart';
import 'package:systemrepair/cores/const/const.dart';
import 'package:systemrepair/modules/profile/controllers/profile_controller.dart';

class ProfileControllerImp extends ProfileController {


  @override
  Future<void> onInit() async {
    accountModel = HIVE_APP.get(AppConst.keyAccount);

    try {
      final storage = FirebaseStorage.instance;
      imgLinkUser.value =  await storage.ref().child('user/${accountModel.imgUser}').getDownloadURL();
    } catch (e) {
      print(e);
    }


    super.onInit();
  }

}