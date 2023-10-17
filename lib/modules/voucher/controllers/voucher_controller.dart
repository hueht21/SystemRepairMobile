import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_controllers/base_controller.dart';

abstract class VoucherController extends BaseGetxController {
  RxInt checkIndex = 0.obs;
  void setIndex(int index);
}