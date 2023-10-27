import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_controllers/base_controller.dart';

import '../../oders/models/registration_schedule_model.dart';


abstract class OderDetailController extends BaseGetxController {

  RxInt indexHead = 0.obs;

  late RegistrationScheduleModel registrationScheduleModel;

  RxString imageUrlFix = ''.obs;

  RxString imageUrlSchedule = ''.obs;


  Future<void> cancelOrderBtn();

  Future<void> cancelOrder();

  Future<void> insertCancel(String reason);

  Future<void> confirmStatus();

  bool isCancelOder();



}