part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const home = _Paths.home;
  static const login = _Paths.login;
  static const screen = _Paths.screen;
  static const walkTroughs = _Paths.walkTroughs;
  static const register = _Paths.register;
  static const otp = _Paths.otp;
  static const finishRegister = _Paths.finishRegister;
  static const scheduleRepair = _Paths.scheduleRepair;
  static const updateProfile = _Paths.updateProfile;
}

abstract class _Paths {
  _Paths._();
  static const home = '/home';
  static const screen = '/screen';
  static const login = '/login';
  static const register= '/register';
  static const walkTroughs = '/walktroughs';
  static const otp = '/otp';
  static const finishRegister = '/finish_register';
  static const scheduleRepair = '/scheduleRepair';
  static const updateProfile = '/updateProfile';
}