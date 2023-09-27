import 'package:flutter/cupertino.dart';
import 'package:systemrepair/base_utils/base_controllers/base_controller.dart';

abstract class LoginController extends BaseGetxController {

  TextEditingController textEmail = TextEditingController();

  TextEditingController textPass = TextEditingController();

  Future<void> loginAcc();
}