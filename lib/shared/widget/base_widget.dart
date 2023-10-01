
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

  Widget optionCircle({required double width, required double height,required String icon, int? check}) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.09),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
            color: Colors.orange,
            shape: BoxShape.circle
        ),
        child: CircleAvatar(
            backgroundColor: Colors.white,
            child: check ==1 ? SvgPicture.asset(icon,color: const Color(0xff6B46D6),) : SvgPicture.asset(icon)
        )
    );
  }

}
