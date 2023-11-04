import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:systemrepair/base_utils/base_controllers/app_controller.dart';
import 'package:systemrepair/cores/const/const.dart';
import 'package:systemrepair/modules/home_page/controllers/home_page_controller.dart';
import 'package:systemrepair/modules/home_page/models/notification_model.dart';
import 'package:systemrepair/modules/register_account/model/account_model.dart';

import '../response/notification_response.dart';

class HomePageControllerImp extends HomePageController {
  @override
  Future<void> onInit() async {
    listTitleNews = [
      "Sửa bếp từ Cheft",
      "Thay ga điều hoà",
      "Sửa tủ lạnh",
      "Máy lọc nước"
    ];
    listImgNews = [
      AppConst.suaBepTu,
      AppConst.thayGa,
      AppConst.suaTuLanh,
      AppConst.mayLocNuoc,
    ];
    listBanner = [
      AppConst.bannerQuangCao,
      AppConst.bannerGt,
      AppConst.bannerXanh,
      AppConst.bannerSuaGap,
    ];


    AccountModel accountModel = HIVE_APP.get(AppConst.keyAccount);

    String tokenFixer = '';
    await FirebaseMessaging.instance.getToken().then((token) {
      tokenFixer = token ?? "";
    });
    if (accountModel.token != tokenFixer) {
      accountModel.token = tokenFixer;
      final CollectionReference collectionReference = FirebaseFirestore.instance
          .collection('User');
      await collectionReference.where('UID', isEqualTo: accountModel.uid)
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          doc.reference.update(accountModel.toMap());
        }
      });
      await HIVE_APP.put(AppConst.keyAccount, accountModel);
    }
  }

  @override
  void sendMessageToDevice2(String device2Token, String message) async {
    NotificationModel notificationModel = NotificationModel(
        to: "eIb-4-DBRmG9Xl0iVmG7HX:APA91bEObPYB1NP6h1iQYON_4oAl-wOpBXWJvC4dH8R_qwghRAABR_jL0taGQhLE0MJZ_b1ir4msZWxxKqL_wJGxapCiM1xNJX8hvwY6lHmyb8qcDiMXuFmz8GXt9oRkY_kbFvGJucsD",
        notification: Notification(title: "Thong Bao", body: "Noi Dung"));

    NotificationResponse().sentNotification(notificationModel.toJson());
  }
}
