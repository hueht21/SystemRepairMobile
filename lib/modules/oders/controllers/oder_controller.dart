import 'package:get/get.dart';
import '../models/registration_schedule_model.dart';

abstract class OrderController extends BaseRefreshGetxController {

  RxInt indexOption = 0.obs;

  List<String> listTitleOption = [
    "Tất cả",
    "Đang chờ",
    "Đã nhận",
    "Hoàn thành",
    "Đã huỷ"
  ];

  RxList<RegistrationScheduleModel> listRegistrationSchedule = <RegistrationScheduleModel>[].obs;
  List<RegistrationScheduleModel> listRegistrationScheduleSearch = [];


  Future<void> getDataRegistrationSchedule();

  void setIndexOption(int index);

  String getStatus(int index);

  void optionType(int indexType);
}