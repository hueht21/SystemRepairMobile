part of 'schedule_repair_view.dart';

Widget buildInformationCorrupted(ScheduleRepairController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(
        height: 10,
      ),
      Text(
        "Thời gian",
        style: FontStyleUI.fontPlusJakartaSans().copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.textTim,
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () async {
                await controller.selectTime(Get.context!);
              },
              child: _buildCardTime("Thời gian", controller.timeSelect.value),
            ),
            const SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () async {
                await controller.selectDate(Get.context!);
              },
              child: _buildCardTime("Ngày đặt", controller.dateSelect.value),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      buildFormNote(controller.textDescribe, "Mô tả", "Mô tả tình trạng hỏng"),
      const SizedBox(
        height: 20,
      ),
      buildFormNote(controller.textNote, "Ghi chú", "Những yêu cầu khi đặt lịch"),
      const SizedBox(
        height: 20,
      ),
      _buildSelectImg(controller)
    ],
  );
}

Widget _buildCardTime(String title, String valueDate) {
  return Container(
    width: 160,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(15),
        bottomRight: Radius.circular(15),
      ),
    ),
    child: Column(
      children: [
        Container(
          width: 160,
          height: 34,
          decoration: const BoxDecoration(
            color: AppColors.textTitleColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppConst.iconDate),
              const SizedBox(
                width: 15,
              ),
              Text(
                title,
                style: FontStyleUI.fontPlusJakartaSans().copyWith(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 48,
          width: 160,
          child: Center(
            child: Text(
              valueDate,
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                color: AppColors.colorDate,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget buildFormNote(TextEditingController textEditingController, String title, String textHide) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(
        height: 10,
      ),
      Text(
        title,
        style: FontStyleUI.fontPlusJakartaSans().copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.textTim,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      _buildItemInforNote(
        textEditingController,
        textHide,
      ),
    ],
  );
}

Widget _buildItemInforNote(
    TextEditingController textEditingController, String title) {
  return Container(
    width: Get.width,
    height: 120,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Center(
      child: TextField(
        maxLines: 5,
        controller: textEditingController,
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.transparent), // Đặt màu trong suốt cho underline
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
        keyboardType: TextInputType.text,
      ).paddingSymmetric(horizontal: 20),
    ),
  );
}

Widget _buildSelectImg(ScheduleRepairController controller) {
  return Obx(
    () => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Các hình ảnh miêu tả tình trạng lỗi",
          style: FontStyleUI.fontPlusJakartaSans().copyWith(
              color: AppColors.textTim,
              fontWeight: FontWeight.w700,
              fontSize: 14),
        ),
        const SizedBox(
          height: 20,
        ),
        controller.image.value.path.isNotEmpty
            ? Image.file(
                controller.image.value,
                fit: BoxFit.cover,
              ).paddingOnly(bottom: 20)
            : const SizedBox(),

        /// Convert BASE64 to IMg
        // controller.linkImg.value.isNotEmpty
        //     ? Image.memory(
        //   base64Decode( controller.linkImg.value),
        //   fit: BoxFit.cover,
        // ).paddingOnly(bottom: 20)
        //     : const SizedBox(),
        ///
        InkWell(
          onTap: () async {
            await controller.getImageFromGallery();
          },
          child: Container(
            width: 160,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.colorDate, // Màu đường viền bạn muốn sử dụng
                width: 1.0, // Độ rộng của đường viền
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(AppConst.iconCamera),
                Text(
                  "Tải hình ảnh lên",
                  style: FontStyleUI.fontPlusJakartaSans().copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.colorDate,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}
