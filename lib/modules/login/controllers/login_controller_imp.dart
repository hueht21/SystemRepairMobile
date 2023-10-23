import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:systemrepair/base_utils/base_controllers/app_controller.dart';
import 'package:systemrepair/cores/const/const.dart';
import 'package:systemrepair/modules/login/controllers/login_controller.dart';
import 'package:systemrepair/modules/login/models/fixer_account_model.dart';
import 'package:systemrepair/router/app_pages.dart';

import '../../../base_utils/base_widget/base_show_notification.dart';
import '../models/account_model.dart';

class LoginControllerImp extends LoginController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  Future<void> loginAcc() async {
    if(checkTextNotNull()){
      showLoading();
      User? user = await loginUsingEmailPasss(
        email: textEmail.text.trim(),
        pass: textPass.text.trim(),
      );
      if (user != null) {

        await getData(user.uid);


      } else {
        BaseShowNotification.showNotification(
          Get.context!,
          "Sai thông tin mật khẩu",
          QuickAlertType.error,
        );
      }
      hideLoading();
    } else {
      BaseShowNotification.showNotification(
        Get.context!,
        "Tên đăng nhập hoặc mật khẩu không được để trống",
        QuickAlertType.error,
      );
    }

  }

  Future<void> getData(String uid) async {
    try {
      final documentSnapshot = await FirebaseFirestore.instance
          .collection('Fixer') // Thay 'your_collection_name' bằng tên collection của bạn
          .where("UID", isEqualTo: uid) // UID của tài khoản bạn muốn truy vấn
          .get();

      if (documentSnapshot.docs.isNotEmpty) {
        var doc =  documentSnapshot.docs.first;
        FixerAccountModel fixerAccountModel = FixerAccountModel.fromJson(doc.data());

        await HIVE_APP.put(AppConst.keyFixerAccount, fixerAccountModel);


        Get.offAllNamed(AppPages.home);
        log('Thành công ${fixerAccountModel.name}');

      } else {
        log('Dữ liệu không tồn tại cho UID này.');
        BaseShowNotification.showNotification(
          Get.context!,
          "Dữ liệu không tồn tại cho UID này.",
          QuickAlertType.error,
        );
      }
    } catch (e) {
      BaseShowNotification.showNotification(
        Get.context!,
        "Lỗi khi truy cập dữ liệu: $e",
        QuickAlertType.error,
      );
      log('Lỗi khi truy cập dữ liệu: $e');
    }
  }

  bool checkTextNotNull() {
    if(textEmail.text.isEmpty || textPass.text.isEmpty) return false;
    return true;
  }

  Future<User?> loginUsingEmailPasss(
      {required String email, required String pass}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential =
      await auth.signInWithEmailAndPassword(email: email, password: pass);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("Khong tim thay email");
      }
    }
    //final uid = user.uid;
    return user;
  }
}