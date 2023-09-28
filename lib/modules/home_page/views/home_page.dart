import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_widget/base_widget_page.dart';
import 'package:systemrepair/shared/utils/font_ui.dart';

import '../../../cores/const/app_colors.dart';
import '../../../cores/const/const.dart';

class HomePage extends BaseGetWidget {
  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGreyT,
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              viewSearchNotifications(),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15.21,
                    height: 46,
                  ),
                  InkWell(
                    onTap: () {
                      // Get.toNamed("/register_schedule");
                    },
                    child: _viewOption(
                      color: 0xff6B46D6,
                      name: "Đặt lịch thợ sửa",
                      icon: AppConst.repairBook,
                    ),
                  ),
                  const SizedBox(
                    width: 21,
                  ),
                  _viewOption(
                      color: 0xff6DB2DE,
                      name: "Chuyển đồ",
                      icon: AppConst.truckCar)
                ],
              ),
              const SizedBox(
                height: 20.21,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 24,
                  ),
                  _iconNameOption(name: "Thợ sửa", icon: AppConst.listRepair),
                  const SizedBox(
                    width: 37,
                  ),
                  _iconNameOption(
                      name: "Trải nghiệm", icon: AppConst.experience),
                  const SizedBox(
                    width: 37,
                  ),
                  _iconNameOption(
                      name: "Ưu đãi", icon: AppConst.ticketNavi, check: 1),
                  const SizedBox(
                    width: 37,
                  ),
                  _iconNameOption(
                      name: "Thuê xe", icon: AppConst.carBus, check: 1)
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(
                    top: 20.21, right: 13.79, left: 15.21, bottom: 20),
                child: Divider(
                  color: Color(0xff888888),
                ),
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Địa điểm thợ sửa ",
                    style: FontStyleUI.fontPlusJakartaSans().copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff574B78)),
                  ),
                  const Flexible(fit: FlexFit.tight, child: SizedBox()),
                  Text(
                    "Xem thêm ",
                    style: FontStyleUI.fontPlusJakartaSans().copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff574B78)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconNameOption(
      {required String name, required String icon, int? check}) {
    return SizedBox(
      width: 54,
      height: 76,
      child: Column(
        children: [
          optionCircle(width: 54, height: 54, icon: icon, check: check),
          const SizedBox(
            height: 6,
          ),
          Text(
            name,
            style: FontStyleUI.fontPlusJakartaSans().copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: const Color(0xff574B78)),
          )
        ],
      ),
    );
  }

  Widget viewSearchNotifications() {
    return Row(
      children: [
        const SizedBox(
          width: 15.21,
          height: 46,
        ),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          elevation: 1, // Độ nổi bật của thẻ
          color: Colors.white, // Đặt màu nền trắng
          child: SizedBox(
            // color: Colors.white,
            height: 46,
            width: 282,
            child: Row(
              children: [
                const SizedBox(
                  width: 14,
                ),
                SizedBox(
                  height: 24,
                  width: 24,
                  child: SvgPicture.asset(AppConst.search),
                ),
                const SizedBox(
                  width: 11,
                ),
                Text(
                  "Tìm kiếm",
                  style: FontStyleUI.fontPlusJakartaSans().copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff574B78)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 18,
        ),
        optionCircle(
          width: 46,
          height: 46,
          icon: AppConst.notification,
        )
      ],
    );
  }

  Widget optionCircle(
      {required double width,
      required double height,
      required String icon,
      int? check}) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.09),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ], color: Colors.orange, shape: BoxShape.circle),
        child: CircleAvatar(
            backgroundColor: Colors.white,
            child: check == 1
                ? SvgPicture.asset(
                    icon,
                    color: const Color(0xff6B46D6),
                  )
                : SvgPicture.asset(icon)));
  }

  Widget _viewOption(
      {required int color, required String name, required String icon}) {
    return Container(
      width: 166,
      height: 96,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(color),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: SvgPicture.asset(icon),
          ),
          const SizedBox(
            height: 9.25,
          ),
          Text(
            name,
            style: FontStyleUI.fontPlusJakartaSans().copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
