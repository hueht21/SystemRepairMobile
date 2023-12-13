import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_controllers/base_refresh_controller.dart';
import 'package:systemrepair/modules/cancel/models/cancel_oder_list_model.dart';
import 'package:systemrepair/modules/cancel/models/cancel_oder_model.dart';
import 'package:systemrepair/modules/oders/models/registration_schedule_model.dart';

abstract class CancelController extends BaseRefreshGetxController {

  RxList<CancelOder> listCancelOder = <CancelOder>[].obs;

  List<RegistrationScheduleModel> listRegistrationSchedule = <RegistrationScheduleModel>[].obs;

  RxList<CancelOderListModel> listCancelOderModel = <CancelOderListModel>[].obs;


}