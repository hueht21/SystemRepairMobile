import 'package:get/get.dart';
import 'package:systemrepair/main.dart';
import 'package:systemrepair/modules/login/views/login_view.dart';
import 'package:systemrepair/modules/onboarding/views/splash_screen_view.dart';
import 'package:systemrepair/modules/onboarding/views/walktroughs_views.dart';
import 'package:systemrepair/modules/register_account/views/finish_regiter_view.dart';
import 'package:systemrepair/modules/register_account/views/register_account_view.dart';

import '../modules/register_account/views/otp_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.screen;
  static const walkTroughs = Routes.walkTroughs;
  static const login = Routes.login;
  static const register = Routes.register;
  static const otp = Routes.otp;
  static const finishRegister = Routes.finishRegister;

  static final routes = [
    GetPage(
      name: _Paths.screen,
      page: () => SplashScreenView(),
    ),

    GetPage(
      name: _Paths.walkTroughs,
      page: () => WalktroughsViews(),
    ),

    GetPage(
      name: _Paths.login,
      page: () => LoginView(),
    ),
    GetPage(
      name: _Paths.register,
      page: () => RegisterAccount(),
    ),
    GetPage(
      name: _Paths.otp,
      page: () => OtpView(),
    ),
    GetPage(
      name: _Paths.finishRegister,
      page: () => FinishRegiter(),
    ),
  ];

}