import 'package:get/get.dart';
import 'package:systemrepair/modules/notifications/controllers/notification_controller.dart';

import 'home_controller.dart';

class HomeControllerImp extends HomeController {
  @override
  void setIndex(int index) {
    selectIndex.value = index;
    if(selectIndex.value == 2){
      if (Get.isRegistered<NotificationController>()) {
        NotificationController notificationController = Get.find<NotificationController>();
        notificationController.getDataNotification();
      }
    }
  }

}