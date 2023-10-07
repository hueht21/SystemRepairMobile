import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_controllers/base_controller.dart';

abstract class OrderController extends BaseGetxController {

  RxInt indexOption = 0.obs;

  List<String> listTitleOption = [
    "Tất cả",
    "Đang chờ",
    "Đã nhận",
    "Hoàn thành",
    "Đã huỷ"
  ];




  void setIndexOption(int index);
}