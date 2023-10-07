import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_widget/base_widget_page.dart';
import 'package:systemrepair/modules/home/controller/home_controller.dart';
import 'package:systemrepair/modules/home/controller/home_controller_imp.dart';
import 'package:systemrepair/modules/home_page/views/home_page.dart';
import 'package:systemrepair/modules/profile/views/profile_view.dart';

import '../../../cores/const/const.dart';
import '../../orders/views/oders_view.dart';

class HomeView extends BaseGetWidget {
  @override
  HomeController controller = Get.put(HomeControllerImp());

  @override
  Widget buildWidgets(BuildContext context) {
    final Facment = [HomePage(), OdersView(), HomePage(), ProfileView()];
    return Obx(()
      => Scaffold(
        body: SafeArea(
          child: Facment[controller.selectIndex.value],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            _bottomNavi(
              AppConst.homeSvg,
              "Trang chủ",
              controller.selectIndex.value == 0
                  ? const Color(0xff6B46D6)
                  : const Color(0xff888888),
            ),
            _bottomNavi(
              AppConst.oderSvg,
              "Đơn đặt",
              controller.selectIndex.value == 1
                  ? const Color(0xff6B46D6)
                  : const Color(0xff888888),
            ),
            _bottomNavi(
              AppConst.ticketNavi,
              "Vouchers",
              controller.selectIndex.value == 2
                  ? const Color(0xff6B46D6)
                  : const Color(0xff888888),
            ),
            _bottomNavi(
              AppConst.userSvg,
              "Cá nhân",
              controller.selectIndex.value == 3
                  ? const Color(0xff6B46D6)
                  : const Color(0xff888888),
            )
          ],
          unselectedItemColor: const Color(0xff888888),
          selectedLabelStyle: const TextStyle(fontSize: 12),
          currentIndex: controller.selectIndex.value,
          selectedItemColor: const Color(0xff6B46D6),
          onTap: controller.setIndex,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  _bottomNavi(String icon, String label, Color color) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: SvgPicture.asset(
          icon,
          color: color,
        ),
      ),
      label: label,
    );
  }
}
