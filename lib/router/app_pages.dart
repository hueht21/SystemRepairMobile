import 'package:get/get.dart';

import '../modules/home/views/home_view.dart';
import '../modules/login/views/login_view.dart';
import '../modules/onboarding/views/splash_screen_view.dart';
import '../modules/order_detail/views/order_details_views.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.screen;
  static const walkTroughs = Routes.walkTroughs;
  static const login = Routes.login;
  static const register = Routes.register;
  static const otp = Routes.otp;
  static const finishRegister = Routes.finishRegister;
  static const home = Routes.home;
  static const scheduleRepair = Routes.scheduleRepair;
  static const updateProfile = Routes.updateProfile;
  static const orderDetails = Routes.orderDetails;
  static const completeRegistration = Routes.completeRegistration;

  static final routes = [
    GetPage(
      name: _Paths.screen,
      page: () => SplashScreenView(),
    ),

    GetPage(
      name: _Paths.login,
      page: () => LoginView(),
    ),

    GetPage(
      name: _Paths.home,
      page: () => HomeView(),
    ),

    GetPage(
      name: _Paths.orderDetails,
      page: () => OrderDetails(),
    ),

  ];

}