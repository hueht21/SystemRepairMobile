import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:systemrepair/base_utils/base_controllers/base_controller.dart';
import 'package:systemrepair/modules/register_account/model/account_model.dart';

abstract class UpdateProfileController extends BaseGetxController {
  TextEditingController textEmail = TextEditingController();

  TextEditingController textNumberPhone = TextEditingController();

  TextEditingController textPass = TextEditingController();

  TextEditingController textEnterPassword = TextEditingController();

  TextEditingController textName = TextEditingController();

  TextEditingController textAddress = TextEditingController();

  late AccountModel accountModel;

  RxDouble latitude = 0.0.obs;

  RxDouble longitude = 0.0.obs;

  final picker = ImagePicker();

  Rx<File> image = File("").obs;

  Future<void> searchLocation(String address);

  Future<void> getImageFromGallery();

  String  fileToBase64(File file);

  Future<void> btnConfirm();





}