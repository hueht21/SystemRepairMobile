import 'package:systemrepair/base_utils/base_controllers/app_controller.dart';
import 'package:systemrepair/cores/const/const.dart';
import 'package:systemrepair/modules/profile/controllers/profile_controller.dart';

class ProfileControllerImp extends ProfileController {


  @override
  void onInit() {
    accountModel = HIVE_APP.get(AppConst.keyAccount);
    super.onInit();
  }

}