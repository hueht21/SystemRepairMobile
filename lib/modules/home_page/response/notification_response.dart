import '../../../base_utils/repository_base/base_request.dart';
import '../../../base_utils/repository_base/base_request_http.dart';
import '../../notifications/models/notification_reponse_model.dart';

class NotificationResponse {

  Future<NotificationResponseModel> sentNotification(dynamic json) async {

    var response = await BaseRequestHttp().sendRequest("POST", urlOther: "https://fcm.googleapis.com/fcm/send", jsonMap: json);
    return NotificationResponseModel.fromJson(response);
  }
}