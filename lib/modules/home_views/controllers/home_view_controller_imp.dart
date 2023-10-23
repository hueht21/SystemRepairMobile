import 'package:systemrepair/cores/const/const.dart';
import 'package:systemrepair/modules/login/models/fixer_account_model.dart';

import '../../../base_utils/base_controllers/app_controller.dart';
import 'home_view_controller.dart';

class HomeViewControllerImp extends HomeViewController {

  @override
  void onInit() {
    // TODO: implement onInit
    FixerAccountModel fixerAccountModel = HIVE_APP.get(AppConst.keyFixerAccount);
    isOperatingStatus.value = fixerAccountModel.status ??  false;
    super.onInit();
  }

}