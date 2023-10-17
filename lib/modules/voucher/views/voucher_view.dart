import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:systemrepair/shared/utils/font_ui.dart';

import '../../../base_utils/base_widget/base_widget_page.dart';
import '../controllers/voucher_controller.dart';
import '../controllers/voucher_controller_imp.dart';

class VoucherView extends BaseGetWidget {
  @override
  VoucherController get controller => Get.put(VoucherControllerImp());

  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Vouchers",
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff574B78)),
            ),
            Row(
              children: [
                const SizedBox(width: 30),
                _filterItem(title: "Vouchers mới", index: 0),
                const Flexible(fit: FlexFit.tight, child: SizedBox()),
                _filterItem(title: "Vouchers của tôi", index: 1),
                const SizedBox(
                  width: 30,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            vouchersUser()
          ],
        ),
      ),
    );
  }

  Widget _filterItem({required String title, required int index}) {
    // bool isActive = index ==
    //     controller.checkIndex.value; // nếu bằng thì trả về true
    return GestureDetector(
      // click
      onTap: () => controller.setIndex(index),
      child: Obx(
        () => Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: index == controller.checkIndex.value
                          ? const Color(0xff6B46D6)
                          : const Color(0xff888888),
                      width: 2))),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            title,
            style: index == controller.checkIndex.value
                ? FontStyleUI.fontPlusJakartaSans().copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: index == controller.checkIndex.value
                        ? const Color(0xff6B46D6)
                        : const Color(0xff888888))
                : FontStyleUI.fontPlusJakartaSans().copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: index == controller.checkIndex.value
                        ? const Color(0xff6B46D6)
                        : const Color(0xff888888)),
          ),
        ),
      ),
    );
  }

  Widget vouchersUser() {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Center(
          child: Text(
            "Bạn chưa có Vouchers nào",
            style: FontStyleUI.fontPlusJakartaSans().copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: const Color(0xff888888)),
          ),
        ),
      ],
    );
  }
}
