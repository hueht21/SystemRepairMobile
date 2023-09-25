import 'package:get/get.dart';
import 'package:systemrepair/main.dart';
import 'package:systemrepair/modules/login/views/login_view.dart';
import 'package:systemrepair/modules/onboarding/views/splash_screen_view.dart';
import 'package:systemrepair/modules/onboarding/views/walktroughs_views.dart';
import 'package:systemrepair/modules/register_account/views/register_account_view.dart';

import '../modules/register_account/views/otp_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SCREEN;
  static const WALKTROUGHS = Routes.WALKTROUGHS;
  static const LOGIN = Routes.LOGIN;
  static const REGISTER = Routes.REGISTER;
  static const OTP = Routes.OTP;

  static final routes = [
    GetPage(
      name: _Paths.SCREEN,
      page: () => SplashScreenView(),
    ),

    GetPage(
      name: _Paths.WALKTROUGHS,
      page: () => WalktroughsViews(),
    ),

    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterAccount(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => OtpView(),
    ),
  ];

}