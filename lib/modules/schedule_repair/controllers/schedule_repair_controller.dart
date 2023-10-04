import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:systemrepair/base_utils/base_controllers/base_controller.dart';
import 'package:systemrepair/modules/register_account/model/account_model.dart';

import '../models/fixer_model.dart';

abstract class ScheduleRepairController extends BaseGetxController {

  RxInt indexHead = 0.obs;

  TextEditingController textEmail = TextEditingController();

  TextEditingController textNumberPhone = TextEditingController();

  TextEditingController textName = TextEditingController();

  TextEditingController textAddress = TextEditingController();

  TextEditingController textDescribe = TextEditingController();

  TextEditingController textNote = TextEditingController();

  Rx<DateTime> selectedDate = DateTime.now().obs;

  Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;

  RxString timeSelect = "".obs;

  RxString dateSelect = "".obs;

  late AccountModel accountModel;

  bool isVideo = false;

  final picker = ImagePicker();

  Rx<File> image = File("").obs;

  List<FixerModel> listFixerModel = [];



  void setIndexHead(int index);

  Future<void> selectDate(BuildContext context);

  Future<void> selectTime(BuildContext context);

  Future<void> getImageFromGallery();

  String  fileToBase64(File file);

  Future<void> getDataFixerModel();

}