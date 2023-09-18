part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const ACCOUT_PERSONNAL = _Paths.ACCOUT_PERSONNAL;
  static const CREATE_ACC_PERSONNAL = _Paths.CREATE_ACC_PERSONNAL;
  static const VIEW_WAITING_POST = _Paths.VIEW_WAITING_POST;
  static const CONFIG_ROLE = _Paths.CONFIG_ROLE;
  static const HOME_DASHBOARD = _Paths.HOME_DASHBOARD;
  static const VIEW_POST = _Paths.VIEW_POST;
  static const RECHARGE = _Paths.RECHARGE;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const HOME_DASHBOARD = '/dashboard';
  static const LOGIN = '/login';
  static const ACCOUT_PERSONNAL = '/accout_personnal';
  static const CREATE_ACC_PERSONNAL = '/create_acc_personnal';
  static const VIEW_WAITING_POST = '/view_post_waiting';
  static const CONFIG_ROLE = '/config_role';
  static const VIEW_POST = '/post_view';
  static const RECHARGE = '/recharge';
}