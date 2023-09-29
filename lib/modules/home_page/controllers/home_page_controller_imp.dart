import 'package:systemrepair/cores/const/const.dart';
import 'package:systemrepair/modules/home_page/controllers/home_page_controller.dart';

class HomePageControllerImp extends HomePageController{

  @override
  void onInit() {
    listTitleNews = ["Sửa bếp từ Cheft", "Thay ga điều hoà", "Sửa tủ lạnh", "Máy lọc nước"];
    listImgNews = [AppConst.suaBepTu,AppConst.thayGa, AppConst.suaTuLanh,AppConst.mayLocNuoc,];
    listBanner = [AppConst.suaBepTu,AppConst.thayGa, AppConst.suaTuLanh,AppConst.mayLocNuoc,];
  }

}