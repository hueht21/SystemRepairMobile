part of 'schedule_repair_view.dart';

Widget buildConfirmSchedule(ScheduleRepairController controller) {
  return Column(
    children: [
      _buildInforCustomer(
        "Thông tin khách hàng",
        _buildItemInforCustomer(),
      ),
      const SizedBox(
        height: 20,
      ),
      _buildInforCustomer(
        "Thông tin sửa chữa",
        _buildInforScheduleRepair(),
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

Widget _buildItemInforCustomer() {
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
                "Phạm Văn A",
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
                "0368542155",
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
                "phamngochue@gmail.com",
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
                "Số nhà 8 ngõ 111 Triều Khúc Thanh Xuân",
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

Widget _buildInforScheduleRepair() {
  return Container(
    height: 116,
    alignment: Alignment.centerLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Thời gian: 12:04 12/07/2023",
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
          "Mô tả lỗi: hjasdhjashjdasbdasmndasbdnmas dnasd ádhbagdasmbdakn báhdbbsa",
          style: FontStyleUI.fontPlusJakartaSans().copyWith(
            color: AppColors.textColorXam,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "Lưu ý: hjasdhjashjdasbdasmndasbdnmas dnasd ádhbagdasmbdakn báhdbbsa",
          style: FontStyleUI.fontPlusJakartaSans().copyWith(
            color: AppColors.textColorXam,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 10,vertical: 5),
  );
}
