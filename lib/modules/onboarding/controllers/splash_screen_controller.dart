import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_controllers/app_controller.dart';

class SplashScreenController extends GetxController{


  int secondsDelay = 5;


  @override
  void onInit() {
    Get.put(AppController(), permanent: true);
    super.onInit();
  }

}