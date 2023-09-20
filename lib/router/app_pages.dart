import 'package:get/get.dart';
import 'package:systemrepair/main.dart';
import 'package:systemrepair/modules/onboarding/views/splash_screen_view.dart';
import 'package:systemrepair/modules/onboarding/views/walktroughs_views.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SCREEN;
  static const WALKTROUGHS = Routes.SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.SCREEN,
      page: () => SplashScreenView(),
    ),

    GetPage(
      name: _Paths.WALKTROUGHS,
      page: () => const WalktroughsViews(),
    ),
  ];

}