import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_controllers/base_controller.dart';

import '../../schedule_repair/models/registration_schedule_model.dart';

abstract class OrderController extends BaseGetxController {

  RxInt indexOption = 0.obs;

  List<String> listTitleOption = [
    "Tất cả",
    "Đang chờ",
    "Đã nhận",
    "Hoàn thành",
    "Đã huỷ"
  ];

  List<RegistrationScheduleModel> listRegistrationSchedule = [];


  Future<void> getDataRegistrationSchedule();

  void setIndexOption(int index);

  String getStatus(int index);
}