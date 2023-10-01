part of 'schedule_repair_view.dart';

Widget buildCustomerInformation(ScheduleRepairController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildInputInformation(controller),
      const SizedBox(
        height: 25,
      ),
      _buildWarning()
    ],
  ).paddingSymmetric(horizontal: 10);
}

Widget _buildInputInformation(ScheduleRepairController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Họ và tên",
        style: FontStyleUI.fontPlusJakartaSans().copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.textTim,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      _buildItemInfor(
          controller.textName, "Nguyễn Văn A", AppConst.svgAccount, true),
      const SizedBox(
        height: 10,
      ),
      Text(
        "Số điện thoại",
        style: FontStyleUI.fontPlusJakartaSans().copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.textTim,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      _buildItemInfor(controller.textNumberPhone, "Số điện thoại cần đầy đủ",
          AppConst.phoneSvg, false),
      const SizedBox(
        height: 10,
      ),
      Text(
        "Email",
        style: FontStyleUI.fontPlusJakartaSans().copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.textTim,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      _buildItemInfor(controller.textNumberPhone, "Nhập đúng định dạng Email",
          AppConst.phoneSvg, false),
      const SizedBox(
        height: 10,
      ),
      Text(
        "Địa chỉ",
        style: FontStyleUI.fontPlusJakartaSans().copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.textTim,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      _buildItemInfor(controller.textAddress, "Địa chỉ: Ngõ , Phường, Xã, Quận",
          AppConst.homeSvg, true),
      Container(
        alignment: Alignment.centerLeft,
        child: Text(
          "Lưu ý: Địa chỉ cần nhập đúng để có định vị tốt nhất",
          style: FontStyleUI.fontPlusJakartaSans()
              .copyWith(color: AppColors.textColorXam, fontSize: 13),
        ).paddingOnly(top: 10),
      ),
    ],
  );
}

Widget _buildWarning() {
  return Container(
    height: 80,
    width: Get.width - 20,
    decoration: BoxDecoration(
        color: AppColors.colorCam.withOpacity(0.45),
        borderRadius: BorderRadius.circular(8)),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: SvgPicture.asset(AppConst.iconWarning),
        ),
        Expanded(
          flex: 9,
          child: Center(
            child: AutoSizeText(
              "Yêu cầu nhập đúng thông tin liên hệ, để trống nếu đặt cho chính bạn, thông tin trên để xác nhận đặt lịch với thợ sửa",
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                fontSize: 12,
                color: AppColors.colorXamWarning,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 20),
  );
}

Widget _buildItemInfor(TextEditingController textEditingController,
    String title, String svg, bool isTextInputNumber) {
  return Container(
    width: Get.width,
    height: 40,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: SvgPicture.asset(
            svg,
            color: AppColors.colorIcon,
          ),
        ),
        Expanded(
          flex: 8,
          child: Center(
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors
                          .transparent), // Đặt màu trong suốt cho underline
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors
                          .transparent), // Đặt màu trong suốt cho underline khi focus
                ),
                hintText: title,
                hintStyle: FontStyleUI.fontPlusJakartaSans()
                    .copyWith(color: AppColors.textColorXam88, fontSize: 14),
              ),
              style: FontStyleUI.fontPlusJakartaSans()
                  .copyWith(color: AppColors.textColorXam88, fontSize: 14),
              keyboardType:
                  isTextInputNumber ? TextInputType.text : TextInputType.number,
            ).paddingSymmetric(horizontal: 10),
          ),
        ),
      ],
    ),
  );
}
