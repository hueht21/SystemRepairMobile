import 'package:get/get.dart';
import 'package:hive/hive.dart';


late Box HIVE_APP;
class AppController extends GetxController {

  RxBool isLogin = false.obs;

  @override
  Future<void> onInit() async {
    HIVE_APP = await Hive.openBox("hive_app");
    super.onInit();
  }
}