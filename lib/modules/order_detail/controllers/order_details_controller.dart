import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_controllers/base_controller.dart';

import '../../oders/models/registration_schedule_model.dart';
import '../../pay_order/models/pay_oder_model.dart';



abstract class OderDetailController extends BaseGetxController {

  RxInt indexHead = 0.obs;

  late RegistrationScheduleModel registrationScheduleModel;

  RxString imageUrlFix = ''.obs;

  RxString imageUrlSchedule = ''.obs;

  RxString imageUrlPayOder = ''.obs;

  Rx<PayOderModel> payOderModel = PayOderModel(amount: 0, createDate: '', idOder: '', uidCustomer: '', uidFixer: '', imgPay: '').obs;


  Future<void> cancelOrderBtn();

  Future<void> cancelOrder();

  Future<void> insertCancel(String reason);

  Future<void> confirmStatus();

  Future<void> confirmPayOder();

  bool isCancelOder();



}