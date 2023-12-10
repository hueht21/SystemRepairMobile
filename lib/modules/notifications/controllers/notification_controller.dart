import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_controllers/base_controller.dart';
import 'package:systemrepair/base_utils/base_controllers/base_refresh_controller.dart';

import '../models/notification_get_model.dart';

abstract class NotificationController extends BaseRefreshGetxController {

  RxList<NotificationGetModel> listNotificationModel = <NotificationGetModel>[].obs;

  Future<void> getDataNotification();

}