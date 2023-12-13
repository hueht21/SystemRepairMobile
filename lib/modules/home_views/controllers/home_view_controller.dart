import 'package:get/get.dart';
import 'package:systemrepair/modules/pay_order/models/pay_oder_model.dart';

import '../../../base_utils/base_controllers/base_controller.dart';
import '../../oders/models/registration_schedule_model.dart';
import '../views/sales_data_view.dart';

abstract class HomeViewController extends BaseGetxController {

  RxBool isOperatingStatus =  false.obs;

  List<RegistrationScheduleModel> listDataSchedule = [];

  List<PayOderModel> listPayModel = [];

  List<MonthMoney> charGetData = [];

  List<SalesData> salesData = [];

  int numberFinish = 0;

  int numberWaiting = 0;

  int numberConfirmedStatus = 0;

  int numberCanceledStatus = 0;

  Map<int, int> mapAmount = <int, int>{};

  Future<void> getDataStatistical();

  Future<void> setStatus();


}