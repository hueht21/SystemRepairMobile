import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:systemrepair/cores/const/app_url.dart';
import 'package:systemrepair/cores/const/const.dart';
import 'package:systemrepair/cores/enum/enum_request_method.dart';

import '../base_controllers/base_controller.dart';

class BaseRequest {
  static Dio dio = getBaseDio();

  static Dio getBaseDio() {
    Dio dio = Dio();

    dio.options = buildDefaultOptions();


    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    return dio;
  }

  static BaseOptions buildDefaultOptions({bool isKyc = false}) {
    return BaseOptions()
      ..connectTimeout = AppConst.requestTimeOut
      ..receiveTimeout = AppConst.requestTimeOut;
  }

  static void close() {
    dio.close(force: true);
    updateCurrentDio();
  }

  static void updateCurrentDio() {
    dio = getBaseDio();
  }

  static Dio getCurrentDio() {
    return dio;
  }

  void setOnErrorListener(Function(Object error) onErrorCallBack) {
    this.onErrorCallBack = onErrorCallBack;
  }

  late Function(Object error) onErrorCallBack;

  /// [isQueryParametersPost]: `true`: phương thức post gửi params, mặc định = `false`
  ///
  /// [dioOptions]: option của Dio() sử dụng khi gọi api có option riêng
  ///
  /// [functionError]: chạy function riêng khi request xảy ra Exception (mặc định sử dụng [showDialogError])
  Future<dynamic> sendRequest(String action, String requestMethod,
      {dynamic jsonMap,
        bool isDownload = false,
        String? urlOther,
        Map<String, String>? headersUrlOther,
        bool isQueryParametersPost = false,
        required BaseGetxController controller,
        BaseOptions? dioOptions,
        Function(Object error)? functionError,
        bool isToken = true,
        bool isHaveVersion = true,
        bool isKyc = false}) async {
    // dio.options = dioOptions ?? buildDefaultOptions(isKyc: isKyc);
    dynamic response;
    String url = urlOther ??
        (AppUrl.url + action);
    Map<String, String> headers = isToken
        ? (headersUrlOther ?? getBaseHeader())
        : {"Content-Type": "application/json"};
    Options options = isDownload
        ? Options(
        headers: headers,
        responseType: ResponseType.bytes,
        followRedirects: false,
        validateStatus: (status) {
          return status != null && status < 500;
        })
        : Options(
      headers: headers,
      //method: requestMethod.toString(),
      responseType: ResponseType.json,
    );
    CancelToken cancelToken = CancelToken();
    controller.addCancelToken(cancelToken);
    try {
      if (requestMethod == EnumRequestMethod.post) {
        if (isQueryParametersPost) {
          response = await dio.post(
            url,
            queryParameters: jsonMap,
            options: options,
            cancelToken: cancelToken,
          );
        } else {
          response = await dio.post(
            url,
            data: jsonMap,
            options: options,
            cancelToken: cancelToken,
          );
        }
      } else {
        response = await dio.get(
          url,
          queryParameters: jsonMap,
          options: options,
          cancelToken: cancelToken,
        );
      }
      return response.data;
    } catch (e) {
      controller.cancelRequest(cancelToken);

      return functionError != null ? functionError(e) : showDialogError(e);
    }
  }

  dynamic showDialogError(dynamic e) {
    if (e.response?.data != null &&
        e.response.data is Map &&
        e.response.data["errorMessage"] != null) return e.response.data;
    onErrorCallBack(e);
  }

  Map<String, String> getBaseHeader() {
    return {
      "Content-Type": "application/json",
      'Authorization': "" ,
    };
  }
}
