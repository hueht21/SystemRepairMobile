import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_controllers/base_controller.dart';
import 'package:systemrepair/modules/schedule_repair/models/fixer_model.dart';

abstract class CompleteRegistrationController extends BaseGetxController {

  FixerModel accFixerModel = Get.arguments;

  RxString imgFixer = "".obs;


}