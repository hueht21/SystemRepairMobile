import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:systemrepair/base_utils/base_controllers/app_controller.dart';
import 'package:systemrepair/base_utils/base_widget/base_show_notification.dart';
import 'package:systemrepair/cores/const/const.dart';
import 'package:systemrepair/modules/login/controllers/login_controller.dart';
import 'package:systemrepair/modules/register_account/model/account_model.dart';

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
          .collection('User') // Thay 'your_collection_name' bằng tên collection của bạn
          .where("UID", isEqualTo: uid) // UID của tài khoản bạn muốn truy vấn
          .get();

      if (documentSnapshot.docs.isNotEmpty) {
        // Dữ liệu tồn tại, bạn có thể truy cập nó như sau:

        var doc =  documentSnapshot.docs.first;
        AccountModel accountModel = AccountModel.fromJson(doc.data());
        
        HIVE_APP.put(AppConst.keyAccount, "accountModel");

        // AccountModel copy = await HIVE_APP.get(AppConst.keyAccount);
        log(copy.email);
      } else {
        print('Dữ liệu không tồn tại cho UID này.');
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
