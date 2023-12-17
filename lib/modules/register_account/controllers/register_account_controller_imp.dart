import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import 'package:systemrepair/base_utils/base_widget/base_show_notification.dart';
import 'package:systemrepair/modules/register_account/controllers/register_account_controller.dart';
import 'package:systemrepair/modules/register_account/model/account_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:systemrepair/router/app_pages.dart';


class RegisterAccountControllerImp extends RegisterAccountController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  Future<void> sendSignInLink(String email) async {
    final actionCode = ActionCodeSettings(
        // Thiết lập URL chuyển hướng sau khi xác minh
        url: 'https://cudevnb.page.link/R6GT?email=$email',
        // Thay thế bằng URL của ứng dụng của bạn
        handleCodeInApp: true,
        // Mở ứng dụng để xác minh mã code
        androidPackageName: "com.cudevnb.systemrepair");
    await FirebaseAuth.instance
        .sendSignInLinkToEmail(email: email, actionCodeSettings: actionCode)
        .catchError(
            (onError) => print('Error sending email verification $onError'))
        .then((value) => print('Successfully sent email verification'));
  }

  @override
  Future<void> signUp({required String email, required String password}) async {

    if(isValidate()){
      try {
        final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        User? user = credential.user;
        if (user != null) {
          // sendVerificationEmail(user);
          await searchLocation(textAddress.text);

          CollectionReference users =
          FirebaseFirestore.instance.collection('User');

          AccountModel accountModel = AccountModel(
              auth: 0,
              latitude: latitude.value,
              longitude: longitude.value,
              nameAccout: textName.text.trim(),
              numberPhone: textNumberPhone.text.trim(),
              uid: user.uid,
              email: textEmail.text.trim(),
              address: textAddress.text.trim(),
              imgUser: "",
              token: ""
          );

          try {
            await users.add(accountModel.toMap());
          } catch (e) {
            BaseShowNotification.showNotification(
              Get.context!,
              'Lỗi khi thêm dữ liệu vào Firestore: $e',
              QuickAlertType.error,
            );
          }
          // Get.back();
          Get.toNamed(AppPages.finishRegister);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          BaseShowNotification.showNotification(
            Get.context!,
            "Mật khẩu được cung cấp quá yếu.",
            QuickAlertType.error,
          );
        } else if (e.code == 'email-already-in-use') {
          BaseShowNotification.showNotification(
            Get.context!,
            "Tài khoản đã tồn tại ",
            QuickAlertType.error,
          );
          print('The account already exists for that email.');
        }
      }
    }else{
      BaseShowNotification.showNotification(
        Get.context!,
        "Định dạng email số điện thoại không hợp lệ",
        QuickAlertType.error,
      );
    }

  }

  bool isValidate() {
    if(isValidEmail(textEmail.text) && textNumberPhone.text.length <= 11){
      return true;
    }else {
      return false;
    }
  }

  bool isValidEmail(String email) {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }


  @override
  Future<void> searchLocation(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        latitude.value = locations[0].latitude;
        longitude.value = locations[0].longitude;
      } else {
        latitude.value = 0.0;
        longitude.value = 0.0;
      }
    } catch (e) {
      BaseShowNotification.showNotification(
        Get.context!,
        "Không lấy được vị trí $e",
        QuickAlertType.error,
      );
    }
  }

  Future<void> sendVerificationEmail(User user) async {
    await user.sendEmailVerification();
  }

  Future<void> verifyEmailWithCode(String code) async {
    try {
      await FirebaseAuth.instance.applyActionCode(code);
      // Xác thực thành công, tài khoản đã được xác minh

      // Đăng ký tài khoản
      // signUpWithEmailAndPassword('user@example.com', 'password123');

// Xác thực tài khoản sau khi nhận email
//       verifyEmailWithCode('mã_code_từ_email');
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Lỗi: $e');
    }
  }

  @override
  Future<void> isCheckEnterPass() async {
    if(checkNotNullText()) {
      FocusScope.of(Get.context!).requestFocus(FocusNode()); // Ẩn bàn phím
      if (textPass.text != textEnterPassword.text) {
        BaseShowNotification.showNotification(
          Get.context!,
          "Mật khẩu nhập không trùng nhau",
          QuickAlertType.error,
        );
      } else {
        if(textEnterPassword.text.length >= 6 && textPass.text.length >= 6){
          await signUp(
            email: textEmail.text.trim(),
            password: textPass.text.trim(),
          );
        }else {
          BaseShowNotification.showNotification(
            Get.context!,
            "Mật khẩu phải lớn hơn 6 ký tự",
            QuickAlertType.error,
          );
        }

      }
    } else {
      BaseShowNotification.showNotification(
        Get.context!,
        "Dữ liệu cần đầy đủ",
        QuickAlertType.error,
      );
    }

  }

  @override
  bool checkNotNullText() {
    if (textEmail.text.isEmpty ||
        textPass.text.isEmpty ||
        textEnterPassword.text.isEmpty ||
        textNumberPhone.text.isEmpty ||
        textName.text.isEmpty) return false;
    return true;
  }
}
