part of 'schedule_repair_view.dart';

Widget buildConfirmSchedule(ScheduleRepairController controller) {
  return Column(
    children: [
      _buildInforCustomer(
        "Thông tin khách hàng",
        _buildItemInforCustomer(controller),
      ),
      const SizedBox(
        height: 20,
      ),
      _buildInforCustomer(
        "Thông tin sửa chữa",
        _buildInforScheduleRepair(controller),
      )
    ],
  );
}

Widget _buildInforCustomer(String title, Widget widget) {
  return Container(
    width: Get.width,
    height: 160,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(8)),
    child: Column(
      children: [
        Container(
          height: 44,
          width: Get.width,
          decoration: const BoxDecoration(
            color: AppColors.colorDate,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: FontStyleUI.fontPlusJakartaSans().copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ).paddingOnly(left: 10),
          ),
        ),
        widget
      ],
    ),
  );
}

Widget _buildItemInforCustomer(ScheduleRepairController controller) {
  return Container(
    height: 116,
    alignment: Alignment.center,
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: SvgPicture.asset(AppConst.iconEverybody),
        ),
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                controller.textName.text.isEmpty
                    ? "${controller.accountModel.nameAccout}"
                    : controller.textName.text,
                style: FontStyleUI.fontPlusJakartaSans().copyWith(
                  color: AppColors.colorTextLogin,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                controller.textNumberPhone.text.isEmpty
                    ? "${controller.accountModel.numberPhone}"
                    : controller.textNumberPhone.text,
                style: FontStyleUI.fontPlusJakartaSans().copyWith(
                  color: AppColors.textColorXam,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                controller.textEmail.text.isEmpty
                    ? controller.accountModel.email
                    : controller.textEmail.text,
                style: FontStyleUI.fontPlusJakartaSans().copyWith(
                  color: AppColors.textColorXam,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                controller.textAddress.text.isEmpty
                    ? controller.accountModel.address
                    : controller.textAddress.text,
                style: FontStyleUI.fontPlusJakartaSans().copyWith(
                  color: AppColors.textColorXam,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget _buildInforScheduleRepair(ScheduleRepairController controller) {
  return Container(
    height: 116,
    alignment: Alignment.centerLeft,
    child: Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Thời gian: ${controller.timeSelect.value} - ${controller.dateSelect.value}",
            style: FontStyleUI.fontPlusJakartaSans().copyWith(
              color: AppColors.textColorXam,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            "Mô tả lỗi: ${controller.textDescribe.text}",
            style: FontStyleUI.fontPlusJakartaSans().copyWith(
              color: AppColors.textColorXam,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "Lưu ý: ${controller.textNote.text}",
            style: FontStyleUI.fontPlusJakartaSans().copyWith(
              color: AppColors.textColorXam,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 10, vertical: 5),
    ),
  );
}
