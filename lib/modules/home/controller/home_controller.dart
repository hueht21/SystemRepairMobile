import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_controllers/base_controller.dart';
import 'package:systemrepair/firebase/firebase_init.dart';

abstract class HomeController extends BaseGetxController {

  RxInt selectIndex = 0.obs;

  void setIndex(int index);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

}