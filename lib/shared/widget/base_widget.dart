
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseWidget {
  static DateTime? _dateTime;
  static int _oldFunc = 0;

  static const Widget sizedBox10 = const SizedBox(height: 10);
  static const Widget sizedBox5 = const SizedBox(height: 5);

  /// Sử dụng để tránh trường hợp click liên tiếp khi thực hiện function
  static Widget baseOnAction({
    required Function onTap,
    required Widget child,
  }) {
    return GestureDetector(
      onTap: () {
        DateTime now = DateTime.now();
        if (_dateTime == null ||
            now.difference(_dateTime ?? DateTime.now()) > 1.seconds ||
            onTap.hashCode != _oldFunc) {
          _dateTime = now;
          _oldFunc = onTap.hashCode;
          onTap();
        }
      },
      child: child,
    );
  }

}
