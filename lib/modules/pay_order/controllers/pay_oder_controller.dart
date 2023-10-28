import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:systemrepair/base_utils/base_controllers/base_controller.dart';

import '../../oders/models/registration_schedule_model.dart';

abstract class PayOderController extends BaseGetxController {

  TextEditingController textTotalOder = TextEditingController();

  FocusNode priceFocus = FocusNode();

  RxString total = "0".obs;

  RxString amount = "0".obs;

  late RegistrationScheduleModel registrationScheduleModel;

  final picker = ImagePicker();

  Rx<File> image = File("").obs;


  Future<void> payOder();

  Future<void> getImageFromGallery();

// KeyboardActionsConfig buildConfig();
}