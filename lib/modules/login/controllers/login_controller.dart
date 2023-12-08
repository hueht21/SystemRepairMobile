import 'package:flutter/cupertino.dart';
import 'package:systemrepair/base_utils/base_controllers/base_controller.dart';

abstract class LoginController extends BaseGetxController {

  TextEditingController textEmail = TextEditingController(text: "dinhhuong2101@gmail.com");

  TextEditingController textPass = TextEditingController(text: "123456");

  Future<void> loginAcc();
}