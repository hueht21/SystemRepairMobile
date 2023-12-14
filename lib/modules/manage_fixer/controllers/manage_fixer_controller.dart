import 'package:systemrepair/base_utils/base_controllers/base_controller.dart';
import 'package:systemrepair/modules/login/models/fixer_account_model.dart';

abstract class ManageFixerController extends BaseGetxController {

  List<FixerAccountModel> listFixerAccountModel = [];

  Future<void> getFixerAcc();


}