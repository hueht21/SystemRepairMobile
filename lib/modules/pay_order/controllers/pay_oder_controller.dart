import 'package:flutter/cupertino.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:systemrepair/base_utils/base_controllers/base_controller.dart';

abstract class PayOderController extends BaseGetxController {

  TextEditingController textTotalOder = TextEditingController();

  FocusNode priceFocus = FocusNode();


  // KeyboardActionsConfig buildConfig();
}