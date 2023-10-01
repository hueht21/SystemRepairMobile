import 'package:flutter/cupertino.dart';
import 'package:systemrepair/base_utils/base_controllers/base_controller.dart';

abstract class LoginController extends BaseGetxController {

  TextEditingController textEmail = TextEditingController(text: "phamngochue1207@gmail.com");

  TextEditingController textPass = TextEditingController(text: "1234567");

  Future<void> loginAcc();
}