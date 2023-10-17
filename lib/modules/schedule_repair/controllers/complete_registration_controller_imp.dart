import 'package:firebase_storage/firebase_storage.dart';

import 'complete_registration_controller.dart';

class CompleteRegistrationControllerImp extends CompleteRegistrationController {


  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    final storage = FirebaseStorage.instance;
    imgFixer.value = await storage.ref().child('fixer/${accFixerModel.imgAcc}').getDownloadURL();
    super.onInit();
  }
}