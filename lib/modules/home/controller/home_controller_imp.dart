import 'package:systemrepair/modules/home/controller/home_controller.dart';

class HomeControllerImp extends HomeController {
  @override
  void setIndex(int index) {
    selectIndex.value = index;
  }
  
}