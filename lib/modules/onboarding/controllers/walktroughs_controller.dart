import 'package:get/get.dart';
import 'package:systemrepair/base_utils/base_controllers/base_controller.dart';

import '../../../cores/const/const.dart';

class WalkTroughsController extends BaseGetxController {
  RxInt indexView = 0.obs;

  List<String> listTextTitle = [
    "Đặt lịch thợ sửa điện lạnh nhanh chóng.",
    "Tận hưởng các dịch vụ với các tính năng đặc biệt",
    "Hỗ trợ đặc biệt cho người mới"
  ];

  List<String> listImgWalkTroughs = [];

  void setUpIndex() {
    if (indexView.value != 2) {
      indexView++;
    }
  }

  String getTitle(int index) {
    return listTextTitle[index];
  }

  String getImgWalkTroughs(int index) {
    return listImgWalkTroughs[index];
  }



  @override
  void onInit() {
    // TODO: implement onInit
    listImgWalkTroughs = [
      AppConst.imgWalkTroughs,
      AppConst.imgWalkTroughs2,
      AppConst.imgWalkTroughs3,
    ];
    super.onInit();
  }
}
