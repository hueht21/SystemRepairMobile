import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:systemrepair/modules/schedule_repair/controllers/schedule_repair_controller.dart';

class ScheduleRepairControllerImp extends ScheduleRepairController {
  @override
  void setIndexHead(int index) {
    indexHead.value = index;
  }

  @override
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    selectedDate.value = picked ?? DateTime.now();
  }

  @override
  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
    );
    selectedTime.value = picked ?? TimeOfDay.now();
  }

  @override
  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Đã chọn ảnh, bạn có thể làm gì đó với nó ở đây
      // Ví dụ: hiển thị nó trên màn hình
      image.value = File(pickedFile.path);
      // linkImg.value = fileToBase64(image.value);
    }
  }

  @override
  String fileToBase64(File file) {
    List<int> imageBytes = file.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }
}
