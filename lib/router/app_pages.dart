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

  // static const initial = Routes.screen;
  // static const walkTroughs = Routes.walkTroughs;
  // static const login = Routes.login;
  // static const register = Routes.register;
  // static const otp = Routes.otp;
  // static const finishRegister = Routes.finishRegister;
  // static const home = Routes.home;
  // static const scheduleRepair = Routes.scheduleRepair;
  // static const updateProfile = Routes.updateProfile;
  // static const orderDetails = Routes.orderDetails;
  // static const completeRegistration = Routes.completeRegistration;
  // static const notificationPage = Routes.notificationPage;
  // static const fixerMapPage = Routes.fixerMapPage;


  static const home = '/home';
  static const screen = '/screen';
  static const login = '/login';
  static const register= '/register';
  static const walkTroughs = '/walktroughs';
  static const otp = '/otp';
  static const finishRegister = '/finish_register';
  static const scheduleRepair = '/scheduleRepair';
  static const updateProfile = '/updateProfile';
  static const orderDetails = '/orderDetails';
  static const completeRegistration = '/completeRegistration';
  static const notificationPage = '/notificationPage';
  static const fixerMapPage = '/fixerMap';

  static final routes = [
    GetPage(
      name: "/",
      page: () => SplashScreenView(),
    ),

    GetPage(
      name: walkTroughs,
      page: () => WalktroughsViews(),
    ),

    GetPage(
      name: login,
      page: () => LoginView(),
    ),
    GetPage(
      name: '/register',
      page: () => RegisterAccount(),
    ),
    GetPage(
      name: otp,
      page: () => OtpView(),
    ),
    GetPage(
      name: finishRegister,
      page: () => FinishRegiter(),
    ),
    GetPage(
      name: home,
      page: () => HomeView(),
    ),
    GetPage(
      name: scheduleRepair,
      page: () => ScheduleRepair(),
    ),
    GetPage(
      name: updateProfile,
      page: () => UpdateProfile(),
    ),
    GetPage(
      name: orderDetails,
      page: () => OrderDetails(),
    ),
    GetPage(
      name: completeRegistration,
      page: () => CompleteRegistration(),
    ),
    GetPage(
      name: notificationPage,
      page: () => const NotificationView(),
    ),
    GetPage(
      name: fixerMapPage,
      page: () => FixerMapView(),
    ),
  ];

}