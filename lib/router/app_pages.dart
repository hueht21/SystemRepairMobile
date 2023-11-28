import 'package:get/get.dart';
import 'package:systemrepair/main.dart';
import 'package:systemrepair/modules/home/views/home_view.dart';
import 'package:systemrepair/modules/login/views/login_view.dart';
import 'package:systemrepair/modules/onboarding/views/splash_screen_view.dart';
import 'package:systemrepair/modules/onboarding/views/walktroughs_views.dart';
import 'package:systemrepair/modules/register_account/views/finish_regiter_view.dart';
import 'package:systemrepair/modules/register_account/views/register_account_view.dart';

import '../modules/ order_details/views/order_details_views.dart';
import '../modules/fixer_map/views/fixer_map_view.dart';
import '../modules/notifications/views/notification_views.dart';
import '../modules/register_account/views/otp_view.dart';
import '../modules/schedule_repair/views/complete_registration_view.dart';
import '../modules/schedule_repair/views/schedule_repair_view.dart';
import '../modules/update_profile/views/update_profile_view.dart';
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
  static const notificationPage = Routes.notificationPage;
  static const fixerMapPage = Routes.fixerMapPage;

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
    GetPage(
      name: _Paths.home,
      page: () => HomeView(),
    ),
    GetPage(
      name: _Paths.scheduleRepair,
      page: () => ScheduleRepair(),
    ),
    GetPage(
      name: _Paths.updateProfile,
      page: () => UpdateProfile(),
    ),
    GetPage(
      name: _Paths.orderDetails,
      page: () => OrderDetails(),
    ),
    GetPage(
      name: _Paths.completeRegistration,
      page: () => CompleteRegistration(),
    ),
    GetPage(
      name: _Paths.notificationPage,
      page: () => const NotificationView(),
    ),
    GetPage(
      name: _Paths.fixerMapPage,
      page: () => FixerMapView(),
    ),
  ];

}