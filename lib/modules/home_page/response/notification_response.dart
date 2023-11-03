import '../../../base_utils/repository_base/base_request.dart';
import '../../../base_utils/repository_base/base_request_http.dart';

class NotificationResponse {

  Future<void> sentNotification(dynamic json) async {

    await BaseRequestHttp().sendRequest("POST", urlOther: "https://fcm.googleapis.com/fcm/send", jsonMap: json);
  }
}