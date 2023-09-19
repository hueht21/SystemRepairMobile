import 'package:get/get.dart';
import 'package:systemrepair/main.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const MyApp(),
    ),
  ];
}