import 'package:systemrepair/base_utils/base_controllers/base_controller.dart';

abstract class HomePageController extends BaseGetxController {


  List<String> listTitleNews = [];

  List<String> listImgNews = [];

  List<String> listBanner = [];

  void sendMessageToDevice2(String device2Token, String message);





}