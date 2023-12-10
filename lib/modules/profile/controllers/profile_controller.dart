import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_controllers/base_controller.dart';
import 'package:systemrepair/modules/login/models/fixer_account_model.dart';


class ProfileController extends BaseGetxController {

  late FixerAccountModel fixerModel;

  RxString imgLinkUser = "".obs;

}