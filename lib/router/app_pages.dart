import 'package:get/get.dart';
import 'package:systemrepair/main.dart';
import 'package:systemrepair/modules/onboarding/views/splash_screen_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.SCREEN,
      page: () => SplashScreenView(),
    ),
  ];
}