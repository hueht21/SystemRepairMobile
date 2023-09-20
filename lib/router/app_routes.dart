part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const SCREEN = _Paths.SCREEN;
  static const WALKTROUGHS = _Paths.WALKTROUGHS;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const SCREEN = '/screen';
  static const LOGIN = '/login';
  static const WALKTROUGHS = '/walktroughs';
}