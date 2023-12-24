import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_controllers/base_controller.dart';

class PayController extends BaseGetxController {
  RxString imageUrlPayOder = ''.obs;


  @override
  Future<void> onInit() async {
    showLoading();
    await getImgPay();
    hideLoading();

    super.onInit();
  }

  Future<void> getImgPay() async {
    try{
      final storage = FirebaseStorage.instance;
      imageUrlPayOder.value = await storage
          .ref()
          .child('pay/hoadon01.jpg')
          .getDownloadURL();
    }catch(e) {
      print(e);
    }

  }
}