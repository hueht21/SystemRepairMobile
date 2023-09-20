import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:systemrepair/base_utils/repository_base/base_request.dart';


late Box HIVE_APP;
class AppController extends GetxController {

  RxBool isLogin = false.obs;

  @override
  Future<void> onInit() async {

    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    HIVE_APP = await Hive.openBox("hive_app");
    Get.put(BaseRequest(), permanent: true);
    super.onInit();
  }
}