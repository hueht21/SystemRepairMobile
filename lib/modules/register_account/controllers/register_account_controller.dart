import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_controllers/base_controller.dart';

abstract class RegisterAccountController extends BaseGetxController {

  TextEditingController textEmail = TextEditingController();

  TextEditingController textNumberPhone = TextEditingController();

  TextEditingController textPass = TextEditingController();

  TextEditingController textEnterPassword = TextEditingController();

  TextEditingController textName = TextEditingController();

  TextEditingController textAddress = TextEditingController();

  RxInt indexForm = 0.obs;

  RxDouble latitude = 0.0.obs;

  RxDouble longitude = 0.0.obs;

  Future<void> isCheckEnterPass();

  Future<void> signUp({required String email, required String password});

  Future<void> sendSignInLink(String email);

  Future<void> searchLocation(String address);
}