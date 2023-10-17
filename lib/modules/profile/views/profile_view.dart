import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_widget/base_widget_page.dart';
import 'package:systemrepair/cores/const/const.dart';
import 'package:systemrepair/modules/profile/controllers/profile_controller.dart';
import 'package:systemrepair/modules/profile/controllers/profile_controller_imp.dart';
import 'package:systemrepair/shared/utils/font_ui.dart';
import 'package:systemrepair/shared/widget/base_widget.dart';

import '../../../router/app_pages.dart';

class ProfileView extends BaseGetWidget {
  @override
  ProfileController controller = Get.put(ProfileControllerImp());

  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          systemNavigationBarColor: Color.fromRGBO(143, 148, 251, 1),
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: const Color(0xffF4F4F4),
              width: MediaQuery.of(context).size.width,
              height: Get.height,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Positioned(child: Image.asset(AppConst.backgroundUser)),
                      Positioned(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40, left: 15),
                          child: Row(
                            children: [
                              Container(
                                width: 285,
                                height: 45,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40)),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 14,
                                    ),
                                    SvgPicture.asset(
                                      AppConst.searchUser,
                                      color: const Color(0xff574B78),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      "Tìm kiếm gì đó ...",
                                      style: FontStyleUI.fontPlusJakartaSans()
                                          .copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff888888),
                                      ),
                                    ),
                                    const Flexible(
                                        fit: FlexFit.tight, child: SizedBox()),
                                    SvgPicture.asset(
                                      AppConst.sortUser,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(
                                      width: 11,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: BaseWidget().optionCircle(
                                  width: 44,
                                  height: 44,
                                  icon: AppConst.messengerUser,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 150),
                          child: Column(
                            children: [
                              Center(
                                child: Obx(
                                  () => SizedBox(
                                    width: 106,
                                    height: 106,
                                    child: controller.imgLinkUser.isEmpty
                                        ? Image.asset(AppConst.userUser)
                                        : ClipOval(
                                          child: CachedNetworkImage(
                                            width: 106, // Điều chỉnh kích thước theo ý muốn
                                            height: 106, // Điều chỉnh kích thước theo ý muốn
                                            fit: BoxFit.cover, // Điều chỉnh cách ảnh sẽ hiển thị
                                              imageUrl:
                                                  controller.imgLinkUser.value,
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                        ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 11,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.accountModel.nameAccout ?? "",
                                    style: FontStyleUI.fontNunito(),
                                  ),
                                  const SizedBox(
                                    width: 5.3,
                                  ),
                                  SvgPicture.asset(AppConst.editName)
                                ],
                              ),
                              Text(
                                controller.accountModel.email,
                                style: FontStyleUI.fontNunito().copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 380),
                          child: Center(
                            child: _panerOption(
                                icon1: AppConst.userSvg,
                                name1: "Thông tin cá nhân",
                                icon2: AppConst.payUser,
                                name2: "Thanh toán",
                                functionHeader: () {
                                  Get.toNamed(AppPages.updateProfile);
                                },
                                functionBottom: () {}),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _panerOption(
                    icon1: AppConst.setting,
                    name1: "Cài đặt",
                    icon2: AppConst.help,
                    name2: "Trợ giúp",
                    icon4: AppConst.logout,
                    name4: "Đăng xuất",
                    functionHeader: () {
                      // Get.offAllNamed(AppPages.login);
                    },
                    functionBottom: () {
                      Get.offAllNamed(AppPages.login);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _panerOption({
    required String icon1,
    required String name1,
    required String icon2,
    required String name2,
    required Function functionHeader,
    required Function functionBottom,
    String? icon4,
    String? name4,
  }) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: 346,
        height: icon4 != null ? 172 : 112,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                functionHeader();
              },
              child: itemOption(
                icon: icon1,
                name: name1,
              ),
            ),
            const Divider(
              color: Color(0xffF3F3F9),
            ),
            itemOption(
              icon: icon2,
              name: name2,
            ),
            if (icon4 != null)
              const Divider(
                color: Color(0xffF3F3F9),
              ),
            if (icon4 != null)
              InkWell(
                onTap: () {
                  functionBottom();
                },
                child: itemOption(
                  icon: icon4,
                  name: name4!,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget itemOption({required String icon, required String name}) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          const SizedBox(
            width: 18,
          ),
          SvgPicture.asset(
            icon,
            width: 20,
            height: 20,
            color: const Color(0xff574B78),
          ),
          const SizedBox(
            width: 19,
          ),
          Text(
            name,
            style: FontStyleUI.fontPlusJakartaSans().copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xff574B78)),
          ),
          const Flexible(fit: FlexFit.tight, child: SizedBox()),
          SvgPicture.asset(AppConst.nextUser),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
    );
  }
}
