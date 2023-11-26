import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class BaseRequestHttp {
  static Dio dio = Dio();

  Future<dynamic> sendRequest(
      String requestMethod, {
        dynamic jsonMap,
        String urlOther = "",
      }) async {
    dynamic response;
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer AAAAQ76nx-M:APA91bHBUnz7Ks-Ummjensdk66vrQEZ1tsQW_t4cYm922coZ_S_xrX0O8-B-tDBZnlCiUKrsP227vlwsv5U7hnjxCyceDK7SDRWmTrVqVoHSNjX7Z03-dW8HtqAhPuabgTzTT2IG3BcN"
    };
    print(jsonMap.toString());
    Options options = Options(
      headers: headers,
      method: requestMethod.toString(),
      responseType: ResponseType.json,
    );
    try {
      response = await dio.post(
        urlOther,
        data: json.encode(jsonMap),
        options: options,
      );
      return response.data;
    } catch (e) {
      log("$e");
    }
  }
}
